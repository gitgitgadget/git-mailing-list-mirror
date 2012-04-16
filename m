From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 10:29:33 -0700
Message-ID: <7vehrnwpoi.fsf@alter.siamese.dyndns.org>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl>
 <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:29:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJpkD-00082h-E0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab2DPR3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 13:29:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2DPR3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 13:29:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420A86E23;
	Mon, 16 Apr 2012 13:29:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H1a7SUGm4QEactcC0FVX7DTyJZ0=; b=G+NyFE
	Ro2ZGVB/otXFa4n1B3FCVl6qXA/odUsGINkNPFBN+HHVKXW6fFDB3LYLTLRDoPci
	tvDp1wjvAQhqmUFpssNVvVkpr4/Kj0S3LeCuiioNyhxTs0RkomRrvgvB/0HtXHMC
	2Pa+h1mMRDOkMX4K9SzdCy97aUWuyZQB0y0wU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuZEGMUjkZi/1BFCipkne9BmTnSp4w8n
	7cchJhfLYUuUcvQNNNDUt5k8196LWhwN3L8M3ZKN/qF5CNRcLe8kLKdi4wVCAjpM
	tR8BQyL6BwJrd9NVjAzN8BIzNC2p7Vzxoi8tPlU/xMWnLMVyKL+tOti2EjkAPAyc
	mxyosVd64M8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 393346E21;
	Mon, 16 Apr 2012 13:29:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3AD26E20; Mon, 16 Apr 2012
 13:29:34 -0400 (EDT)
In-Reply-To: <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 16 Apr 2012 07:57:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBF18BD6-87E9-11E1-A8D3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195669>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Trivially tested with
>
>     git merge HEAD^ HEAD^^
>
> which did the wrong thing before, and now works.
>
>                        Linus
>
> ---
>  builtin/merge.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 016a4dbee3b5..28fb5c9d6ada 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1370,8 +1370,7 @@ int cmd_merge(int argc, const char **argv, const
> char *prefix)
>
>         if (!common)
>                 ; /* No common ancestors found. We need a real merge. */
> -       else if (!remoteheads->next && !common->next &&
> -                       common->item == remoteheads->item) {
> +       else if (!parents->next && parents->item == head_commit) {

When everybody in remote_heads is an ancestor of the current HEAD,
finalize_parents() would have reduced parents to a single element list
with HEAD on it, and we are "already up-to-date".  Ok.

I wonder if use of remoteheads later in the same function are correct,
though.  We equate "!remoteheads->next" and "We are not doing octopus",
for example.
