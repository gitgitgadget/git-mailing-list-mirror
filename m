Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A7C4320A
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C4460F0F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhHGHRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhHGHRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:17:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1BC06179A
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:17:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so20063660pjv.3
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clA24kMKRMcE4dsNXF8NItKQefu2PB5aJzRuAOOWW/E=;
        b=cXafzQWrL/SjT/lPQR1azaX9SiAFEI9v5zqDqd7XqxLoxUVDCKIXMaDenk93JObFDm
         Wy7ClBkhTVfU/L8Fociq3TGf8bG/O+B1Bylv5j6i7Eqhu05cEdXoXyPeCrq7xDdy1AOD
         zk1ki+9IeZGuq7J2ubzLUs9hy4ifaSuN659K1L1ThYoNThdOsak1VN3Hmg6zDH1W4ZQU
         LJLmfmEwBarcedb3atwxq/tj0mcC7iJIYcionfGZevDgGkiofem3LDUdmuhf1sn57l8r
         P/oOzaZcFQbhfI/tQc6rHtsM38CktvM0UEVObuLMDQ48ri8VB/8kQsElSdw1VaTRyl5T
         SvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clA24kMKRMcE4dsNXF8NItKQefu2PB5aJzRuAOOWW/E=;
        b=lLIOz3RsoG5RMUAtKqk3TUEHZZYIiGg6czBUQNe1Mi9DxA79AFo9s+LVXFVNPXFMvW
         E250r4jWGvX8dl7hrDNZhisokmA5tTQaQuFqtwdEosPyxJUpy4N1uOFT3mqF62N6xyIh
         USaAtPkhc6xAv6URfdwNatwSkiq6DdhjTKamNJqeqt+Fszk8z2GV6ukWWNJaBymml4+E
         7fQ9WT/LvWSVquzvK/SCFcwvPARdn8aG6ansZeyocr1Z11OP1VdTvbTkh0pHU30Gc8KI
         GcL1ckYsEF07zZa29MxeoNuHTqzEYRHr4NLkBVut30PUF20tb0gdOIf3Rd26RVUT4q4t
         aKKQ==
X-Gm-Message-State: AOAM530ns4WGbsgLICsxwYNhdSLLTfJ6GPp/z3kw9dg4RyALh5xxxNRj
        jlVnxw1aEnwePQrMwbN6z1U=
X-Google-Smtp-Source: ABdhPJx49VKDFOhoivnZmKBQPko5EFqba0qw3udsT0nUZg2K7Qpx9nhflJfcjBXUNzuAWBw3eNr6Pg==
X-Received: by 2002:a63:4e0d:: with SMTP id c13mr543586pgb.276.1628320646198;
        Sat, 07 Aug 2021 00:17:26 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm14604981pgm.15.2021.08.07.00.17.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:17:25 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v4 8/8] submodule--helper: remove resolve-relative-url subcommand
Date:   Sat,  7 Aug 2021 12:46:13 +0530
Message-Id: <20210807071613.99610-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell subcommand `resolve-relative-url` is no longer required, as
its last caller has been removed when it was converted to C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d526423a0c..bc123d7aaf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -223,25 +223,6 @@ static char *compute_submodule_clone_url(const char *rel_url, const char *up_pat
 	return relurl;
 }
 
-static int resolve_relative_url(int argc, const char **argv, const char *prefix)
-{
-	const char *up_path = NULL;
-	char *res;
-	const char *url;
-
-	if (argc != 2 && argc != 3)
-		die("resolve-relative-url only accepts one or two arguments");
-
-	url = argv[1];
-	if (argc == 3)
-		up_path = argv[2];
-
-	res = compute_submodule_clone_url(url, up_path, 1);
-	puts(res);
-	free(res);
-	return 0;
-}
-
 static int resolve_relative_url_test(int argc, const char **argv, const char *prefix)
 {
 	char *remoteurl, *res;
@@ -3118,7 +3099,6 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

