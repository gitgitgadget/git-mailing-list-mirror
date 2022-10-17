Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0556AC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiJQRtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJQRtb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA1A47C
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so19680727wrt.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6Dl86hj3Vupae3jBYIAt/oYs9QyoZVSqsiEHcykyAc=;
        b=EnBQx2nHvryWL+1I2wzPiSif0Ax4KerwUOGErgRi+AAXXT4fXAf9mwXXv5bAu1BFd1
         H1FB+nCI1E5xhexelN2LfqCpGJUG3Rf9eXkS/mLB8xVe1r+wrsK/RMIR0VDO6UOCnByC
         ZmczaZ3f6pdug5TxWRNaxT1+qnslPGhaK4KsHwJqggopQJBXZ7/aNy7yZQMvNYc4fqVA
         4DVuLooeoun8/8/w8fynnn5nrKM2oPp2AeG5MfSD41PUA5fAZ4oOpRNKqobZEqAVmE+D
         K2C5djFjv+duiQ+GmrP6CYf/W7LwRVkB8h1owTOdUF8fqQFKUObpnGF+7H98/I3A29yy
         tzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6Dl86hj3Vupae3jBYIAt/oYs9QyoZVSqsiEHcykyAc=;
        b=BPu9rb9AShBNxGjIGwj5/vEpQAvk0RZQYUKNGlFX8joEYahxaXHA5OclOCJb9PmnGQ
         FlHMAtCxZn5I4TEalnH7mZwPEkOCjesy/Qyi1s92qh3rgEdAhre6ATqx8i9OUxaLX0on
         aKBrSzYfySZHcD60oPhV2Da8YF4pGfGKbhuLthm1fk0ixVJMbxHnm8XrfBuL4s9FBT3z
         R6TaEeUR4pbeCWMB2z79jAnuUL+/QFoDQot1NM3xPzMDXmSexVJ06ExUSEsEyuROLd+4
         7/nOYHAiqEeI51xzdWyRLGFP2UKAaAwcuY0zGBNqC4fNLbstUWcjAW4VDfygQXATOZAf
         JO5g==
X-Gm-Message-State: ACrzQf33xMs1bgFBIqTwcQGsHA376j1JGdrWDzAg7Nm2O+kdRNHUyBst
        lQXIZaSdnbfvWK4s+GIzHAggGw76UU1i9A==
X-Google-Smtp-Source: AMsMyM5VD7dab6dPeArO28gkG4bDq5pls3pIeygIBDtMj8XvSqNLc/EV6hC0LKIzAjYD+Keybx9gsA==
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id o3-20020a5d6483000000b0022e48048be4mr6666903wri.528.1666028966995;
        Mon, 17 Oct 2022 10:49:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] merge: remove always-the-same "verbose" arguments
Date:   Mon, 17 Oct 2022 19:49:13 +0200
Message-Id: <patch-v2-02.10-8b00172ef83-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the code that builds the arguments for the "read-tree"
invocation in reset_hard() and read_empty() to remove the "verbose"
parameter.

Before 172b6428d06 (do not overwrite untracked during merge from
unborn branch, 2010-11-14) there was a "reset_hard()" function that
would be called in two places, one of those passed a "verbose=1", the
other a "verbose=0".

After 172b6428d06 when read_empty() was split off from reset_hard()
both of these functions only had one caller. The "verbose" in
read_empty() would always be false, and the one in reset_hard() would
always be true.

There was never a good reason for the code to act this way, it
happened because the read_empty() function was a copy/pasted and
adjusted version of reset_hard().

Since we're no longer conditionally adding the "-v" parameter
here (and we'd only add it for "reset_hard()" we'll be able to move to
a simpler and safer run-command API in the subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729d..3bb49d805b4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -345,14 +345,12 @@ static int save_state(struct object_id *stash)
 	return rc;
 }
 
-static void read_empty(const struct object_id *oid, int verbose)
+static void read_empty(const struct object_id *oid)
 {
 	int i = 0;
 	const char *args[7];
 
 	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
 	args[i++] = "-m";
 	args[i++] = "-u";
 	args[i++] = empty_tree_oid_hex();
@@ -363,14 +361,13 @@ static void read_empty(const struct object_id *oid, int verbose)
 		die(_("read-tree failed"));
 }
 
-static void reset_hard(const struct object_id *oid, int verbose)
+static void reset_hard(const struct object_id *oid)
 {
 	int i = 0;
 	const char *args[6];
 
 	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
+	args[i++] = "-v";
 	args[i++] = "--reset";
 	args[i++] = "-u";
 	args[i++] = oid_to_hex(oid);
@@ -385,7 +382,7 @@ static void restore_state(const struct object_id *head,
 {
 	struct strvec args = STRVEC_INIT;
 
-	reset_hard(head, 1);
+	reset_hard(head);
 
 	if (is_null_oid(stash))
 		goto refresh_cache;
@@ -1470,7 +1467,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 					       check_trust_level);
 
 		remote_head_oid = &remoteheads->item->object.oid;
-		read_empty(remote_head_oid, 0);
+		read_empty(remote_head_oid);
 		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 		goto done;
-- 
2.38.0.1091.gf9d18265e59

