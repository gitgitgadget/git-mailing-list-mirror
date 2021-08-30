Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A0C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B59060F4B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhH3VWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhH3VWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:22:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C560C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:21:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so895064pjq.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pKydGJVCB5SzBnhjolHzU1hPrQQBV+pB6L4fYmUXp0w=;
        b=cM07NJBivB7uUuPN2mEKamFl/XnFH03U7VGILgjZc+/XNg4yXvvlxqAkMLdDA3jP+e
         Q7Hn3rACLjYRMSi/k/jreljy/4TS2lrNfG4LCN3BU26nEf61TWnc09Hrd1lSIA2pPTZ5
         fOAEZoOWYUSJ2Sh/BeemBpuIXRmSaWSR6xNiISPFRXVnq0btiwsqWHuxlrZEvNkVA0Vd
         tmvRDSXVcfLVFQ8DYvevuh1+K1bGykI9SckytJ9drzWYPPF1LSBLqVSPDMVMMLgYW+Rc
         DWqVbNZijCTSgyPNAEYgO0xt8TpTyfrleWgyz/L3ap4cMYPpHSIG8gZeUz7qZUNnqcN6
         eE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=pKydGJVCB5SzBnhjolHzU1hPrQQBV+pB6L4fYmUXp0w=;
        b=oel376CeUyF3St8Vsnc9wZdG6bzApaB+BQIlGRsxoqe7I4rcxrNOPduLzG6654328o
         U3Uj+c+/Ov7v2yUft21UPE68d7YaaUhxry7GWh7hrJR7UKardctT3wwxESoMLI9pS8TI
         jkaCP491lkf+FLiN/8wNatVGdqjT9OXrFWzmRhw3agLvrVQNWmNTYwJBeuKkbTCN01fy
         rQ4/rqwqjLjD2ZgjjLcUZ7Kg3iMs3B8BMbt8t/N7t9QDHcWYUKDTNY4kCvC2cSEe9tq/
         0jt0MfIrArKEtDMIY8z3CZEi5e3N+bmprOeobaUcXVK+NC68UW9OGXryy4da7NMq9eur
         LoNA==
X-Gm-Message-State: AOAM532TE8bP0BjC3Pw0kR5yyKlRaiqGckXgW6fzUHww8rOF72pj76pc
        NEltNpQKZDro4jsOromddcwi6g==
X-Google-Smtp-Source: ABdhPJzqTcEJIa4s3HlKKfy3obbwlS56rL3IIKmrc64JOFtVEKwQjpBR56kZTAYx/1rDFhtnBu5u4w==
X-Received: by 2002:a17:90a:d712:: with SMTP id y18mr1194038pju.37.1630358480815;
        Mon, 30 Aug 2021 14:21:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:16fe:83fb:786f:9778])
        by smtp.gmail.com with ESMTPSA id o9sm16226667pfh.217.2021.08.30.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:21:20 -0700 (PDT)
Date:   Mon, 30 Aug 2021 14:21:14 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
Message-ID: <YS1LyjjOgER2R1fv@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, phillip.wood123@gmail.com
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
 <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.08.12 13:45, Philippe Blain wrote:
> Hi Josh,
> 
> Le 2021-08-10 à 15:20, Josh Steadmon a écrit :
> > Silently skipping commits when rebasing with --no-reapply-cherry-picks
> > (currently the default behavior) can cause user confusion. Issue advice
> > in this case so that users are aware of what's happening.
> 
> I think this is an excellent idea. It can be very surprising, especially
> for 'git rebase' beginners/intermediate users who might not have read the
> man page.
> 
> Since your proposed changes are in sequencer.c, this will only affect
> the default "merge" rebase backend, and not the older 'apply' backend. I think
> it might be worth mentioning this in the commit message.
> 
> Note that it might be considerably more work to also add the warning
> for the 'apply' backend, since rebase.c::run_am generates the patches
> using 'git format-patch --cherry-pick --right-only $upstream..HEAD' and
> so cherry-picks are dropped early in the process. I think that this not that big
> of a deal since the default backend is now "merge".

Ah good point, thank you for the catch. I have noted this in the V3
commit message.

