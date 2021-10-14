Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC43C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B1D61152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJNAI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJNAIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA76C061765
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e12so13821211wra.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oY5wmqqFAoPPkDO+3Qk5K1rXb2KC11EZfFtbk/XIqZw=;
        b=fdM5Ym1OOoxf7flgxJiAtSRn/JABmQi9F5x1Oro4Q2bqJ/+XrzaLej8MYJz3lLDfQB
         qaov2SqBiwg7qZaS8Tj04Q138OoQHwwfnp3N2U65TP7k/iLJcd7rvM+0PbdyIZSdjMEz
         ae8JcdeZlI+/R1hgDutMvNCAhQtu364xtwHIhZCLD++55oVadJONxZkToLEJWXjss5FG
         bChprPJxbKN0pJFKjE/N6X8ytJPhyjS8JrxcMhkCSrCfHYOhfCSP5AHD0f8WR9+H4JQD
         HbwKUz3PdvXu2K6gIIA31OVAqPWTEGZYoND6CI/JrTlBxrU00fxq7iS9yltKGi7IJ7CU
         Pm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oY5wmqqFAoPPkDO+3Qk5K1rXb2KC11EZfFtbk/XIqZw=;
        b=LZc/5u8B1q0ZUgI/aT+6/RP0rssxONAqwjzx0lyhmDYHl4uZua+CWvKnbs1tx3arLQ
         6/XGuMJ16L3Mldm6EVloWu2mdsu2h5xFsSN7ENz51iTE3Pt12ZbOk+nitbCNTio0oPvP
         Vv2StVvqNUvXmREPdwnkpcxQb0/yFn9Q01F2O2QJy4ERC0PC7fhOXIGV+xCwbqtiBCfi
         rlfVXL3FlW5XvmDLzRUTRl1Q4NiivYsMzOY1YCdCWPUDkeZCekkM7mdwHtwzPPiJTu53
         wkJzxsaTDEn9Umj/1jGtyCiVo3ldl4urHAQv4hOjO3Z0/LbiileooG3ga2AGTDZriEWe
         60ng==
X-Gm-Message-State: AOAM531SBZhxABcl9J61jZ7iX50aLD3Ni3N2RwKnHPsmUHh5F6CWVUoN
        y30qRWMEg+lmfSVxuzOgrlZF21nI+spZIw==
X-Google-Smtp-Source: ABdhPJx2EIOYqPB7849daq4uZMkTwDhZoP7d8nHdgoPPXzk4I+rkrFd57zC/KUahwLKsUtWhAxS4zg==
X-Received: by 2002:a05:6000:18cf:: with SMTP id w15mr2644170wrq.314.1634170002245;
        Wed, 13 Oct 2021 17:06:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/20] refs API: make files_copy_or_rename_ref() et al not set errno
Date:   Thu, 14 Oct 2021 02:06:22 +0200
Message-Id: <patch-10.20-8753210f9cc-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

None of the callers of rename_ref() and copy_ref() care about errno,
and as seen in the context here we already emit our own non-errno
using error() in the case where we'd use it.

So let's have it explicitly ignore errno, and do the same in
commit_ref_update(), which is only used within other code in
files_copy_or_rename_ref() itself which doesn't care about errno
either.

It might actually be sensible to have the callers use errno if the
failure was filesystem-specific, and with the upcoming reftable
backend we don't want to rely on that sort of thing, so let's keep
ignoring that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1d27f915638..b3d4544dcf0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1410,9 +1410,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
+	if (!refs_werrres_ref_unsafe(&refs->base, oldrefname,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				&orig_oid, &flag)) {
+				     &orig_oid, &flag, &ignore_errno)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
@@ -1823,10 +1823,12 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 */
 		int head_flag;
 		const char *head_ref;
+		int ignore_errno;
 
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
+		head_ref = refs_werrres_ref_unsafe(&refs->base, "HEAD",
 						   RESOLVE_REF_READING,
-						   NULL, &head_flag);
+						   NULL, &head_flag,
+						   &ignore_errno);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-- 
2.33.1.1346.g48288c3c089

