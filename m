Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3974E207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944029AbdDTL1A (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33335 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942870AbdDTL07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:26:59 -0400
Received: by mail-io0-f195.google.com with SMTP id k87so15225958ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJvgGxMUxcEZ7EhrJAcFW5ruM7mbNBQL8bkAiWBjx/o=;
        b=bVVxw65PKO3EzMn9XAEMAUgwkbgg6OTD9Wm24EX+EoRCJJn8HLQdzhmzKrtKfNU/9N
         HbsdbjkMuQ9rg8uZb+UhdwtGh+SQqGB2UolYcr23DaxiNhtXJA3jI3qAANK4b86i8OY8
         sL3y42kTeMpR4JEqgs6hCiCDUMc0dAuqIDAarqvqPa+kbqDBYiHQaxiQfZrkXJco6CPJ
         qSimHjAmN5Avc8D9BFxET8aHR2ynxfIrA3+rGBgpS3AtccZ/CjgZrWMY+vwLvtGS3e8u
         utIT2dAuy/9BnZBSUpdc3DigaPxXjb4tEXIe47G0K45j1iPobSCotju9Fj5u2lIxuXeS
         HqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJvgGxMUxcEZ7EhrJAcFW5ruM7mbNBQL8bkAiWBjx/o=;
        b=cqUtFs9yT9tTypkssuhNIH15iAJXqz7e/GaSCl44oaUgVVWtuOW63GTWhTrCqM+rv1
         7jR6W4Ngs4PzQAO5VAq12wfXamZFlzPzaR6YByrjWuBkPLbZR620WIssKzg+OLwO58uq
         l9akVbVl84G4ZNwXAM/kWvQioHTWOybhDY4Fztwhuxw3NhSdYo/8BjkgOoDtDKsq9Jk0
         Spqcim5sCvX9hk9oNUEABshDYNswqEVFt0ur0JgfBcR9htlNlPBosQrRM6xXlgQ+IbEv
         osEBqES6uMTEWd08mJcoG0v4M9wrfV5GBAFh5I7IwD5+FV83VTeE7nqf2jN6KLMPVNhj
         /WEw==
X-Gm-Message-State: AN3rC/4dcEk6yasGUNDkpM+UqCx6vzjzdKqGamU07vDs3xy5FzdmFJjq
        Z6dKI08ukEvE6w==
X-Received: by 10.99.2.88 with SMTP id 85mr7509524pgc.23.1492687613869;
        Thu, 20 Apr 2017 04:26:53 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id q5sm10053618pgn.59.2017.04.20.04.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/15] commit.c: report error on failure to fopen() the graft file
Date:   Thu, 20 Apr 2017 18:26:00 +0700
Message-Id: <20170420112609.26089-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppressing the error (because the command requires --quiet) is not a
concern because we already call error() just a couple lines down.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 73c78c2b80..8726225a7c 100644
--- a/commit.c
+++ b/commit.c
@@ -169,8 +169,11 @@ static int read_graft_file(const char *graft_file)
 {
 	FILE *fp = fopen(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
-	if (!fp)
+	if (!fp) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(graft_file);
 		return -1;
+	}
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
-- 
2.11.0.157.gd943d85

