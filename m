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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A75C33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B5E217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKcg8Yi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgATOjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:39:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33908 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgATOjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:39:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so29835241wrr.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPvrePRLFOriVYHvw8J3v/d4MJp8UlblmQNFQX4oVhA=;
        b=vKcg8Yi5dkWnl/KDSHmevyHOOb7Jr2mxg8gE6CpIka3BLFB+IVQduumoq6O0Sxwmm3
         0R2S4R5zV7kbZIlmzUtGq16xIoCUEM9v0UcnNXqDH777wezFyMSdZV0kqCDn5OfKuboM
         XYMHwkKBnUUJsKNA1cNW7pbzSRVPurgW8mEODWTP5kIsuH+rt60Ur0D2QLMpzj7GrRqj
         h5aSBs4JoyjFAABup5ZxhaYgK2VYrJoou9fMAcv/IMEWfAOMlNobKRHr8z/IgDd7Aysb
         vCO89kUMGjkY1nQYd5WDlm9mt/4dOFL+O77/V3SUknU8D+QElWTCM8IUw+5+9CRqPnZO
         agrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPvrePRLFOriVYHvw8J3v/d4MJp8UlblmQNFQX4oVhA=;
        b=ByDqOUwrCDnK8EJCPn+E+JccCopGKQoJbKZl6LhtK44kP3HSd7JU2Hhyh5cbHpFFqf
         lC81CmztDhF306OQc2t1ob5g56f2U9nGT6lBgL7cMPCq/hL7DpSDWLtJ+X4357aZpQyp
         bGGwpUigay3lne0yLdFnyMvrxcCKysh9vi8l/UNboYn/Y9XyB9T2mDt16RLpGOmGE/gx
         Mjxkwm4gfjOplQo+rB9r7W1fbxquUy3EgDhuEanmsb3l0YTlHkXcgvFmn1N8anWIwv5O
         ULi45LLW55kgrcuzOyfei0JNrZaC+MYPwxlEn60ohst4qa5986MiE9fTgqI10ZqwfklS
         cTDg==
X-Gm-Message-State: APjAAAXnAxZVtmw/WRT7e3CXhATGkKFVTnDLaTmNWv1vB158wkYB6thk
        rLIMWUbxxLXXt6JKeXb/fVlQpoS5kxo=
X-Google-Smtp-Source: APXvYqySxBcuy0F6LLz29MPdhBgSv4XKJP+TG76Ae54krCxnkUOtS1nIq0G1vQMHttg2W8onWEhguQ==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr15049204wrt.70.1579531139213;
        Mon, 20 Jan 2020 06:38:59 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:58 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 25/29] bisect--helper: retire `--bisect-auto-next` subcommand
Date:   Mon, 20 Jan 2020 15:37:56 +0100
Message-Id: <20200120143800.900-26-mirucam@gmail.com>
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

The --bisect-auto-next subcommand is no longer used from the
git-bisect.sh shell script. Instead the function bisect_auto_next()
is directly called from the C implementation.

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
index 9becc1d514..a40477811e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -27,7 +27,6 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -1027,7 +1026,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1046,8 +1044,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_CMDMODE(0, "bisect-next", &cmdmode,
 			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
-			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1102,12 +1098,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
-	case BISECT_AUTO_NEXT:
-		if (argc)
-			return error(_("--bisect-auto-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_auto_next(&terms, prefix);
-		break;
 	case BISECT_STATE:
 		if (!argc)
 			return error(_("--bisect-state requires at least one revision"));
-- 
2.21.1 (Apple Git-122.3)

