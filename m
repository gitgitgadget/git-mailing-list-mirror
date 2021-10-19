Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7359C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF136137D
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhJSLl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhJSLl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:41:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB0C061745
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t7so4636023pgl.9
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2tnoIzhKzpCWRe4l4tY6XfOp+1WivcSANGbei9HNQQ=;
        b=j9ZyUQUrwdldffY7S7sAPx/BGNM7WJXPeZ3pZEPKn4EzxG9OJB7WPqPV1pXyCrubHJ
         x7GEr3Occ91iMWAKStAAXVrlLcPqyJD06/EGJHpPpY3Lmc9EpSrv4xxyy9BzQX5/t9X+
         M9QAN3TPYE4hvBbAIq/x+ErjbpWafMt/gf/mNYve21331A6DlPbjEBiMKGz2z8Yjs0xN
         nEkVJ3+oJ7YzrdU33ohrOVvy2LNWkhr7Fo/RiWQuDWCEw1WamUnF+OhR9SjVxrBNj+QT
         swWYAKE6Q45AStDjgMhtsdkUN/LMmy3oZG6BCf4QfjKUdL+cE1aFrpO8ofm98aqIAvsl
         TI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2tnoIzhKzpCWRe4l4tY6XfOp+1WivcSANGbei9HNQQ=;
        b=siZaNg2D7GzTkmwXMpOerjvDT2jqzz4gDYs3tjVifu6yusKGPVf4OtmMW2RV+Gf+D0
         aIxlACHBJ0H0jmJemqLwnVpx0YHt2A+yJPhtBFG5Q10xnsjZjozdqMK3k0v2wgeJnSj9
         Jabuk5uTHX5T8/8nBrcZRbRLimjExlXS9uoqwDj2CCFZ6KUWQ8Mm0sxHZJDrWtkFCf9f
         wOhp4sePzbMex8Tm/xi6/UgIFfD07Xb/KKk6P9G4lAAwlJVoDpxEFE5i9Uhe9XQvpmhB
         +kkT/URsRPd+J2IRBoeOjzkBxtx7nqwxcwiF7mkfPJzxWgh/UbT+y5yjO4lAtUS/Vj54
         NUWQ==
X-Gm-Message-State: AOAM531FAeAgrWeW1Dswh+JwiK0Iy2P3TI1d+I+B3PJzSGHLvFPPPQlU
        YeTRz5G3ycB/6cKCuqB11EJdZP0OZFk=
X-Google-Smtp-Source: ABdhPJw8r1NZp2enfxtlo9sudaEOk40KOM6bNyiZ1la7/dq6mdIU3JFlwLvOtnr3loWD5HBZqzmrIg==
X-Received: by 2002:a62:7656:0:b0:44c:591b:5a42 with SMTP id r83-20020a627656000000b0044c591b5a42mr35063474pfc.57.1634643553473;
        Tue, 19 Oct 2021 04:39:13 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:12 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v6 02/12] Introduce function `match_packfile_uri_exclusions`
Date:   Tue, 19 Oct 2021 19:38:26 +0800
Message-Id: <36426b4d9fc868f144277472605a4384e39e159c.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The matching codes now placed in function `want_object_in_pack`, move it
to a new function `match_packfile_uri_exclusions` to prevent subsequent
modifications caused by its continuing expansion.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 73b92a0c90..17053dc85a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1231,6 +1231,24 @@ static int have_duplicate_entry(const struct object_id *oid,
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
@@ -1378,19 +1396,10 @@ static int want_object_in_pack(const struct object_id *oid,
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
2.31.1.453.g945ddc3a74.dirty

