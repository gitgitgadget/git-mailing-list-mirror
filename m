Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347DFC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C65C61164
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhJNAIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhJNAIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63E7C061760
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v17so13749749wrv.9
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9KQ3D0B6zButhuTSLtZuiZ/+JQO65I/xGCF1uYoJYE=;
        b=RH9l/U7sM9duHMhndm4vehUy2sVDoymkBtY5dcH+Y4AOUyyT1a2C/z0h3VLxGHrmFx
         PpE63r2uQ/V0pLMXLfWxYaj+Z2Um2WRRYkNNv1LuWADMY1tLCLaVkh8Hnt7rNP3RM1sh
         TkYi+RHrAXMU75H6n+XFr7XLtyLps5wpNwXiuCESVeucRfjRStfT5fUgpavzl1TRXQOv
         KtcTnqWikg1Zz+pZMXhTGTkg529S5iR+O3gOd/UXIVrMJlXeev/bO+dW/sIMBlEnB+5J
         ocexUpgL66+NMNm1z37zoyx0siIVH9IAGt489XF1blMDEXICQpT0FeHEcEwIX66LBf4H
         1lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9KQ3D0B6zButhuTSLtZuiZ/+JQO65I/xGCF1uYoJYE=;
        b=Omqfxn5WgepFatmsshG5eic1MFoK3VlzIgGS7W3x1mXkSU2Kz5ha+EkqMQKY8e4IWg
         JQoc3ymh8Xej2WS4k0lnISnV8JpEFKNMjIlzORcZxz5triHD49RXqlYa0A4d2hA/8db7
         AjYSvquubrgJEzAJj3owtyo058RYwOblf2ourXe1kUVXeWCkxsmLQ7RsECG8ApmyiS31
         l6iV+Y/liYWc1NETzm0+IT2pSbXLj/XLI9UrnAvRNU/sw3H2xMUt8g20j11XWCqRrHjy
         HyGC1mhtDkTwxUCTytpDSlHmyFX+w2bKmy0OBvlSoGDtQfD53nUPUIZtz74bQvDglHkn
         C8gA==
X-Gm-Message-State: AOAM530uYv4CwkX6Ou75HSnj1XxnSIEWIK+Jdl3LFFAH+tDX6RHlPQes
        OLkNvTulmMX0Em4hWFNEswp31+UMaxOnAQ==
X-Google-Smtp-Source: ABdhPJz/5UAsWqbrGBPxIJU80bP+3hHqGjb98Q6OOHS5GePxGuHnVM3NmUv+CM0nySVGYSA8fu78Pg==
X-Received: by 2002:a1c:4b16:: with SMTP id y22mr16005292wma.73.1634169999276;
        Wed, 13 Oct 2021 17:06:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/20] refs/files: remove "name exist?" check in lock_ref_oid_basic()
Date:   Thu, 14 Oct 2021 02:06:18 +0200
Message-Id: <patch-06.20-3162bf28505-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In lock_ref_oid_basic() we'll happily lock a reference that doesn't
exist yet. That's normal, and is how references are initially born,
but we don't need to retain checks here in lock_ref_oid_basic() about
the state of the ref, when what we're checking is either checked
already, or something we're about to discover by trying to lock the
ref with raceproof_create_file().

The improved diagnostics here were added in
5b2d8d6f218 (lock_ref_sha1_basic(): improve diagnostics for ref D/F
conflicts, 2015-05-11), and then much of the surrounding code went
away recently in my 245fbba46d6 (refs/files: remove unused "errno ==
EISDIR" code, 2021-08-23).

The refs_resolve_ref_unsafe() code being removed here looks like it
should be tasked with doing that, but it's actually redundant to other
code.

The reason for that is as noted in 245fbba46d6 this once widely used
function now only has a handful of callers left, which all handle this
case themselves.

To the extent that we're racy between their check and ours removing
this check actually improves the situation, as we'll be doing fewer
things between the not-under-lock initial check and acquiring the
lock.

Why this is OK for all the remaining callers of lock_ref_oid_basic()
is noted below. There are only two of those callers:

* "git branch -[cm] <oldbranch> <newbranch>":

  In files_copy_or_rename_ref() we'll call this when we copy or rename
  refs via rename_ref() and copy_ref(). but only after we've checked
  if the refname exists already via its own call to
  refs_resolve_ref_unsafe() and refs_rename_ref_available().

  As the updated comment to the latter here notes neither of those are
  actually needed. If we delete not only this code but also
  refs_rename_ref_available() we'll do just fine, we'll just emit a
  less friendly error message if e.g. "git branch -m A B/C" would have
  a D/F conflict with a "B" file.

  Actually we'd probably die before that in case reflogs for the
  branch existed, i.e. when the try to rename() or copy_file() the
  relevant reflog, since if we've got a D/F conflict with a branch
  name we'll probably also have the same with its reflogs (but not
  necessarily, we might have reflogs, but it might not).

  As some #leftoverbits that code seems buggy to me, i.e. the reflog
  "protocol" should be to get a lock on the main ref, and then perform
  ref and/or reflog operations. That code dates back to
  c976d415e53 (git-branch: add options and tests for branch renaming,
  2006-11-28) and probably pre-dated the solidifying of that
  convention. But in any case, that edge case is not our bug or
  problem right now.

* "git reflog expire <ref>":

  In files_reflog_expire() we'll call this without previous ref
  existence checking in files-backend.c, but that code is in turn
  called by code that's just finished checking if the refname whose
  reflog we're expiring exists.

  See ae35e16cd43 (reflog expire: don't lock reflogs using previously
  seen OID, 2021-08-23) for the current state of that code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0af6ee44552..0dd21b2e205 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1013,16 +1013,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	CALLOC_ARRAY(lock, 1);
 
 	files_ref_path(refs, &ref_file, refname);
-	if (!refs_resolve_ref_unsafe(&refs->base, refname,
-				     RESOLVE_REF_NO_RECURSE,
-				     &lock->old_oid, type)) {
-		if (!refs_verify_refname_available(&refs->base, refname,
-						   NULL, NULL, err))
-			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(errno));
-
-		goto error_return;
-	}
 
 	/*
 	 * If the ref did not exist and we are creating it, make sure
@@ -1364,14 +1354,14 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     struct strbuf *err);
 
 /*
- * Check whether an attempt to rename old_refname to new_refname would
- * cause a D/F conflict with any existing reference (other than
- * possibly old_refname). If there would be a conflict, emit an error
+ * Emit a better error message than lockfile.c's
+ * unable_to_lock_message() would in case there is a D/F conflict with
+ * another existing reference. If there would be a conflict, emit an error
  * message and return false; otherwise, return true.
  *
  * Note that this function is not safe against all races with other
- * processes (though rename_ref() catches some races that might get by
- * this check).
+ * processes, and that's not its job. We'll emit a more verbose error on D/f
+ * conflicts if we get past it into lock_ref_oid_basic().
  */
 static int refs_rename_ref_available(struct ref_store *refs,
 			      const char *old_refname,
-- 
2.33.1.1346.g48288c3c089

