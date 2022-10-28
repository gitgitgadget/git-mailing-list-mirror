Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D5ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 21:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJ1VQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJ1VQN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 17:16:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7883622E8CD
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:16:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o7so2492989pjj.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:cc:subject:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZbBuLkGFP70OJH2YLZ3+WGtKCwtjLYi0q9E8sYx1l8=;
        b=W7f89Ui6Jga9/15p6bAOYdYZdaRrfFFp25mNY7ghwDFc3fdyDdAqqFcb9oOuMHQHjg
         wQnjHxD50I1E2d26iF2iJ5MVh0bujKgPP8gwkyOfWUGG17/XYYVNPyVvJZfB1ip8D5sV
         fz2tLYuYJ91345lY5ZDXBaqb74ZTURg2FprcGeiawF07nHAG1uxmJOBmbIsgGXOXC6Jx
         nk60f647cO6ZkkcSNmfPtNkzQCcsNesloyKF6N7FNLkJCT+Nst4qDIPws3DgyeTsyfcJ
         fwL+1j4VwwBRlCJMFynFBfWo5n5xf9anSMaZCY7ENqpuqqU8oa2zT6bJh4n/vdFPWo8c
         nwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:cc:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZbBuLkGFP70OJH2YLZ3+WGtKCwtjLYi0q9E8sYx1l8=;
        b=7GH69o+XAT7ZzL/BQeTeSm//7YncOdCvJi5o86QoEWviOzD+Z8kB9Spbqhxq49sF/g
         b+IguYR3FUNM2OWdIzHFWzCA2K0aKFXLYaFSp2T4nHwRSbntwbukB9F44xd36WMW/kfF
         DXEYNmlYk5LvGLmX8SlKnY9YgskN9tTeHFMIrUwxCgd/xmyjpMiL53mYMGxZ/BrWjNxq
         3YLoXT73eGC0o3Khof7MUkuNjA4oFalQRRoet/eeCgQZ5Rom1dlcA9kzosTyoZIz4hQL
         x8SN3pDqSNb62sVFdHOVp6uiY3XGa02kbV0seKJN6nNbZ1DBwXERQWpF9MtSs3L1/oU+
         Wtvw==
X-Gm-Message-State: ACrzQf1fERbToXRkOWh5Oh85K6JJTgmvaIEQx7p6anOG+2otpkF4NEXE
        tRZbiXT8egO1AFGuFzJS16NCbrozSwo=
X-Google-Smtp-Source: AMsMyM6c4QMFcYRApjXHCQ4pl4rLpnTOHWJSh7Uoh4lcRw3m8qglRpIfiwrtA3G0vPAIY9eAAYCslg==
X-Received: by 2002:a17:90b:390c:b0:211:6e5:6351 with SMTP id ob12-20020a17090b390c00b0021106e56351mr1301891pjb.158.1666991770754;
        Fri, 28 Oct 2022 14:16:10 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b00176ae5c0f38sm3441543plb.178.2022.10.28.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:16:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] adjust_shared_perm(): leave g+s alone when the group does
 not matter
cc:     Julien Moutinho <julm+git@sourcephile.fr>
Date:   Fri, 28 Oct 2022 14:16:09 -0700
Message-ID: <xmqqr0yrhco6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Moutinho reports that in an environment where directory does
not have BSD group semantics and requires g+s (aka FORCE_DIR_SET_GID)
but the system cripples chmod() to forbid g+s, adjust_shared_perm()
fails even when the repository is for private use with perm = 0600.

When we grant extra access based on group membership (i.e. the
directory has either g+r or g+w bit set), which group the directory
and its contents are owned by matters.  But otherwise (e.g. perm is
set to 0600, in Julien's case), flipping g+s bit is not necessary.

Reported-by: Julien Moutinho <julm+git@sourcephile.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index a3cfcd8a6e..492e17ad12 100644
--- a/path.c
+++ b/path.c
@@ -901,7 +901,13 @@ int adjust_shared_perm(const char *path)
 	if (S_ISDIR(old_mode)) {
 		/* Copy read bits to execute bits */
 		new_mode |= (new_mode & 0444) >> 2;
-		new_mode |= FORCE_DIR_SET_GID;
+
+		/*
+		 * g+s matters only if any extra access is granted
+		 * based on group membership.
+		 */
+		if (FORCE_DIR_SET_GID && (new_mode & 060))
+			new_mode |= FORCE_DIR_SET_GID;
 	}
 
 	if (((old_mode ^ new_mode) & ~S_IFMT) &&
-- 
2.38.1-280-g63bba4fdd8

