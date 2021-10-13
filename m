Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99524610D0
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhJMN0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbhJMN0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:26:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E2C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:24:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t2so8357944wrb.8
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVvPK5COM6v54G4vPWlHwnaXgrf/PDAHYl3qMymFINY=;
        b=mQaBxEXggAQ0TRfndB619S1YKErF4mu+8t4P3rBbhgha/Y0nOHArlJxym9mT4dc/U6
         7aovW98G2k9A6R8zQNJ3IAV5gCJ86uRbEAiCqyUEPfQboxoQ0zpO/oFThRtsWgMqKHHI
         U6wdN1gRVnGDj7ZO3O2K+kFiXZClvqMji50JW9FDsok72TrvgqIW34QAldPBpjjImpre
         9muxy+vRj32b+JDbArP9uSqynlquw+hQi4chEAm47kiNCRauTbq0NWqAUrCRcVuFeWGo
         DsjlKEVpKks1AivAtF2ZHOkhrJUBJmAI8ANxIkdr4XG5LTRRJdjJNbnlFiXSP5jCOBXR
         PlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVvPK5COM6v54G4vPWlHwnaXgrf/PDAHYl3qMymFINY=;
        b=JETytoOr5VkI4Q4lG5YXLUuF73YxcZNDe7Mj2LNLQpMelxJx8TDB/9LQK8pGLhayGz
         MI+oB9mbM6Z1u8J/CgVUCbkFYZITrYIp02ScPXu6ODhGnWrU2Bvoe2PLBYF3cSmpAGtW
         VyhB9AQ9/XMqoSOWJE7EE7UwsMJMMove4/nJsYGX1ggeE1GH3DmdONCSPQPq3vvyjROd
         IeLouQUJGprlTt5wjPQvW5+2Vl0LCrxkJUYDaojSQe8qOxOtVktaD6EE5+MJGCCALW+z
         F29RMolcqyNCRhBYFntmHwIXrmGVKzlp0FSq+1UaNJ7JBDAnzNVuvGa2ER5x2spQxl2J
         uBgA==
X-Gm-Message-State: AOAM533T0s7tlQi92Ps4+BXNfcHV1UdjxFbOvsxu1gqcBJcxI0DQWqoj
        Wu6Yb+y3O47kKAtLQwd8VvQvjiaIMV+l+w==
X-Google-Smtp-Source: ABdhPJzQIP9csTmKKFsb6ePjGesI8bwoOQrWY6wayU13iVdMM+qAAdBkIEeF1BoLSTSem7rl0wLj6A==
X-Received: by 2002:adf:8bca:: with SMTP id w10mr40176716wra.43.1634131439112;
        Wed, 13 Oct 2021 06:23:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm13044205wrh.64.2021.10.13.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:23:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] sequencer: add a "goto cleanup" to do_reset()
Date:   Wed, 13 Oct 2021 15:23:54 +0200
Message-Id: <patch-v3-2.3-393937e8a98-20211013T132223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1569.gd2dc77f7abf
In-Reply-To: <cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Restructure code that's mostly added in 9055e401dd6 (sequencer:
introduce new commands to reset the revision, 2018-04-25) to avoid
code duplication, and to make freeing other resources easier in a
subsequent commit.

It's safe to initialize "tree_desc" to be zero'd out in order to
unconditionally free desc.buffer, it won't be initialized on the first
couple of "goto"'s.

There are three earlier "return"'s in this function which should
probably be made to use this new "cleanup" too, per [1] it looks like
they're leaving behind stale locks. But let's not try to fix every
potential bug here now, I'm just trying to narrowly plug a memory
leak.

1. https://lore.kernel.org/git/CABPp-BH=3DP-dXRCphY53-3eZd1TU8h5GY_M12nnbEGm-UYB9Q@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b92dae12166..14c37c4e25b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3644,7 +3644,7 @@ static int do_reset(struct repository *r,
 	struct strbuf ref_name = STRBUF_INIT;
 	struct object_id oid;
 	struct lock_file lock = LOCK_INIT;
-	struct tree_desc desc;
+	struct tree_desc desc = { 0 };
 	struct tree *tree;
 	struct unpack_trees_options unpack_tree_opts;
 	int ret = 0;
@@ -3678,10 +3678,8 @@ static int do_reset(struct repository *r,
 		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 		if (get_oid(ref_name.buf, &oid) &&
 		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
-			error(_("could not read '%s'"), ref_name.buf);
-			rollback_lock_file(&lock);
-			strbuf_release(&ref_name);
-			return -1;
+			ret = error(_("could not read '%s'"), ref_name.buf);
+			goto cleanup;
 		}
 	}
 
@@ -3697,24 +3695,18 @@ static int do_reset(struct repository *r,
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
-		rollback_lock_file(&lock);
-		strbuf_release(&ref_name);
-		return error_resolve_conflict(_(action_name(opts)));
+		ret = error_resolve_conflict(_(action_name(opts)));
+		goto cleanup;
 	}
 
 	if (!fill_tree_descriptor(r, &desc, &oid)) {
-		error(_("failed to find tree of %s"), oid_to_hex(&oid));
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		strbuf_release(&ref_name);
-		return -1;
+		ret = error(_("failed to find tree of %s"), oid_to_hex(&oid));
+		goto cleanup;
 	}
 
 	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		strbuf_release(&ref_name);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	tree = parse_tree_indirect(&oid);
@@ -3722,13 +3714,15 @@ static int do_reset(struct repository *r,
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
 		ret = error(_("could not write index"));
-	free((void *)desc.buffer);
 
 	if (!ret)
 		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
 						len, name), "HEAD", &oid,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
-
+cleanup:
+	free((void *)desc.buffer);
+	if (ret < 0)
+		rollback_lock_file(&lock);
 	strbuf_release(&ref_name);
 	return ret;
 }
-- 
2.33.0.1569.gd2dc77f7abf

