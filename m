Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B70C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD7723AC2
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgLROmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgLROmz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 09:42:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB3C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:42:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o13so6042352lfr.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=euhU1OGXCdITHgfJTe8SVzp2UGHejr4j9YYZSDIyk1A=;
        b=YH9fWhxa5jK8r7yg6DMVP+3VNj+KasKz/vcLnjHNbT+hZudulVTkQdqTEJKuvHwYI0
         CDIzVOoD6MZEPPUuJr7oP2YvZgs/w0tDRF64cWltjL26Tu2SGJitssYxMsh9OH5eEQyK
         gC1RkHt51mCQqQwvw+AWAwUkqkV2Koz0UPzNcXpNHEkGYmhkSHLRTY9v8qg4YLiecQeW
         P962zMG7X5iFd34maTyPqb98r06JZDyvN3vdc5cUw0YfhY5Y295SYPZKkCIiYo/KSvmx
         IIo+AGHBZTVi0Cq99NBA5o63PaMCUmDKsIVIEn+BS/wp2xX6lPm7TO0UbDiDXUoc3Cj4
         uZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=euhU1OGXCdITHgfJTe8SVzp2UGHejr4j9YYZSDIyk1A=;
        b=Hc6HiOfBicQHhlmMH5D80DfgL+WxuaTTWawb+8hmQxCy/05Is1q6vxe94jc8dBWpPA
         MMw8Avz0vSmr6Eq9MlAs8oSnNYWkueIAhOKAOoKsVu9AIscWfeAJ6W38GnDviOER8xpV
         jS74pJp9Fs5HZnzE6gEc48DB4D5fN0qfRPwcAgDQIXpQ5DoEzZSDjKDrfAgtqGfkGelE
         IhLSkEMnw+ALwurH/ulnVxId6+qGLKfTWaBAHgVETACcKm2nNFPdG6PyeY36HPp3Vwa9
         aK4wrFBnc/llbGY+qltUp2Qebr6hYd/nhc6vysTymVbr4HcsukvqVXAnLIHW/jNDO8IB
         +BSA==
X-Gm-Message-State: AOAM531ZUCR+bdsdsahYuWsbVq7yoWdgTqRsISMEZ90iOhE9ieGBCYdI
        Kuh1nl1hFFicnwaGBlpCsFzrlmNu5uw=
X-Google-Smtp-Source: ABdhPJwe3H/nqJsEcZvm5cddDP0Cttl8U69s/1kPLmOVzUOgfuVReatITK3L8Ra3362H7oDwRiQk5w==
X-Received: by 2002:a2e:b5d8:: with SMTP id g24mr2063519ljn.50.1608302532756;
        Fri, 18 Dec 2020 06:42:12 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q12sm1060133ljc.49.2020.12.18.06.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:42:11 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-27-sorganov@gmail.com>
        <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
Date:   Fri, 18 Dec 2020 17:42:10 +0300
In-Reply-To: <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Dec 2020 22:12:11 -0800")
Message-ID: <87wnxfb2gt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> New options don't have any visible effect unless -p is either given or
>> implied, as unlike -c/-cc we don't imply -p with --diff-merges. To fix
>> this, this patch adds new functionality by letting new options enable
>> output of diffs for merge commits only.
>>
>> Add 'merges_need_diff' field and set it whenever diff output for merges is
>> enabled by any of the new options.
>>
>> Extend diff output logic accordingly, to output diffs for merges when
>> 'merges_need_diff' is set even when no -p has been provided.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  diff-merges.c | 16 ++++++++++------
>>  log-tree.c    | 13 +++++++++----
>>  revision.h    |  1 +
>>  3 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/diff-merges.c b/diff-merges.c
>> index 725db2312074..ffe20d8daa4a 100644
>> --- a/diff-merges.c
>> +++ b/diff-merges.c
>> @@ -10,6 +10,7 @@ static void suppress(struct rev_info *revs)
>>         revs->dense_combined_merges = 0;
>>         revs->combined_all_paths = 0;
>>         revs->combined_imply_patch = 0;
>> +       revs->merges_need_diff = 0;
>>  }
>>
>>  static void set_separate(struct rev_info *revs)
>> @@ -51,9 +52,11 @@ static void set_dense_combined(struct rev_info *revs)
>>
>>  static void set_diff_merges(struct rev_info *revs, const char *optarg)
>>  {
>
>> +       if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
>> +               suppress(revs);
>> +               return;
>> +       }
>>         if (0) ;
>> -       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
>> -               suppress(revs);
>
> The "if (0) ;" is still really weird.

