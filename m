Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E4C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhKWMLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbhKWMLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:11:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD2C061714
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:07:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l16so615991wrp.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRF/7Eh0SHw8SQQbZK2gL5AnCoFCJ7XHT770r09PPMk=;
        b=Q8Kdkp8FC68drERy4YH5mL3KqyGGJrQXCw2D0Hbofc/REQcuW+seVhA3duyIaNVFCV
         wDFvtvlnEt3Vfgzsi1LzNAVae4jbF0W8shS8wl0dep68K+KJw3X1cDrDlbUgjUEQhWgx
         PvGzGqVrOnl4Ob/OpF3Yucp9b85JmoALbdeAH7sX34dcR1QD4No19HOf58bbF9G+mKax
         EKq2pNsTqfbyqGwWcMnye32zRBzNiopJnhe1ccHuIE8xL0mg1Bu6K+MURVhpA03IKv8Y
         q3iOqwBVVOushgYHJlS4dIe09buy4aPvVqntLu0F+U5UpaBFYgOQIRObZO4zH6a/dipP
         6PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRF/7Eh0SHw8SQQbZK2gL5AnCoFCJ7XHT770r09PPMk=;
        b=pfEgQwsn02ddvFM+ZvXOl4YpH4FdU1B8PBmVoJEuOTLTpubJvNTcpxMeUhzSGFZ6DG
         6C7ofyTi8TTMaf2LLO86fh24DcZrGPCMW7loamYUNeW2Xqrn6cM5DpV1O+HY5nJGtrgI
         yquBpb3ckS88EWTaZiwIP0TQMz+bNDjNPhg9BSmpyOcY4IRQA4hJJsZZ/M0joKsRiHt3
         hUChAQMOxdi9Pt3DRooqI3JhjFLevf5zs/rAU5vbGOu2SD5sU48bbl51aJ3C5FlgStCe
         900Hgurdc1WdgR7gRDDGKyz8mg2CC/7rA1/uFWsGasIUJ4NHoGOdQr0VjNVnD7gn+fVg
         vfnw==
X-Gm-Message-State: AOAM53049bx8CvU8tKbocinwaisM7b1DmJ1F5EOWrzwkfzAOqBxvrzuq
        Fmko57WnVfR1qQ4dvh0VyDpvVshUT+bGrg==
X-Google-Smtp-Source: ABdhPJylw+3L+fYy+UkjbjZtDKDUsaiSG5oQ1tWEaV9PURupVCWSqPL5SOVySE0RW1Y01wA2iSKpdw==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr6657842wri.343.1637669277456;
        Tue, 23 Nov 2021 04:07:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m9sm1220299wmq.1.2021.11.23.04.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:07:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] worktree: remove redundant NULL-ing of "cp.argv
Date:   Tue, 23 Nov 2021 13:06:28 +0100
Message-Id: <patch-v2-1.9-9cc220ce5a3-20211123T115551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The clearing of "argv" was added in 7f44e3d1de0 (worktree: make setup
of new HEAD distinct from worktree population, 2015-07-17) when the
"cp" variable wasn't initialized. It hasn't been needed since
542aa25d974 (use CHILD_PROCESS_INIT to initialize automatic variables,
2016-08-05).

Let's remove it to make a later change that gets rid of the "argv"
member from "struct child_process" smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1a..7264a5b5de0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -355,7 +355,6 @@ static int add_worktree(const char *path, const char *refname,
 		goto done;
 
 	if (opts->checkout) {
-		cp.argv = NULL;
 		strvec_clear(&cp.args);
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
@@ -390,7 +389,6 @@ static int add_worktree(const char *path, const char *refname,
 			cp.stdout_to_stderr = 1;
 			cp.dir = path;
 			cp.env = env;
-			cp.argv = NULL;
 			cp.trace2_hook_name = "post-checkout";
 			strvec_pushl(&cp.args, absolute_path(hook),
 				     oid_to_hex(null_oid()),
-- 
2.34.0.831.gd33babec0d1

