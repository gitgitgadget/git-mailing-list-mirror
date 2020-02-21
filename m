Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B2EC35669
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D69E206D7
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODq5HIx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgBUVrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:47:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32914 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 16:47:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so6092596wmc.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 13:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6U0PfHwMooVOokYwJGBg5FmOTEJmecyj0uVZ0d5sHWc=;
        b=ODq5HIx3dnwHvZtpNW7lSz5yGUM1oKC9gzDgcPZLKZECB62gbDruDGPIirxBoEv4ut
         ND9CH9ThG71abYeqLe/dYelSi2jtPjQbLKlQ41NfFzETtPyaQMk3NYi7CnX5297znF+t
         gxTvU5N3GBTiF2lGy8mj18doS5ustfYUanCsBxAOrS5HKzphaKmZHg1fb2rr84VldBZv
         mBHyWyOKvu+7+vBkG7Cmb3rZRvundeKR1mkcc+H4tECQyNvVGaI+pS/y7zi3dSx/IW56
         tApoCvh+DtQlZn18QIqwnavQ6Wu9xwNCaWdeuxnkgWo8NVJRRkS0YBUOHpdK/sRvFSsO
         HClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6U0PfHwMooVOokYwJGBg5FmOTEJmecyj0uVZ0d5sHWc=;
        b=D0FmBRXlTWPDjHi3YenQnY1UvuAWoadFsCk8j/OmBW0Ppfsr+xOA0yxZaCnS89Or6t
         2yqXZSl0RIC+RP6SL19ZW8wXKnryAKwjVfBkpmR3g8Lsv+ay6zmlEBKIclKuWptcKbMN
         8sTm9mfFYx/bHrBG/KEr3rKbSMeis02nmO9aMv5mO2Bq21SSB6U5GJI8SfJZSaCEtO0B
         SGp1UxiSc/+PayyoGCg6KZJU4KbutzMuJKwBNcMxMvTxrseoQgltCtaqC7ktqbisrFk5
         KP93Y2GU1KZqEp8SiZDrVIz10JY0NlSEXhC09izmNhXBvEP2aq01Z67evSIdomcXEfFZ
         yvww==
X-Gm-Message-State: APjAAAVeNlMnOt8PD3YqmPZl1s7B9VAJqHSmApH1XZs22phet6SCZY9A
        5fpaU5sE95noZHbxeW4yylKewYKI
X-Google-Smtp-Source: APXvYqxC6MwMvxcEvwZrHYjoEM1grSj5uohuCr8vklKnFIv0mXSFbOgl9kVx2LURhyHBfTOMfFCIvg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr6004714wmg.92.1582321651084;
        Fri, 21 Feb 2020 13:47:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm5521950wme.16.2020.02.21.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:47:30 -0800 (PST)
Message-Id: <7c4c9f0f8e1052d2ae78c6336909711126de2547.1582321648.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.556.v2.git.1582321648.gitgitgadget@gmail.com>
References: <pull.556.git.1582129312.gitgitgadget@gmail.com>
        <pull.556.v2.git.1582321648.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 21:47:28 +0000
Subject: [PATCH v2 2/2] partial-clone: avoid fetching when looking for objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, jonathantanmy@google.com,
        jrnieder@gmail.com, sunshine@sunshineco.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When using partial clone, find_non_local_tags() in builtin/fetch.c
checks each remote tag to see if its object also exists locally. There
is no expectation that the object exist locally, but this function
nevertheless triggers a lazy fetch if the object does not exist. This
can be extremely expensive when asking for a commit, as we are
completely removed from the context of the non-existent object and
thus supply no "haves" in the request.

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
index 022f1018ace..da3ad4e32a1 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -390,7 +390,7 @@ test_expect_failure 'verify fetch succeeds when asking for new tags' '
 	git -C tag-test -c protocol.version=2 fetch --tags origin
 '
 
-test_expect_failure 'verify fetch downloads only one pack when updating refs' '
+test_expect_success 'verify fetch downloads only one pack when updating refs' '
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
 	ls pack-test/.git/objects/pack/*pack >pack-list &&
 	test_line_count = 2 pack-list &&
-- 
gitgitgadget