> > 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> > Changes in V2:
> > * use advise_if_enabled() instead of warning()
> > * s/seen/applied/ in the advice text
> > 
> >   Documentation/config/advice.txt |  3 +++
> >   advice.c                        |  3 +++
> >   advice.h                        |  1 +
> >   sequencer.c                     | 22 ++++++++++++++++++++--
> >   4 files changed, 27 insertions(+), 2 deletions(-)
> 
> I would suggest mentioning the new behaviour and the new
> advice.skippedCherryPicks config in git-rebase.txt, say in the paragraph
> starting with "If the upstream branch already contains" in the Description section
> and in the description of '--reapply-cherry-picks'.

Done in V3.


> >   int git_default_advice_config(const char *var, const char *value);
> > diff --git a/sequencer.c b/sequencer.c
> > index 7f07cd00f3..1235f61c9d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -5099,6 +5099,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
> >   	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
> >   	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
> >   	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
> > +	int skipped_commit = 0;
> >   	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
> >   	struct strbuf label = STRBUF_INIT;
> >   	struct commit_list *commits = NULL, **tail = &commits, *iter;
> > @@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
> >   		oidset_insert(&interesting, &commit->object.oid);
> >   		is_empty = is_original_commit_empty(commit);
> > -		if (!is_empty && (commit->object.flags & PATCHSAME))
> > +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> > +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> > +					_("skipped previously applied commit %s"),
> > +					short_commit_name(commit));
> > +			skipped_commit = 1;
> >   			continue;
> > +		}
> >   		if (is_empty && !keep_empty)
> >   			continue;
> 
> For interactive rebase, an alternate implementation, that I suggested in [1] last summer, would be to keep
> the cherry-picks in the todo list, but mark them as 'drop' and add a comment at the
> end of their line, like '# already applied' or something like this, similar
> to how empty commits have '# empty' appended. I think that for interactive rebase, I
> would prefer this, since it is easier for the user to notice it and change the 'drop'
> to 'pick' right away if they realise they do not want to drop those commits (easier
> than seeing the warning, realising they did not want to drop them, aborting the rebase
> and redoing it with '--reapply-cherry-picks').

I haven't had time to do this in V3, but I can look into it for V4.

> For non-interactive rebase adding a warning/advice like your patch does seems to
> be a good solution.
> 
> > @@ -5214,6 +5220,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
> >   		oidcpy(&entry->entry.oid, &commit->object.oid);
> >   		oidmap_put(&commit2todo, entry);
> >   	}
> > +	if (skipped_commit)
> > +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> > +				  _("use --reapply-cherry-picks to include skipped commits"));
> >   	/*
> >   	 * Second phase:
> > @@ -5334,6 +5343,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
> >   	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
> >   	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
> >   	int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
> > +	int skipped_commit = 0;
> >   	repo_init_revisions(r, &revs, NULL);
> >   	revs.verbose_header = 1;
> > @@ -5369,8 +5379,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
> >   	while ((commit = get_revision(&revs))) {
> >   		int is_empty = is_original_commit_empty(commit);
> > -		if (!is_empty && (commit->object.flags & PATCHSAME))
> > +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> > +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> > +					  _("skipped previously applied commit %s"),
> > +					  short_commit_name(commit));
> > +			skipped_commit = 1;
> >   			continue;
> > +		}
> >   		if (is_empty && !keep_empty)
> >   			continue;
> >   		strbuf_addf(out, "%s %s ", insn,
> > @@ -5380,6 +5395,9 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
> >   			strbuf_addf(out, " %c empty", comment_line_char);
> >   		strbuf_addch(out, '\n');
> >   	}
> > +	if (skipped_commit)
> > +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> > +				  _("use --reapply-cherry-picks to include skipped commits"));
> >   	return 0;
> >   }
> > 
> 
> Like Junio remarked, it is a little unfortunate that some logic is duplicated between
> 'sequencer_make_script' and 'make_script_with_merges', such that your patch has to do
> the same thing at two different code locations. Maybe a preparatory cleanup could add
> a new function that takes care of the duplicated logic and call if from both ? I'm
> just thinking out loud here, I did not analyze in details if this would be easy/feasible...

Will look into this for V4 as well.

> Thanks for suggesting this change,
> 
> Philippe.
> 
> 
> [1] https://lore.kernel.org/git/0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com/
