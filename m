Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC80C433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 10:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4FE61158
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 10:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhDYKm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDYKm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 06:42:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3ACC061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 03:41:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j5so51865639wrn.4
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZrUXtY74WBlbPcn4HDYKrTdav9aZsjJ7d8dEyj0Maz4=;
        b=trjxs5ClZdrXppLdj6S5glqfnZ8oFrLgcVtlBMNmj/TCNneUjjCY09qzUQPZKfsdcr
         8go47c8AWIMQgbKNnWEZJ7hDNoNAHJph9IHW5foaRz/Bt/eirhwskxhu+eIjq4quoIMA
         x+kjLm0s0e2p/S8NDOFL+JD0G/QLaP7nztjBFuO2h7bb5DWE4Bm1lz9TFaHyHCUS1MpF
         3mflOfMvBeUPdNOrzoLysNHYPeEMuvip2upr6iWtj0BhlpjLIgXUFXQbzb/zs+fNRLG6
         F5UGZl3BXHsZo5vyq/Mq7aQQJWVGO/eGBPgG9RhUJwHNW9mFJHHqSE6tMO8BQSAPCA6X
         YFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZrUXtY74WBlbPcn4HDYKrTdav9aZsjJ7d8dEyj0Maz4=;
        b=s0ZwtjoqpeeMi6AZcnGx8Eq5I49dwNe8bn8zhx760IB9cZigqgictiko5oCKPPwFtR
         UD11YH4+74j1399kqorsFh07qOVuFfQuA/uV3jEGY5GNRmAoyxsm6eY7qBPo88klikre
         JURhAwEZOSghA973G3sYmbiQtVZCFhd1cgw8sMm3G0aF+vdmNed/yUFqJIODShjdyvhv
         k9V6JKrTYvKwiDoh2KRCPyebXZjVxYm/CiIQBY83ZxXGkxFMClLDrZd9EUwfLnJsJ/Ic
         W1y2g8NNcsjboyiWXE+66TomSvHqBgu3MEgbTN0UjBJLjzO1ssoeofM4H9VBlSvzOMV8
         t2wQ==
X-Gm-Message-State: AOAM530IIpZ9IGCE50/leXpx3oNXZk9AIAPlJsVc1vFnUV52yMcHqKdl
        O7SwPEsN/gdVAmF/R+v9vIYu4QiUNuM=
X-Google-Smtp-Source: ABdhPJywwFIdEEkoBE5/e+2wPqiZzYrxQOGq1Tcl14x2AYO4pfHxyyJGckxQbZnf4DggqjgwPiH+Kw==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr16403282wrv.38.1619347307642;
        Sun, 25 Apr 2021 03:41:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5sm16115810wmg.25.2021.04.25.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 03:41:47 -0700 (PDT)
Message-Id: <pull.939.v3.git.1619347306291.gitgitgadget@gmail.com>
In-Reply-To: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
References: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 10:41:45 +0000
Subject: [PATCH v3] [GSOC] pretty: provide human date format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add the placeholders %ah and %ch to format author date and committer
date, like --date=human does, which provides more humanity date output.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] pretty: provide human date format
    
    Reasons for making this patch: --date=human has no corresponding
    --pretty option.
    
    Although --date=human with --pretty="%(a|c)d" can achieve the same
    effect with --pretty="%(a|c)h", but it can be noticed that most time
    formats implement the corresponding option of --pretty, such as
    --date=iso8601 can be replaced by --pretty=%(a|c)i, so add
    --pretty=%(a|c)h seems to be a very reasonable thing.
    
    Change from v2: change %(a|c)h link to git-rev-list and change to more
    suitable test title.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2Fadlternative%2Fpretty_human-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlternative/pretty_human-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/939

Range-diff vs v2:

 1:  1517708876b5 ! 1:  67c57d8f4a17 [GSOC] pretty: provide human date format
     @@ Documentation/pretty-formats.txt: The placeholders are:
       '%ai':: author date, ISO 8601-like format
       '%aI':: author date, strict ISO 8601 format
       '%as':: author date, short format (`YYYY-MM-DD`)
     -+'%ah':: author date, human style (like the --date=human option of
     -+	linkgit:rev-list-options.txt[1])
     ++'%ah':: author date, human style (like the `--date=human` option of
     ++	linkgit:git-rev-list[1])
       '%cn':: committer name
       '%cN':: committer name (respecting .mailmap, see
       	linkgit:git-shortlog[1] or linkgit:git-blame[1])
     @@ Documentation/pretty-formats.txt: The placeholders are:
       '%ci':: committer date, ISO 8601-like format
       '%cI':: committer date, strict ISO 8601 format
       '%cs':: committer date, short format (`YYYY-MM-DD`)
     -+'%ch':: committer date, human style(like the --date=human option of
     -+	linkgit:rev-list-options.txt[1])
     ++'%ch':: committer date, human style(like the `--date=human` option of
     ++	linkgit:git-rev-list[1])
       '%d':: ref names, like the --decorate option of linkgit:git-log[1]
       '%D':: ref names without the " (", ")" wrapping.
       '%(describe[:options])':: human-readable name, like
     @@ t/t4205-log-pretty-formats.sh: test_expect_success 'short date' '
       	test_cmp expected actual
       '
       
     -+test_expect_success 'human date' '
     ++test_expect_success '--date=human %ad%cd is the same as %ah%ch' '
      +	git log --format=%ad%n%cd --date=human >expected &&
      +	git log --format=%ah%n%ch >actual &&
      +	test_cmp expected actual


 Documentation/pretty-formats.txt | 4 ++++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 45133066e412..cd697f508c53 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -190,6 +190,8 @@ The placeholders are:
 '%ai':: author date, ISO 8601-like format
 '%aI':: author date, strict ISO 8601 format
 '%as':: author date, short format (`YYYY-MM-DD`)
+'%ah':: author date, human style (like the `--date=human` option of
+	linkgit:git-rev-list[1])
 '%cn':: committer name
 '%cN':: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -206,6 +208,8 @@ The placeholders are:
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
 '%cs':: committer date, short format (`YYYY-MM-DD`)
+'%ch':: committer date, human style(like the `--date=human` option of
+	linkgit:git-rev-list[1])
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%(describe[:options])':: human-readable name, like
diff --git a/pretty.c b/pretty.c
index e5b33ba034bd..b1ecd039cef2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -745,6 +745,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 'h':	/* date, human */
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(HUMAN)));
+		return placeholder_len;
 	case 's':
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
 		return placeholder_len;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index cabdf7d57a00..10d511ba7307 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -539,6 +539,12 @@ test_expect_success 'short date' '
 	test_cmp expected actual
 '
 
+test_expect_success '--date=human %ad%cd is the same as %ah%ch' '
+	git log --format=%ad%n%cd --date=human >expected &&
+	git log --format=%ah%n%ch >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 test_expect_success 'set up log decoration tests' '
 	head1=$(git rev-parse --verify HEAD~0) &&

base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
-- 
gitgitgadget
