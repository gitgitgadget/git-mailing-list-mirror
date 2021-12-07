Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC444C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhLGLKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbhLGLKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:10:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF21C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:06:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so28602914wrr.8
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQdn7VhOz6jMLXrCGDRirPwLcnlomNvBVQU64XUlWco=;
        b=h6/qAxL0MjkyNXXJvHOhwCLlO4M8A1AqNBoAVbxBAoXAngqrd3p56ywam2DVI8dEA5
         vvmVMiEepJp/JNEocog1r+KwqYkdtw7VAO4vDwKajwSWU7h1WPvwlCxAu1WCO3pUiH0O
         ox/Clir4pINbttKSCSYpgDcGl2X1n9p7+e24fw/AaDiDAxiv1Zd9Yx58T/a8fcRl+Gl0
         syqCmubmvYr2DsAtbp8Soq3F0bHMuzYVaIUB//3NUTnBAWYJek6sGs9py+5PsRBIRZ3/
         hgWCtqW22V8DJqTxxR+YdGw6D77YK9AuUVneOZzBHgydzDExGyUMkYAfjSJuU+RoOqig
         drsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQdn7VhOz6jMLXrCGDRirPwLcnlomNvBVQU64XUlWco=;
        b=h/tTolAUTRlb9RBnrYA04V7OHhCWC5ZE6F9O1C55AEXNr8qrCt5xIThdkiEdwdCA7e
         BFXnQAaIq3MbKL13/ZzYvGEuePQWOUZTID2SMVCIuSw1EJZavQN3jmcKkyL1Im3KT8U0
         3NiywADB72TxLlwxikSsSEF/D0qO1u/BEgv81Syo1K4RniiEmPK7ZbcaBUnxY0/oCNaR
         vgJNCgKqh2u62SY1WGKFc2kiNegHIE9u3lwecpOs7UQ34VubB/ptAIom2UadkhaX2DF2
         lMbBIOftaVJ8iq56b3y6qZ4lIY+t8F6gwAABp9rJ+QYDCatTpRXwdabJhkm/wN7NsLW3
         dMOQ==
X-Gm-Message-State: AOAM531zeRl7tDkf19wcxvkePqFsIT7JCBaRIvxXRWMAEej8YloQxLLD
        kxK2GW7H6m27gahB211yIcYRCFrJ+GBahg==
X-Google-Smtp-Source: ABdhPJz2TA0I1ogtPBy87eFQovMkmGQQZNgWCy2XTdU2CVomi7pYOdN6t/6MvKOUjAPaNv8vTEcMRQ==
X-Received: by 2002:adf:a181:: with SMTP id u1mr8007334wru.69.1638875189476;
        Tue, 07 Dec 2021 03:06:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm2629587wmq.11.2021.12.07.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:06:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] pathspec: use BUG(...) not die("BUG:%s:%d....", <file>, <line>)
Date:   Tue,  7 Dec 2021 12:05:53 +0100
Message-Id: <patch-v2-3.4-81e354fa3be-20211207T110440Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20211207T110440Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that was added in 8f4f8f4579f (guard against new pathspec
magic in pathspec matching code, 2013-07-14) to use the BUG() macro
instead of emitting a "fatal" message with the "__FILE__"-name and
"__LINE__"-numbers.

The original code predated the existence of the BUG() function, which
was added in d8193743e08 (usage.c: add BUG() function, 2017-05-12).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pathspec.h  | 3 +--
 tree-diff.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/pathspec.h b/pathspec.h
index 2341dc99010..402ebb80808 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -58,8 +58,7 @@ struct pathspec {
 #define GUARD_PATHSPEC(ps, mask) \
 	do { \
 		if ((ps)->magic & ~(mask))	       \
-			die("BUG:%s:%d: unsupported magic %x",	\
-			    __FILE__, __LINE__, (ps)->magic & ~(mask)); \
+			BUG("unsupported magic %x", (ps)->magic & ~(mask)); \
 	} while (0)
 
 /* parse_pathspec flags */
diff --git a/tree-diff.c b/tree-diff.c
index 437c98a70e4..69031d7cbae 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -603,8 +603,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	 * about dry-run mode and returns wildcard info.
 	 */
 	if (opt->pathspec.has_wildcard)
-		die("BUG:%s:%d: wildcards are not supported",
-		    __FILE__, __LINE__);
+		BUG("wildcards are not supported");
 #endif
 
 	/* Remove the file creation entry from the diff queue, and remember it */
-- 
2.34.1.898.g5a552c2e5f0

