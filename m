Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBF3EB64D9
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFZTBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjFZTA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:00:56 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8103810C2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:00:52 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7006F5B41B;
        Mon, 26 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687806051;
        bh=I13hPmqncRz3v0+bIyLLj0sZb0vf9WiWwKWhDxrwmoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jk8v7Tn58RiuqZg7k7ItrU5qODUorPwMpMzKejzx21WYVVODPwUHQuI6oqh/1hERQ
         CeH9l6cD86LqQhs7mtcFoghZfQEQsXtk8lK96dJJCa8hka0HfSXUoh/tJNfPDVTjZd
         fbx6MLt9zZagWQxtpYkURIBJ6nG2mwyieYLuLJoIaRzMmDo+aOXv00keWKXqo/jfGy
         114fsLVwHAQUQnPtjo1tBkfNtIwhTAoCArQjf6nHure1uf2NzbLC34VTmcITaRgd5T
         w26Yif2qFWrgI8tzfC81egm+ke8JhoCC8pyR5EWedBg2LLNwg7yYyHmPNDBS+/GPRg
         /T6XKlyz8Szc/t0wbREztX5xdjC4l0wsZGTOe9aaKepGvmS5D/8zpDqlkOu5wvWEnf
         kV3JvawyoUbaLNZl3ksPTsTIjodc38jCumXK04j8YnDm/DPKxs0Gme7Gf+ab/W6ZrS
         aRyXdzL4bey/oi8rMS54/hw/R+oO9JC9943nK/HJXgKFdPntDBO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 3/7] var: format variable structure with C99 initializers
Date:   Mon, 26 Jun 2023 19:00:04 +0000
Message-ID: <20230626190008.644769-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230626190008.644769-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-1-sandals@crustytoothpaste.net>
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
index f97178eed1..bd2750b1bf 100644
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
