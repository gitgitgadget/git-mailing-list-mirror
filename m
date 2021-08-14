Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1FC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2427E61038
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhHNUdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 16:33:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53108 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNUdc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 16:33:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 268A813E7BF;
        Sat, 14 Aug 2021 16:33:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CwhaocLVaEpF8lsZ7VCPXwuJufxYIsyTmKugy5
        Q1+XM=; b=S13AyluwU+Yd9ZHbrptd9Nm9M5rxjkKDf09/h8sb9yF92eJQmPJ31P
        +TAtZdwbKw1k4PiSXaDReFx9sgWgJEP38B+HnliYvgDpWF1B2Bv7GONlv9I3mOf6
        N8/eiQZ95pITCSbYj3JufieI+7TDJpYGexLKd7tKsDu02+m1V6PBo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10A8C13E7BE;
        Sat, 14 Aug 2021 16:33:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4744E13E7BB;
        Sat, 14 Aug 2021 16:33:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] [GSOC] cherry-pick: use better advice message
References: <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
        <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com>
Date:   Sat, 14 Aug 2021 13:32:58 -0700
In-Reply-To: <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Sat, 14 Aug 2021 10:27:43 +0000")
Message-ID: <xmqqa6lju5qd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D11DBFAA-FD3E-11EB-8619-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> In the past, git cherry-pick would print such advice when
> there was a conflict:
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'

In our log messages, we desciribe the current state in the present
tense.

It may be worth mentioning that this is because the program
originally was about picking only one commit and the hint was
inherited from those days.  Or it may not.  I dunno.

> But in fact, when we want to cherry-pick multiple commits,
> we should not use "git commit" after resolving conflicts, which
> will make Git generate some errors. We should recommend users to
> use `git cherry-pick --continue`, `git cherry-pick --abort`, just
> like git rebase does.

I am not sure "should not" is the right phrase.  Also it does not
help readers to have a vague "generate some errors" than not saying
anything---it leaves readers puzzled with "what errors???"

Whether picking a single commit or a series of commits, after
resolving conflicts in the current step, wouldn't

    $ git commit ;# to conclude the resolution
    $ git cherry-pick --continue

do the right thing?

> This is the improved advice:

It may be an improved advice, but just omit it and say something
like:

	Suggest use of "git cherry-pick --contiue", so that it would
	also apply to cases where multiple commits are being picked.

The actual message does not have to be reproduced here, as it is in
the source, and it can be seen in the test ;-)

That would make the proposed log message conform to our norm,
i.e. brief description of what happens with the current system,
followed by description of the perceived problem, followed by
an order to the codebase to become different in a specific way
that solves the problem.

Taken together, perhaps

	"git cherry-pick", upon seeing a conflict, says:

	    hint: ...

	as if running "git commit" to conclude the resolution of
	this single step were the end of the story.  This stems from
	the fact that the command originally was to pick a single
	commit and not a range of commits, and the message was
	written back then and has not been adjusted.

	When picking a range of commits and the command stops with a
	conflict in the middle of the range, however, after
	resolving the conflict and (optionally) recording the result
	with "git commit", the user has to run "git cherry-pick
	--continue" to have the rest of the range dealt with,
	"--skip" to drop the current commit, or "--abort" to discard
	the series.

	Suggest use of "git cherry-pick --continue/--skip/--abort"
	so that the message also covers the case where a range of
	commits are being picked.


> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Hepled-by: Junio C Hamano <gitster@pobox.com>

It seems that unlike other people I keep hepling you, whatever that
verb means ;-).

Thanks.

> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38e..2dd73d24a87 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -403,7 +403,7 @@ static void print_advice(struct repository *r, int show_hint,
>  	char *msg = getenv("GIT_CHERRY_PICK_HELP");
>  
>  	if (msg) {
> -		fprintf(stderr, "%s\n", msg);
> +		advise("%s\n", msg);
>  		/*
>  		 * A conflict has occurred but the porcelain
>  		 * (typically rebase --interactive) wants to take care
> @@ -418,6 +418,20 @@ static void print_advice(struct repository *r, int show_hint,
>  		if (opts->no_commit)
>  			advise(_("after resolving the conflicts, mark the corrected paths\n"
>  				 "with 'git add <paths>' or 'git rm <paths>'"));
> +		else if (opts->action == REPLAY_PICK)
> +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
> +				 "\"git add/rm <conflicted_files>\", then run\n"
> +				 "\"git cherry-pick --continue\".\n"
> +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
> +				 "To abort and get back to the state before \"git cherry-pick\",\n"
> +				 "run \"git cherry-pick --abort\"."));
> +		else if (opts->action == REPLAY_REVERT)
> +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
> +				 "\"git add/rm <conflicted_files>\", then run\n"
> +				 "\"git revert --continue\".\n"
> +				 "You can instead skip this commit: run \"git revert --skip\".\n"
> +				 "To abort and get back to the state before \"git revert\",\n"
> +				 "run \"git revert --abort\"."));
>  		else
>  			advise(_("after resolving the conflicts, mark the corrected paths\n"
>  				 "with 'git add <paths>' or 'git rm <paths>'\n"
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 9d100cd1884..6766aed7282 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -158,4 +158,24 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
>  	grep -q "^modified$" renamed
>  '
>  
> +test_expect_success 'advice from failed revert' '
> +	echo dream >dream &&
> +	git add dream &&
> +	git commit -m "add dream" &&
> +	dream_oid=$(git rev-parse --short HEAD) &&
> +	cat <<-EOF >expected &&
> +	error: could not revert $dream_oid... add dream
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: "git add/rm <conflicted_files>", then run
> +	hint: "git revert --continue".
> +	hint: You can instead skip this commit: run "git revert --skip".
> +	hint: To abort and get back to the state before "git revert",
> +	hint: run "git revert --abort".
> +	EOF
> +	echo dream >>dream &&
> +	git add dream &&
> +	git commit -m "double-add dream" &&
> +	test_must_fail git revert HEAD^ 2>actual &&
> +	test_cmp expected actual
> +'
>  test_done
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 014001b8f32..cb2ebea9ad3 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -47,20 +47,23 @@ test_expect_success 'failed cherry-pick does not advance HEAD' '
>  	test "$head" = "$newhead"
>  '
>  
> -test_expect_success 'advice from failed cherry-pick' "
> +test_expect_success 'advice from failed cherry-pick' '
>  	pristine_detach initial &&
>  
> -	picked=\$(git rev-parse --short picked) &&
> +	picked=$(git rev-parse --short picked) &&
>  	cat <<-EOF >expected &&
> -	error: could not apply \$picked... picked
> -	hint: after resolving the conflicts, mark the corrected paths
> -	hint: with 'git add <paths>' or 'git rm <paths>'
> -	hint: and commit the result with 'git commit'
> +	error: could not apply $picked... picked
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: "git add/rm <conflicted_files>", then run
> +	hint: "git cherry-pick --continue".
> +	hint: You can instead skip this commit: run "git cherry-pick --skip".
> +	hint: To abort and get back to the state before "git cherry-pick",
> +	hint: run "git cherry-pick --abort".
>  	EOF
>  	test_must_fail git cherry-pick picked 2>actual &&
>  
>  	test_cmp expected actual
> -"
> +'
>  
>  test_expect_success 'advice from failed cherry-pick --no-commit' "
>  	pristine_detach initial &&
>
> base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
