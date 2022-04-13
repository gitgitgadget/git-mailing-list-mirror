Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F286C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiDMUNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiDMUNb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:13:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DB38DBF
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:11:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r13so6211273ejd.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jKoyc/JhkDffbOFF7HogFGJp4kdysPRE17ifvAStHB8=;
        b=Xe11pm0WtowKy+MbdPDtfWCCIGfFaggzi9vYfbKq9y0gj8NySqXKvC5qLkxQJaHs2c
         LKWcN18qAqZtvPEj68nNEd2ss12TB6rEH2TdocSF0VZtReQ3hstxxLc0V53cWXuPTvRt
         p5xayz5VqhrR2moIZy1J5zlRa3+7aqsy+8GywygsxZ9NS5V0kvD093OpG/6thlspxyLn
         otnnDXkphY6vraaz8ndP+1VjM2+QjUIcO2BIDX8zaBX5pWonbvBOC9c0aR+6PiV7JaKi
         zNgwF4KCR7EPedV3X83uZdwP049cYuRze/LrCU2feoYJ93kpCEjyXTsc8TWD6n8o2iNs
         dwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jKoyc/JhkDffbOFF7HogFGJp4kdysPRE17ifvAStHB8=;
        b=rWoYsIHmKeP+2hy0nixCFc0VsZvwuysjFb3s3uYO9ThIoBym9QSdgA1US6ekO/f1ZZ
         9mdcJFQ7lz3jBXn7PktFeijg9z/8eon6bt2NON67e5+VN7eIxVPYGIzViJp4nB8nIHkH
         tS3bjdjzFM3fR+Y9vjvGzJ9k84QTEWD+WMuxoJvTNBraHFTYLvcWFYHizyDSa5WJsE90
         Z4c+auU6H7yoaDxheHlHrazDkFuddCatx1TG8efUUrc0Xb9gW9dLZ1sItheB+7i2RmGu
         PY7ND6XTdaT13juAcn8qZpYngQgMty1Rt97QY4q4BM3g50Fe87rzdKMUZbDTXJ8jEMb+
         Bv5g==
X-Gm-Message-State: AOAM530yh4HZhNUye6QZTIhVK8iorZxltNf0FT8Zd2hteYnwD6lv8wJq
        fZuIH9j6Xm9I36NFsaai810=
X-Google-Smtp-Source: ABdhPJzyEx0ATFZ6qBnTOBBfGSMo+1DLuz+2hWVBnokhJcfzaufrEKgqzYLNhzzDdpaGnYr4uSLZiw==
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id rl15-20020a170907216f00b006ced85f35cfmr41702876ejb.517.1649880666486;
        Wed, 13 Apr 2022 13:11:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bs2-20020a056402304200b0041fc40eeb91sm938103edb.49.2022.04.13.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:11:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nejKT-005C51-0A;
        Wed, 13 Apr 2022 22:11:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: ab/plug-leak-in-revisions (was: What's cooking in git.git (Apr
 2022, #03; Tue, 12))
Date:   Wed, 13 Apr 2022 22:08:54 +0200
References: <xmqq8rsab5do.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rsab5do.fsf@gitster.g>
Message-ID: <220413.86bkx4eobr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 12 2022, Junio C Hamano wrote:

> * ab/plug-leak-in-revisions (2022-04-03) 28 commits
>  - revisions API: add a TODO for diff_free(&revs->diffopt)
>  - revisions API: have release_revisions() release "topo_walk_info"
>  - revisions API: have release_revisions() release "date_mode"
>  - revisions API: call diff_free(&revs->pruning) in revisions_release()
>  - revisions API: release "reflog_info" in release revisions()
>  - revisions API: clear "boundary_commits" in release_revisions()
>  - revisions API: have release_revisions() release "prune_data"
>  - revisions API: have release_revisions() release "grep_filter"
>  - revisions API: have release_revisions() release "filter"
>  - revisions API: have release_revisions() release "cmdline"
>  - revisions API: have release_revisions() release "mailmap"
>  - revisions API: have release_revisions() release "commits"
>  - revisions API users: use release_revisions() for "prune_data" users
>  - revisions API users: use release_revisions() with UNLEAK()
>  - revisions API users: use release_revisions() in builtin/log.c
>  - revisions API users: use release_revisions() in http-push.c
>  - revisions API users: add "goto cleanup" for release_revisions()
>  - stash: always have the owner of "stash_info" free it
>  - revisions API users: use release_revisions() needing REV_INFO_INIT
>  - revision.[ch]: document and move code declared around "init"
>  - revisions API users: add straightforward release_revisions()
>  - revision.[ch]: provide and start using a release_revisions()
>  - cocci: add and apply free_commit_list() rules
>  - format-patch: don't leak "extra_headers" or "ref_message_ids"
>  - string_list API users: use string_list_init_{no,}dup
>  - blame: use "goto cleanup" for cleanup_scoreboard()
>  - t/helper/test-fast-rebase.c: don't leak "struct strbuf"
>  - Merge branch 'ds/partial-bundle-more' into ab/plug-leak-in-revisions
>
>  Plug the memory leaks from the trickiest API of all, the revision
>  walker.
>
>  Will merge to 'next'?
>  source: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>

I think it should be ready with my just-submitted re-roll, which fixes a
trivial nit spotted by Phillip Wood by removing a useless NULL check:
https://lore.kernel.org/git/cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com/
