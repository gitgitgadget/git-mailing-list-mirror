Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E13C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B476044F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhHLRq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhHLRq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 13:46:27 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB748C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 10:46:01 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 3so3615238qvd.2
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IKkwB2u3RprM1X4hsNuukS/0BGVoFPj4z3dF1uNmQ5k=;
        b=CfEiSr/A77d82cJM1puTJUMIjWNoRXXb45/oUlMZ7xCCQPl4sCa6R8s5HEbYAtuYMY
         4/QgGOIfQ8XyKYd5+mjKw8ZGjpIx2RKB4fHFiikw657lh5GPzM8bh0G1nSaMM39lnR/t
         5v2mXJfCiHCSNo59TSHbr4qKlYE+WaJMv7RisLFM8uugUwGz+5YN3nrG7Br1+Mdl6lRU
         6fSkOtxfYBLD5FH0904KmYUKOM3qdjIIfLv5/Wq7iQxXK+uH0eK9R9QgGKkVe15U4Fzj
         mnQyAiW/M+w/QCXLxFWORrSz2/0t709OlT3zaBLzI+TV8KAc3t6uQEHXRVRb6tlxOISm
         E/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IKkwB2u3RprM1X4hsNuukS/0BGVoFPj4z3dF1uNmQ5k=;
        b=ksbb9uHXwv4IaThOZET+4y/3n/1iG5BAOuMEiEKnlJ1QhyE3aq7spjbsRH2Z7OeCc6
         WXMIs1skA74kSPNbJsAW5UX2ll2ajZydTxG9KA/Nbqc7qNLi4sAGmePGNj7zRPC2AMfL
         qMRkVsvZJpMjOI9fIDbEsgHi5eRDhACepHoovoo9DRd0PWpnUwa2mS2enLGZN0Lgdq+j
         qwDe/Glnf0NsZDWJU5AflG6qPKPwuQzGsYX6ka/ToB/HYU+/CEgJS977WSZji6jkmOpk
         flVWg2EwdJCAmXOnhjUkJjGSmTqsaur1CffdxTFrqlC3d6cFMxlG+J0Lz+sanD71NE0+
         cVAA==
X-Gm-Message-State: AOAM5314u2tYBUlF1Ww2DLowr32HQJCQugtDcbKySIVfMFfJsfp0SGzG
        iD3vxQpAQIGcoXWd3O31Cb0=
X-Google-Smtp-Source: ABdhPJxRiUFYDsOCZy7PxGFgR+CEdSSVPiBaoaQwdljyhRGESN40nKKj+wq4k3cfRI8QTeW900ee5Q==
X-Received: by 2002:ad4:5bae:: with SMTP id 14mr5145809qvq.22.1628790360939;
        Thu, 12 Aug 2021 10:46:00 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id l145sm1767103qke.92.2021.08.12.10.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:46:00 -0700 (PDT)
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
Date:   Thu, 12 Aug 2021 13:45:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

Le 2021-08-10 à 15:20, Josh Steadmon a écrit :
> Silently skipping commits when rebasing with --no-reapply-cherry-picks
> (currently the default behavior) can cause user confusion. Issue advice
> in this case so that users are aware of what's happening.

I think this is an excellent idea. It can be very surprising, especially
for 'git rebase' beginners/intermediate users who might not have read the
man page.

Since your proposed changes are in sequencer.c, this will only affect
the default "merge" rebase backend, and not the older 'apply' backend. I think
it might be worth mentioning this in the commit message.

Note that it might be considerably more work to also add the warning
for the 'apply' backend, since rebase.c::run_am generates the patches
using 'git format-patch --cherry-pick --right-only $upstream..HEAD' and
so cherry-picks are dropped early in the process. I think that this not that big
of a deal since the default backend is now "merge".

> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> Changes in V2:
> * use advise_if_enabled() instead of warning()
> * s/seen/applied/ in the advice text
> 
>   Documentation/config/advice.txt |  3 +++
>   advice.c                        |  3 +++
>   advice.h                        |  1 +
>   sequencer.c                     | 22 ++++++++++++++++++++--
>   4 files changed, 27 insertions(+), 2 deletions(-)

I would suggest mentioning the new behaviour and the new
advice.skippedCherryPicks config in git-rebase.txt, say in the paragraph
starting with "If the upstream branch already contains" in the Description section
and in the description of '--reapply-cherry-picks'.

>   int git_default_advice_config(const char *var, const char *value);
> diff --git a/sequencer.c b/sequencer.c
> index 7f07cd00f3..1235f61c9d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5099,6 +5099,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
>   	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
>   	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
> +	int skipped_commit = 0;
>   	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
>   	struct strbuf label = STRBUF_INIT;
>   	struct commit_list *commits = NULL, **tail = &commits, *iter;
> @@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   		oidset_insert(&interesting, &commit->object.oid);
>   
>   		is_empty = is_original_commit_empty(commit);
> -		if (!is_empty && (commit->object.flags & PATCHSAME))
> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +					_("skipped previously applied commit %s"),
> +					short_commit_name(commit));
> +			skipped_commit = 1;
>   			continue;
> +		}
>   		if (is_empty && !keep_empty)
>   			continue;

For interactive rebase, an alternate implementation, that I suggested in [1] last summer, would be to keep
the cherry-picks in the todo list, but mark them as 'drop' and add a comment at the
end of their line, like '# already applied' or something like this, similar
to how empty commits have '# empty' appended. I think that for interactive rebase, I
would prefer this, since it is easier for the user to notice it and change the 'drop'
to 'pick' right away if they realise they do not want to drop those commits (easier
than seeing the warning, realising they did not want to drop them, aborting the rebase
and redoing it with '--reapply-cherry-picks').

For non-interactive rebase adding a warning/advice like your patch does seems to
be a good solution.

>   
> @@ -5214,6 +5220,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>   		oidcpy(&entry->entry.oid, &commit->object.oid);
>   		oidmap_put(&commit2todo, entry);
>   	}
> +	if (skipped_commit)
> +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +				  _("use --reapply-cherry-picks to include skipped commits"));
>   
>   	/*
>   	 * Second phase:
> @@ -5334,6 +5343,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>   	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
>   	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
>   	int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
> +	int skipped_commit = 0;
>   
>   	repo_init_revisions(r, &revs, NULL);
>   	revs.verbose_header = 1;
> @@ -5369,8 +5379,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>   	while ((commit = get_revision(&revs))) {
>   		int is_empty = is_original_commit_empty(commit);
>   
> -		if (!is_empty && (commit->object.flags & PATCHSAME))
> +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +					  _("skipped previously applied commit %s"),
> +					  short_commit_name(commit));
> +			skipped_commit = 1;
>   			continue;
> +		}
>   		if (is_empty && !keep_empty)
>   			continue;
>   		strbuf_addf(out, "%s %s ", insn,
> @@ -5380,6 +5395,9 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>   			strbuf_addf(out, " %c empty", comment_line_char);
>   		strbuf_addch(out, '\n');
>   	}
> +	if (skipped_commit)
> +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> +				  _("use --reapply-cherry-picks to include skipped commits"));
>   	return 0;
>   }
>   
> 

Like Junio remarked, it is a little unfortunate that some logic is duplicated between
'sequencer_make_script' and 'make_script_with_merges', such that your patch has to do
the same thing at two different code locations. Maybe a preparatory cleanup could add
a new function that takes care of the duplicated logic and call if from both ? I'm
just thinking out loud here, I did not analyze in details if this would be easy/feasible...

Thanks for suggesting this change,

Philippe.


[1] https://lore.kernel.org/git/0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com/
