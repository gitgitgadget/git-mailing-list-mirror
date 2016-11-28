Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E5E1FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbcK1Jhg (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:37:36 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32901 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbcK1Jhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:37:32 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so12686638pgd.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTdrFU8u9o4VXNEtg9bPrmuH7BUl1O4PmT60rFca7S0=;
        b=Wdd6EXwlaP/nZ+mtKqbSRIS9/C062g8ZEczk9VC81vz3Z9dp5Kg7CKoSgsAo9kPyop
         bp2sRIQoRejoVW4md0+/nNUFdJWDW5i+gPrWU22AhafUL2D0nFn43+r0aAkUgHwsloK7
         kRE4iciKBrwlvm2uANQW9eGi/xIZcfIAtMd+ZJvaMaa2OYDJnsGWmB5qxiJewg+BSF/o
         /C2Ix5VRCO1ys736FiQWk8bxfmffe7Q40aFvrhqZOG1ErGVZCdv5pusUppIfl41WBTjO
         DwpswCjpOA/AZL0aKmUFlnUMvCHbEFGO4LPeb3LLn2R0K6QO+DFFk52PXDaUhDVzKyPt
         Vt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTdrFU8u9o4VXNEtg9bPrmuH7BUl1O4PmT60rFca7S0=;
        b=RA5IBbc68ExqYdjMzQoVTYLThxZHcr61oR7EAeKHyZfk14pfSAOp6KDJLfPYVA1knI
         9d/QOCJn+ckqdX/Vc32MRREHUQjqxMbqNF6p97OYkN1LJaDhO3y1Hd5jo75JPxExpllH
         ObGoSvActlcjUqYGXpLj4Xu7bDH9t8+8HVMqJjJPC2a6RVvQ2c3Ve4q3ZihvOQqrDHuB
         z6RsZyGyi0L/ib8MJesLrNkIjlwTYmefWW5I8uZ8rwzIG4CRL0x3rqk7Jxncp4yQElCQ
         LTSXwgQGgNu0mIGp3pples54xPyOLf89PqiOBkCIwJ2Smp/39Tovr3tJ7wKI0Sdno2XF
         CIvQ==
X-Gm-Message-State: AKaTC016MZdKFIu4Zet7wxDL4ee8qrWqzeXgnwkaBHiRivXQHvjw2U9z0gHF0X00K09/sw==
X-Received: by 10.99.168.10 with SMTP id o10mr38291482pgf.105.1480325844623;
        Mon, 28 Nov 2016 01:37:24 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id r1sm85693881pfg.56.2016.11.28.01.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:37:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:37:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/5] worktree.c: zero new 'struct worktree' on allocation
Date:   Mon, 28 Nov 2016 16:36:52 +0700
Message-Id: <20161128093656.15744-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128093656.15744-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
 <20161128093656.15744-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This keeps things a bit simpler when we add more fields, knowing that
default values are always zero.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 worktree.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/worktree.c b/worktree.c
index f7869f8..f7c1b5e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -91,16 +91,11 @@ static struct worktree *get_main_worktree(void)
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
 
-	worktree = xmalloc(sizeof(struct worktree));
+	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-	worktree->id = NULL;
 	worktree->is_bare = is_bare;
-	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
-	worktree->is_current = 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason = NULL;
-	worktree->lock_reason_valid = 0;
 
 done:
 	strbuf_release(&path);
@@ -138,16 +133,11 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
 
-	worktree = xmalloc(sizeof(struct worktree));
+	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
-	worktree->is_bare = 0;
-	worktree->head_ref = NULL;
 	worktree->is_detached = is_detached;
-	worktree->is_current = 0;
 	add_head_info(&head_ref, worktree);
-	worktree->lock_reason = NULL;
-	worktree->lock_reason_valid = 0;
 
 done:
 	strbuf_release(&path);
-- 
2.8.2.524.g6ff3d78

