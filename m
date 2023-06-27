Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B4BEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjF0QUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjF0QTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:31 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F973A90
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:26 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C79405B420;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=WdsKnMu+237T7FLdP1HSugCwl1Lo8d8TMMxVbzR0vsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bz8gozdrM1LqKbVT+QfDr9YSoA4RFS3HkjVPRQhJRqlNuDAvzjhJ0O+uQYTUU4OX7
         1lbJEihuCHl6LIRm70K8uXfoHHqa0cCFR/X9hxipFm4Xn6AODxiusAqiPg+iYRpeip
         4IXCgVWqT9ss6Bi13Imp4bLaANe83IwgcHPlf5xTW/KT8V2L0oLh1PR3WH5HpjMNIr
         YdZ9oQkrjqzspf9C4AklWtobMvR+sJ+JWkFhMQbRO+KvAiy7z0mZHDDl3JBE9Ut9zW
         NRYU7UihfIs9crwrjA9hvpzhYipwIXlf70YFazX1xCnF6HiuGF9Ivdu2V4R+JHdFnP
         nood0PCB+SVNW0NUWDAe2EtSHJ4sH3TzXodi3lY2a84M6CRZlnHBBNuyNR569mRkQ/
         XAUx791YeiurrMjdr7Ff1AunZgbQJansh8Qhp4OaFiH0HEEId1LXXkI/pgz3atEy4H
         sPUu0oEWbbQ8v7x5x82JflBpmbt1BdKyG8BbkHYkRtkcx9+0xCF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 6/8] attr: expose and rename accessor functions
Date:   Tue, 27 Jun 2023 16:19:00 +0000
Message-ID: <20230627161902.754472-7-sandals@crustytoothpaste.net>
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

Right now, the functions which determine the current system and global
gitattributes files are not exposed.  We'd like to use them in a future
commit, but they're not ideally named.  Rename them to something more
suitable as a public interface, expose them, and document them.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 attr.c | 14 +++++++-------
 attr.h |  9 +++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index d45d34058d..66203ce322 100644
--- a/attr.c
+++ b/attr.c
@@ -870,7 +870,7 @@ static struct attr_stack *read_attr(struct index_state *istate,
 	return res;
 }
 
-static const char *git_etc_gitattributes(void)
+const char *git_attr_system_file(void)
 {
 	static const char *system_wide;
 	if (!system_wide)
@@ -878,7 +878,7 @@ static const char *git_etc_gitattributes(void)
 	return system_wide;
 }
 
-static const char *get_home_gitattributes(void)
+const char *git_attr_global_file(void)
 {
 	if (!git_attributes_file)
 		git_attributes_file = xdg_config_home("attributes");
@@ -886,7 +886,7 @@ static const char *get_home_gitattributes(void)
 	return git_attributes_file;
 }
 
-static int git_attr_system(void)
+int git_attr_system_is_enabled(void)
 {
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
 }
@@ -920,14 +920,14 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	push_stack(stack, e, NULL, 0);
 
 	/* system-wide frame */
-	if (git_attr_system()) {
-		e = read_attr_from_file(git_etc_gitattributes(), flags);
+	if (git_attr_system_is_enabled()) {
+		e = read_attr_from_file(git_attr_system_file(), flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
 	/* home directory */
-	if (get_home_gitattributes()) {
-		e = read_attr_from_file(get_home_gitattributes(), flags);
+	if (git_attr_global_file()) {
+		e = read_attr_from_file(git_attr_global_file(), flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
diff --git a/attr.h b/attr.h
index 676bd17ce2..2b745df405 100644
--- a/attr.h
+++ b/attr.h
@@ -227,4 +227,13 @@ void git_attr_set_direction(enum git_attr_direction new_direction);
 
 void attr_start(void);
 
+/* Return the system gitattributes file. */
+const char *git_attr_system_file(void);
+
+/* Return the global gitattributes file, if any. */
+const char *git_attr_global_file(void);
+
+/* Return whether the system gitattributes file is enabled and should be used. */
+int git_attr_system_is_enabled(void);
+
 #endif /* ATTR_H */
