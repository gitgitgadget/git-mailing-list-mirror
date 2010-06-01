From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Remove stray error message from sed
Date: Tue, 01 Jun 2010 10:44:17 -0700
Message-ID: <7veigqvea6.fsf@alter.siamese.dyndns.org>
References: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
 <1275384022-12131-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:44:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVVx-0000gF-9t
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400Ab0FARo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 13:44:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab0FARo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:44:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 616F4B867D;
	Tue,  1 Jun 2010 13:44:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+bB9UUmnvSomOF8nqkGQqdZXjpg=; b=Crcuqp
	TPKIUS1iTNRr7vUogRkbVl5544YGtjjn3TRoZdUSdSFMuHssynvGxDnyPD5fygUn
	YxZYevY7zhpselTJukUnE1VdyoaiAO7IYBpdF/m8V1Q8YCP4kHJcW/PyawzaDMoe
	oU0muHCX/XqtMjUlBlhwyaN2T8yrcc/0A01Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xbFwAYBmAFYKmDZXavAEAiIJmFj+DzVU
	vyFVB0Jp3lSmnZQ8LgyE9tOCfJeZoDb5Y/G7Jh7JTBDf1JJaoqgW8g1teEwG1SFz
	ilO9za7ofEqh57Adb9RaYftc3Uo0PfRAQfAOAEEAlA7d/q45klWHGKR7tmAeiOLj
	Lkw+R0g1lgw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1901B867A;
	Tue,  1 Jun 2010 13:44:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21B54B8675; Tue,  1 Jun
 2010 13:44:18 -0400 (EDT)
In-Reply-To: <1275384022-12131-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue\,  1 Jun 2010 11\:20\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50512108-6DA5-11DF-A574-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148147>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When --continue is invoked without any changes, the following stray
> error message appears- sed: can't read $dotest/final-commit: No such
> file or directory. Remove this by making sure that the file actually
> exists.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-am.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 04f02a8..e61f47a 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -693,7 +693,7 @@ do
>  	else
>  	    action=yes
>  	fi
> -	FIRSTLINE=$(sed 1q "$dotest/final-commit")
> +	test -e "$dotest/final-commit" && FIRSTLINE=$(sed 1q "$dotest/final-commit")

This will let the command follow the same codepath as before but the
change in behaviour is that it does not reset FIRSTLINE to an empty
string.  Does this difference affect what the user sees after this part of
the code?

I would generally prefer to use "test -f" not "-e" (simply because it came
later and I am an old-timer), but if you want to use something newer than
"test -f", it might be worth using "test -r" instead, as readability (not
existence) is what you are after anyway.

>  
>  	if test $action = skip
>  	then
> -- 
> 1.7.1
