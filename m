Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B07C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350307AbiCKQ0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiCKQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:47 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804610E566
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r6so13292319wrr.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+La/Xk9OtpGN1w9rRYNkUN8P0Okli2PeNf+VeC1EF1c=;
        b=eDOrn5wTRtZvN5EPw4Np5iHp4HgWNZ2OsMY/tRpEdWxOrMs7uAM6L54Hs4l8zfsfCH
         hK0rEBfspEOHcwXrSiZiJkC2qcURRKkhIIGJLI4nshMSQuuQZdFwiyus5wAOERlQqoce
         31nj5wmdU7e7+Dq+nFGYS+0NRYtMi4T3SZ97w8K42p1qY2v9zqN2rF0++IS36+hZfrYc
         QKqESl2rGhOLAQV3/Fkhffwp9m4GxZjp6T0cZvOLOADkcikcmjvj82WOWymdhtvzq71w
         G+ORy7kIvrZ+QnJXvazlPUu2SJvPQ0HDydGAQRB7VV7csBJz5EtttArpjyJurSez6dPm
         wR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+La/Xk9OtpGN1w9rRYNkUN8P0Okli2PeNf+VeC1EF1c=;
        b=pE2uFWTWK8BcyPYPUOxiFkruVjSnHohuL1daSK5qwuM7GxmIp17QRRd4xpNFICbqKR
         VEAJwaQ6N724te24yaXE1rHg7/0HXkcf48TZxypn9tHhlvq2gZ5ZkJTaRCidQwMVLtCK
         v0S9715CRngjlbtkhSiq6ruLgyUY0gMzY0B3dCHIT2IfSa7euHIlATmYNuJ/wglD82ro
         6zMCvp/2zpXmDBq+C4dSmPRzuLn932vNoQSKaoONJ2NGmxIP7Kch7X5IwqMf8OQZuzJR
         0nGaZRbfjU3IhHpdng6yI6vudcxFlBBADyc3hERBSdd9MfKQUaPpV0Pa2qNdfVCdgstz
         aokg==
X-Gm-Message-State: AOAM533pEeGXzMOQ2l11TPvAXc76eoffAFWak842nG11s4e3oyDSk3w0
        v4Y3WH7a87lD+V10h/eWB9qTc/OkRjFRaQ==
X-Google-Smtp-Source: ABdhPJzWaRp8HqOCybrXELjrwQI7PlYfRlyABFtnzLZVO9GfFuj05KgCvrhipxL6szcnT1gu3qggNg==
X-Received: by 2002:a5d:4aca:0:b0:1f0:7a8c:3505 with SMTP id y10-20020a5d4aca000000b001f07a8c3505mr8048918wrs.337.1647015879833;
        Fri, 11 Mar 2022 08:24:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 09/13] fetch-pack: add a deref_without_lazy_fetch_extended()
Date:   Fri, 11 Mar 2022 17:24:21 +0100
Message-Id: <RFC-patch-v2-09.13-d9f5b486511-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a version of the deref_without_lazy_fetch function which can be
called with custom oi_flags and to grab information about the
"object_type". This will be used for the bundle-uri client in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 87657907e78..a0558f70b0c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -115,11 +115,12 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 		cb(negotiator, cache.items[i]);
 }
 
-static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
-					       int mark_tags_complete)
+static struct commit *deref_without_lazy_fetch_extended(const struct object_id *oid,
+							int mark_tags_complete,
+							enum object_type *type,
+							unsigned int oi_flags)
 {
-	enum object_type type;
-	struct object_info info = { .typep = &type };
+	struct object_info info = { .typep = type };
 	struct commit *commit;
 
 	commit = lookup_commit_in_graph(the_repository, oid);
@@ -128,9 +129,9 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
+					     oi_flags))
 			return NULL;
-		if (type == OBJ_TAG) {
+		if (*type == OBJ_TAG) {
 			struct tag *tag = (struct tag *)
 				parse_object(the_repository, oid);
 
@@ -144,7 +145,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 		}
 	}
 
-	if (type == OBJ_COMMIT) {
+	if (*type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(the_repository, oid);
 		if (!commit || repo_parse_commit(the_repository, commit))
 			return NULL;
@@ -154,6 +155,16 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 	return NULL;
 }
 
+
+static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
+					       int mark_tags_complete)
+{
+	enum object_type type;
+	unsigned flags = OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK;
+	return deref_without_lazy_fetch_extended(oid, mark_tags_complete,
+						 &type, flags);
+}
+
 static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 			       const struct object_id *oid)
 {
-- 
2.35.1.1337.g7e32d794afe

