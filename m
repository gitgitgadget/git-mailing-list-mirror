From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Mon, 29 Jul 2013 08:18:45 -0700
Message-ID: <7vtxjd1jje.fsf@alter.siamese.dyndns.org>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
	<20130726191631.GD29799@sigill.intra.peff.net>
	<CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
	<20130726212438.GA1388@sigill.intra.peff.net>
	<20130726213705.GJ14690@google.com>
	<20130726214036.GB1388@sigill.intra.peff.net>
	<20130726224359.GA3928@sigill.intra.peff.net>
	<20130726230527.GA12968@sigill.intra.peff.net>
	<20130726230857.GK14690@google.com>
	<20130726231902.GA1674@sigill.intra.peff.net>
	<20130726233928.GD12968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:18:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pDp-0004Uo-BH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab3G2PSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:18:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757245Ab3G2PSs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:18:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01B4F34E9F;
	Mon, 29 Jul 2013 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lotr4AOKyXoC6fARbT2FHMyz4o8=; b=Mq9sFO
	HmWBHxZdy0lbYZYei/qBN3IfAK1GRBZBQBNwNNzdloDSDN3ULxRzEguIpeSfgpWn
	NYog5a7PA4yxwIlWW501wNfomuZk2zeeo2Ek8Gg/g3kGMP0wBXjGJMWUX7uZsM9y
	X1J3unrUAYZUKVi0pmQKh1TFmbjuL0DD9sSz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aF1XOOcEvzll3I1b7KOG3EQmpg6Tw/vG
	YXj/hZJ1vH2b98SByAXDla4T5NL4U5FKhy9PS+qC27LpF/XgVQuKrXvEFRn5FPpZ
	OIeHm5VUpbG5WtK883CK2trWvUd0a0bd3ConSiFcyLt6auc+TPLTHej+HsPLmt8M
	yicb70Tb2z4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBC0734E9E;
	Mon, 29 Jul 2013 15:18:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E2D434E9C;
	Mon, 29 Jul 2013 15:18:47 +0000 (UTC)
In-Reply-To: <20130726233928.GD12968@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 26 Jul 2013 19:39:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A196B44-F862-11E2-9530-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231288>

Jeff King <peff@peff.net> writes:

> Here it is in patch form, with an updated commit message that hopefully
> explains the rationale a bit better.
>
> -- >8 --
> Subject: [PATCH] commit: tweak empty cherry pick advice for sequencer
>
> When we refuse to make an empty commit, we check whether we
> are in a cherry-pick in order to give better advice on how
> to proceed. We instruct the user to repeat the commit with
> "--allow-empty" to force the commit, or to use "git reset"
> to skip it and abort the cherry-pick.
>
> In the case of a single cherry-pick, the distinction between
> skipping and aborting is not important, as there is no more
> work to be done afterwards.  When we are using the sequencer
> to cherry pick a series of commits, though, the instruction
> is confusing: does it skip this commit, or does it abort the
> rest of the cherry-pick?
>
> It does skip, after which the user can continue the
> cherry-pick. This is the right thing to be advising the user
> to do, but let's make it more clear what will happen, both
> by using the word "skip", and by mentioning that the rest of
> the sequence can be continued via "cherry-pick --continue"
> (whether we skip or take the commit).
>
> Noticed-by: Ramkumar Ramachandra <artagnon@gmail.com>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/commit.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e47f100..73fafe2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -63,8 +63,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
>  "If you wish to commit it anyway, use:\n"
>  "\n"
>  "    git commit --allow-empty\n"
> +"\n");
> +
> +static const char empty_cherry_pick_advice_single[] =
> +N_("Otherwise, please use 'git reset'\n");
> +
> +static const char empty_cherry_pick_advice_multi[] =
> +N_("If you wish to skip this commit, use:\n"
>  "\n"
> -"Otherwise, please use 'git reset'\n");
> +"    git reset\n"
> +"\n"
> +"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
> +"the remaining commits.\n");
>  
>  static const char *use_message_buffer;
>  static const char commit_editmsg[] = "COMMIT_EDITMSG";
> @@ -107,6 +117,7 @@ static enum commit_whence whence;
>  static const char *cleanup_arg;
>  
>  static enum commit_whence whence;
> +static int sequencer_in_use;
>  static int use_editor = 1, include_status = 1;
>  static int show_ignored_in_status, have_option_m;
>  static const char *only_include_assumed;
> @@ -141,8 +152,11 @@ static void determine_whence(struct wt_status *s)
>  {
>  	if (file_exists(git_path("MERGE_HEAD")))
>  		whence = FROM_MERGE;
> -	else if (file_exists(git_path("CHERRY_PICK_HEAD")))
> +	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
>  		whence = FROM_CHERRY_PICK;
> +		if (file_exists(git_path("sequencer")))
> +			sequencer_in_use = 1;

Should this be

	sequencer_in_use = file_exists(...)

so readers do not have to wonder what the variable is initialized
to?

Other than that, looks reasonable to me.  Thanks.



> +	}
>  	else
>  		whence = FROM_COMMIT;
>  	if (s)
> @@ -808,8 +822,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		run_status(stdout, index_file, prefix, 0, s);
>  		if (amend)
>  			fputs(_(empty_amend_advice), stderr);
> -		else if (whence == FROM_CHERRY_PICK)
> +		else if (whence == FROM_CHERRY_PICK) {
>  			fputs(_(empty_cherry_pick_advice), stderr);
> +			if (!sequencer_in_use)
> +				fputs(_(empty_cherry_pick_advice_single), stderr);
> +			else
> +				fputs(_(empty_cherry_pick_advice_multi), stderr);
> +		}
>  		return 0;
>  	}
