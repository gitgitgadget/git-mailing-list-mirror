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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00A6C4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2075650F8
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhCPP7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbhCPP6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB0C061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o16so7701409wrn.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTKwzfpHpixOsZTgzJPo8ijwcC75UiHFYOs24mncvbc=;
        b=gIHV7/0ZfrhEivPfZRJ/ZTHT3TcYYD2nvHOfcIPDylFdU8IFjpbU5w5lwiLbKWXla8
         6ITn9TexpGJNblU/5lmkilb6fxJdTOB/15mD1ll46675j6SimKmDAAHNcrJffXjn3emG
         LZ7ZW6ijUdNmowYp1dA7G4U4iHMvSJxDVO04pPkHWguhFUZVhvtPYxAVRsG9owmZstEG
         h3AtTepzN/58a6VcaSXyWvTve51JsvENEmPh8dbLOdR3x7i/Kyx4cYhUJp14tye4qFd/
         h9I+i8LAU5VyUPF25zObh3Wn2mjcuesOG/Xmz+uGzNir1BDG1uWAZnWkGL+fyvoNZbmZ
         /omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTKwzfpHpixOsZTgzJPo8ijwcC75UiHFYOs24mncvbc=;
        b=ZuHHO4Eu1TDE/zxh1WSkCb+vqs4kzhTcU+/UHuT4X9ybzDPXG5bySBMJdXJ3GtNcll
         doPjnNZrWknSmymeQaRwxd7XKYGYyPJWjgvtOc7m00B3rN5uWyKixbO06UrpulPaGIks
         KxeaLaDF9ntegiGcXHTkPgKdCM5Q+B4kqRetDMupiK7SngYh+mNw9qHINpKKeRLDS3B6
         ZRtVKPl2TY55t0Qo/iypwwDU4hJl+sBQKdVCpImrxoB6Vz3HoDBomDuWLTQB0a9DOYNY
         u1+2gos8n5zBRJYZLoSDR1EnfgACUQxtDNTDaelCcIsSDmdehE2esdeKz3MagRk9BaY2
         rgnw==
X-Gm-Message-State: AOAM531/fs1TLKfoJbr1qenitSPu6I5UHIRy8mAptbAKwuFnRuMYa4Zd
        q70G6uCC8YobcOt2EYsbbZJHsYiB4yOnWQ==
X-Google-Smtp-Source: ABdhPJzLR0xa1T8J4+obworE2QBYYd9dZFXej6ElgSb08wiNzvmFDDDz3mWIu1oEBl8/BB3If0OGQg==
X-Received: by 2002:a5d:4884:: with SMTP id g4mr5602315wrq.191.1615910320097;
        Tue, 16 Mar 2021 08:58:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/32] cache.h: add a comment to object_type()
Date:   Tue, 16 Mar 2021 16:58:00 +0100
Message-Id: <20210316155829.31242-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment to the object_type() function to explain what it
returns, and what the "mode" is in the "else" case.

The object_type() function dates back to 4d1012c3709 (Fix rev-list
when showing objects involving submodules, 2007-11-11). It's not
immediately obvious to someone looking at its history and how it's
come to be used.

Despite what Linus noted in 4d1012c3709 (Fix rev-list when showing
objects involving submodules, 2007-11-11) about wanting to move away
from users of object_type() relying on S_ISLNK(mode) being true here
we do currently rely on that. If this is changed to a condition to
only return OBJ_BLOB on S_ISREG(mode) then t4008, t4023 and t7415 will
have failing tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index c2f8a8eadf..ae0c0bef5c 100644
--- a/cache.h
+++ b/cache.h
@@ -451,11 +451,16 @@ enum object_type {
 	OBJ_MAX
 };
 
+/*
+ * object_type() returns an object of a type that'll appear in a tree,
+ * so no OBJ_TAG is possible. This is mostly (and dates back to)
+ * consumers of the tree-walk.h API's "mode" field.
+ */
 static inline enum object_type object_type(unsigned int mode)
 {
 	return S_ISDIR(mode) ? OBJ_TREE :
 		S_ISGITLINK(mode) ? OBJ_COMMIT :
-		OBJ_BLOB;
+		OBJ_BLOB; /* S_ISREG(mode) || S_ISLNK(mode) */
 }
 
 /* Double-check local_repo_env below if you add to this list. */
-- 
2.31.0.256.gf0ddda3145

