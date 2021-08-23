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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E813C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DF0611EF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhHWLhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbhHWLhE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF06C061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u15so10307351wmj.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWEvP/rgqF998BLYui1IRCFqFy97LCGOvuaM5Kyt9uU=;
        b=RCIY+8KWvefZxaUlpf/Y9OBlzzoai/SXwQSWRu2CH68+Di3r8G43r05mLS46iPwIMF
         kgwONCgxD9qeQl7JtgPvuRoXyu0PKQfRW4mBWvktMUKS+ZIpJVSmjWHCd5C8UGh3ONaT
         UaV/3VRbKvqESMqJ6BC0nPtVHXDXyOVthxgQb7Zv1NurXnCEuwx7Ft1Jsoi/Pwr6XlNt
         MXrDC9WeATQ54ONFwS90vhVnmMSJQBSVlr3dled99z6i+J0IGtCilj7lVqANCDvE3tGb
         OVpwUbEZD8xFqgwEY26u768gD+0UIR/Zamk9N8ZkxTsJ6IwZMEYcAjU0u4R3dRKp18JN
         RGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWEvP/rgqF998BLYui1IRCFqFy97LCGOvuaM5Kyt9uU=;
        b=HmpPNqzeMhffrkShxF99YbiospA9J5sVZtlz2M+tehz05z8ybq8hIJnm1Z1p04KF/O
         8IXd6tdtj3pmvuXwZQJ3cz4JzRyuAXW1rkhlZwcdeF97uMH9V4U4Lhhimx0ZVObrSkn2
         LQOwn0i8XtN3EYpIqZ2lqoGwFWA79ZDcpViHPHbu+xylzJIm3qMpoeZWIg5nZT6o+oga
         6jwXjVahtJHCZJHJi35k/I16tqi8sFW4KIrlicXQ2vi2Z/9jwiciBdVZ2KsEPqdWIv5j
         Uz6SAmOUr+uzj5km/dmTpm51iw57czdpNjXsukTzYY/VySpm2aA03Nse1VOvEJHZx+C5
         wsWg==
X-Gm-Message-State: AOAM533CxUWFsCHMJjmURI2T2t5Zp2p7suqS7rdP1XbncrUK3NaMIIVG
        2xpBkfWFVmMtqX729GYxqRXXX1OBwubN7+rY
X-Google-Smtp-Source: ABdhPJwrNUXNafVzJLflMwP8KUMvJRhCWTZXdoTnvP7u8qxGpqeKnZFf4VHg1k+vZGYtUrvvi6V/ew==
X-Received: by 2002:a05:600c:2281:: with SMTP id 1mr16037770wmf.9.1629718579414;
        Mon, 23 Aug 2021 04:36:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/13] refs: drop unused "flags" parameter to lock_ref_oid_basic()
Date:   Mon, 23 Aug 2021 13:36:04 +0200
Message-Id: <patch-v5-03.13-d3216a6b1d8-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In the last commit we removed the REF_DELETING flag from
lock_ref_oid_basic(). Since then all of the remaining callers do pass
REF_NO_DEREF, but that has been ignored completely since
7a418f3a17 (lock_ref_sha1_basic(): only handle REF_NODEREF mode,
2016-04-22).

So we can simply get rid of the parameter entirely.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 326f0224218..e73458e2571 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -917,8 +917,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const struct object_id *old_oid,
 					   const struct string_list *extras,
 					   const struct string_list *skip,
-					   unsigned int flags, int *type,
-					   struct strbuf *err)
+					   int *type, struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
@@ -1413,8 +1412,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
+
 	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
-				  REF_NO_DEREF, NULL, &err);
+				  NULL, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1437,7 +1437,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
  rollback:
 	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
-				  REF_NO_DEREF, NULL, &err);
+				  NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1845,7 +1845,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	int ret;
 
 	lock = lock_ref_oid_basic(refs, refname, NULL,
-				  NULL, NULL, REF_NO_DEREF, NULL,
+				  NULL, NULL, NULL,
 				  &err);
 	if (!lock) {
 		error("%s", err.buf);
@@ -3064,8 +3064,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference if --updateref was specified:
 	 */
 	lock = lock_ref_oid_basic(refs, refname, oid,
-				  NULL, NULL, REF_NO_DEREF,
-				  &type, &err);
+				  NULL, NULL, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-- 
2.33.0.662.g438caf9576d

