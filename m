Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D5DC433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A520691
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 00:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbqy4L/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgGQAZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 20:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgGQAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 20:25:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2508C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 17:25:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so4506724pfn.7
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F3I7JGmzU5gvJt7SEPfUFZKZBKhuwknmkAlHO/OqcAM=;
        b=Vbqy4L/uBULuWST4aSp/LZGymD7h7h8fS6GgnlPu0cn+S/vofKdm3H5GApci1MpBWu
         aZ7a/1rK001sBUooKnnlQzAMQVUSDbb+EEfsmRWh27WcGVibWS5M/wmbJvw/oUWiNbVq
         MMjY+3i0EuCSDtIsc+IuWOckEVYCwq1amVUA7QqHvtyXXdNHrbERSUg+ZZZGhd4dz6oo
         MOP3Ma6r9tKu+T8df6Fm5+vW/LyYb7sHv8Tdcce2R/GoA1Bai9BhAYVdR2xqVyhYVaI5
         fNsRfl88VFAwoh9eYJwXjXds1RtmGo/B2Gj0kRX5vBMxS8pqHA3pHyaw9eNVcjf/Cpil
         50SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F3I7JGmzU5gvJt7SEPfUFZKZBKhuwknmkAlHO/OqcAM=;
        b=PcNjrFpDFSvqsaHGRgaLRswp4RkD7dCKOd6xx52YhFdHiqmQ/tYprcN52A334/9WCP
         /NwGBLiYL8l3ERwQWusbDOSPfiK5jHFUNzTuIRmmT7uLWRXzb4bi+BVENtC0Q6X5SOru
         0vWgIdaiKbrvEUMfCsa04EyLwkb49n30GswBmRxXgPYjagyfVnNQMyidzgKGM6XwN+ow
         Nhk74HONi6Msck5kKNtInKNjGC3PWbvoXgGVD6wK81J5OLuU9Ftd99sIJ3OcuD6Jy+zL
         kF4oTWShCQxhnD2Znqy52zWI8ZtjjhJ6Tjzwt2aYnNiwbCjY0w4POckU0yWGESP31uPe
         PHZw==
X-Gm-Message-State: AOAM530UoV1i9fxMpKhieHw0idI+ihoc+jxUkjmp6osnCF+2e1k8fEkC
        dvQS9IiQF7BxLywo9W2bTA4=
X-Google-Smtp-Source: ABdhPJyrkATOC7AgiqlABl2btW7Ck2uT64IoWKoY2S+KMvgFujTItlTRoqCb1qRjMBalFN2vukSutA==
X-Received: by 2002:a62:19c4:: with SMTP id 187mr5713257pfz.312.1594945503647;
        Thu, 16 Jul 2020 17:25:03 -0700 (PDT)
Received: from localhost ([2402:800:6375:2db4:7eb6:3e8e:903a:6638])
        by smtp.gmail.com with ESMTPSA id l9sm1001726pjy.2.2020.07.16.17.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:25:02 -0700 (PDT)
Date:   Fri, 17 Jul 2020 07:25:00 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] rebase -i: support --committer-date-is-author-date
Message-ID: <20200717002500.GA20467@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200713101045.27335-1-phillip.wood123@gmail.com>
 <20200713101045.27335-3-phillip.wood123@gmail.com>
 <20200715142717.GA7803@danh.dev>
 <281d92d3-f901-bca1-6030-fd0c8761f214@gmail.com>
 <20200716130603.GB7803@danh.dev>
 <6f818af7-78b9-d6c8-c0fe-bcb84a4ef8ff@gmail.com>
 <640a3f1b-4e00-4b8a-9a9f-207ea76c648a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <640a3f1b-4e00-4b8a-9a9f-207ea76c648a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-16 18:34:51+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >> That translation isn't correct either.
> >> It seems like it's recurring pattern.
> >> I'll take it to the Vietnamese translation team.
> >>
> >> Anyway, I've checked with other translation that I can understand
> >> in part. I think
> >>
> >>     invalid ident line: %s
> >>
> >> is better candidate for the message.
> > 
> > Yes I realized after sending my email that the string we're printing is
> > NUL terminated so we don't need to specify the length with '*'. I think
> > the best thing would be to change the message in this patch to 'invalid
> > ident line: %s' and then have a follow up after this is merged to change
> > all the "invalid ident line" messages to use "identity" instead. Would
> > you be interested in taking on the follow up patch?
> 
> In the end I decided it was better just to change the message in this
> patch to something more descriptive. We can update the other commands
> separately. For format-patch we should probably update the option
> description for `--from` as well as the error message.

Yes, I also think we should leave the other messages there for now.
When this topic get merged, we will come back to see which one should
be updated/changed.

All other parts look sane to me.

I don't mind get my hand wet if noone steps in.

Thanks,
Danh

