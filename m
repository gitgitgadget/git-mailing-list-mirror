Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154AF1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 18:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbdFISSL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 14:18:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36241 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdFISSG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 14:18:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id e23so8440783wre.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZDiHGn5rilXIc5zNtg8eLDMjI29ErlfxLa2UrT4hgg=;
        b=H4sY08DK4tCEw3YP3G7VhKSvcqvZpcqeDgDFO1N2CIyOOXD4MCf2L3gsuGBQqvJ8dV
         x9hj1PYc/obAky/7P+SvR4Ewz8fgjlbQwRVUAuN9IACwPwfRskzI6918rq/fRnC69FRu
         JlSOOxml2B2xTA6w05XU2UdQUoqWfLzYPa+lLupSs2UEu6Nnn88FeTLiUJC92NAQi9zR
         6jUakx6Z3dXqtIH3aw2C1EPPOeTjGDBiBy2K9cr0nwCglKmEi6/5CE0v6EZOu0Ao6n1c
         kRKeuveKSjNYE/GrhqpGMCKnYqQ5Ci+CE5e7WMY5KPyb14e9D8RTxZD0jNJtcP6Rum/u
         M+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZDiHGn5rilXIc5zNtg8eLDMjI29ErlfxLa2UrT4hgg=;
        b=UAl/BreDuh0Eazl8o5omCdHAIrwC5TCaIOyBv1J2r01UN0a27f603KnmnbV+P5f6AL
         QM5BIc4Ev6x7+8bVvdfIVWpSPVPKPM81Yd4jzYHr+cmphN86+ZcG7LxQUJzuIdPaswKP
         IcU+/LrIgQFkZisrvuWIZirGYwiIZmR4TYSvbnbxCIYw9KzatWJjJwd/5/pNw7KSY4qa
         ijTQZUPfhZkk89v1NvexYGQIB5Wzov5nNszploMxEq60ePiiO936Kte9fYq7AQtm3ZBu
         3Q5x6imc7g6RnTtrrCYSILhNaUUtCTM0nwPN/ZwRIUTb/6xLOt+4rM0/74gleYX5NJbP
         SEoQ==
X-Gm-Message-State: AODbwcCx+YRITXWgzt5lyLz35euK9VkGgWE2eZBI9Iqa+GZZO9qxv4At
        wkfoybqueYVoLg==
X-Received: by 10.223.177.213 with SMTP id r21mr13407wra.121.1497032285032;
        Fri, 09 Jun 2017 11:18:05 -0700 (PDT)
Received: from localhost.localdomain (x590e0f24.dyn.telefonica.de. [89.14.15.36])
        by smtp.gmail.com with ESMTPSA id g46sm3485851wrg.69.2017.06.09.11.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 11:18:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 5/5] revision.c: use skip_prefix() in handle_revision_pseudo_opt()
Date:   Fri,  9 Jun 2017 20:17:33 +0200
Message-Id: <20170609181733.6793-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170609181733.6793-1-szeder.dev@gmail.com>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of starts_with() and a bunch of magic numbers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 revision.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index c99c47c50..12a44189e 100644
--- a/revision.c
+++ b/revision.c
@@ -2135,20 +2135,20 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (starts_with(arg, "--branches=")) {
+	} else if (skip_prefix(arg, "--branches=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--tags=")) {
+	} else if (skip_prefix(arg, "--tags=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--remotes=")) {
+	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
@@ -2158,14 +2158,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-	} else if (starts_with(arg, "--no-walk=")) {
+	} else if (skip_prefix(arg, "--no-walk=", &optarg)) {
 		/*
 		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
 		 * not allowed, since the argument is optional.
 		 */
-		if (!strcmp(arg + 10, "sorted"))
+		if (!strcmp(optarg, "sorted"))
 			revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-		else if (!strcmp(arg + 10, "unsorted"))
+		else if (!strcmp(optarg, "unsorted"))
 			revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		else
 			return error("invalid argument to --no-walk");
-- 
2.13.0.420.g54001f015

