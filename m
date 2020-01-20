Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A8C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFF5217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUfS95Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgATOiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgATOiy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so29729899wro.9
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPzfknqnB/AQ3WDH8t/xlCoGz47tpu6JaVcaUDNnLGY=;
        b=XUfS95FiflQNzxSYF8hYFOt4kffhDRjYeCUBZJ+Fb6hYvKas3bhS8/VlNtM8GZZYJF
         jECAzdrDtctFs+Kd16SBcWCQw0ZadkQgrcZeAObCB9e3r1mDmhRO0E92FD5Ws3FSCFQt
         bAH0A5G//VvTFHwQORiFIPBJXej+RYkqdJrbmS1ststbZJN8YDVGc8XGtZrBvzNXueOC
         IRIsEoyO/8bGm1CSZMBeImtG11uDRSrljpp60OlZP9I9FX8I9GZo9bhBzeHe1IX8eZGR
         z3uDMGX69Oi4HinO78nDF1Rk1t8jN10RXzDAe5WzWSRrZe4J35fS9hpYMQkRw5w5sQTK
         AerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPzfknqnB/AQ3WDH8t/xlCoGz47tpu6JaVcaUDNnLGY=;
        b=mT+gOHE4JDG45T8gL208trQYkWOw+uOtgMYDCtNyPeJFXcTwXOcFtMBRRIaF2Qrrn/
         T4NZnRgCPV/8JIbqSSdz/CQ7SVZbMbQSv3bm4FHOfwqdWFx/M6diY5E8p2C4K263/69m
         tFij1xInzG0YK2mkAUefQKX7IyuZdIeZkyfb9GJNTvpAe6kpz9AMvkJoxC9VFumeUY8j
         iPffK1XIp2/vaOTTfGV7bS1XIjVZEmpNoWeyQ4ie6nnSIftX0iScLozTJ225qRW0i0l6
         ss/2+0gt6gT7+BnXL11YLcFfuYX3dFm0yAB0+KsvT1M/NiYEK8Avak58NSMBGxftw1W/
         vgqQ==
X-Gm-Message-State: APjAAAXBsGRfdNF72trJzO6are0plWDiONDX3M0Ja9b5Mw7igUJCUkok
        ETgG5sILlT7/zzHy56bjJwsaYRbnAJo=
X-Google-Smtp-Source: APXvYqwhoYAS27tkGWPZQDmj9HY2MYDHTkFlqjzRsR/znSclKko2Dpb5tw1uqdNK5HvSulN3bLUwsA==
X-Received: by 2002:adf:e290:: with SMTP id v16mr19245751wri.16.1579531131848;
        Mon, 20 Jan 2020 06:38:51 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:51 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 19/29] bisect--helper: retire `--write-terms` subcommand
Date:   Mon, 20 Jan 2020 15:37:50 +0100
Message-Id: <20200120143800.900-20-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index 3868d34a29..4ff8035cd8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -896,8 +895,7 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -910,8 +908,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -948,10 +944,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
2.21.1 (Apple Git-122.3)

