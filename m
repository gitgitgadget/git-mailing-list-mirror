Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932AC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBFAI0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:08:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32771 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeBFAIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:08:24 -0500
Received: by mail-pg0-f67.google.com with SMTP id u1so150523pgr.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDjkjWNHjo2IqYzkjMMXfK/G0X2gX+VpFlRVj4hKhPg=;
        b=Zn4b7SK/gEWigOkHivMhu5RbLPz/0ypW+s8E2FfIVods0rSWEb8wLpB3EXT5nHlu5i
         wGVukHc/wka6HdmpJGc/UylNS3iasdoIqzZY89rYqMoNTrvm8sv+hyeRlUsiPHgOH2jR
         6ynnDTWMMQG+s/kOzmn1V2abN6fHHRUHf6nc5zzjZY1ynbt2v3NxYdHDeULvFOW8i9i9
         2g2Z+p0QZxt7V142yCfumE/Zf9znui0tPIozoIim3/B4K4tYu+3viteThfsokyl7/+b6
         n5Egj6nNUvLc5SUeW4TnZiRypqLxIHw0zl2nwGiMMs4KFuCLR/+iVVSVVtJv+vjFfy/k
         Fcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDjkjWNHjo2IqYzkjMMXfK/G0X2gX+VpFlRVj4hKhPg=;
        b=i0ak8HwnfUVhrC84wCQwBgHCfpMj4Kkn7juwT9ifwXqjixPAIwkjUMffjlBvb+zUQ+
         yw68WqHuOioxNjSyReauSpDPSERop3Jd0SM3Quq7h1OYg69E65cKtndiZ8eUixO2QYIv
         ThcDg92TcsN4ml2Ft67hRywqEtTSFjpkPKqNdxynLTwKlqJ5O+k7lK9InT82YLuK1EvR
         wG4thNhCn8DxW+12TAz1G4NCjqdkzqa58Lvho5f1UT1IPer4ocaMZGeCXZS0ous4CRH+
         xBMsJ2TogkOhqiFajf7VlwBF+6rJdUsCaXMvrkRQ3/uotnaOjwoHz/BiOjFbMYzfBUx+
         bJ/w==
X-Gm-Message-State: APf1xPCCKYdO8ukIIkRBMtFlN9LmrwRK80BN5ZZyX1YlFvSypyuDmI9w
        Qj3OlsGgHrBcwAGMA/rM0Uz7Eze6CCs=
X-Google-Smtp-Source: AH8x226mv/nT92qzk9tTC8kfrC3NZUDIhcBm1Q/UX2RfaJPRJ8xnrhGRbrSqKqEJOuWZgT7Yhvo08A==
X-Received: by 10.99.138.199 with SMTP id y190mr431937pgd.90.1517875703632;
        Mon, 05 Feb 2018 16:08:23 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id v186sm17654882pfb.5.2018.02.05.16.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:08:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 067/194] pack: add repository argument to packed_to_object_type
Date:   Mon,  5 Feb 2018 15:55:28 -0800
Message-Id: <20180205235735.216710-47-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of packed_to_object_type
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index 66391b8a6f..250c9af1a7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1102,11 +1102,13 @@ static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t ob
 
 #define POI_STACK_PREALLOC 64
 
-static enum object_type packed_to_object_type(struct packed_git *p,
-					      off_t obj_offset,
-					      enum object_type type,
-					      struct pack_window **w_curs,
-					      off_t curpos)
+#define packed_to_object_type(r, p, o, t, w, c) \
+	packed_to_object_type_##r(p, o, t, w, c)
+static enum object_type packed_to_object_type_the_repository(struct packed_git *p,
+							     off_t obj_offset,
+							     enum object_type type,
+							     struct pack_window **w_curs,
+							     off_t curpos)
 {
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
@@ -1356,8 +1358,8 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 
 	if (oi->typep || oi->typename) {
 		enum object_type ptot;
-		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
-					     curpos);
+		ptot = packed_to_object_type(the_repository, p, obj_offset,
+					     type, &w_curs, curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (oi->typename) {
-- 
2.15.1.433.g936d1b9894.dirty

