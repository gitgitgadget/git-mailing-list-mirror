From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Restore line limit option in post-receive-email
Date: Thu, 10 Nov 2011 22:56:07 -0800
Message-ID: <7v4nybrvug.fsf@alter.siamese.dyndns.org>
References: <1320993311-27112-1-git-send-email-leongc@alumni.rice.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kpfleming@digium.com
To: Cheng Leong <leongc@alumni.rice.edu>
X-From: git-owner@vger.kernel.org Fri Nov 11 07:56:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROl28-0000ZC-LJ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 07:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab1KKG4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 01:56:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab1KKG4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 01:56:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E459492B;
	Fri, 11 Nov 2011 01:56:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UHhoWi/VuyI5kiAFq6V+9FsuQU=; b=wY8wiP
	Xrel/r10vY8CJRFCLAcw4E5nqhh0/qIeAmUlFIMxL8RXyOTGRnkYnA7H//JCsKiL
	VMCpJlfDE1HEWJbqjzc6xYRrGISYuCb+dgM5fBDDmX8BI+7DeU+rA6gzD3E+b6zf
	wYQRToZg6USvQe83x1z5iBcGreN4ZpLD1xseo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kvg9uwumB550gNHsPwyqIh+nIyxcCMlx
	shPj6mECThc8xX6IBrXVwC7lx2fEtnBapDpISFr1cHdfmwm+Sqna4y4k/QH5WW0K
	zPkgNjYQfFvvP1yf6H9g85rSONKDhVLiu+DShnnLJD/rBZVSgEox+4/GmVjWqfx5
	Cqrz2gPTzf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 559A6492A;
	Fri, 11 Nov 2011 01:56:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3A8C4928; Fri, 11 Nov 2011
 01:56:08 -0500 (EST)
In-Reply-To: <1320993311-27112-1-git-send-email-leongc@alumni.rice.edu>
 (Cheng Leong's message of "Fri, 11 Nov 2011 00:35:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BC95890-0C32-11E1-A801-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185255>

Cheng Leong <leongc@alumni.rice.edu> writes:

> The hooks.emailmaxlines config currently has no effect. Stop
> prep_for_email from clobbering the already-initialized maxlines
> variable in the contrib/hooks/post-receive-email example.
>
> Signed-off-by: Cheng Leong <leongc@alumni.rice.edu>
> ---
>  contrib/hooks/post-receive-email |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index ba077c1..ac2e0ed 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -85,7 +85,6 @@ prep_for_email()
>  	oldrev=$(git rev-parse $1)
>  	newrev=$(git rev-parse $2)
>  	refname="$3"
> -	maxlines=$4
>  
>  	# --- Interpret
>  	# 0000->1234 (create)

Umm, there is another place where $maxlines is used without
merit. Shouldn't we do something like below as well?

 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index ba077c1..e27ca3c 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -743,6 +743,6 @@ else
 	while read oldrev newrev refname
 	do
 		prep_for_email $oldrev $newrev $refname || continue
-		generate_email $maxlines | send_mail
+		generate_email | send_mail
 	done
 fi
