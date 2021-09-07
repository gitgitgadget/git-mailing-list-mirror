Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DFEC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDF26103E
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbhIGVGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346617AbhIGVG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7BCC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so303623wms.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Q1820TIN9Te7W2uFLd7/E73z6PycF6gol1jzAM2MjPs=;
        b=J1HeVKuQpYHUPhSb1QJ5bDnJJm63wvznZqk5jspdCmmrYlMvK3/Zz/WhkpiBOwNY/T
         FOrVG82u2axqk8hpyqF1WODKCtGVboYGoIIgn5zw4bf3kJrcF1ZOZOgA2iQPETWmehgu
         Xk+PI75nVHD0zkZ1EY4expgNHJefD0B3nDdAV1CJ0Q8FjyJWFqrbRwvA2DJgQ7M0Iqb5
         AQq4GmklvGZcj7riqS6NO9/bKmEdxOLqOkTwfcR2NCuaa/Q62nT/elCBxiWn8fWJrVSt
         eLyvpgUM4QDueKj2BVwGsFi8xdD0tQG6Fond6bDamTKuk1GEK2XEb48MgtFizrt+k6Z4
         72fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Q1820TIN9Te7W2uFLd7/E73z6PycF6gol1jzAM2MjPs=;
        b=thr30GimyiTHVzIzyshdMr7HWMla9N86lkJ+SxgsDldrNDcrbOQcl2D8UW7uvwkEe6
         5y03u/chCxy98w54+fguyaCKhgwlpefJdgZes8hX5NUL7PGdvDwbtUEsnZWtsJpnT5w2
         9pXtoSYEDOY+01ni9u+2ayjmI10sdv7co+9Y74yUOaeJulAfPTy2WuZghBzn8nzU9LCw
         SLzFcFPBHeoP98x0En+m0mrTAcxtp35ZBCYR9vTDDpHn493oV0Pqvhg+BqAi4u4vLKx1
         SdQk/qUCy+dxMajLW6njMusjqSO93VqzlKGM9AQLD/WtIgblFZdwwpKr4nc6Fr3lOtLD
         n0PQ==
X-Gm-Message-State: AOAM531y/JvNRd70v9PeaZ8J0LlonJLJbQ8yBVUjCzdkV3dQNjj9kena
        QsIJFlcJP/Se4cAEGubbMhZXZnszUXU=
X-Google-Smtp-Source: ABdhPJz+1tsGETySMq4vhNbBgNiFnCAttvm3ccvsqt9aJmf1bxJ0NczDdZkiSZVR1tItV1nv15+t5g==
X-Received: by 2002:a1c:80d7:: with SMTP id b206mr243012wmd.36.1631048718118;
        Tue, 07 Sep 2021 14:05:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u27sm128239wru.2.2021.09.07.14.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:17 -0700 (PDT)
Message-Id: <913647d8e76b74bfd2de77463aea14d501489186.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:07 +0000
Subject: [PATCH v3 06/11] git-svn: drop support for `--preserve-merges`
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already passed the `--rebase-merges` option to `git rebase` instead,
now we make this move permanent.

As pointed out by Ævar Arnfjörð Bjarmason, in contrast to the
deprecation of `git rebase`'s `--preserve-merges` backend, `git svn`
only deprecated this option in v2.25.0 (because this developer missed
`git svn`'s use of that backend when deprecating the rebase backend
running up to Git v2.22).

Still, v2.25.0 has been released on January 13th, 2020. In other words,
`git svn` deprecated this option over one and a half years ago, _and_
has been redirecting to the `--rebase-merges` option during all that
time (read: `git svn rebase --preserve-merges` didn't do _precisely_
what the user asked, since v2.25.0, anyway, it fell back to pretending
that the user asked for `git svn rebase --rebase-merges` instead).

It is time to act on that deprecation and remove that option after all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-svn.txt | 1 -
 git-svn.perl              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index d5776ffcfd5..222b556d7a9 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -678,7 +678,6 @@ config key: svn.authorsProg
 --strategy=<strategy>::
 -p::
 --rebase-merges::
---preserve-merges (DEPRECATED)::
 	These are only used with the 'dcommit' and 'rebase' commands.
 +
 Passed directly to 'git rebase' when using 'dcommit' if a
diff --git a/git-svn.perl b/git-svn.perl
index 70cb5e2a83b..be987e316f9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -273,7 +273,6 @@ my %cmd = (
 			  'fetch-all|all' => \$_fetch_all,
 			  'dry-run|n' => \$_dry_run,
 			  'rebase-merges|p' => \$_rebase_merges,
-			  'preserve-merges|p' => \$_rebase_merges,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
-- 
gitgitgadget

