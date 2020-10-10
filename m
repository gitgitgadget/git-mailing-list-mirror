Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24871C43467
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51A12075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8RUq4rK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbgJJW4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730912AbgJJTwD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:52:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5047C05BD1C
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e18so13196099wrw.9
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kis2M38+KigRUHpZkMWQTHtObAnQ5SZYj6k8yZUSu34=;
        b=a8RUq4rKEc/TTzJGGa3sUN9oIauVKbFsM7Fq0BmkUiqZMV9hT1xn4g7kwmJ9ymPXQu
         qCt56ovhvAA1t7GhOUJG2kJQdI5awwFMNJK1kAEEjQamLr+aUmmMS6CiX9/rPDFZIQ6j
         J5ghVG7VTRpGlwsykM+cdBNfs0yUDh31zmGdIo00BZKKyWPJRwZvE6+QOpFESft7V26r
         wxA0ZMgy2M1iehWxEFiVP3Zy1IVHWT4MqW59vQGoL76QK7pQO2x+8LWZOQfDuIeEWw3O
         uWkrJfNl7KOgueM94B0G0BjaptZzvbbI4iCp4Vrpj167IN21tEqF1cUquQrmt1mA/0OF
         kFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kis2M38+KigRUHpZkMWQTHtObAnQ5SZYj6k8yZUSu34=;
        b=NPvIBK139X3s0DrRihFQnGA9/4mRB8qnD9/WFbW+6xcpUe1BFpdL79RA2AG9nTbAgU
         iDtc3mePy19kh7qT51Z7KaciRP4AerUz0sI61Q9AnMDrJ0anNelENRYNihgozsQzhls7
         NmgqPiRk6xYVMbRlOwX/flM0hC1enMR/E7Hn0ltxtO4gWHQ+b2YPrQi74rEb1Uyx4ifw
         L88Abmg+07vR5soyoAL1CQnBK8tBjwAEUgSzEtt2hOfh/ywOIFiMxbRmOoJ7nK/sGFLM
         Cz0kV5ywdWIGgdmkkbaMajCzLFaEos1x4J5XAGJgZU7+EEGbMysGJZIxCe5fAmdOflCG
         E3Jg==
X-Gm-Message-State: AOAM5322PZXmKQ3BtCdwws7MVoGYpVZmX//QRD+fb43AnEEzwrKsFPFq
        ctzNiXNG3Ic5zY8JVjzS8JbH9rW1dl8=
X-Google-Smtp-Source: ABdhPJzZmDWFzYYBEE6jwXsBCHQi1OkTXbr6/n4ZEY6qzv2mByj8qixCCKgmKji5AEpMo7rxE8FNsQ==
X-Received: by 2002:adf:e741:: with SMTP id c1mr8425066wrn.16.1602338941354;
        Sat, 10 Oct 2020 07:09:01 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.08.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:09:00 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 6/7] bisect--helper: retire `--write-terms` subcommand
Date:   Sat, 10 Oct 2020 16:07:42 +0200
Message-Id: <20201010140743.580-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201010140743.580-1-mirucam@gmail.com>
References: <20201010140743.580-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--write-terms` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `write_terms()`
is called from the C implementation of `set_terms()` and
`bisect_start()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 14a8f2b9df..f90b3efdd1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -907,8 +906,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -921,8 +919,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -957,10 +953,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case WRITE_TERMS:
-		if (argc != 2)
-			return error(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
2.25.0

