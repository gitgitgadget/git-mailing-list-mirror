Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B9C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbiDRR0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiDRR0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A533A1C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8634657wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hTeUNDKsqrngP5GaEC0OHa9DHOAY2ba8dPCAu8ZofA=;
        b=iQYbA3evu0ezCmdmz+2VWFL5XCsFcHDLoeKPrOiWEi2cJL+RwRYh5sgHkl+6z2ITKm
         luOaf+C2zT5tg/P7i0D7rwsbZ8Of+pqQ2K/JCApRmFafwaor+0QsTsEE+ywF7AUgqrpK
         HLuyrxgzvgHQRmAPkzz6UpEe5B6qq6NEVZNISnfwpyQb7ayxJ3IXMCEiK0enFt8LPbUH
         Dct6wb8aB20njRawRVjQmOp7abefBTua7iYlokCP77ftsPGjyvmgGbonijqwQkVz2r89
         Es+cVbCce63sv7cHd2Z1KeIBXZgbwEeWIF8Kdil85m70p4K27V9ezRFakC4Gg7Y5/KcE
         pIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hTeUNDKsqrngP5GaEC0OHa9DHOAY2ba8dPCAu8ZofA=;
        b=5V2RsWqU7nvPeuICgA0aPhv+N+Q9EIGZuKdLm3hshmK3BpmEMcyYAavNp/6lJo/iZm
         bSVU1tPi/zyTTg6oIGb7H2XJsYMIbhnUwyMKI4My5eYHm43HOlgTO0jM4H41z+a7XlTU
         VwANon1EeFwQDJNZUqGRtUKG2sBN4sSqqnJlJMnafsCPjNXuzLLvcv16UIcBI06HJVG6
         zK2vHKtgG398CCfXX8hxQcOlTx2LYbi+Mw1DkCyDYDQZAEP4tr8+dqEEIRDZc8quh06i
         GU6Ap+GATkFec6b0HQ+nA7sPi4oVllkL0fa9KNTNaiH8GNlbtrJlRjAf0MO9q7IuSf5i
         OrSw==
X-Gm-Message-State: AOAM533LisvaBtqrLbQS+RtDPAEyVM+IaBYG86qn3x70Hfb7X/M59ngn
        ARupWh+RHiGpaFQDZDRzmJhtLJ3AsHYgIQ==
X-Google-Smtp-Source: ABdhPJwCO2qabg/fz86+pXVC/HUVE7cy7j9EQTI5NTYn61VYi2nTQckSR8Zq47Ec9a3yQPh9z29heA==
X-Received: by 2002:a05:600c:1992:b0:392:916d:2168 with SMTP id t18-20020a05600c199200b00392916d2168mr8180356wmq.50.1650302643916;
        Mon, 18 Apr 2022 10:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/36] fetch-pack: add a deref_without_lazy_fetch_extended()
Date:   Mon, 18 Apr 2022 19:23:20 +0200
Message-Id: <RFC-patch-v2-03.36-7823a177fd7-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
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
index 4e1e88eea09..d0aa3a5c229 100644
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
2.36.0.rc2.902.g60576bbc845

