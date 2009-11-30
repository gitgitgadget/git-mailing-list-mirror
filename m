From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] builtin-merge: show user-friendly error messages
 for fast-forward too.
Date: Sun, 29 Nov 2009 18:23:11 -0800
Message-ID: <7vy6lo7nu8.fsf@alter.siamese.dyndns.org>
References: <1259497113-1393-1-git-send-email-Matthieu.Moy@imag.fr>
 <1259497113-1393-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 30 03:23:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEvvD-00013V-El
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 03:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbZK3CXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 21:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZK3CXP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 21:23:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbZK3CXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 21:23:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54867EF2;
	Sun, 29 Nov 2009 21:23:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pbj7i5HhaSUhIpG3iLUHX1WENT8=; b=dB41NK
	mNnBm4pwnOR+xDsz3D+u6lRbZdiNnYTz8/FIcnZ9Bhd7wygC7golKy/vMRmvqSxC
	XYvHO94S4ECWU28S6+VPkOnsFQ/LQ/m5PJfs52cdZDolYm29Yv6Unpc+T2zQdONe
	bbxpkdZ6VR8HYIlHvPUQmeKJvfqpY6S16UOt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OZn93EXec3LHThuhRl88jeEKzin19l3x
	p/RtMwHsh+mlUKM1jrkg1f+SE61HulKacq/lbc3Em34U9Bd07c1ioJYr3DSO9ANN
	uvU7/AVrpRLxs/up1zEZBC2XabHaSl6D0Y8VgblqNvRY0uRlTHT0i8dCVdY6SPDL
	l4mAjMWCqc4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 434A7EF1;
	Sun, 29 Nov 2009 21:23:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95980EF0; Sun, 29 Nov
 2009 21:23:13 -0500 (EST)
In-Reply-To: <1259497113-1393-3-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun\, 29 Nov 2009 13\:18\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5137C3C6-DD57-11DE-ABC2-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134044>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This is where I'm not 100% sure I'm not breaking some plumbing.

I think this change is safe for the current codebase, as the only caller
of checkout_fast_forward() is cmd_merge(), which is an implementation of
"git merge".  Even if there were a plumbing implementation that internally
runs "git merge", either by calling cmd_merge() or via run_command()
interface (there isn't as far as I know), or if somebody adds such a thing
in the future, such a "plumbing" will get Porcelain messages from other
codepaths in cmd_merge() anyway.  You are not introducing a new problem.

Or did you have something a lot more subtle in mind?

Side note. checkout_fast_forward() switches between two commits (the one
that matches HEAD) to another (given as remote), which is the same as what
"git checkout other-branch" and "git checkout -b new-branch" do.  We might
want to replace it with the main part of merge_working_tree() from
builtin-checkout.c eventually, which would teach the "checkout -m" logic
that carries the local changes forward to fast-forward of "git merge".

>  builtin-merge.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-merge.c b/builtin-merge.c
> index 57eedd4..0dd363f 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -656,6 +656,7 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
>  	opts.verbose_update = 1;
>  	opts.merge = 1;
>  	opts.fn = twoway_merge;
> +	opts.msgs = get_porcelain_error_msgs();
>  
>  	trees[nr_trees] = parse_tree_indirect(head);
>  	if (!trees[nr_trees++])
