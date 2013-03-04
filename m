From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule update: when using recursion, show full path
Date: Sun, 03 Mar 2013 19:48:04 -0800
Message-ID: <7vsj4bygej.fsf@alter.siamese.dyndns.org>
References: <5127C45C.2020204@web.de>
 <1362253499-48847-1-git-send-email-github.com@phor.net>
 <5133E570.7030507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Entriken <fulldecent@gmail.com>, git@vger.kernel.org,
	Phil Hord <hordp@cisco.com>, Stefan Zager <szager@google.com>,
	William Entriken <github.com@phor.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 04 04:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCMOD-0003yY-6H
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 04:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799Ab3CDDsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 22:48:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757658Ab3CDDsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 22:48:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B637B0C2;
	Sun,  3 Mar 2013 22:48:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xVEl60+6UmZstpr7lzL5abB1Dw=; b=AK9D4k
	PWWpgt+g27dQ39aEnEBM6Dc8ds4q8aIwdj2JRP6De7v5OjSzj2oyY8g3rHqAwg8k
	bUCQtIpwottMgAKxNeAXD11zI7lrK82pXCRC4690JDkqEpt3/POGijqyI7dzcjG0
	vKYtERlSPrBMW5qnDfKfXmScKexgQ51Ux5dw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KayRXw3N6ZnPlFoMeH8LwVf0mYNxDBiC
	8REW7RuYiZvTmRlc9A2lm/13udqy3/QVtZFDVD+eQfXwgWGkjGjFgF/SJ9n1Pg5m
	obYEZLn4gWzima/8tEpjwJ+RhtUSLfbIA4FpkZC/MpjO53xYTjshnExL0f3B2Lkm
	6Odc+7PVKJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20F01B0C1;
	Sun,  3 Mar 2013 22:48:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BFD5B0C0; Sun,  3 Mar 2013
 22:48:06 -0500 (EST)
In-Reply-To: <5133E570.7030507@web.de> (Jens Lehmann's message of "Mon, 04
 Mar 2013 01:06:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52E51B3E-847E-11E2-A515-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217389>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 02.03.2013 20:44, schrieb William Entriken:
>> Previously when using update with recursion, only the path for the
>> inner-most module was printed. Now the path is printed relative to
>> the directory the command was started from. This now matches the
>> behavior of submodule foreach.
>> 
>> Signed-off-by: William Entriken <github.com@phor.net>
>
> Thanks, this patch cleanly applies against maint and addresses all
> issues from the previous rounds.
>
> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
>
> Junio, could you please squash in this additional test?

Thanks.

I wish all areas of Git had competent and diligent area maintainers
like you.  Makes it a lot easier for me _not_ to keep track of ;-).

>
> --------8<-------
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index feaec6c..70528b7 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -612,7 +612,8 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
>  	rm -rf super_update_r2 &&
>  	git clone super_update_r super_update_r2 &&
>  	(cd super_update_r2 &&
> -	 git submodule update --init --recursive &&
> +	 git submodule update --init --recursive >actual &&
> +	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" actual &&
>  	 (cd submodule/subsubmodule &&
>  	  git log > ../../expected
>  	 ) &&
