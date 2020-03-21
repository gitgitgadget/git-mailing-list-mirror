Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05694C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01A920776
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCAS0FvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCUQOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:14:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36433 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgCUQOE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:14:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so5201731wrs.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ogHLIRJ+uR2baoE9reT+pIo+zIlr9lDLtDPV+i8uiA=;
        b=PCAS0FvDI1YqJxDb0LQKBX+5mXg9kFl1gKfn0epU0z8UcvqVPTP7UUOLWiuCkJoJeX
         7SKWerj4XEL14o9O4iz9MF2cNhtXVeIGoc8OsXp0aZr4b5mBekSDansKKOGrkvXc8GAM
         9EqmMxEYJInNJGpqfePvKE5lA379TvwbFWo/p0xCRwVv7xRn09mw8lB9P3mCMMyKsYem
         f253i1cPFf6hRLZfZXRr0rmWGpb9tuOhjM+utbCnVndgeYo29k/EUIfceJIDaZHtfODr
         KhxtQ++pkfv3oemwYgtmHXyEdxfEQAGShyzuJsvgKyYXMS4i6pDWhsHVLc5HLAckAiHM
         7vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ogHLIRJ+uR2baoE9reT+pIo+zIlr9lDLtDPV+i8uiA=;
        b=svG1r6s6SqNak/XFgrHK11vvs8ExXuOkvLuE0yujlv9nh4rWAjWj3WRmgY0AJuesw/
         +cGr7xabunZDmaPbkWKtJf07MuuoxuUqKNTzVPmF+WgztDWILNRSbbuOU3LpGij0mrUi
         uxPUjMRm/pHysi7PCMNeo8AewbgiAKmiLbgxBQtF71HuJ83h1hD4F3r1kD89tJ6GISz9
         zHt0ZFVOPuqcdTGlhElESlpqR0jR1ryX6eEIWB78+iWAMty+GsDFl07p90QGY4muEJ0p
         v+wb8AI/+6HCnRIK32QrcWSWCelaNEWw/neIrBTi2l1OUA71NPripuq5OK/hbjdzyvI1
         tn1A==
X-Gm-Message-State: ANhLgQ3o259npDaIE6DfOF5DRequqLrR6YGwvTWE3Q/BrsAmBPPEvNT9
        E8KP5JrdhYYumtyCTpCvAqe3O2fh+w0=
X-Google-Smtp-Source: ADFU+vuX4u9vndpjVRnhUj4UHuA+WY3K1Pj49pByMxkgjFufAalMCIqIDBAFb+ChcS1cE9ceoBIOGw==
X-Received: by 2002:adf:f841:: with SMTP id d1mr19232100wrq.77.1584807243144;
        Sat, 21 Mar 2020 09:14:03 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:14:02 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 11/11] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Sat, 21 Mar 2020 17:10:20 +0100
Message-Id: <20200321161020.22817-12-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-autostart` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_autostart()` is directly called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8fdefb611b..d3ec926ae4 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,7 +29,6 @@ static const char * const git_bisect_helper_usage[] = {
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
@@ -902,7 +901,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
@@ -923,8 +921,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
@@ -986,12 +982,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			return error(_("--bisect-autostart requires 0 arguments"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.25.0