> 
> Best Wishes
> 
> Phillip
> 
> > 
> > Best Wishes
> > 
> > Phillip
> > 
> >> Since Spanish translation also mis-translates the message:
> >>
> >>     es.po:9836:msgid "invalid ident line: %.*s"
> >>     es.po-9837-msgstr "sangría no válida: %.*s"
> >>
> >> "sangría" also means "indentation" in this context.
> >>
> >> Thanks,
> >> -Danh
> >>
> >>>
> >>> Best Wishes
> >>>
> >>> Phillip
> >>>
> >>>>
> >>>>> +            goto out;
> >>>>> +        }
> >>>>> +        if (!ident.date_begin) {
> >>>>> +            res = error(_("corrupted author without date
> >>>>> information"));
> >>>>> +            goto out;
> >>>>> +        }
> >>>>> +
> >>>>> +        strbuf_addf(&date, "@%.*s %.*s",
> >>>>> +                (int)(ident.date_end - ident.date_begin),
> >>>>> +                ident.date_begin,
> >>>>> +                (int)(ident.tz_end - ident.tz_begin),
> >>>>> +                ident.tz_begin);
> >>>>> +        res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
> >>>>> +        strbuf_release(&date);
> >>>>> +
> >>>>> +        if (res)
> >>>>> +            goto out;
> >>>>> +    }
> >>>>> +
> >>>>>        if (write_index_as_tree(&tree, r->index, r->index_file, 0,
> >>>>> NULL)) {
> >>>>>            res = error(_("git write-tree failed to write a tree"));
> >>>>>            goto out;
> >>>>> @@ -2532,6 +2578,11 @@ static int read_populate_opts(struct
> >>>>> replay_opts *opts)
> >>>>>                opts->signoff = 1;
> >>>>>            }
> >>>>> +        if (file_exists(rebase_path_cdate_is_adate())) {
> >>>>> +            opts->allow_ff = 0;
> >>>>> +            opts->committer_date_is_author_date = 1;
> >>>>> +        }
> >>>>> +
> >>>>>            if (file_exists(rebase_path_reschedule_failed_exec()))
> >>>>>                opts->reschedule_failed_exec = 1;
> >>>>> @@ -2622,6 +2673,8 @@ int write_basic_state(struct replay_opts
> >>>>> *opts, const char *head_name,
> >>>>>            write_file(rebase_path_drop_redundant_commits(), "%s", "");
> >>>>>        if (opts->keep_redundant_commits)
> >>>>>            write_file(rebase_path_keep_redundant_commits(), "%s", "");
> >>>>> +    if (opts->committer_date_is_author_date)
> >>>>> +        write_file(rebase_path_cdate_is_adate(), "%s", "");
> >>>>>        if (opts->reschedule_failed_exec)
> >>>>>            write_file(rebase_path_reschedule_failed_exec(), "%s", "");
> >>>>> @@ -3542,6 +3595,10 @@ static int do_merge(struct repository *r,
> >>>>>                goto leave_merge;
> >>>>>            }
> >>>>> +        if (opts->committer_date_is_author_date)
> >>>>> +            argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> >>>>> +                     author_date_from_env_array(&cmd.env_array));
> >>>>> +
> >>>>>            cmd.git_cmd = 1;
> >>>>>            argv_array_push(&cmd.args, "merge");
> >>>>>            argv_array_push(&cmd.args, "-s");
> >>>>> @@ -3819,7 +3876,8 @@ static int pick_commits(struct repository *r,
> >>>>>        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> >>>>>        if (opts->allow_ff)
> >>>>>            assert(!(opts->signoff || opts->no_commit ||
> >>>>> -                opts->record_origin || opts->edit));
> >>>>> +                opts->record_origin || opts->edit ||
> >>>>> +                opts->committer_date_is_author_date));
> >>>>>        if (read_and_refresh_cache(r, opts))
> >>>>>            return -1;
> >>>>> diff --git a/sequencer.h b/sequencer.h
> >>>>> index 0bee85093e..4ab94119ae 100644
> >>>>> --- a/sequencer.h
> >>>>> +++ b/sequencer.h
> >>>>> @@ -45,6 +45,7 @@ struct replay_opts {
> >>>>>        int verbose;
> >>>>>        int quiet;
> >>>>>        int reschedule_failed_exec;
> >>>>> +    int committer_date_is_author_date;
> >>>>>        int mainline;
> >>>>> diff --git a/t/t3422-rebase-incompatible-options.sh
> >>>>> b/t/t3422-rebase-incompatible-options.sh
> >>>>> index 55ca46786d..c8234062c6 100755
> >>>>> --- a/t/t3422-rebase-incompatible-options.sh
> >>>>> +++ b/t/t3422-rebase-incompatible-options.sh
> >>>>> @@ -61,7 +61,6 @@ test_rebase_am_only () {
> >>>>>    }
> >>>>>    test_rebase_am_only --whitespace=fix
> >>>>> -test_rebase_am_only --committer-date-is-author-date
> >>>>>    test_rebase_am_only -C4
> >>>>>    test_expect_success REBASE_P '--preserve-merges incompatible
> >>>>> with --signoff' '
> >>>>> diff --git a/t/t3436-rebase-more-options.sh
> >>>>> b/t/t3436-rebase-more-options.sh
> >>>>> index 4f8a6e51c9..50a63d8ebe 100755
> >>>>> --- a/t/t3436-rebase-more-options.sh
> >>>>> +++ b/t/t3436-rebase-more-options.sh
> >>>>> @@ -9,6 +9,9 @@ test_description='tests to ensure compatibility
> >>>>> between am and interactive backe
> >>>>>    . "$TEST_DIRECTORY"/lib-rebase.sh
> >>>>> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
> >>>>> +export GIT_AUTHOR_DATE
> >>>>> +
> >>>>>    # This is a special case in which both am and interactive backends
> >>>>>    # provide the same output. It was done intentionally because
> >>>>>    # both the backends fall short of optimal behaviour.
> >>>>> @@ -21,11 +24,20 @@ test_expect_success 'setup' '
> >>>>>        test_write_lines "line 1" "new line 2" "line 3" >file &&
> >>>>>        git commit -am "update file" &&
> >>>>>        git tag side &&
> >>>>> +    test_commit commit1 foo foo1 &&
> >>>>> +    test_commit commit2 foo foo2 &&
> >>>>> +    test_commit commit3 foo foo3 &&
> >>>>>        git checkout --orphan master &&
> >>>>> +    rm foo &&
> >>>>>        test_write_lines "line 1" "        line 2" "line 3" >file &&
> >>>>>        git commit -am "add file" &&
> >>>>> -    git tag main
> >>>>> +    git tag main &&
> >>>>> +
> >>>>> +    mkdir test-bin &&
> >>>>> +    write_script test-bin/git-merge-test <<-\EOF
> >>>>> +    exec git-merge-recursive "$@"
> >>>>> +    EOF
> >>>>>    '
> >>>>>    test_expect_success '--ignore-whitespace works with apply
> >>>>> backend' '
> >>>>> @@ -52,6 +64,50 @@ test_expect_success '--ignore-whitespace is
> >>>>> remembered when continuing' '
> >>>>>        git diff --exit-code side
> >>>>>    '
> >>>>> +test_ctime_is_atime () {
> >>>>> +    git log $1 --format=%ai >authortime &&
> >>>>> +    git log $1 --format=%ci >committertime &&
> >>>>> +    test_cmp authortime committertime
> >>>>> +}
> >>>>> +
> >>>>> +test_expect_success '--committer-date-is-author-date works with
> >>>>> apply backend' '
> >>>>> +    GIT_AUTHOR_DATE="@1234 +0300" git commit --amend
> >>>>> --reset-author &&
> >>>>> +    git rebase --apply --committer-date-is-author-date HEAD^ &&
> >>>>> +    test_ctime_is_atime -1
> >>>>> +'
> >>>>> +
> >>>>> +test_expect_success '--committer-date-is-author-date works with
> >>>>> merge backend' '
> >>>>> +    GIT_AUTHOR_DATE="@1234 +0300" git commit --amend
> >>>>> --reset-author &&
> >>>>> +    git rebase -m --committer-date-is-author-date HEAD^ &&
> >>>>> +    test_ctime_is_atime -1
> >>>>> +'
> >>>>> +
> >>>>> +test_expect_success '--committer-date-is-author-date works with
> >>>>> rebase -r' '
> >>>>> +    git checkout side &&
> >>>>> +    GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
> >>>>> +    git rebase -r --root --committer-date-is-author-date &&
> >>>>> +    test_ctime_is_atime
> >>>>> +'
> >>>>> +
> >>>>> +test_expect_success '--committer-date-is-author-date works when
> >>>>> forking merge' '
> >>>>> +    git checkout side &&
> >>>>> +    GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
> >>>>> +    PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
> >>>>> +                    --committer-date-is-author-date &&
> >>>>> +    test_ctime_is_atime
> >>>>> +'
> >>>>> +
> >>>>> +test_expect_success '--committer-date-is-author-date works when
> >>>>> committing conflict resolution' '
> >>>>> +    git checkout commit2 &&
> >>>>> +    GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only
> >>>>> --reset-author &&
> >>>>> +    test_must_fail git rebase -m --committer-date-is-author-date \
> >>>>> +        --onto HEAD^^ HEAD^ &&
> >>>>> +    echo resolved > foo &&
> >>>>
> >>>> Nitpick: no space after ">" :D
> >>>>
> >>
> 

-- 
Danh
