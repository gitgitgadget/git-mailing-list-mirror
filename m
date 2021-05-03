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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D6C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F05610E6
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhECPiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhECPh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:37:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CDDC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:37:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l14so6056460wrx.5
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OEndZfapI+RGgAOcuD52zimVDPviNmUtaZJGd3mQKXc=;
        b=omGOkNa/Z9JBukrX+DVUnVgTez6Fb7/Dou1DLdtsdlLeu6DGRPXYkW16Me2uQJXWcq
         noN0v2gMxbZ+XAaEHvYFnX8h0i5xBZ+oeGiY0gfe90QBW6dTV3P3v06EN/eCFHTC81ur
         vAx8VqGH+hBcNjV2u6G/gpCHJAAJAUHeJH7Vdjn2FjLpe4zCiI+PbpT2KvqKexG9gNZz
         7+iPCEE7hjTiRQdZXYtpKNpFBQTwv6avxvP7G5HqmMnWgHPWuZ5CCzhBgXYmmMZbRcBh
         zTIaC3kk2YEXQAqkEOqzAuUzr+H2NsoyCctQEfQIi++r7PtszQzwnavjVOzq7gwVWElR
         NWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OEndZfapI+RGgAOcuD52zimVDPviNmUtaZJGd3mQKXc=;
        b=Bblld5Z/9G6Z3qVerKZqDIMQKluVk8yYHvY1W/FRJB2iP3II/7RFOJAlEAWxkjilT0
         qEjYsNzn33QA9fLdRnwGB/lorhzsyLVjId6G5dNIRiRckffOr7Eqo3U2WY/QFm5FR3Bj
         jZ/WgS+qZgmnE/eIyMyUQG7/5sbhQOT5P1zgxGqhCJLb1III4sRC0XEEDmUmFszO4pY0
         SxleQa66vGeQPJPoMghlJSeTh7nbj/yaJ1IM4n2idcb6S/ho7EqkonV4gm/Snq7Judyn
         ATYhgMa1SXMIutPfS3k/OvpA6RBIKK01em/acchg2KuLU8dZ1GS6+chyo3Tiotjj+BFM
         25Bw==
X-Gm-Message-State: AOAM532CdWF1lMOdyBZcIj+uAjQA245no1q1g+jeuYLMg64rq35LC6NU
        KyJY/2gQjWLFndu8wGYUfiMZVmTkZMA=
X-Google-Smtp-Source: ABdhPJxnq1thaID6lkQoLsz0E5UDVg8m1/bW40wAIekzaZN/q01eVjA2IaqGs87RfuZ9G9BKdtUkWQ==
X-Received: by 2002:adf:f891:: with SMTP id u17mr6235691wrp.352.1620056223014;
        Mon, 03 May 2021 08:37:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm2118wmb.35.2021.05.03.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:37:02 -0700 (PDT)
Message-Id: <pull.939.v4.git.1620056221874.gitgitgadget@gmail.com>
In-Reply-To: <pull.939.v3.git.1619347306291.gitgitgadget@gmail.com>
References: <pull.939.v3.git.1619347306291.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 May 2021 15:37:01 +0000
Subject: [PATCH v4] [GSOC] pretty: provide human date format
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
        <avarab@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        ZheNing Hu <adlternative@gmail.com>,
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
    
    Change from v3: Fix format errors.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2Fadlternative%2Fpretty_human-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlternative/pretty_human-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/939

Range-diff vs v3:

 1:  67c57d8f4a17 ! 1:  8e5ae0d9a01e [GSOC] pretty: provide human date format
     @@ Documentation/pretty-formats.txt: The placeholders are:
       '%ci':: committer date, ISO 8601-like format
       '%cI':: committer date, strict ISO 8601 format
       '%cs':: committer date, short format (`YYYY-MM-DD`)
     -+'%ch':: committer date, human style(like the `--date=human` option of
     ++'%ch':: committer date, human style (like the `--date=human` option of
      +	linkgit:git-rev-list[1])
       '%d':: ref names, like the --decorate option of linkgit:git-log[1]
       '%D':: ref names without the " (", ")" wrapping.


 Documentation/pretty-formats.txt | 4 ++++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 45133066e412..58bb2795284d 100644
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
+'%ch':: committer date, human style (like the `--date=human` option of
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
