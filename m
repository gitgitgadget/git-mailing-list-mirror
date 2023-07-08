Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B35EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 00:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjGHAbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGHAbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 20:31:34 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A81991
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 17:31:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bff89873d34so2567721276.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688776292; x=1691368292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVORtbrYg2YCHdaldyjZL5dqJmkpM6uxkWUFx2drBS0=;
        b=jNJFGqUTq6LB6tC768qmwjSgGuDEStwQFgnnPW74MzedG4ZLOkg31wn1QVTPbb3+Uh
         wJX672yPrhnHX2OEDxuyRGTwm1+2yZ7fnhTbK3dLwZtg7LOcfedbP23JT0kMQaFHTULZ
         yWvJ0s2agwhrFk5ijfc+kpv0Frjag/7JIkOxFacnT4GUSi8QTbm2VhemFr6tis7dN0LN
         cbso23Mlj9SmB+muUkicCE5ZiLxjcdcOcUxQTT8TUPPhQ/BpQDcnM5AEj3MgBMYzNKWr
         ondukCYbwyuMJy9g+HYC4kMtdU9qbdY+QbJYZo7/giL2dOSO/gQiRWdPByWbNU58TEAL
         H10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776292; x=1691368292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVORtbrYg2YCHdaldyjZL5dqJmkpM6uxkWUFx2drBS0=;
        b=fRsyjgNSRRPwLk6k2gweju5t3SAslb9nvKJujwD+f98BkMF7r9I+kSE/JqG6Fd655t
         R2cQ9V6p2KMnDtoyQDMseS6D/JLBddLHSFgICLqZBnHn4/iSkbHU1GUPi0dLPUwTc62t
         TsU6L0af1ivuM3dkXFTYrrSyBHkv+SqBNcGOm0aodZNGNmtBIVzf8Tey0g36tAzk0Y/5
         djy6KIekumFWMFKHWJSEicfwRbOFNo3OuqPuysmCAvGr0Y74JC5AtYrbgD/6Vvc2aKtg
         Y5lZ8LYpJ8zvGRLakJUs6U7213EyNl/AXCbunxtOsAV4H9PgH4TsHtlgiGzAFmG7G/YC
         1k5Q==
X-Gm-Message-State: ABy/qLYueVPulzwFmWDGyb3iH6ZdAjl6x66yLvQYQnUZjKfah5xk7n+D
        TlL3y7dvkOzl91xKPeYoB0SWVS6zxXIBeG0DnGZ7Cg==
X-Google-Smtp-Source: APBJJlGuRUi+C6K4ldHTxdqFBQwDANklpARvEiMMpKXrZzPIMkII1I5XHPTYyxjP/oJYtAjJy1Pqdw==
X-Received: by 2002:a25:5086:0:b0:c20:da9b:e6b3 with SMTP id e128-20020a255086000000b00c20da9be6b3mr5563129ybb.63.1688776292616;
        Fri, 07 Jul 2023 17:31:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j184-20020a25d2c1000000b00c4f175716fcsm1271543ybg.20.2023.07.07.17.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:31:32 -0700 (PDT)
Date:   Fri, 7 Jul 2023 20:31:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 1/6] fsck: suppress commit-graph output with `--no-progress`
Message-ID: <b88140d3e4221ca314ac7627f3cb6370f0101cef.1688776280.git.me@ttaylorr.com>
References: <cover.1688776280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1688776280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e0fd51e1d7 (fsck: verify commit-graph, 2018-06-27), `fsck` runs
`git commit-graph verify` to check the integrity of any commit-graph(s).

Originally, the `git commit-graph verify` step would always print to
stdout/stderr, regardless of whether or not `fsck` was invoked with
`--[no-]progress` or not. But in 7371612255 (commit-graph: add
--[no-]progress to write and verify, 2019-08-26), the commit-graph
machinery learned the `--[no-]progress` option, though `fsck` was not
updated to pass this new flag (or not).

This led to seeing output from running `git fsck`, even with
`--no-progress` on repositories that have a commit-graph:

    $ git.compile fsck --connectivity-only --no-progress --no-dangling
    Verifying commits in commit graph: 100% (4356/4356), done.
    Verifying commits in commit graph: 100% (131912/131912), done.

Ensure that `fsck` passes `--[no-]progress` as appropriate when calling
`git commit-graph verify`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/fsck.c          |  4 ++++
 t/t5318-commit-graph.sh | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fa26462337a..e6473ecabc7 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1074,6 +1074,10 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			commit_graph_verify.git_cmd = 1;
 			strvec_pushl(&commit_graph_verify.args, "commit-graph",
 				     "verify", "--object-dir", odb->path, NULL);
+			if (show_progress)
+				strvec_push(&commit_graph_verify.args, "--progress");
+			else
+				strvec_push(&commit_graph_verify.args, "--no-progress");
 			if (run_command(&commit_graph_verify))
 				errors_found |= ERROR_COMMIT_GRAPH;
 		}
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b6e12115786..bf8a92317b3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -684,6 +684,16 @@ test_expect_success 'git fsck (checks commit-graph when config unset)' '
 	test_must_fail git fsck
 '
 
+test_expect_success 'git fsck shows commit-graph output with --progress' '
+	git -C "$TRASH_DIRECTORY/full" fsck --progress 2>err &&
+	grep "Verifying commits in commit graph" err
+'
+
+test_expect_success 'git fsck suppresses commit-graph output with --no-progress' '
+	git -C "$TRASH_DIRECTORY/full" fsck --no-progress 2>err &&
+	! grep "Verifying commits in commit graph" err
+'
+
 test_expect_success 'setup non-the_repository tests' '
 	rm -rf repo &&
 	git init repo &&
-- 
2.41.0.242.g6eec849fa5a

