Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE96C433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 14:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C796140F
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 14:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhDXOnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDXOnC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 10:43:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0968C061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 07:42:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p6so44587238wrn.9
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d7Qym9nT5yxKa1otscbqF55yHQ7NRN5xpOG+j96NNjA=;
        b=tku6tU1PaSINIsZ48w0A/VslctXu2qRUsk2mM/w+nGmyU+2VoYvXxLqQoWDurH+2GF
         qwNEyb/sbP/QZ5S5qDb+we1G8uAt5k4z/5PzY2bGaQXegodIt/qbhx9xqrQv6H0UjoyE
         7mnmzAM1WOhFbAS3CVMOk3ByNM6CX01uQmyOegMAE3jYZsxI8jN9VtZsB/cDCAlqqcCt
         lCwKZ+A52EosrGFh5u4gn7ZwFyBKz3ulwNplLoiiV8nThrNym4HR12u+x39c2iIUN/4A
         CqpRs8dScU5TnpCsXxAIJ3gsq9NFIxSmWMc3emasZBhQBnB7HPMZrW0z2Npo7oD8Rxgj
         6Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d7Qym9nT5yxKa1otscbqF55yHQ7NRN5xpOG+j96NNjA=;
        b=nOCY5KEfukiZRvS0eC2UxGlfPUyBtv/rLdwTw/O8vPT9IeF8aW2jUcgzSA/7820xSz
         ArFQBFo0GUHCSrIkQ8CJhISTMPQZncl6H8Q+BML8e5+lXFAd1jk391MeuAC71x8XbbHI
         QtGB58qYwG8Y7aPL18OogD3rApyyzdYeH7G6GwPpxlRQMx6vyWJ/7VfN167IhwfET/1y
         TeDMmqis0lFRGMxwJlAMsPsCmzS/Y+7MCqztrR1IUkbRiKxMr2XS1CAdNxyBThqI7dJq
         ejcOyIP4anXr7OUnWgEoldG89nXNerg2ADvhw4wlUa2rCgJaN5dVcI4DSkm0zzZFR2dd
         AuvA==
X-Gm-Message-State: AOAM532SJQaipRMV3UtgBkPaq24zQ9i6QDcEBt3BRYa/ievf5SldXU/r
        BqjOUli6WyEuLmzF5ThpCOIHyDJNVlU=
X-Google-Smtp-Source: ABdhPJxa1NPsQ8G9wTCcHRPAiodDV0U2oyQGPYVNsDAr3Net7U9JB05e7kzSUzIlAGTwpz6qt7p1EQ==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr3470900wrx.418.1619275341497;
        Sat, 24 Apr 2021 07:42:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y125sm10855225wmy.34.2021.04.24.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 07:42:20 -0700 (PDT)
Message-Id: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
In-Reply-To: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
References: <pull.939.git.1619195245606.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Apr 2021 14:42:19 +0000
Subject: [PATCH v2] [GSOC] pretty: provide human date format
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
    "--pretty=%(a|c)h" seems to be a very reasonable thing.
    
    Change from v1: add %(a|c)h link to rev-list-options.txt.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-939%2Fadlternative%2Fpretty_human-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-939/adlternative/pretty_human-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/939

Range-diff vs v1:

 1:  ed8abd6179d1 ! 1:  1517708876b5 [GSOC] pretty: provide human date format
     @@ Documentation/pretty-formats.txt: The placeholders are:
       '%ai':: author date, ISO 8601-like format
       '%aI':: author date, strict ISO 8601 format
       '%as':: author date, short format (`YYYY-MM-DD`)
     -+'%ah':: author date, human style
     ++'%ah':: author date, human style (like the --date=human option of
     ++	linkgit:rev-list-options.txt[1])
       '%cn':: committer name
       '%cN':: committer name (respecting .mailmap, see
       	linkgit:git-shortlog[1] or linkgit:git-blame[1])
     @@ Documentation/pretty-formats.txt: The placeholders are:
       '%ci':: committer date, ISO 8601-like format
       '%cI':: committer date, strict ISO 8601 format
       '%cs':: committer date, short format (`YYYY-MM-DD`)
     -+'%ch':: committer date, human style
     ++'%ch':: committer date, human style(like the --date=human option of
     ++	linkgit:rev-list-options.txt[1])
       '%d':: ref names, like the --decorate option of linkgit:git-log[1]
       '%D':: ref names without the " (", ")" wrapping.
       '%(describe[:options])':: human-readable name, like


 Documentation/pretty-formats.txt | 4 ++++
 pretty.c                         | 3 +++
 t/t4205-log-pretty-formats.sh    | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 45133066e412..e37d5cbb6b16 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -190,6 +190,8 @@ The placeholders are:
 '%ai':: author date, ISO 8601-like format
 '%aI':: author date, strict ISO 8601 format
 '%as':: author date, short format (`YYYY-MM-DD`)
+'%ah':: author date, human style (like the --date=human option of
+	linkgit:rev-list-options.txt[1])
 '%cn':: committer name
 '%cN':: committer name (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -206,6 +208,8 @@ The placeholders are:
 '%ci':: committer date, ISO 8601-like format
 '%cI':: committer date, strict ISO 8601 format
 '%cs':: committer date, short format (`YYYY-MM-DD`)
+'%ch':: committer date, human style(like the --date=human option of
+	linkgit:rev-list-options.txt[1])
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
index cabdf7d57a00..d4d75b0b350e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -539,6 +539,12 @@ test_expect_success 'short date' '
 	test_cmp expected actual
 '
 
+test_expect_success 'human date' '
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
