Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E95C71150
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B5B217F4
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvHOw617"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBOVg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44214 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgBOVgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so15098662wrx.11
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SLnqtLk+4aSqBz/JN1WZZ1+FrIkJmWOVx9kZHrhk6vs=;
        b=fvHOw617YgKygoU1HZyE/En8cUIAFJwbctJofuIAqFvmMFJEOqnAsIMsbawkmv7bMO
         LEc8T51I2zpztFuIzCPwAXGETQ8RQ9eq6gRxiv6PFaAN7E2lHD6uO6GQnt+cNs4gsnb8
         b5gMYtJ3usJO7D6/zyvoO9EHXoipEJZN/NVTC6y9lhWbPY4vyg08WbMu2xuicOVO0VzD
         691Q5WNq2Rm9px8xHAHJ6tux5AY4HFksXaANj7o6XC7+2JYPoGVTYjls/VncPPuWNvkb
         12S0HVAYiVbov367Yu0syVzKTSfERfsvlQp94cFkSiQJc4MnHq1VjAoWNKDv8t/72Htv
         EzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SLnqtLk+4aSqBz/JN1WZZ1+FrIkJmWOVx9kZHrhk6vs=;
        b=DL0vUU2Pr8cfJoqXQezVL3qRiSp9xK6yk5nF4YhhZc0W4VH+w536/N5iCPWTvmxImy
         BG2XBnQY/IWL2xsP5Co1gVqSRJJbqOfL9BqSEg/0i/arYDntbJYQiT7eKXv0WGBcRtNX
         G1ts/sj5L/WDq72K35qe8Phd3AfuarkqzBETFlTAeaq2hin2EZ61fTT1vnyd8SFP+nwS
         8i2EQUgiiyrhsmOjJtxF+1dqA8cJ/suCgurfEGfalZb2e4o7ph/oGyhgUVGdkYMgoFIq
         Zyz86LEc6eA6s/L2LGMTzY0Fmq8zlk27zPjH7oyxuBtbw5Btjb1PEjLzaQ98s/BkWKzF
         AhKg==
X-Gm-Message-State: APjAAAVCatRXtI7+G+5RZX80MQLVf5/KJxONv/S5cmsA2BBeQOF5l6lb
        B5+P1NnosMA9PW9z+84WRHZHWeyH
X-Google-Smtp-Source: APXvYqx1M+cz4bkQ+3jJTdS/obDTs1g0e5fkFqqfnK0AJJ8wf8VAe5o3eUS/aaaW2O+zstjWFZGK9Q==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr12687645wrw.60.1581802609404;
        Sat, 15 Feb 2020 13:36:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm13085371wrn.26.2020.02.15.13.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:49 -0800 (PST)
Message-Id: <4e6f5ce8c46253ae0eb6afddcdc513b8ff57da17.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:29 +0000
Subject: [PATCH v5 08/20] rebase: fix handling of restrict_revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

restrict_revision in the original shell script was an excluded revision
range.  It is also treated that way by the am-backend.  In the
conversion from shell to C (see commit 6ab54d17be3f ("rebase -i:
implement the logic to initialize $revisions in C", 2018-08-28)), the
interactive-backend accidentally treated it as a positive revision
rather than a negated one.

This was missed as there were no tests in the testsuite that tested an
interactive rebase with fork-point behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c  |  4 ++--
 t/t3400-rebase.sh | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1a664137d29..8264a9243f1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -348,8 +348,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
 	if (opts->restrict_revision)
-		argv_array_push(&make_script_args,
-				oid_to_hex(&opts->restrict_revision->object.oid));
+		argv_array_pushf(&make_script_args, "^%s",
+				 oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 79762b989a4..71fd6396cdc 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -165,11 +165,29 @@ test_expect_success 'rebase works with format.useAutoBase' '
 	git rebase master
 '
 
-test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--merge)' '
 	git checkout -b default-base master &&
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/default-base &&
+	git rebase --merge &&
+	git rev-parse --verify default-base >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual &&
+	git checkout default-base &&
+	git reset --hard HEAD^ &&
+	git checkout default &&
+	git rebase --merge &&
+	git rev-parse --verify default-base >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+	git checkout -B default-base master &&
+	git checkout -B default topic &&
+	git config branch.default.remote . &&
+	git config branch.default.merge refs/heads/default-base &&
 	git rebase &&
 	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
-- 
gitgitgadget

