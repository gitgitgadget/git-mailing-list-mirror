Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049D8C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbiAKQkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 11:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiAKQkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 11:40:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B413C061748
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d19so3559435wrb.0
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfvuXJDeWiMaa4TkVydyxuanCqxO27LyODjAV6LXaM4=;
        b=AEzmwm2FFQqpi1gzuHoNCPDLRNf3jgebsjajB//cJs5iFzrQIHc+chIy+iP7MK34wa
         FdDusVu/Cp9XQDCLk4kBwOsXt8to1PeUJlfjtZiXi1yNNRuaZYqadVSaNFOMqjBnRIzA
         wKb8xHp/o/JViPAuFLqxHRPeYm/RZfa4FcPmmxUwSMcA7D+zYnpKA/lYYwNlxOyU9PS/
         hxpfyrDc97DX+bYT20JtFn0FCYbmSk6bgzdKT2T2oqB9YtoHCqFSkolrS6UE+TWVaIeu
         /GnfqPSdXSkyDtCh7SX36l3wWJm7JXNpC3qwEyoVI1dbbDAZzu3ddrOxanlXsmhuIgIc
         hAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfvuXJDeWiMaa4TkVydyxuanCqxO27LyODjAV6LXaM4=;
        b=xs4ec96/TK2JuvmcdS2okFdn34wChT1GzBi4HAgtoCdqAHr5hNVP8VgtlwDoo+5n6Y
         LWFbDxiGAET6C9yJ3RBwimZSOxylJZvskcWAno6PEl9GTrtjO4KYOSoCEk++nBQtjGLX
         4LXxhl21SJ64yhVjdj9uB3hzFBgee9s0EONC13YvBq8IAy898p1eEbVCTHGPIASZqmp0
         /fJdDvaL88b2Hz58VTZ5i9sqe1hI1skJC098qBoUEMFbkPCrBJ2Q4v8D5+Ua+WTXNpCt
         BBczV6kqffem6v7Ji0MYijv3UvewYT6q1Kx9ZHA6rAdvFIpzRe2Vr7Zdd5/cnPjkjPGr
         /96Q==
X-Gm-Message-State: AOAM533NCcCOeCBUNesJmPCDWfLBfHTBSvwq0mpGmosa/1zhb2dlK45i
        Yyw9uPdeS7yvLE5OvcjNa7hf9yE3RQcPlg==
X-Google-Smtp-Source: ABdhPJz7pa8GKLe3MvYMngnFcWKU98enF6G7+ZZ0mzx4Q8sQ2Pko1GdSwCXcrvZXUn2VQnJRWhNEBQ==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr2946702wrm.476.1641919241731;
        Tue, 11 Jan 2022 08:40:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o38sm2536934wms.11.2022.01.11.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:40:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] reftable: remove unreachable "return" statements
Date:   Tue, 11 Jan 2022 17:40:22 +0100
Message-Id: <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.844.gb5945183dcf
In-Reply-To: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove unreachable return statements added in acb533440fc (reftable:
implement refname validation, 2021-10-07) and f14bd719349 (reftable:
write reftable files, 2021-10-07).

This avoids the following warnings on SunCC 12.5 on
gcc211.fsffrance.org:

    "reftable/refname.c", line 135: warning: statement not reached
    "reftable/refname.c", line 135: warning: statement not reached

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reftable/refname.c | 1 -
 reftable/writer.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/reftable/refname.c b/reftable/refname.c
index 95734969324..136001bc2c7 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -132,7 +132,6 @@ static int validate_refname(const char *name)
 			return REFTABLE_REFNAME_ERROR;
 		name = next + 1;
 	}
-	return 0;
 }
 
 int validate_ref_record_addition(struct reftable_table tab,
diff --git a/reftable/writer.c b/reftable/writer.c
index 35c8649c9b7..70a7bf142a2 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -39,7 +39,6 @@ writer_reftable_block_stats(struct reftable_writer *w, uint8_t typ)
 		return &w->stats.log_stats;
 	}
 	abort();
-	return NULL;
 }
 
 /* write data, queuing the padding for the next write. Returns negative for
-- 
2.35.0.rc0.844.gb5945183dcf

