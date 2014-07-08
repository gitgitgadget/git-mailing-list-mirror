From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 07/19] rebase -i: The replay of root commits is not shown with --verbose
Date: Tue, 08 Jul 2014 15:29:12 -0700
Message-ID: <xmqq4myr8oxz.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<b1ecef042cd18a0251199429e4efb969b085d5fe.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 00:29:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4dtC-0008AU-A8
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 00:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbaGHW30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 18:29:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62524 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbaGHW3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 18:29:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFB0427EBF;
	Tue,  8 Jul 2014 18:29:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kKRGUIhGRhYYh609DlQYe9P7w6Q=; b=cZeTCZ
	6m2B3+U8cCncviEnibZyqPNQw61F1c48AiG2L0z0RCJ16hSrzLTzcVjZrplzlL5j
	9bZMM/Nrs7u0oArnwnqbG36gYS/yLPu7TplJ/00+j5II6VE/mhy0dYq0h52YXVsw
	XizDLoHG+IQG9D4qFQk2oarG1jZec4CQzCKy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kjOHfRNS707vmCA20jWVGQKDa7wZu/Iw
	aguJ/UlOuK0Bp7PVvpVhty689t2MkEesukKMpzRPMPDgy6ap5ZYtG/p4s/AEBuG8
	CMQATf6WU9CiK0/OY2GUrLQduQvhVOpiHqQCJNdbU1d8YZlmVYzqEdfQPmSsaQwk
	D9/kVWdy5q0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B478C27EBD;
	Tue,  8 Jul 2014 18:29:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8905227EB6;
	Tue,  8 Jul 2014 18:28:58 -0400 (EDT)
In-Reply-To: <b1ecef042cd18a0251199429e4efb969b085d5fe.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:47:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41050786-06EF-11E4-AF9E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253055>

Fabian Ruch <bafain@gmail.com> writes:

> The command line used to recreate root commits specifies the
> erroneous option `-q` which suppresses the commit summary message.
> However, git-rebase--interactive tends to tell the user about the
> commits it creates, if she wishes (cf. command line option
> `--verbose`). The code parts handling non-root commits or squash
> commits all output commit summary messages. Do not make the replay of
> root commits an exception. Remove the option.
>
> It is OK to suppress the commit summary when git-commit is used to
> initialize the authorship of the sentinel commit because the
> existence of this additional commit is a detail of
> git-rebase--interactive's implementation. The option `-q` was
> probably introduced as a copy-and-paste error stemming from that part
> of the root commit handling code.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---

This one I can buy; there is no reason to drop "-q" from both (which
would give us the same thing twice and the one before the "pick_one
-n" runs is not the final one anyway) and the later one that records
the updated tree would be the one to report what it did.

>  git-rebase--interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0af96f2..ff04d5d 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -511,7 +511,7 @@ do_pick () {
>  			   --no-post-rewrite -n -q -C $1 &&
>  			pick_one -n $1 &&
>  			git commit --allow-empty \
> -				   --amend --no-post-rewrite -n -q -C $1 \
> +				   --amend --no-post-rewrite -n -C $1 \
>  				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>  			die_with_patch $1 "Could not apply $1... $2"
>  	else
