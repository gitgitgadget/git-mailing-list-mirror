Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED2BC34050
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A8D2465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9ReEnXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBSQV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:21:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37250 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSQV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:21:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so1252241wru.4
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QOlAw8r3za8uo1YqxBtBcHBy6PEOKurX4bZpEUtVFgo=;
        b=e9ReEnXkmWPr3GGAuN2kPMSD7Al1sd0VsiWMvZ0drXtK9VMDSsIUcwUBxVOROfskuB
         elYioXzDBESkRUNLCYGd/QGlyCkmBkLbG+9QARszpDTtmhJThlfXA5iBfWOhGkS5DfFV
         Q3FrLfPcqSC4Rl2xuxxzxvkvE2l44DPkSWVvUC9Edn5Ru9gJKftBg1IUxPQFoO8wC1sr
         Fn9RRpgJoWvMPQxUr1BCzo3i+wyXRXkWHfUBwYtvhvz1fulX7oXKK4JyoNkKw14avoCu
         Q5zPMKiivjxQkiStv+/6Psdf6a/t2TDbrPDjG9BtyyhU6YOWub/IOXYl3wieTV17cOxB
         fMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QOlAw8r3za8uo1YqxBtBcHBy6PEOKurX4bZpEUtVFgo=;
        b=NJMen6rCjeFbMGrzx//Rle3Cq2CR3kJtZCeI5Vc3YBQ4CNYwJQGtyD6J6TVbLyxSm/
         CbmrNopGY5qSAUt2TajT7b0S7WS6Rc7B5rBHsLuU2JjtN6Cipf4pAaFxRVxeZTxwgTbH
         8D9KbpO4R/ZmYVGymklFeeoYC8GAx80JKeePBZsJk9PurInrXf8264KsK+QKNe1LGXgz
         n5CL7BwThh9STz0Vf3Lpx9JM3YOAHmHlBcnZ3s4byKL0vOXFXJK9XSgHPVTDNiFmCi+0
         zBY5xjJnSN6XBYpP968FeumvZxkoNM+lV4fX79Nulv4fX4Cv8VGJqV1dgMgpWu+06uGE
         C0mw==
X-Gm-Message-State: APjAAAVM4hl2o/1IJ0V7wqQcXMi4B6cm+y5mEtSGy5UhzMbSU0j96P7E
        sph8rc7PbUJGJ8NhpZCJl9bgygld
X-Google-Smtp-Source: APXvYqzTSlX8ye185ZzvGrCTR+nxKu5MJYmGHWMyHTayYsG6G0QSxwldkst0u8Cd0UFLUbUBixz8AQ==
X-Received: by 2002:a5d:5188:: with SMTP id k8mr36774116wrv.151.1582129315562;
        Wed, 19 Feb 2020 08:21:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm342161wrs.8.2020.02.19.08.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:21:54 -0800 (PST)
Message-Id: <937a882261d4d4552a144e5f0efad8abd8002ab4.1582129312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.556.git.1582129312.gitgitgadget@gmail.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 16:21:52 +0000
Subject: [PATCH 2/2] partial-clone: avoid fetching when looking for objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When using partial-clone, do_oid_object_info_extended() can trigger a
fetch for missing objects. This can be extremely expensive when asking
for a tag or commit, as we are completely removed from the context of
the missing object and thus supply no "haves" in the request.

6462d5eb9a (fetch: remove fetch_if_missing=0, 2019-11-05) removed a
global variable that prevented these fetches in favor of a bitflag.
However, some object existence checks were not updated to use this flag.

Update find_non_local_tags() to use OBJECT_INFO_SKIP_FETCH_OBJECT in
addition to OBJECT_INFO_QUICK. The _QUICK option only prevents
repreparing the pack-file structures. We need to be extremely careful
about supplying _SKIP_FETCH_OBJECT when we expect an object to not exist
due to updated refs.

This resolves a broken test in t5616-partial-clone.sh.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c          | 10 +++++-----
 t/t5616-partial-clone.sh |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b4c6d921d06..fd69c4f69d7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -335,6 +335,7 @@ static void find_non_local_tags(const struct ref *refs,
 	struct string_list_item *remote_ref_item;
 	const struct ref *ref;
 	struct refname_hash_entry *item = NULL;
+	const int quick_flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
 
 	refname_hash_init(&existing_refs);
 	refname_hash_init(&remote_refs);
@@ -353,10 +354,9 @@ static void find_non_local_tags(const struct ref *refs,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !has_object_file_with_flags(&ref->old_oid,
-							OBJECT_INFO_QUICK) &&
+			    !has_object_file_with_flags(&ref->old_oid, quick_flags) &&
 			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
-			    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
+			    !has_object_file_with_flags(&item->oid, quick_flags) &&
 			    !oidset_contains(&fetch_oids, &item->oid))
 				clear_item(item);
 			item = NULL;
@@ -370,7 +370,7 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
+		    !has_object_file_with_flags(&item->oid, quick_flags) &&
 		    !oidset_contains(&fetch_oids, &item->oid))
 			clear_item(item);
 
@@ -391,7 +391,7 @@ static void find_non_local_tags(const struct ref *refs,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !has_object_file_with_flags(&item->oid, OBJECT_INFO_QUICK) &&
+	    !has_object_file_with_flags(&item->oid, quick_flags) &&
 	    !oidset_contains(&fetch_oids, &item->oid))
 		clear_item(item);
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index ed2ef45c37a..c70516734d5 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -385,7 +385,7 @@ test_expect_failure 'verify fetch succeeds when asking for new tags' '
 	git -C tag-test fetch --tags origin
 '
 
-test_expect_failure 'verify fetch downloads only one pack when updating refs' '
+test_expect_success 'verify fetch downloads only one pack when updating refs' '
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
 	ls pack-test/.git/objects/pack/*pack >pack-list &&
 	test_line_count = 2 pack-list &&
-- 
gitgitgadget
