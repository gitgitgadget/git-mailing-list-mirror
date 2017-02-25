Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8749B2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbdBYHZP (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:25:15 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33900 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdBYHZP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:25:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so5891394pgb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WQvg6rtaMoP2u4da9NSVPpf4wv3HrPb+l0Sc8l1797k=;
        b=bc2fTGf0Fb7aJMPALCW7JLLGKnFJOQXlbQrHlR25jafBf2XriY2SzGyqdRx47GS1OU
         fehh0f4ZaXEkmp9IZVtx8kXNqT6MeU4Nsy3hda1l0axMeny1BZ2X9+XzvMyeaFQBDBat
         +QDQQXckC4nSywNy+IWj9NdgQMSiw0FVWpweJ/NpqOfkSRE72Id8iPQSTOz+71AkZusn
         vzopJ96Phz/avFb8MdWVa9GpvefyiHYMKzmRQmFQHcOk7Wv8iaFUltOIuQqX8bHrtwq6
         2wM5AyT5LMaMBm5mWyHTSYYYu403nxvQqIS87g/tIBc5qKUpdfMHOOc2NEJuTq8BodwH
         BYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WQvg6rtaMoP2u4da9NSVPpf4wv3HrPb+l0Sc8l1797k=;
        b=Trp2suX7+3qjpDq8aHnxKKp2j6MFIyP49Dfzwjq4umohmmdYFbIzx1tYK8UP1oef5e
         sf5iS04G8lgW5b/8eEQv+aTAvchCGfgnI9baKEhrjDKa3OeWVkhGKv8fTPeu/ueUqKAu
         Cl9iwvrK+lmBh6v/xtybuQkazpIU7DwidsTZzhj3ueP0P7IDFABqPFn/EBgXSmNJCDxt
         s5OxTfwSXjPCstK77W04MtFUXrWG/n62QScLq6TjoeoKnxGQUzEMP4DSxpifzQTn5Nbb
         xYuhmfTW9x6cqsOmkPag5+G/DNncFHG7VXULrk8VhkkoI2IAnFbhzJPw6FT1xG96rgyf
         9TBg==
X-Gm-Message-State: AMke39m/KYMQpkVYRFQNxrBUwyTNENeMDHgm/oQEexHNTBHl9Uojm2qODblgSI/i6kp+xA==
X-Received: by 10.99.240.83 with SMTP id s19mr8501456pgj.45.1488007514105;
        Fri, 24 Feb 2017 23:25:14 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id n8sm18783077pgc.16.2017.02.24.23.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:25:13 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 3/6 v5] revision.c: args starting with "-" might be a revision
Date:   Sat, 25 Feb 2017 07:24:44 +0000
Message-Id: <1488007487-12965-4-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
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

