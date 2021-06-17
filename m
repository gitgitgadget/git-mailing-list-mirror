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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A37DC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A53613C1
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhFQK74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhFQK7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:59:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F71C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:57:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c84so3121581wme.5
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMCULwZF6CNrBKVIawGJoMUhqkcP1UdIvescnf1bLrw=;
        b=n/n5bCTTl+wVGCvgE2qJNyWnkob9e6Wb4OLqqGpyoix5rWjMj09gW3ErfPIOsose6o
         MshVqN7e+0AFtEkrJdPHrMrvYRL93gcj7AvS6NIUOWxwB+ZnzHlUgg3H9VE2Vfy4mcSb
         /PCCFhdA98q190/wAsUgSRGyfber9ZovSNtInJhYaleQEB7GAUWtnIHmI2d08PrRxRz3
         C4rAbSG785D7jG69Rh2Z7WiwYoaZ4MO6TZ+rodpoBnZ8qxW8N/vqrn850GeP8g2IEkzE
         wnibD3vBaUNZ2ch+882R7BJyNuLaP8T4k/0Qc6SBGqFssV9InfJr8oXXRd1IE2PFPsQN
         atGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMCULwZF6CNrBKVIawGJoMUhqkcP1UdIvescnf1bLrw=;
        b=tnxZ66zCduJoXC/mT4FtK5keT2qlBNDda2Xbp49mHtN1GnSNHTep1VcOXehdd2jUKq
         bGsLfBJ2uvZEOcOQEKRegufDLz9l3ylVlBZVldkkSq7Z/LPw6MnY6IsanZ1a3QVWcVNT
         3S6BThgLaQ2EIeypM57/ncme4K78Ds+VJLS0pg0HVbJZxLWSlbA6NUXmqub90GjUg4zN
         A8TIvZLh+9mdNhziZdSeiM53+rFxRloIbj8k4DVIehg45zjOJl95Gj5CYr2i6FuEvNyg
         9rA734+UG9HPGe0XDyMKKNQSE9AgsVqEdTnwj/gad6BAdI+vmtdev39vFnx5XXX3X+7n
         i9Zw==
X-Gm-Message-State: AOAM530zRZcxNXTSKIavdp3e3dN7jx4JioI300/wwm5W1Q7d8dWabmeE
        ogQSzUSMMr26GugrPGz3uTxg7en5tEzRgg==
X-Google-Smtp-Source: ABdhPJxuJpHPVZC3ZsHMegfIXmEAg0yqIa/sjG73gOmX0vN7vUM3GVHekR2qkwezTncea1IWpQhAuA==
X-Received: by 2002:a1c:984c:: with SMTP id a73mr2660200wme.17.1623927465090;
        Thu, 17 Jun 2021 03:57:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k5sm4897948wmk.11.2021.06.17.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:57:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] upload-pack: run is_repository_shallow() before setup_revisions()
Date:   Thu, 17 Jun 2021 12:57:34 +0200
Message-Id: <patch-1.4-6a8b20a7cf-20210617T105537Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com> <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_repository_shallow() added in b790e0f67cd (upload-pack:
send shallow info over stdin to pack-objects, 2014-03-11) to above
setup_revisions().

Running is_repository_shallow() before setup_revisions() doesn't
matter now, but in subsequent commits we'll make the code that
followed setup_revisions() happen inside a callback in that
function. This isolated change documents that re-arranging this part
of the code is OK in isolation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e..1fbaa34f91 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3757,11 +3757,12 @@ static void get_object_list(int ac, const char **av)
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	setup_revisions(ac, av, &revs, &s_r_opt);
+
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-- 
2.32.0.571.gdba276db2c

