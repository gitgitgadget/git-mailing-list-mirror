Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F947C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJLVEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJLVDj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84151A206
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu30so27945479wrb.8
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkROGW5xLXvHujNX5ZUKJWZAD26ecJpu623pIbCn9VU=;
        b=iaqD3qZAjO9+QOB5jLL/jBEuSgwomrJpeX92Dv4onjL4J5URtlE9fGPmvNDxABqqJt
         HOaEAQqgxNnPAuYcWf3dNAnXsjhEJ3aPKD1ORtHyfDxzs9kXfJri//bVZfbXErWWYIEO
         jL2y6Bjq3xPLkvbKiwdpQkPHBQNyVt2G0j2cyDPFrFdRbY0UY/ltunTVGhAI6xmljKsU
         CYZ29mACgwL8aDRHV20D4efMSd8IiiH5SiHvSDHFZIQazTF9iZKiFJ/BLVjtggB/3Tkw
         hJvj58kO99EuyjIDpkn6A9vVjjLYphGHfUEySpVzYlDLeOdXQpmm2lsZeFWb2TRVEmOP
         xNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkROGW5xLXvHujNX5ZUKJWZAD26ecJpu623pIbCn9VU=;
        b=K48xU9XcDDfc7fggjrsM/Zv3llGt7jnvjzPe6qoGMLm26vpA1wAebUK27ajpLosPL7
         5K6XnW1RyK3AlMGLLWutcBcLn1Kcl5tf9+ZGCjqDTK/xETDvKOoxF8fr8Yy0moDk7/gW
         dsJIFhtuC5pNh5Dd+nDT1ciWRShfT4UwPksKv2NMNqmMd/3K205EGogrSJWALQhkaE/n
         ANcJOSG3nJuCdivUO4Cn+3U9ihsAcVZSXCHV1KsKf5J5mhd3X08Fgx9/sWyf5E6a0h6C
         Oe2jSzbwsHvwc3pwUkDtAs5x7IKetAyLRGoLv8brjRc+JJgNbD/9xGukvL6IYe9aqnIc
         UT8w==
X-Gm-Message-State: ACrzQf3LeUx+DCHZWWUtsfeilvXbgypVTq8jcThs/hVIqIxDAPRYVYQG
        in/zqnxhujjocoYISzzaZivZIyoVLYv48g==
X-Google-Smtp-Source: AMsMyM4AHbL92OYRuQCGSXoU9g14ChG2uL1CqOaNiKOFZOjl8eSB1CoJgKbCZVtxlBEKOJn3BVcl7g==
X-Received: by 2002:a05:6000:1a88:b0:231:bc2a:4f1b with SMTP id f8-20020a0560001a8800b00231bc2a4f1bmr5046633wry.291.1665608612186;
        Wed, 12 Oct 2022 14:03:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/15] run-command.c: make "struct parallel_processes" const if possible
Date:   Wed, 12 Oct 2022 23:02:28 +0200
Message-Id: <patch-v3-09.15-99a4f4f6b9c-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "const" to two "struct parallel_processes" parameters where
we're not modifying anything in "pp". For kill_children() we'll call
it from both the signal handler, and from run_processes_parallel()
itself. Adding a "const" there makes it clear that we don't need to
modify any state when killing our children.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 646ea22e399..a72c4295adc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1540,7 +1540,7 @@ static int default_task_finished(int result,
 	return 0;
 }
 
-static void kill_children(struct parallel_processes *pp, int signo)
+static void kill_children(const struct parallel_processes *pp, int signo)
 {
 	for (size_t i = 0; i < pp->max_processes; i++)
 		if (pp->children[i].state == GIT_CP_WORKING)
@@ -1698,7 +1698,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 	}
 }
 
-static void pp_output(struct parallel_processes *pp)
+static void pp_output(const struct parallel_processes *pp)
 {
 	size_t i = pp->output_owner;
 
-- 
2.38.0.971.ge79ff6d20e7

