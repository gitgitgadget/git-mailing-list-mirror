Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192B120248
	for <e@80x24.org>; Thu, 28 Feb 2019 20:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfB1Ug4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 15:36:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37393 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfB1Ugz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 15:36:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id z196so15597370lff.4
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 12:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BFhpZJygaI89cCqo0enwzxl1PVa8Z9Wsa1Ms03hVKo=;
        b=SwA57G48FyNruammNEOyTYjjCXoSBOw2Hd+xoP2LCFs/+aZd3vlyfbOPgZoO3/OO99
         5dvuhDZmJTMrXgsUlQJTpOEGW5Nr5BeQMLHNx7YzW/MXfnFq0oPlHaTRIuNtpsN79AR8
         biQ/zXFgSy+9QApu5EEGPE+/SwN2pfq1C2nc/o/uw7FN4FilZp24BSlodgglaMj6u03R
         IGv51GaJIynlug2FkTGq2qyITc4fcFWtjOHdG3eUOawrZm8pGsOoUY3F4CQAp8S3PT8R
         WLEry2rSuJtlwaR4AWlA4vzSCz5kxNJg3tGaFN5GfbYvsNo95I/Jvw6vNonA2o/kJG4O
         eM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BFhpZJygaI89cCqo0enwzxl1PVa8Z9Wsa1Ms03hVKo=;
        b=k89KtV7EDqR/uZ5aL5umsCOLjcxssxorwGfF0Y93SpwHihAPuEC+7EGAVwsTtqEe/7
         BFwb/VB/qb8mcjjcvBdjHT9lcMylvyEmnraX1kIA3Tf9Oiu7Kln/VdFyLjbme/PVdCVB
         0jcB7bePJmPAh54qOduDiNmRdGmL9hK8YYywSAvRY9Tu7yVPYg9Hq7DAKNAGzsu79sjr
         NPIliIUJzCnxfuYFPggS6RVZJ9PAZ+UzgCZB4jaETHFEXxhCG1a9c+r6eR2SyVXXC2uR
         TmhVo8apUhj50oH8y82V6YW9puOmYnafgJiYxD1EdiEX8gsEQd/4F+pjUSWLY1zM5Y7g
         8ljg==
X-Gm-Message-State: APjAAAW0W+F4QkEH9KuaeJikqAbr3ohnMDMyELVEDHCI5H9rUzCM1iBi
        OC4dWV+LyfiTnRdAa0IbmN0JyHxi
X-Google-Smtp-Source: APXvYqy9b7/uYpm1wUKvR8e4T+CguVNU2PPklK2c8wAmrEC0S787KOf2JiIOej032MuGTr+GlgOr/A==
X-Received: by 2002:a19:5013:: with SMTP id e19mr771072lfb.89.1551386212471;
        Thu, 28 Feb 2019 12:36:52 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id l11sm4282415lja.38.2019.02.28.12.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:36:51 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 0/2] setup: fix memory leaks with `struct repository_format`
Date:   Thu, 28 Feb 2019 21:36:26 +0100
Message-Id: <cover.1551385992.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190226174655.GE19606@sigill.intra.peff.net>
References: <20190226174655.GE19606@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to v3 [1] from about a month ago. Patch 1 is
unchanged; patch 2 provides some additional documentation of the
initialization that is required, plus I've gotten rid of the compound
literal. Range-diff below.

Thanks Peff and brian for very helpful comments and discussion.

Martin
 
[1] https://public-inbox.org/git/cover.1548186510.git.martin.agren@gmail.com/

Martin Ågren (2):
  setup: free old value before setting `work_tree`
  setup: fix memory leaks with `struct repository_format`

 cache.h           | 31 ++++++++++++++++++++++++++++---
 builtin/init-db.c |  3 ++-
 repository.c      |  3 ++-
 setup.c           | 40 ++++++++++++++++++++++++++++------------
 worktree.c        |  4 +++-
 5 files changed, 63 insertions(+), 18 deletions(-)

Range-diff against v3:
1:  13019979b8 = 1:  13019979b8 setup: free old value before setting `work_tree`
2:  e0c4a73119 ! 2:  b21704c1e4 setup: fix memory leaks with `struct repository_format`
    @@ -16,15 +16,16 @@
         they take from it, rather than stealing the pointers.
     
         Call `clear_...()` at the start of `read_...()` instead of just zeroing
    -    the struct, since we sometimes enter the function multiple times. This
    -    means that it is important to initialize the struct before calling
    -    `read_...()`, so document that. Teach `read_...()` to clear the struct
    -    upon an error, so that it is reset to a safe state, and document this.
    +    the struct, since we sometimes enter the function multiple times. Thus,
    +    it is important to initialize the struct before calling `read_...()`, so
    +    document that. It's also important because we might not even call
    +    `read_...()` before we call `clear_...()`, see, e.g., builtin/init-db.c.
     
    -    About that very last point: In `setup_git_directory_gently()`, we look
    -    at `repo_fmt.hash_algo` even if `repo_fmt.version` is -1, which we
    +    Teach `read_...()` to clear the struct on error, so that it is reset to
    +    a safe state, and document this. (In `setup_git_directory_gently()`, we
    +    look at `repo_fmt.hash_algo` even if `repo_fmt.version` is -1, which we
         weren't actually supposed to do per the API. After this commit, that's
    -    ok.
    +    ok.)
     
         We inherit the existing code's combining "error" and "no version found".
         Both are signalled through `version == -1` and now both cause us to
    @@ -34,11 +35,21 @@
         non-negative version number before using them.
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/cache.h b/cache.h
      --- a/cache.h
      +++ b/cache.h
    +@@
    + extern const char *core_partial_clone_filter_default;
    + extern int repository_format_worktree_config;
    + 
    ++/*
    ++ * You _have_ to initialize a `struct repository_format` using
    ++ * `= REPOSITORY_FORMAT_INIT` before calling `read_repository_format()`.
    ++ */
    + struct repository_format {
    + 	int version;
    + 	int precious_objects;
     @@
      	struct string_list unknown_extensions;
      };
    @@ -146,8 +157,15 @@
      	}
      
      	return 0;
    -@@
    + }
      
    ++static void init_repository_format(struct repository_format *format)
    ++{
    ++	const struct repository_format fresh = REPOSITORY_FORMAT_INIT;
    ++
    ++	memcpy(format, &fresh, sizeof(fresh));
    ++}
    ++
      int read_repository_format(struct repository_format *format, const char *path)
      {
     -	memset(format, 0, sizeof(*format));
    @@ -167,7 +185,7 @@
     +	string_list_clear(&format->unknown_extensions, 0);
     +	free(format->work_tree);
     +	free(format->partial_clone);
    -+	*format = (struct repository_format)REPOSITORY_FORMAT_INIT;
    ++	init_repository_format(format);
     +}
     +
      int verify_repository_format(const struct repository_format *format,
-- 
2.21.0

