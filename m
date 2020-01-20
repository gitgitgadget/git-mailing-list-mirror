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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E9C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E278E217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqsSApb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgATOiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgATOis (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so29772380wrl.13
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhNlePj7c7w7f9rdB4Q9xDKd38rWgO5jV1D012eatZA=;
        b=MqsSApb4KZkETzVCA42LFr2EYs0aCjsYocOIhHFVyvu3UXpnY/54D8xeAKne+foOUn
         z6TLm6PfSt5plxsGVSjckJ9DRoky0hHUwglTNJNsiDPeGyesNFIQKc/d0iOQ/OXttcdL
         vO57w1/PimFX0PI0d0TJrlkuMhaLoBlesOLQOpffNpdz0Z/UhMJaUW9CZwBQRKagKVRH
         vQcK1hA/9AEcqmb1wwitrJXkiDUgfjthkjXzzr+RaTSBQr/5MY8Sm/zKVytfcIHMmzaV
         oQUoMhGQfU0Xsr2bHWWKFbWTtAlRT4AsHFru+iWcotDK7e+gqAzu1AlZV2ZbBnNyjZ9I
         1zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhNlePj7c7w7f9rdB4Q9xDKd38rWgO5jV1D012eatZA=;
        b=TXNn1fEdBGouXYrl64YqffkiUFVUUmXAQwIiOwsP++VuCTFmbnP6p0aH0b87pF2EL9
         nmfxb6tUIuw6zW1/AagP1F7TT/a0j8HOOthRupOyl2LSman+QjSy6I7PTAd7JCBj/nlf
         XCihssnwroUVD0fh2LOeFwhFgBcCDcISgoKzmtAI14LTi9DP/SVQP6bV4eHzK0U0MfNm
         bLaCIE3kiiTybmkdIMArAaHl8m1KoIgLtUquhFXJXF9UliDQK0GfVp/7UdBWKA5ae7qK
         0tQM9uLjxcdNOHXIycYf1VL/jd+uEdpiHFWgFQCYJUa8IotBnE4hD5qjqIWrDULsFR5R
         7Rsw==
X-Gm-Message-State: APjAAAWKFKnlBNaN3OTAG60CAOSJrnUazkxfesQIITOS2H1yjnaLbZuY
        8UDG+mn5X99LUZKViqW+BbX3o3bSB8I=
X-Google-Smtp-Source: APXvYqy9Uz+arvprwEKQVfFpxO8mwPkdeZHWixjjuykSlFsufKPbyzkVcRQzKFZCMcRo0ezsx24rYQ==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr18826333wrr.27.1579531126602;
        Mon, 20 Jan 2020 06:38:46 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:46 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 15/29] bisect--helper: retire `--next-all` subcommand
Date:   Mon, 20 Jan 2020 15:37:46 +0100
Message-Id: <20200120143800.900-16-mirucam@gmail.com>
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

The `--next-all` subcommand is no longer used from the git-bisect.sh
shell script. Instead the function `bisect_next_all()` is called from
the C implementation of `bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7190304a98..6953c68f93 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
@@ -797,8 +796,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		NEXT_ALL = 1,
-		WRITE_TERMS,
+		WRITE_TERMS = 1,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -811,8 +809,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "next-all", &cmdmode,
-			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
@@ -849,9 +845,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case NEXT_ALL:
-		res = bisect_next_all(the_repository, prefix, no_checkout);
-		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.21.1 (Apple Git-122.3)

