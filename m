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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DFCC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F0422314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIzqkRpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgATOi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55083 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgATOi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so14687459wmj.4
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDV9a12WNuEaOQomBcJHl8yNKTTRQxq4FebZB+Il9ds=;
        b=sIzqkRpJxhSqXLxrc0UZ7VTt3gWDqyokuD5+Y5pUwnGWh7sOi6wrx3jdrJgbNp+Gw4
         FVHMltaOVaBw1G70fPDnG00FZt9EV2rzTLXmF8DcExdJdHJuWrT3gPLZSkYKFXCaU9Fk
         sB617q9Q34eoxlMcrMWvlG2rMRn6rHzUiPawAavkXZT4mbTJ6TbqQs0ukA3GSaQm1oM3
         fnHfMl8yh2FKMux3YcSbHbbeNZAZhvH6/zh7pSHV6mgFDFxOVg25SxQR12L63jEaa9GT
         OlSVaMSG0jnwUimmGa1oTs6M/w61R1JOx5Wkz78lAkjKDE7bBo+POwDC28/BFbRw8460
         PxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDV9a12WNuEaOQomBcJHl8yNKTTRQxq4FebZB+Il9ds=;
        b=NT5NC9rXB6CCriJNcBoBNTikQ0vCgvMj+IRF/7ABahz3Sj9/USEx9LrPzSDatBPNSC
         Y4YzYavgN21gOgw7km5nx1KYcJm1knlOqsDZ7mtuZQB2rImUKmHyatZzFH1cAgUoPAtg
         O1iARbWrkDdm3JiniVMEnzeLmQXxiSDfeGpKSD3NG7+NZL2PkGO3LfbbuQru6W4DZF/B
         oBzTtlHbcE3HDuDPfgCHHjTbJaqFnON4WYcvI9FrAhI3SMkckAHKSvINTssqrF2cpJk0
         pxLGSpjEvmsJFs28GDh8KhA1KzrXnUdPDwkxTNZSv0oECVAXpNOCWaz9suRTH0ha5093
         dFAg==
X-Gm-Message-State: APjAAAU7AccD4eUS57SalOniiICAvfe4XuoHmtowOc4YD0jIHdczkqy4
        E5k8k8KzKafFgrI1UZBgbPH7kryG/PU=
X-Google-Smtp-Source: APXvYqzRuvx0qytBKMbN3iMcYcZttk/2abNHwOCmgvSQRDdGI56KW/KHSBtfPN5yxxYXd2OOOx8yPA==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr19018608wme.27.1579531135593;
        Mon, 20 Jan 2020 06:38:55 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:55 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 22/29] bisect--helper: retire `--bisect-write` subcommand
Date:   Mon, 20 Jan 2020 15:37:53 +0100
Message-Id: <20200120143800.900-23-mirucam@gmail.com>
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

The `--bisect-write` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `bisect_write()`
is directly called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4b4ce13b50..95ac1a4558 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -1024,7 +1023,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -1040,8 +1038,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1082,11 +1078,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		return !!bisect_reset(argc ? argv[0] : NULL);
-	case BISECT_WRITE:
-		if (argc != 4 && argc != 5)
-			return error(_("--bisect-write requires either 4 or 5 arguments"));
-		set_terms(&terms, argv[3], argv[2]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.21.1 (Apple Git-122.3)

