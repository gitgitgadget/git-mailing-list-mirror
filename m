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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC8CC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629826120F
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhGTJtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD565C0613BE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c12so7399008wrt.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryKUMtXcrmxdlURminBMLvgMC9zyz7J8hNISbA3YZJU=;
        b=BVmupZdd8OBwmZy8IN+w3tWbMveARgu+HFmMCU7afFH41TLUdefPedmS551GqWltLJ
         bc1YamJe9fO8t6kvn9JGHqo/S2gkK6/fLr2BdqLK9510t1GnIk8Xfm7LKioWk4kgAqpn
         H6NYclBEQkhdL5qpdFSi/Z7+NTDQK8x81+KPHTk+a/yAXKOdF7WnnwHHIBYYGoUX7TM5
         xYGoZuJ3I4WZbBnU4jt82BhmZDatXYu12KHaUA0J6tymIdOuwsKar6UA3LLA6TgOvYfp
         PdMTA8PSjBlEK7F4RELHrU4GWoX+oiaxw7z6MMkdZ8rkTybbzDHLRKWsICZuPOSKmtcY
         iOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryKUMtXcrmxdlURminBMLvgMC9zyz7J8hNISbA3YZJU=;
        b=Y+s3wPZKLn2NVHyTFpEivSLX2w5ABP+/NnFb+ElfazO3v/f7XpFO63uzEGjkNgEbmX
         K/lcL6Bp1lY/wh5Zzy+vYC590Ldkm7otBNGTIOuHIJVUzh+12jUqdsCqVM2na25SxSb7
         jDAVXGYTa+HTUn7b63PGqOn3YEB0l4PcnKSvK1nJ3bXVbGpx2JYgyDSBIkGBRbk3FZtE
         LxkyHxIMkmF+xhpuUnnUH36XfHOzsPEWOKlkeczwmf+thrOsfXnfV6AEdPteTeyXTFP4
         3UzDs9jmPhW1oYx7V2GatoeoARujZ5/jDOweGHpMj2prM1lHQT+sjBLbsT2TA2b0mfWh
         UDPg==
X-Gm-Message-State: AOAM530t/m1IjxIt04dcNTqw7jbztrPPniy9KLftVJLeDg4YngHTpbi/
        cqyxW5dO9aVDsqqclDxhHsC2kiwejhRUBA==
X-Google-Smtp-Source: ABdhPJwkPIYqDvilXYcwoWLJCDCc3OVYS89Yz8O2W7BySGnvJU2jDPMfAQL7kAv17HfHws79rTHskQ==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr13651504wrw.65.1626776669211;
        Tue, 20 Jul 2021 03:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/12] refs/files: add a comment about refs_reflog_exists() call
Date:   Tue, 20 Jul 2021 12:24:13 +0200
Message-Id: <patch-08.12-8ae8e5ac029-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment about why it is that we need to check for the the
existence of a reflog we're deleting after we've successfully acquired
the lock in files_reflog_expire(). As noted in [1] the lock protocol
for reflogs is somewhat intuitive.

This early exit code the comment applies to dates all the way back to
4264dc15e19 (git reflog expire, 2006-12-19).

1. https://lore.kernel.org/git/54DCDA42.2060800@alum.mit.edu/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ce4b3fb1c7a..92f49cfb7d4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3068,6 +3068,19 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
+
+	/*
+	 * When refs are deleted, their reflog is deleted before the
+	 * ref itself is deleted. This is because there is no separate
+	 * lock for reflog; instead we take a lock on the ref with
+	 * lock_ref_oid_basic().
+	 *
+	 * If a race happens and the reflog doesn't exist after we've
+	 * acquired the lock that's OK. We've got nothing more to do;
+	 * We were asked to delete the reflog, but someone else
+	 * deleted it! The caller doesn't care that we deleted it,
+	 * just that it is deleted. So we can return successfully.
+	 */
 	if (!refs_reflog_exists(ref_store, refname)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.32.0.874.ge7a9d58bfcf

