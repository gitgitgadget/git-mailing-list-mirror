From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-am: fix regression with new cover-letter config
Date: Sun, 14 Apr 2013 18:48:41 -0700
Message-ID: <7vhaj84l8m.fsf@alter.siamese.dyndns.org>
References: <1365978424-11841-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYXP-0006Uj-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab3DOBsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:48:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3DOBsv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:48:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8E03E39A;
	Mon, 15 Apr 2013 01:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X31BOKeFxW+46PdnRsaV1nsDH4s=; b=R9HxbH
	VZpHlc/M7sTe6FzbNi31d5pTRSDebfchd/CEAxTMJKXzf0PA2H9MIv3ufO8Z5V/a
	FOAy0ZCIvTmq8gFWlWPVgF1Pa9C60APdlEudn6dPiMz1VI+/fsFIi8JndVWZVWcb
	PRVc+sh6xdotwuLeiBNthSpEYL2/CqlfV1u4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JA2oXfrrM8Bb9cfFxcrcYtnTR2hXckx6
	1GFmoXm25lDa/nTNld0YZidBSJxdYcJiVSEZZ6JnsymdjT79fGodo2OTB48U16pg
	dV0HVFAP7n14NVluLwGxGAjrND5JZJUHsi0Cwq7+ingTXJrD1LcYzi/0J7yMApkC
	GRUbSJJALAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD95DE397;
	Mon, 15 Apr 2013 01:48:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2552BE394; Mon, 15 Apr 2013
 01:48:50 +0000 (UTC)
In-Reply-To: <1365978424-11841-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 14 Apr 2013 17:27:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EAC937E-A56E-11E2-9331-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221180>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If you have a cover-letter configuration set to anything other than
> 'false', 'git format-patch' might generate a cover letter, and 'git am'
> doesn't seem to like that.
>
> Ideally 'git am' should skip the cover-letter, but for now lets just fix
> the regression.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

This is a follow-up to the fc/send-email-annotate topic, right?

You are mean to say "fix regression", which gave me a small heart
attack ;-).  I was worried if we had already merged it to 'next'.

As I already wrote in the recent "What's cooking", the series looks
good to me.  I am inclined to say that we should merge it (together
with this update) to 'next'.

Thanks for catching this before breaking the real world users.

>  git-rebase--am.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 97f31dc..f84854f 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -31,8 +31,8 @@ else
>  	rm -f "$GIT_DIR/rebased-patches"
>  
>  	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> -		--src-prefix=a/ --dst-prefix=b/ \
> -		--no-renames $root_flag "$revisions" >"$GIT_DIR/rebased-patches"
> +		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
> +		$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
>  	ret=$?
>  
>  	if test 0 != $ret
