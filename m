Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA9DC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E66A6137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhHWMOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbhHWMOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF2C0611FA
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so10628142wma.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+AJChtzucZGNU2OGNxomP1FHjNsLpjcBUXfQ2Nk6DYU=;
        b=afBCKxK8nVPXBTQZDc1MvuO4eQf4NPHA7nqOeeqdAOcFU/jBhra9muyvCzGEMIOo9b
         u2CLyOkMvYGIthNup5dIa0GQULenjyZcJdb3V8CEVXPETU/lnavGJTSKpfu+XFTTCaJm
         jDK0darOg5pUlMvUbYKjisJ2r+91V6WtzrGFqAYrKMiVEDFPAjpsCihmwHx5Aeb556sR
         QOWF6FEiWsg6ptIeFhiqW4/XfHsLmiEImdcVh58che+rCrUYbge/b3pIkKFbS3DAYWcz
         pV51JWTo3lH7aQKrUh8Ubtzfr/vL8UWgPj4582A4zjOYBc6R9JbnFvVWO3uOFKmJzaZO
         Nhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AJChtzucZGNU2OGNxomP1FHjNsLpjcBUXfQ2Nk6DYU=;
        b=OyB1XPrwcYQLGC7ZutQszc2iIlg1WLTrGpYtpQ6TMSuTfMQuXHJ0yMHzQ2JGSfIJSO
         xBOgZlRdaRIBl+Fd8l99hMM65xuklAitrYe7w3hCaW9lCvmKzHK97qX2vilf/Bz8Qa2R
         f1WZRfNGxDLi+P4GcgHsbcCsVka5nYW2dgfNRNRlb2+FOyHbLcpuNz/TS1/uA/bCtw8N
         JYY4XlsKQsLrTIW1a6msOdwVxiooyBjAXOVOfml1KDYKJ4HXJ8hdguiSVVwA8cJ4FFJa
         ImrnNHOErT+NHLGd7Gv/oq986sH1h/b3/XjSA1OT76ETP3JFsbfzs0JTu5Wh6kNzqgt1
         XvlA==
X-Gm-Message-State: AOAM533Rz5kKXd0afJHaXceXRkt5nBNrkrfmcjBtswFGwNUgdrZ2BfOv
        kcR2gEOg9/csxe68sIAXCfnfiE6NNx8pPhx/
X-Google-Smtp-Source: ABdhPJzECFm7yp4SkxkyW6xq/RtEGecAjL0o9t5MqSmijZibUyrjszeDUPfIzTtNrJDg4L7JJI6ZIQ==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr15607124wmc.102.1629720799283;
        Mon, 23 Aug 2021 05:13:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 28/28] reftable: fixup for new base topic 3/3
Date:   Mon, 23 Aug 2021 14:12:39 +0200
Message-Id: <patch-v4-28.28-c863b03201c-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "refs: add failure_errno to refs_read_raw_ref() signature"
in the base topic we've preferred to use
refs_resolve_ref_unsafe_with_errno() over the
refs_resolve_ref_unsafe().

Let's make it explicitly clear that we're ignoring "errno" in these
cases, and while we're at it change "if (x != NULL)" to just "if (x)"
as refs_resolve_ref_unsafe*() returns a const char *, and explicitly
checking 0 or NULL in if's is not in line with our coding guidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/reftable-backend.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 94917c85cf7..61ee144e19e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -315,9 +315,11 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			break;
 		case REFTABLE_REF_SYMREF: {
 			int out_flags = 0;
-			const char *resolved = refs_resolve_ref_unsafe(
+			int ignore_errno;
+			const char *resolved = refs_resolve_ref_unsafe_with_errno(
 				ri->ref_store, ri->ref.refname,
-				RESOLVE_REF_READING, &ri->oid, &out_flags);
+				RESOLVE_REF_READING, &ri->oid, &out_flags,
+				&ignore_errno);
 			ri->base.flags = out_flags;
 			if (resolved == NULL &&
 			    !(ri->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
@@ -543,8 +545,10 @@ static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
 {
 	struct object_id out_oid;
 	int out_flags = 0;
-	const char *resolved = refs_resolve_ref_unsafe(
-		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
+	int ignore_errno;
+	const char *resolved = refs_resolve_ref_unsafe_with_errno(
+		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags,
+		&ignore_errno);
 	if (is_null_oid(want_oid) != (resolved == NULL)) {
 		return REFTABLE_LOCK_ERROR;
 	}
@@ -845,20 +849,24 @@ static int write_create_symref_table(struct reftable_writer *writer, void *arg)
 		struct reftable_log_record log = { NULL };
 		struct object_id new_oid;
 		struct object_id old_oid;
+		int ignore_errno;
 
 		fill_reftable_log_record(&log);
 		log.refname = (char *)create->refname;
 		log.update_index = ts;
 		log.value.update.message = (char *)create->logmsg;
-		if (refs_resolve_ref_unsafe(
+		if (refs_resolve_ref_unsafe_with_errno(
 			    (struct ref_store *)create->refs, create->refname,
-			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
+			    RESOLVE_REF_READING, &old_oid, NULL,
+			    &ignore_errno)) {
 			log.value.update.old_hash = old_oid.hash;
 		}
 
-		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
-					    create->target, RESOLVE_REF_READING,
-					    &new_oid, NULL) != NULL) {
+		if (refs_resolve_ref_unsafe_with_errno((struct ref_store *)create->refs,
+						       create->target,
+						       RESOLVE_REF_READING,
+						       &new_oid, NULL,
+						       &ignore_errno)) {
 			log.value.update.new_hash = new_oid.hash;
 		}
 
-- 
2.33.0.662.gbaddc25a55e

