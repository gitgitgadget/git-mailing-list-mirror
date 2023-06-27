Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA452EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF0QTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjF0QT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:26 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D583A81
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:13 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A844E5B41E;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=fgHU67J1qfuJ0KrP8fAKJg1oTBA8bd3f9UPX+FAHNcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0kpU5bht4T+pg1H9Di2oymg7MVm3oj8CDH8zBEoLE7QSTykvhvJ9BHdArr3US/+3z
         y/AgH/QlyirafZ3xQmugZC1HZVWhT/9s7UIo/8oAdx3v+t30q1eyYQ5GYALhhMlgOA
         /h4+wyQt9bT5Ru7qMHwKRQii5iXQIG+wvE9wDiO4CuvAgerFw5jUV67AwQQt9WKeVh
         klGgtCX6l8eUJ2MbKib7Cmh2G0aEVcgNgEaz4L2yfPtR0mO1LRKnfGdczWCU9XIG98
         ypUeUcbKYsJueEk1PHaumAFRiBMwvxOgtcHXDS/ebt5cjn4OVa+FXJQjXaKzu8C+2R
         Xq6bgoJc9I04oaxiVB0BoYmA9oyLxV2l0pqTstwvAHzi+rtZlXTpCNclvwioMPIfck
         YFomY3fjRDAHP8loZazQZUAR+pOVAMEWO+Y0VhLb4z4xR1AaFBVw1pl53ghG/TGDmM
         l5SSWFmjz301AYlV0HgtXyfatWA7+Dv0BRGRIcHsjKayi1VjpTv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 4/8] var: format variable structure with C99 initializers
Date:   Tue, 27 Jun 2023 16:18:58 +0000
Message-ID: <20230627161902.754472-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230627161902.754472-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230627161902.754472-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

Right now, we have only two items in our variable struct.  However, in
the future, we're going to add two more items.  To help keep our diffs
nice and tidy and make this structure easier to read, switch to use
C99-style initializers for our data.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/var.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index bd340c5717..379564a399 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -46,14 +46,38 @@ struct git_var {
 	const char *(*read)(int);
 };
 static struct git_var git_vars[] = {
-	{ "GIT_COMMITTER_IDENT", git_committer_info },
-	{ "GIT_AUTHOR_IDENT",   git_author_info },
-	{ "GIT_EDITOR", editor },
-	{ "GIT_SEQUENCE_EDITOR", sequence_editor },
-	{ "GIT_PAGER", pager },
-	{ "GIT_DEFAULT_BRANCH", default_branch },
-	{ "GIT_SHELL_PATH", shell_path },
-	{ "", NULL },
+	{
+		.name = "GIT_COMMITTER_IDENT",
+		.read = git_committer_info,
+	},
+	{
+		.name = "GIT_AUTHOR_IDENT",
+		.read = git_author_info,
+	},
+	{
+		.name = "GIT_EDITOR",
+		.read = editor,
+	},
+	{
+		.name = "GIT_SEQUENCE_EDITOR",
+		.read = sequence_editor,
+	},
+	{
+		.name = "GIT_PAGER",
+		.read = pager,
+	},
+	{
+		.name = "GIT_DEFAULT_BRANCH",
+		.read = default_branch,
+	},
+	{
+		.name = "GIT_SHELL_PATH",
+		.read = shell_path,
+	},
+	{
+		.name = "",
+		.read = NULL,
+	},
 };
 
 static void list_vars(void)
