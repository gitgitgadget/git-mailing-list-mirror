Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3FC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5E661289
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhFVSR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhFVSRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 14:17:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97DFC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:15:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v7so17785527pgl.2
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSifAKwtOJd+nhbHSqSbRWiFUlwMoPlC7uRbfvQqhD8=;
        b=a7Sh2aqmc20tE9OCnibGyO7DSFLwhCJdLg6EubcBYRNi8eSWDGg+DBDzNPyGgO2SoW
         CNLBO9gfPov75bgtVYLrZMGdbA5kUQtgfIPptsi1R5I4hBWoJfENpSBQQ1FMKN9LduW8
         TbDM6bnW5jp4NJqRXVyVmIURD+w8pUvGTWlPB9Ya4NqWx3gy4LILW86XzY1esQRGMe+J
         SEJeGlO17eovH7QJ52iJS3TsbIIfwGbH/IGuQgSD2a226qyjJSsKxyh2Ub6S5AW5L2XI
         JUFfuA1ObaxGyTBG9NTevzx/7nE40a9J63SoSBynyFq4gkDKbkyNmeMJFoyIWI9lMixs
         fpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSifAKwtOJd+nhbHSqSbRWiFUlwMoPlC7uRbfvQqhD8=;
        b=aIq+XpTKXYrLoDpMXpYaa7XznYpx0LZjzdLZZ0tKVo4kTZNKcwUmMxNgstoul776Oz
         8efgWv70O5wJ+pHJFjULmHOi3e80BBs3KacR6YqPYxPz3/NzxtVyboMgglAhZXKzSE5O
         JaKxtVjZ7Xp1j9YUTNQ9Kkjj/SpsdEam4nSrRfl8AifhxVrrJLljfk8yTYfXILpjfdWw
         IKCijyE8ACf0YlkEpvf59+f6f/xaZ8gjmi+f9YgX51o/9Nrvfkgc0qHeR6Tx61EViDHU
         wF3y4RkYUuUZfQ3ugYjPrBp42zn30yF2zYWQ2ZNTOay5eVqYPKaSJm2F55thcsJNeyYu
         uxjA==
X-Gm-Message-State: AOAM533wQI2jgbziVGLeV+I7IkflBU0nJgCzav92HJaL3E3bxgyWySzD
        C1X8JISwetELci+16hcLxxaiQjNbOCFahw==
X-Google-Smtp-Source: ABdhPJx7zMlPkmRIe2HJbnh5AppL5dCeOMqWrDaz3cxicDm3cprg6T1bnnlU1piJiwRLqGnwTyStoA==
X-Received: by 2002:a63:2125:: with SMTP id h37mr4829011pgh.205.1624385708335;
        Tue, 22 Jun 2021 11:15:08 -0700 (PDT)
Received: from localhost.localdomain ([183.82.190.58])
        by smtp.gmail.com with ESMTPSA id co18sm2828679pjb.37.2021.06.22.11.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:15:07 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 1/1] submodule: remove unnecessary `prefix` based option logic
Date:   Tue, 22 Jun 2021 23:44:52 +0530
Message-Id: <20210622181452.2974-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.9.g81a5432dce.dirty
In-Reply-To: <20210622181452.2974-1-kaartic.sivaraam@gmail.com>
References: <20210621190837.9487-1-kaartic.sivaraam@gmail.com>
 <20210622181452.2974-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Over time when parts of submodule have been ported from shell to
builtin, many instances of the submodule helper have been added.
Also added with them are some unnecessary option passing
logic that are based on the `prefix` shell variable which never
gets set in their code flows.

On analysis, the only shell functions which have a valid usage
for the `prefix` shell variable are:

    - cmd_update: which is the only function which sets the variable
      and thus uses it properly

    - cmd_init: which uses the variable via a call from cmd_update

So, remove the unnecessary option parsing logic based on the `prefix`
shell variable.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-submodule.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4678378424..cb06aa02c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -335,7 +335,7 @@ cmd_foreach()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 #
@@ -402,7 +402,7 @@ cmd_deinit()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${force:+--force} ${deinit_all:+--all} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
 is_tip_reachable () (
@@ -726,7 +726,7 @@ cmd_set_branch() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
 }
 
 #
@@ -755,7 +755,7 @@ cmd_set_url() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
@@ -807,7 +807,7 @@ cmd_summary() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${prefix:+--prefix "$prefix"} ${files:+--files} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $summary_limit} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${files:+--files} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $summary_limit} -- "$@"
 }
 #
 # List all submodules, prefixed with:
@@ -848,7 +848,7 @@ cmd_status()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
 }
 #
 # Sync remote urls for submodules
@@ -881,7 +881,7 @@ cmd_sync()
 		esac
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 cmd_absorbgitdirs()
-- 
2.32.0.9.g81a5432dce.dirty

