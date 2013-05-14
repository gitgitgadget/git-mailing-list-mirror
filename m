From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe: make error messages more consistent
Date: Tue, 14 May 2013 10:46:12 -0700
Message-ID: <7vsj1pjvyz.fsf@alter.siamese.dyndns.org>
References: <1368540973-25830-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 19:46:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJIu-0001wf-WD
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 19:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395Ab3ENRqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 13:46:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3ENRqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 13:46:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7FE41E681;
	Tue, 14 May 2013 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3+23RxBTHmKUnM3BVqZCkvT/7es=; b=P26LFT
	qHcL+zMzL2gt26MYFQeaGYhoyENu/iLVrHIsfrAmAO4Ffdjvccs0Bd9aUatECKCR
	PZ2197Zqv3XFlRfNK9qmJpWl6sZztWGEqexYCcT61drdvs6zvhufzGt5w/t8EzwZ
	cp9rryMmxjjFsVV7sfXAASasdefrGOzvo6e8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SEH4oEl7QgQolsqycZNPEi2KyDPwiWlY
	u0eOBWa6zQ12KcpMNFqaG9NjMPKxw4A0UebQ6vQGj+b9yqdfCSEvth5s298neV13
	XDgcodhDWJVCPFx6LFpjKwk2NHPxzLVXaIPb4VIFAVKWoO72KE3ogCzA0WCj7PkY
	i5s/daBruLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A071B1E680;
	Tue, 14 May 2013 17:46:14 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ECEF1E67F;
	Tue, 14 May 2013 17:46:13 +0000 (UTC)
In-Reply-To: <1368540973-25830-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 14 May 2013 19:46:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BE39786-BCBE-11E2-B285-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224305>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, diffcore-pickaxe reports two distinct errors for the same
> user error:
>
>     $ git log --pickaxe-regex -S'\1'
>     fatal: invalid pickaxe regex: Invalid back reference
>
>     $ git log -G'\1' # --pickaxe-regex is implied
>     fatal: invalid log-grep regex: Invalid back reference
>
> Since the error has nothing to do with "log-grep", change the -G error
> message to match the -S error message.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Sorry I couldn't do more.  diffcore-pickaxe.c isn't at all easy to
>  hack on, because there are so few tests guarding it.
>
>  diffcore-pickaxe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 63722f8..d69a7a2 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -122,7 +122,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
>  		char errbuf[1024];
>  		regerror(err, &regex, errbuf, 1024);
>  		regfree(&regex);
> -		die("invalid log-grep regex: %s", errbuf);
> +		die("invalid pickaxe regex: %s", errbuf);
>  	}
>  
>  	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);

I am debating myself if it is truly easier to explain for users that
"-G" is a different variant of pickaxe.

It happens to be implemented in the same source file as pickaxe, but
they do logically quite different things.  -G does not even have a
reason to pay attention to --pickaxe-regexp (it is "grep in the log
-p").

I suspect that it might avoid unnecessary confusion to explain them
as totally separate operations, and not labelling this error with
"pickaxe regex".  I dunno.