An idiom (see my previous answer). I'm fine getting rid of it if you
guys find it weird (that I'm not).

>
>>         else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
>>                 set_first_parent(revs);
>>         else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
>> @@ -64,6 +67,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
>>                 set_dense_combined(revs);
>>         else
>>                 die(_("unknown value for --diff-merges: %s"), optarg);
>> +       revs->merges_need_diff = 1;
>
> I'd put this above the if-else-else block, to make it clearer why you
> are returning early for the "off"/"none" case.

Yeah, makes sense, thanks!

>
>>  }
>>
>>  /*
>> @@ -132,12 +136,12 @@ void diff_merges_setup_revs(struct rev_info *revs)
>>                 revs->first_parent_merges = 0;
>>         if (revs->combined_all_paths && !revs->combine_merges)
>>                 die("--combined-all-paths makes no sense without -c or --cc");
>> -       if (revs->combine_merges)
>> +
>> +       if (revs->combined_imply_patch)
>>                 revs->diff = 1;
>> -       if (revs->combined_imply_patch) {
>> -               /* Turn --cc/-c into -p --cc/-c when -p was not given */
>> +
>> +       if (revs->combined_imply_patch || revs->merges_need_diff) {
>>                 if (!revs->diffopt.output_format)
>>                         revs->diffopt.output_format = DIFF_FORMAT_PATCH;
>>         }
>> -
>
> The random space changes squashed in here instead of being combined
> with the earlier patches that introduced the relevant areas break up
> the reading.  Would be nice to clean this up.
>
>>  }
>> diff --git a/log-tree.c b/log-tree.c
>> index f9385b1dae6f..67060492ca0a 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>>         int showed_log;
>>         struct commit_list *parents;
>>         struct object_id *oid;
>> +       int is_merge;
>> +       int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>
> So rev_info.diff has changed in meaning from
> commits-need-to-show-a-diff, to non-merge-commits-need-to-show-a-diff.
> That's a somewhat subtle semantic shift.  Perhaps it's worth adding a
> comment to the declaration of rev_info.diff to highlight this?  (And
> perhaps even rename the flag?)

No, the meaning of rev_info.diff hopefully didn't change. rev_info.diff
still enables all the commits to pass further once set. It is still
exactly the same old condition, just assigned to a variable for reuse.
My aim was to avoid touching existing logic of this function and only
add a new functionality when opt->merges_need_diff is set.

It looks like I rather choose confusing name for the variable, and it'd
be more clear if I'd call this, say:

  int need_diff = opt->diff || opt->diffopt.flags.exit_with_status;

?

What do you think?

>
>> -       if (!opt->diff && !opt->diffopt.flags.exit_with_status)
>> +       if (!regulars_need_diff && !opt->merges_need_diff)
>>                 return 0;
>>
>>         parse_commit_or_die(commit);
>>         oid = get_commit_tree_oid(commit);
>>
>> -       /* Root commit? */
>>         parents = get_saved_parents(opt, commit);
>> +       is_merge = parents && parents->next;
>> +       if(!is_merge && !regulars_need_diff)
>> +               return 0;
>> +
>> +       /* Root commit? */
>>         if (!parents) {
>>                 if (opt->show_root_diff) {
>>                         diff_root_tree_oid(oid, "", &opt->diffopt);
>> @@ -916,8 +922,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>>                 return !opt->loginfo;
>>         }
>>
>> -       /* More than one parent? */
>> -       if (parents->next) {
>> +       if (is_merge) {
>>                 if (opt->combine_merges)
>>                         return do_diff_combined(opt, commit);
>>                 if (opt->separate_merges) {
>> diff --git a/revision.h b/revision.h
>> index bfbae526ad6e..494d86142454 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -194,6 +194,7 @@ struct rev_info {
>>                         always_show_header:1,
>>                         /* Diff-merge flags */
>>                         explicit_diff_merges: 1,
>> +                       merges_need_diff: 1,
>>                         separate_merges: 1,
>>                         combine_merges:1,
>>                         combined_all_paths:1,
>> --
>> 2.25.1
>
> The rest makes sense.

Thanks,
-- Sergey

