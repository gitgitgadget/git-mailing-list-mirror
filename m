Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFCCC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiCYRag (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiCYR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1FFCBCA
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4799418wmb.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63gFW+EwKfLK2dxaSv6TaMQf8x5xrbRmTzKRH1+NA+0=;
        b=AEa4NhKE+972DAoY01+0/53wr1Aw2E8OQbGpntZYhy48cMuIqR6zcKpLMaTMXRCWM6
         K66VA1MqTywtpxRdVYyUGgcwC4xZ1FYKzUCKJWnY7fW62FVRUZLbDqlzJw89XjOs8F9/
         gfy0Zor4EhvlFapt0t/CpZ5ZtagsVuFF/EKci6XMaiyyu+DaSOli5Ag+AYhBIYQIv7/j
         7Ar324pAqxJHOEYUprKJZKIISdV5gKEbUHbckklYCicet2Med9hko1K+PcsxprG0ZQ/a
         8FhB5bId3QtR+dE5SXq/PKEOcEFyRV4u6xuFW5w3uhz7qoB6PN9Skgb+/LpKwaUXTRcB
         RENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63gFW+EwKfLK2dxaSv6TaMQf8x5xrbRmTzKRH1+NA+0=;
        b=pV7Ik1S4otNzLiDt9NW+xQ5C5VimuDzydewbuCkb3Q3qFIIcR4F+YyucKi5Ev+73z1
         8RkpiYmqKzjT2goG5/ruTC9+568NtAdi1djXJ7lqLOsKfdpg8iQG2DzSiyluWKZFSS3w
         eQmRrayKMKZPnul/zkhAklQg9z9U9Jg1XjJpZRxeN94YDC21+oVL9AnxsVxCKQ/fYs8x
         UZZ9fS7SXwYKaf9sJHwlH5bcXW/kK0qKRqr1QnbnfWXqm79sFdqpvXbG9IOELUgp4Phu
         TRmjDukmE9iZg6TAO09ktSuJPrPKhBtM9Zthsv+WCYDs2roBvFUsxAiOYEn51zOqJ/c5
         4zig==
X-Gm-Message-State: AOAM532pToN9vcDk1kkVDPu/4IcIGOCNqpnJ69ydrbSkdK2I8rvdyKpy
        pjEYojNW3hvMUsW9Z2TUA0nr2Py4Q9swmw==
X-Google-Smtp-Source: ABdhPJwzMIkE+BrdiAB+6dhrOXJ6hWXmSIkY9mj0cpyhfwnMbkMrQO61q0U8Zd8iv9qrA+r3vVy+Eg==
X-Received: by 2002:a05:600c:3546:b0:38c:a8ff:843b with SMTP id i6-20020a05600c354600b0038ca8ff843bmr11199489wmq.24.1648228779247;
        Fri, 25 Mar 2022 10:19:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/27] revisions API users: add "goto cleanup" for "rev_info" early exit
Date:   Fri, 25 Mar 2022 18:18:32 +0100
Message-Id: <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add release_revisions() in various users of "struct rev_info" that can
mostly use a "goto cleanup" pattern, but also have an early "return"
before we've called repo_init_revisions(). We need to avoid calling
release_revisions() with uninitialized memory.

It would be a lot cleaner to be able to initialize "struct rev_info"
with "{ 0 }" here, or if a "REV_INFO_INIT" existed, we'll hopefully
get around to making the initialization easier in the future (now it
can't be done via a macro).

Until then let's leave a "cleanup_no_rev[s]" in place to document the
intention here. Only status_submodule() in builtin/submodule--helper.c
strictly speaking needs this, the other ones could keep their "return"
for the early exit. But let's have them also use the "goto
cleanup[...]" for consistency, and for the eventual migration to
simpler initialization.

For the bundle.c code see the early exit case added in
3bbbe467f29 (bundle verify: error out if called without an object
database, 2019-05-27).

For the relevant bisect.c code see 45b6370812c (bisect: libify
`check_good_are_ancestors_of_bad` and its dependents, 2020-02-17).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                    | 17 ++++++++++++-----
 builtin/submodule--helper.c |  6 ++++--
 bundle.c                    | 12 +++++++++---
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index cc6b8b6230d..c2e9f6ca9f6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1035,7 +1035,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 
 	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
 	if (res)
-		return res;
+		goto cleanup_no_revs;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
 
@@ -1060,14 +1060,16 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		       term_good,
 		       term_bad);
 
-		return BISECT_FAILED;
+		res = BISECT_FAILED;
+		goto cleanup;
 	}
 
 	if (!all) {
 		fprintf(stderr, _("No testable commit found.\n"
 			"Maybe you started with bad path arguments?\n"));
 
-		return BISECT_NO_TESTABLE_COMMIT;
+		res = BISECT_NO_TESTABLE_COMMIT;
+		goto cleanup;
 	}
 
 	bisect_rev = &revs.commits->item->object.oid;
@@ -1087,7 +1089,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		 * for negative return values for early returns up
 		 * until the cmd_bisect__helper() caller.
 		 */
-		return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
+		res = BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
+		goto cleanup;
 	}
 
 	nr = all - reaches - 1;
@@ -1106,7 +1109,11 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(r, ALL_REV_FLAGS);
 
-	return bisect_checkout(bisect_rev, no_checkout);
+	res = bisect_checkout(bisect_rev, no_checkout);
+cleanup:
+	release_revisions(&revs);
+cleanup_no_revs:
+	return res;
 }
 
 static inline int log2i(int n)
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 24980863f68..d1b656c0909 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -779,7 +779,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
 		print_status(flags, 'U', path, null_oid(), displaypath);
-		goto cleanup;
+		goto cleanup_no_rev;
 	}
 
 	strbuf_addf(&buf, "%s/.git", path);
@@ -791,7 +791,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	    !is_git_directory(git_dir)) {
 		print_status(flags, '-', path, ce_oid, displaypath);
 		strbuf_release(&buf);
-		goto cleanup;
+		goto cleanup_no_rev;
 	}
 	strbuf_release(&buf);
 
@@ -851,6 +851,8 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	}
 
 cleanup:
+	release_revisions(&rev);
+cleanup_no_rev:
 	strvec_clear(&diff_files_args);
 	free(displaypath);
 }
diff --git a/bundle.c b/bundle.c
index e359370cfcd..9b7c0bc55c4 100644
--- a/bundle.c
+++ b/bundle.c
@@ -202,8 +202,10 @@ int verify_bundle(struct repository *r,
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
-	if (!r || !r->objects || !r->objects->odb)
-		return error(_("need a repository to verify a bundle"));
+	if (!r || !r->objects || !r->objects->odb) {
+		ret = error(_("need a repository to verify a bundle"));
+		goto cleanup_no_revs;
+	}
 
 	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
@@ -221,7 +223,7 @@ int verify_bundle(struct repository *r,
 		error("%s %s", oid_to_hex(oid), name);
 	}
 	if (revs.pending.nr != p->nr)
-		return ret;
+		goto cleanup;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
@@ -283,6 +285,10 @@ int verify_bundle(struct repository *r,
 			list_refs(r, 0, NULL);
 		}
 	}
+
+cleanup:
+	release_revisions(&revs);
+cleanup_no_revs:
 	return ret;
 }
 
-- 
2.35.1.1509.ge4eeb5bd39e

