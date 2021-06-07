Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A84C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E356054E
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFGQqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:46:54 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45899 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhFGQqx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:46:53 -0400
Received: by mail-ed1-f43.google.com with SMTP id r7so6773078edv.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0eXb4vDYbP3Qp5rTY50PbC4F3S/E9aczQKqh5xezeY=;
        b=Iagh9XQLayS4QiF24Gr57UFJ7Zg13EHZf8p+40xVljvqfEHwh08l4V3iu6kQy+mZqy
         3P5KMQSSKMM/yL/m770vjRYCcun3CwfERnBRtfZ1z39x8e84Al6IZMZjhU+BHO6AkakH
         qZwBS46cXudvSFSJwVDOCUb1utydeOyjoyVIgnnNy/Q/vE5LAYBrIqnLXz/xM2ZsC5W2
         XAnRweoQRWzc8c1SmJ//7xfYPw70T4hyTeRzn0w3icusi9ov1TywkLixS8QkTgOVAmt0
         kWRrOmLtno2knZpvz47yqvt73CoVXqc4SZYSQsYAOX/JXZm98ue5DVuxh2JqpcUIJWRJ
         JS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0eXb4vDYbP3Qp5rTY50PbC4F3S/E9aczQKqh5xezeY=;
        b=eICQ2OxGVFuZhOZxkO/bJvI9hzDUMgaaEYkG4i2rJpvErT2K9Dp6kyotGiWEGweVt1
         uYJW5SouGrFgQBsk/qcnXbbRE4VsGMvCZzJLpTzgMALVwdZjMWWtc4Y0XJm1LD/fPkBM
         pUmuRMPY1qLw4dWCLn9GuvHxvD4sZdztw7PA2s7scVIGIBMCQYYierPip3BuAK6rBLpi
         X7whNEq0/o9sJfqs8CNyEirAzPWwStdgbcu6JP5Xf3fLhBIeTSyMuOpqfxVVfpzrg7aL
         7qyLi/fNHsh836hbobLRaNKVSETeV/ysASMVhwABabYG4wxmUQSbB7106BE3odDQXFMo
         /P7A==
X-Gm-Message-State: AOAM531OV6qIWtgSsiH6cvdAsZNTY29KXCrQXhANe1Fh+2lAkz0+Pv+z
        K3EovOakCpuS7z1yJ/Excp9ymav1o/0RXQ==
X-Google-Smtp-Source: ABdhPJyPzbf+Ln6zMVnf3JClaBN2SDIzNo9+uNF/zYxPoKIckGjvWvQyr7Dfbch9Rk9M60DjNKye6Q==
X-Received: by 2002:a50:afe4:: with SMTP id h91mr20819788edd.28.1623084231274;
        Mon, 07 Jun 2021 09:43:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dy19sm7796510edb.68.2021.06.07.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:43:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] xdiff: use BUG(...), not xdl_bug(...)
Date:   Mon,  7 Jun 2021 18:43:49 +0200
Message-Id: <patch-1.1-68bf1ba4d3-20210607T164305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xdl_bug() function was introduced in
e8adf23d1e (xdl_change_compact(): introduce the concept of a change
group, 2016-08-22), let's use our usual BUG() function instead.

We'll now have meaningful line numbers if we encounter bugs in xdiff,
and less code duplication.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xdiffi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 380eb728ed..a4542c05b6 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -796,12 +796,6 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g, long flags)
 	}
 }
 
-static void xdl_bug(const char *msg)
-{
-	fprintf(stderr, "BUG: %s\n", msg);
-	exit(1);
-}
-
 /*
  * Move back and forward change groups for a consistent and pretty diff output.
  * This also helps in finding joinable change groups and reducing the diff
@@ -841,7 +835,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			/* Shift the group backward as much as possible: */
 			while (!group_slide_up(xdf, &g, flags))
 				if (group_previous(xdfo, &go))
-					xdl_bug("group sync broken sliding up");
+					BUG("group sync broken sliding up");
 
 			/*
 			 * This is this highest that this group can be shifted.
@@ -857,7 +851,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				if (group_slide_down(xdf, &g, flags))
 					break;
 				if (group_next(xdfo, &go))
-					xdl_bug("group sync broken sliding down");
+					BUG("group sync broken sliding down");
 
 				if (go.end > go.start)
 					end_matching_other = g.end;
@@ -882,9 +876,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 */
 			while (go.end == go.start) {
 				if (group_slide_up(xdf, &g, flags))
-					xdl_bug("match disappeared");
+					BUG("match disappeared");
 				if (group_previous(xdfo, &go))
-					xdl_bug("group sync broken sliding to match");
+					BUG("group sync broken sliding to match");
 			}
 		} else if (flags & XDF_INDENT_HEURISTIC) {
 			/*
@@ -925,9 +919,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 			while (g.end > best_shift) {
 				if (group_slide_up(xdf, &g, flags))
-					xdl_bug("best shift unreached");
+					BUG("best shift unreached");
 				if (group_previous(xdfo, &go))
-					xdl_bug("group sync broken sliding to blank line");
+					BUG("group sync broken sliding to blank line");
 			}
 		}
 
@@ -936,11 +930,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		if (group_next(xdf, &g))
 			break;
 		if (group_next(xdfo, &go))
-			xdl_bug("group sync broken moving to next group");
+			BUG("group sync broken moving to next group");
 	}
 
 	if (!group_next(xdfo, &go))
-		xdl_bug("group sync broken at end of file");
+		BUG("group sync broken at end of file");
 
 	return 0;
 }
-- 
2.32.0.rc3.434.gd8aed1f08a7

