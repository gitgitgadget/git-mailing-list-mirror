Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3CFC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AC160EBD
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhHKHqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbhHKHqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:46:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85823C0613D3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so3220917pjl.2
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dK9XN658pfDffqZOwrDE6K2S5AJBi65yKQqb8InwQ+g=;
        b=sVZn5JNGqFR4ddiFCftt6FUcR80rCCHWod+7xOwCVTGVkVFkjrUtoccwQvIYbXb/5A
         K+3Uh8J7zXeZyyTtlAY8H2I87Ay7vTuxS+QuDFbMaUHdS90oU9ACDx/z/EZNwWJKo8cN
         GDXstcMuc04aZR0b6gaNFf6FLDq7wb6z3NsjjpX7kMnHSa44Mtj4O+dpPC5QTBjpAkjp
         5lEYoAnO6fWcLUH0OOdE+zofiAgytJe9xYQPlZxcsarZ8vNwVFsclGqry7x5M8+oxuu8
         TnX+HSZFCJjZVDS7XtYhc6xHzhdbydFQ1fJQTBb8iFqdAh45A7b6WiJpEE0pkZDjQJOO
         /Qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dK9XN658pfDffqZOwrDE6K2S5AJBi65yKQqb8InwQ+g=;
        b=EWKtuieKLfR1ehXG5ndSKdmBEW4tvDEvc/xBYeunrr7SXNgSrarSpmifoYGVZLoaPd
         jl/tLiv6R0f6GrHR4WJIhHcysiqUjdPK/FzqocQ/KDpdDvoK8TwOAtvn50hzJqPx0Pgn
         6ugErbrWyzvE+fQ6Pxn8aDzuiAVAZVK1XMGcuFY4vmkyKqWx5WscznRb+keXAmwDTO1S
         AgLJXL/0YtVm6tw/jeyBA+RfJsZlRSWeY4CGVS/n83NGCjIB+f7C1Zq/kcnkzjQ82Y1t
         ubOj4GsmoOixlTgsdfdwFY962IdvMoz4/Mhc6ss+kqe/bzb/UFDGZ6lU3sN8+HEE5TVv
         E/cA==
X-Gm-Message-State: AOAM533ISVbECn77DwQcKSBXzksG3Lrs5I330SpH94wCt6BjIbi1O5D/
        9/lIoRAYygNkKlKwoeJKWdM=
X-Google-Smtp-Source: ABdhPJyCn0IdiKfszt3nfDIGy2edMNMw9hQ4GJvJ+atd7zGJlKOG56EpIvS9mWgKOv/adrV5sjAK2A==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id rm13mr35228110pjb.109.1628667980151;
        Wed, 11 Aug 2021 00:46:20 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id u13sm26179672pfi.51.2021.08.11.00.46.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 00:46:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v4 1/7] pack-objects.c: introduce new method `match_packfile_uri_exclusions`
Date:   Wed, 11 Aug 2021 15:45:48 +0800
Message-Id: <73a5b4ccc11b8b0604dc3414129069ab41be45d0.1628666093.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <cover.1628666093.git.dyroneteng@gmail.com>
References: <cover.1628666093.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d13cd3e1a..31556e7396 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1188,6 +1188,24 @@ static int have_duplicate_entry(const struct object_id *oid,
 	return 1;
 }
 
+static int match_packfile_uri_exclusions(struct configured_exclusion *ex)
+{
+	int i;
+	const char *p;
+
+	if (ex) {
+		for (i = 0; i < uri_protocols.nr; i++) {
+			if (skip_prefix(ex->uri,
+					uri_protocols.items[i].string,
+					&p) &&
+			    *p == ':')
+				return 1;
+
+		}
+	}
+	return 0;
+}
+
 static int want_found_object(const struct object_id *oid, int exclude,
 			     struct packed_git *p)
 {
@@ -1335,19 +1353,10 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (uri_protocols.nr) {
 		struct configured_exclusion *ex =
 			oidmap_get(&configured_exclusions, oid);
-		int i;
-		const char *p;
 
-		if (ex) {
-			for (i = 0; i < uri_protocols.nr; i++) {
-				if (skip_prefix(ex->uri,
-						uri_protocols.items[i].string,
-						&p) &&
-				    *p == ':') {
-					oidset_insert(&excluded_by_config, oid);
-					return 0;
-				}
-			}
+		if (ex && match_packfile_uri_exclusions(ex)) {
+			oidset_insert(&excluded_by_config, oid);
+			return 0;
 		}
 	}
 
-- 
2.31.1.449.gb2aa5456a8.dirty

