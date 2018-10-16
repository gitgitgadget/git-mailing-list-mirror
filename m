Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902881F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJQH2n (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:28:43 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:36427 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQH2n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 03:28:43 -0400
Received: by mail-ot1-f73.google.com with SMTP id y22so18332352oty.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 16:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WXc/W7WM7svmOBnFamHW+1HsHd8RooyP9LEyJ6h6gzI=;
        b=wQQnAT/oJLe6Iu+Xo0E3vqXnBnV2+Z9NxONoL7WDH75eVdo2XKh4A8GyriLfJNY5Hs
         3UyYYk0GJI14GdLjX2I/AWd5jAuCSI901KHdkOcKflzT0+6xCxToot0IK/K4qBiTA2Ha
         4RhWlBnrCXy83GRcWAzEmy3kz8brC2j6/Y1s0YguAMqpEpT1r784v3pvyJScP7VLZMmi
         r/PbgA50WgxKz7c4GmgnVnIMfQTYCQzpKVkIyoD3YT7hJFCS2Wxmn97y4U+R5Jn6QoVo
         tAb9YydolHNys1A+tYXFgl1BiMk4uoiZe72gHBd75JE3286ZQ/Sa5lXmvaPhchy6XFtC
         k8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WXc/W7WM7svmOBnFamHW+1HsHd8RooyP9LEyJ6h6gzI=;
        b=uTEy8eF9UbHwiwU55bZIXBHDUqObudAcruvPSZuCOedzDAI+sqFd8EtmHnfki3zzpZ
         2oL0QEAa9pB1RW3GgrljMxckJdPva8WX4Iw7dIcI+ShAW7x42Tasu0l7xGsJrrJj0WxK
         h9f/pNmbZACr+f+baZT8iEIDcZJsKSTZ0Xt5ONujdRU3SZ27p0wj0hBNT4VhwIB3/ld3
         wy7YFanGt+QElwJKj9e1wihj91uzxl4y9Ub8ElTvuDZVFmYWLmfVB/dzCtXhFciRkifT
         ka0NJUIxTWr92hvtmtc9NRq6KOx+5Tl0ydCRMzHaAaKj/YBAZcg0RSGQzaEjDbQEQWQO
         Ga+A==
X-Gm-Message-State: ABuFfoj5hSt6T4496KwA4s5CIs8j5DCEDI1QWeaJ5edzZcxv8GpZ1WFY
        NF1h6K8f8saSl19M2uyGbf4FP+n9NwF0JzuCKN3msdkKIe5Pw4f7+sBDT3ScowJroXd2JEuz3Jp
        jGW4d8FmuSRJH95ybMUNEjV0rBAQCNFsY22xFprgKcmCUcYgyHt5Ce74Gruqh
X-Google-Smtp-Source: ACcGV60pVMqd9A8sVxSv05bHOASXkEXsff6K3zd6ma9XrvhI+XtsXf/k8mzxFoypxkA26PGoPLby8IP158q9
X-Received: by 2002:a9d:b9:: with SMTP id w54mr19572187oti.30.1539732958239;
 Tue, 16 Oct 2018 16:35:58 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:35:32 -0700
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Message-Id: <20181016233550.251311-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 01/19] sha1_file: allow read_object to read objects in
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow read_object (a file local functon in sha1_file) to
handle arbitrary repositories by passing the repository down
to oid_object_info_extended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1-file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 308d5e20e2..647068a836 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1361,7 +1361,9 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
+static void *read_object(struct repository *r,
+			 const unsigned char *sha1,
+			 enum object_type *type,
 			 unsigned long *size)
 {
 	struct object_id oid;
@@ -1373,7 +1375,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 	hashcpy(oid.hash, sha1);
 
-	if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
+	if (oid_object_info_extended(r, &oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1414,7 +1416,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		lookup_replace_object(the_repository, oid) : oid;
 
 	errno = 0;
-	data = read_object(repl->hash, type, size);
+	data = read_object(the_repository, repl->hash, type, size);
 	if (data)
 		return data;
 
@@ -1755,7 +1757,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(oid->hash, &type, &len);
+	buf = read_object(the_repository, oid->hash, &type, &len);
 	if (!buf)
 		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
-- 
2.19.0

