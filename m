Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F96BC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiI3SMD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiI3SLG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE625C9CD
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m4so7994933wrr.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=r13vzno36kJTvTi7UwPMIkr+evmD1/fo6RlGyjwzASs=;
        b=CUI9qGxD65gmtZkEpDTs2qq2EaUHMuvwEJfb83u8qM1BdoXEhP+IY09uBn8RWWQS35
         In/evX8agcFHAVaqnjk30Yt7fmV86btNZJpOg5Y5yX3aWCwUfTuqLN36FXgAgE35KCN5
         VD2ZfFLwfkDFtbH/WrF4HWVA4q9OXNGH44t51gfSRBr9reaaHtwzQPxzMv4nfGEVpIf8
         TX/LZD5JyuWpPh+Frp8jz8s946dt+lN2Hrmx/j977zsdsNIdKosTjQS3ByzbRKN8gtnh
         hSSN67brEht5gvtt9MU6S0qjicmvZ5erZIrdBLZ8JlLHO7KPppl7GjJmr8t485bkN2AL
         DHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=r13vzno36kJTvTi7UwPMIkr+evmD1/fo6RlGyjwzASs=;
        b=7YEpARMFElY/sPS1yLrtxwlGCDmHWlrbvexWXz3UWfyANXzId/FRhnutE3RZtadvFf
         PoEL4NgJr35+0Le+VRuX0c9Bt0BXylHQ6EqwXiMf1+3nljsICOgVciBFHJ33k3q+pR2a
         bn4CoS7cosz/+oIA/Wm81bwxhJlGBH3/H7tHQxGCxAjdmTskseDlkBbM2V5vwEwMazVR
         muuCR7n6iZqWP4qzQWuoxlfxe2I9EZ5BFXF40o3ZkKSC8I6r0V8Csry9tgAlNcT4YUDZ
         74OCSjr1sam0C/ykb5cTkE4NHzN8mEwQpne9Ddz476BX8s/mcnwalQT7rsy+mz8NSLFI
         6/AA==
X-Gm-Message-State: ACrzQf2OSSSX7+36YE7WWHlCKt5prItTRl7cMTf7X6HOPrK6MsJ1ye+0
        R+cXQNimR+fTuBe/ZheVUAhBwXL8EMoCVQ==
X-Google-Smtp-Source: AMsMyM7LG9oXlgrCp0Q0eqjjWlHZhgLxvlJa0JlRc867tavTuKz+o2HO3P8jpz1pHg0qSQZNIIriMQ==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr6599372wrq.718.1664561390459;
        Fri, 30 Sep 2022 11:09:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 30/36] doc txt & -h consistency: make "diff-tree" consistent
Date:   Fri, 30 Sep 2022 20:07:53 +0200
Message-Id: <patch-v3-30.36-34b778dd176-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "diff-tree -h" output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 23f58702fa0..85e8c81e594 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -83,8 +83,9 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"git diff-tree [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]\n"
+"              [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]\n"
+"              [<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "\n"
 "  -r            diff recursively\n"
 "  -c            show combined diff for merge commits\n"
-- 
2.38.0.rc2.935.g6b421ae1592

