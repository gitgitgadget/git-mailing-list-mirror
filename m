From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] stash: tweak error message in store_stash ()
Date: Mon, 13 May 2013 07:42:57 -0700
Message-ID: <7v7gj3os9a.fsf@alter.siamese.dyndns.org>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
	<1368449154-21882-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubty0-0008MY-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab3EMOnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:43:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab3EMOnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:43:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E1721D4A6;
	Mon, 13 May 2013 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDwWK0JiC0vWJ5tbkyVnERslqnI=; b=GKBRyk
	+SB/QMo7aJtOfjpwRrRaJLyIzDwejoe98feB/16w+Xw7WV3UXuU9hqx7O2BfX1g6
	v1p27evbGJtzJ9kCvArWyshqEYVOJEmRu/e9veE9slwOTdRchc99J0klemgL0XX5
	VgNXGxoP5zgUY1+t9tQT3L5JUagXtuevKCGWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lH82FeQHQLOol3J0256gap0sYsXRT5Pm
	Fdj5lHgwYdMMxYGpxj+EOREefe6pW3JEF9+qH3va97aLvobbl6iQ1+AGqd5HH5qB
	hxySn95YHo5/bHtr8aRfutD/GSpVldcERYpB3o95kypfr5iMBNEZ3MwRCrBptqzZ
	dSxtAMq4aJ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 039E61D4A3;
	Mon, 13 May 2013 14:43:00 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43C821D4A1;
	Mon, 13 May 2013 14:42:59 +0000 (UTC)
In-Reply-To: <1368449154-21882-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 13 May 2013 18:15:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68134258-BBDB-11E2-B469-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224155>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When the update-ref invocation fails, store_stash currently prints:
>
>     Cannot save the current status
>
> This is not very useful for diagnosing the problem.  Instead, print:
>
>     Cannot store 688268c4254ca5dc6e2effa83bae4f0dbbe75e5b
>
> so we can inspect the object and analyze why the update-ref failed.

This would break the error message for save_stash with your current
patch series, wouldn't it?  I think this patch is a solution to a
wrong problem.  As I already said in 4/6, store_stash should allow
its caller to supply a customised error message.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-stash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 1d483f5..24d72fc 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -167,7 +167,7 @@ store_stash () {
>  	# Make sure the reflog for stash is kept.
>  	: >>"$GIT_DIR/logs/$ref_stash"
>  	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
> -	die "$(gettext "Cannot save the current status")"
> +	die "$(gettext "Cannot store $w_commit")"
>  }
>  
>  save_stash () {
