Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F1C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC85A611CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhJUQAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhJUQAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:00:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26BDC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso7481670wmn.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQ2t4T/52zeBY2r2c/9A/g+VIPUK1AUBzCE9i3AKqcc=;
        b=RxZdplMFLF3qJ1oGapAJamYJxlXraEZ9pdob5Iuo/SXGpWyNOG83flA05cAAUXtcWL
         znQV3wbA06kgz3ULaybtwwvCo8wJQjRVJzEbBSwX4jevP1gkqnou8e4m8UJPp5q/lXnE
         /Cm/YhCtuJ5jTqDgHpB7clwgyy+grjqNdQLUvoRaZI9CnUu0FUgV41dBcAJ67BnTVCLt
         koEc4EEoQUmgumiCydPOTTdxnPHkAWsu3PykBMFU3dJUqgoEoEP6jLXYV+kGmGTqdnqB
         5OcGBf389BbZJgnZe0BRfhGOeJSzTHF6tnVjA8Kfw+iwmOe1s04cD9GAqjsmIb0z4yco
         eWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQ2t4T/52zeBY2r2c/9A/g+VIPUK1AUBzCE9i3AKqcc=;
        b=rLPVgFuPHqMbRoZ1F7PFxcVHnYWwz6/Wyr1XcoFGGjjUyVW01qGNBkEi6nrjtCzX1e
         Vf2cQkTsNFOA7CB6wIPHomEOs5i8vK/DNRb09hvjf5+9g3ddaoAmcveOxa4CvgTGPFqM
         bKuDEvzvI2PXFwdrHnbiQ6UedmGpP2AAKLn/ThZWbTueo236UOeOTl0QwG1N8B+n8TYb
         ue6L1CcTXHWqZkS9VKLlzSlEbuLnOimVnkDZ5GUSdGuex9dL+Fq0fQv8l2ftMdDmFVcQ
         3UwFdu4lN0e1caCd1MDF4pwdXSquBr5HLttkcCJ8potWcQqloKZFIBpMgd3GEUmM/sQV
         XCpw==
X-Gm-Message-State: AOAM5325JQ+flZr/u0ha1yl46yI9p3MTxAyqlDNoc5uckRZ2yzHmboXO
        7wcfw7BhrjP1/8PPEB5ppkjB0/1zmVa64A==
X-Google-Smtp-Source: ABdhPJzxPAhGNjddvHnrtezfGTwmIEZYEEGnJTz89VDCeVRhC7r4oArzT49M00as0ZpaBTBT+PvXJg==
X-Received: by 2002:a1c:7fd0:: with SMTP id a199mr22211780wmd.96.1634831862330;
        Thu, 21 Oct 2021 08:57:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7082259wmp.1.2021.10.21.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:57:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] clone: fix a memory leak of the "git_dir" variable
Date:   Thu, 21 Oct 2021 17:57:34 +0200
Message-Id: <patch-3.6-86d928ae2f9-20211021T155529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this point in cmd_clone the "git_dir" is always either an
xstrdup()'d string, or something we got from mkpathdup(). Let's free()
it before we clobber it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 559acf9e036..fb377b27657 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1040,8 +1040,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
 		INIT_DB_QUIET);
 
-	if (real_git_dir)
+	if (real_git_dir) {
+		free((char *)git_dir);
 		git_dir = real_git_dir;
+	}
 
 	/*
 	 * additional config can be injected with -c, make sure it's included
-- 
2.33.1.1494.g88b39a443e1

