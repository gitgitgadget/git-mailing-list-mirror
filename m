Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21EC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C459720578
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kL5vlk3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHXTRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHXTRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:17:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3172CC061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:00 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ei10so5159813pjb.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mPaJM5bueCYmeHg+EcLJinSR1Hm7oluX5vMhkQkq52A=;
        b=kL5vlk3KuTvxedrh8IWrRSrE2v5E+eDv3TLA+V0elSnAjo4YyL0CWMI/SEmH07oH7J
         lk4czhVZH9+ZkINEhUeCio6UI0ZCSU3k+4k0o0b+e41CkKquMebpDcN89HaDyOfgxvQp
         k5AmATjw9qqKeT+7u21Z0tFrewVDvpkkJDZ8XLlqXoNYtRGGhm3jaz6MY54/EAT/ZFOV
         Qr7bNkB8NV4Rw8yV9tktZRSSpfipI2h+6ZaBANKIT8jYtCJXOkh/cBJblOeLCqji26Js
         OrdWbDhz6nZSUhiXjiyPTVTt8oLGmhllNmEkZqsyZNY2a0EwsyPliDMhZli1UehHRJ2Y
         9FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mPaJM5bueCYmeHg+EcLJinSR1Hm7oluX5vMhkQkq52A=;
        b=WSf5xin+9g2qt2VacR4Y/KK1tOYXQgMz+JwXbflv9KYabqyVLviNCNwxh70xT8KX/g
         cRDgszjV/npdOa+BYJEvtHBt5c0ESL2b/c3ZHpmcCECjbPGC4H/3/mdtA6weXZ2x//PZ
         YhCQtqttdjPeuR8XoNk8vojYF5N3V0+d3zl39ja/ZoBKMUSvjtOgTK+oCwhrWaC36mA9
         1RyOclU6s0ywNv9EFGad2saBcPt4iqHq6Flx3rFasrlK7ayvutpLATaKO72R5Iu8mJHT
         5Bg5+cOQalBlQqShHCEpABLwGAsj9ycyFm0PgaN7wk5zxLP5VtD1tD/SKFX7t9JVWLAo
         P+hQ==
X-Gm-Message-State: AOAM533tgXKa1BtWfnaFylbYUgzExqRP75Y3D8fGQdXjtrdfV2FjWXr1
        EeSMIyOgmPgefdlW1WA9VGxi1DWUNKO60tVlG+tRr5JUMnxvmIy9YLe3CuaNvdvyfKYaPditS9a
        D1TTZU+4XAtKi/p+K1cZubjwi850ghqvIlQvAayv83BbuvCggw+A0tDiNNQrrC1RasFPSXeMn82
        b4
X-Google-Smtp-Source: ABdhPJwAU4Xn6Ps9eLIoN9WiJ/Qb7WwzigtKpb8x/W5Xbxv/bKFx/l3/nO/uW3Fr8wOjIzCJ3i3eaJ+z0+ErmR9zJgKf
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:638c:: with SMTP id
 f12mr109833pjj.1.1598296619306; Mon, 24 Aug 2020 12:16:59 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:16:33 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <648ec34821bd435468a0917167bdeef7ca101c02.1598296530.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 2/7] index-pack: remove redundant parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find_{ref,ofs}_delta_{,children} take an enum object_type parameter, but
the object type is already present in the name of the function. Remove
that parameter from these functions.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f865666db9..a8444d550b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -614,7 +614,7 @@ static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
 	       0;
 }
 
-static int find_ofs_delta(const off_t offset, enum object_type type)
+static int find_ofs_delta(const off_t offset)
 {
 	int first = 0, last = nr_ofs_deltas;
 
@@ -624,7 +624,8 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 		int cmp;
 
 		cmp = compare_ofs_delta_bases(offset, delta->offset,
-					      type, objects[delta->obj_no].type);
+					      OBJ_OFS_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -637,10 +638,9 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 }
 
 static void find_ofs_delta_children(off_t offset,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ofs_delta(offset, type);
+	int first = find_ofs_delta(offset);
 	int last = first;
 	int end = nr_ofs_deltas - 1;
 
@@ -668,7 +668,7 @@ static int compare_ref_delta_bases(const struct object_id *oid1,
 	return oidcmp(oid1, oid2);
 }
 
-static int find_ref_delta(const struct object_id *oid, enum object_type type)
+static int find_ref_delta(const struct object_id *oid)
 {
 	int first = 0, last = nr_ref_deltas;
 
@@ -678,7 +678,8 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 		int cmp;
 
 		cmp = compare_ref_delta_bases(oid, &delta->oid,
-					      type, objects[delta->obj_no].type);
+					      OBJ_REF_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -691,10 +692,9 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 }
 
 static void find_ref_delta_children(const struct object_id *oid,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ref_delta(oid, type);
+	int first = find_ref_delta(oid);
 	int last = first;
 	int end = nr_ref_deltas - 1;
 
@@ -983,12 +983,10 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 {
 	if (base->ref_last == -1 && base->ofs_last == -1) {
 		find_ref_delta_children(&base->obj->idx.oid,
-					&base->ref_first, &base->ref_last,
-					OBJ_REF_DELTA);
+					&base->ref_first, &base->ref_last);
 
 		find_ofs_delta_children(base->obj->idx.offset,
-					&base->ofs_first, &base->ofs_last,
-					OBJ_OFS_DELTA);
+					&base->ofs_first, &base->ofs_last);
 
 		if (base->ref_last == -1 && base->ofs_last == -1) {
 			free(base->data);
-- 
2.28.0.297.g1956fa8f8d-goog

