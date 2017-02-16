Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF951FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 15:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbdBPPOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 10:14:47 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34492 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbdBPPOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 10:14:46 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so1836627pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 07:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WQvg6rtaMoP2u4da9NSVPpf4wv3HrPb+l0Sc8l1797k=;
        b=GmWwXKIrBt9TRYBURDvRFs5qP44uT5cM5LLyqmWyTs9sWABCqMvcJG2dFiFwW5uz/B
         OwxDgn3cCdUgFMnzca2j+f1iD1e1r5WGUm6y8i8mMWo3ROhLSkpvhUivAIOeqQ60jJtJ
         foWTukXDARpKu9Bu0QErG7VdZF7OgodVrO4GDql3PZV1eriKWojpXhX/Ma1NA2mbsFjs
         DXP+cCI/NzTpzM5jWclKz83dJrp5x3EGSby58SuCdmQrsTQ4gh65zobZyMnYf3BDZdGb
         esijKtCxAN738uRFksDO9YbpyDYPOEw/hpLSSY1PGW+G1RElYLW8VxTuceqwA0YfBDAd
         cRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WQvg6rtaMoP2u4da9NSVPpf4wv3HrPb+l0Sc8l1797k=;
        b=B/stpet85CEwNORCfmMF1QDmoyogQqpD9ytrNM5NwL8Uq5lBNw1dnBVDVOe2tN/gNm
         eytS1fZNqbYB7t8aCObqgXRKB2yGOma7EpwCE9mfNM36AqpBIQsOcZ6OX4daLexHU7iw
         d0NBW0Gujxbkr6mIjYepI1nBy0DIrKYP+5w8p51jurita3ZbnshZpTK4lj+rQDwByVuI
         RlmzbzkWcWKISNKS99oocG5V+N4+2YH9W8GiRg75GFMLXkfgpUKDXhNVIwc+X66ny4Pl
         /XKPh9Fbh6TqdWNxczkjjouX/1e/yrEUfsls85FU7bnfi/FH3J6sRNZPRUTpJVS9LBOm
         fh5g==
X-Gm-Message-State: AMke39kHDP99K4H7Dkg/zYsuXESMBi2KZDEcLg0CiGJSQnqC4RiuICLP/YB2DnJANyX1kw==
X-Received: by 10.99.55.91 with SMTP id g27mr3514791pgn.65.1487258085548;
        Thu, 16 Feb 2017 07:14:45 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id p25sm14428212pfd.0.2017.02.16.07.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 07:14:44 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 3/4 v4] revision.c: args starting with "-" might be a revision
Date:   Thu, 16 Feb 2017 15:14:13 +0000
Message-Id: <1487258054-32292-4-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_revisions used to consider any argument starting with "-" to be either a
valid or an unknown option.

Teach setup_revisions to check if an argument is a revision before adding it as
an unknown option (something that setup_revisions didn't understand) to argv,
and moving on to the next argument.

This patch prepares the addition of "-" as a shorthand for "previous branch".

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 revision.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 8d4ddae..5470c33 100644
--- a/revision.c
+++ b/revision.c
@@ -2203,6 +2203,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		int maybe_opt = 0;
 		if (*arg == '-') {
 			int opts;
 
@@ -2232,15 +2233,17 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
-			/* arg is an unknown option */
-			argv[left++] = arg;
-			continue;
+			maybe_opt = 1;
 		}
 
 
 		if (!handle_revision_arg(arg, revs, flags, revarg_opt))
 			got_rev_arg = 1;
-		else {
+		else if (maybe_opt) {
+			/* arg is an unknown option */
+			argv[left++] = arg;
+			continue;
+		} else {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
-- 
2.1.4

