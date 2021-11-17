Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A82C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8D561BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhKQKXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhKQKX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA4C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1661334wme.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIkoM4mF9N24o4kZ60pVMbwxCYGMKPNaAdM30H2rKFA=;
        b=TzE+9z6crobZTRvWCJsm98x6guYu7uySHM+MnyNO4vllITk/THUgaTdW0o1tgJpIqK
         7UBytsqUBF1XPQoJT6+sXjkTPlRfT8CF41eFmXJiZ3QkO+k8qo5RwOGknpEdiDm/6suD
         KaGKgcTqufCylksd5IAocRO5UGkmxqgcvAIjWmjGfjHHk0OXK9lyuGJslEpaXjJeu3Gd
         AlRL5DkvJuBkySYNBBYqra5K9KDga5sC/T2q9wsXHiyjum1ZtjGL17LjBWcq9rNVvVwW
         jrhcxBD7WXNC8RHOhAOg1ssLAHG92UvqslnTE579Bm0zY+AIHjvUOeEOXvLXPtciWdgI
         BS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIkoM4mF9N24o4kZ60pVMbwxCYGMKPNaAdM30H2rKFA=;
        b=jOGtp8Y9R1agQHSjydD+upQ+9Uq0w2zqp7r/CqVqtdhBF+QTsfFX80i6UQGG2sej/D
         WXAGBgyr9+I747Fg1cErgTXzsRbctQxaUTUWf6XKdt5h9m361st9a7p/WKpp1E4RiNjy
         pOMKtkIOG35MQAE3/i0Spet4et6eO1pJnYwUiBAOEFAIbLorP3dbaR5KV0J5qgh7sN28
         z7De3aetEXrQVWErDI7oVmNHwyPHg2gDtDxa0PEJo1Nc9SGe7o0oqf2GumhW5NVAEzdr
         U1BrslYF8OUR9u87mp71wwgQa4d38Y+2h5+SsVMIUHumxuw6jnIy+WN7WngWcaS0j5JO
         qE1A==
X-Gm-Message-State: AOAM5300E+t1UZbjnPtQxLkDtPWg7PUp4fg1lscXCxx2UPiQOkj6C9wm
        irjE1OsuBFLogW1Khhe35Unch+6IzgtK8w==
X-Google-Smtp-Source: ABdhPJyDZKjsNBuOmxe+vilX+Wy9nU6YL5AeJDeatg3Ec/Vlnoa55I2fKintQEMo2xw1XEUq/kdbXA==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr16879700wmj.30.1637144428612;
        Wed, 17 Nov 2021 02:20:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/23] Makefile: clean perl/build/ even with NO_PERL=Y
Date:   Wed, 17 Nov 2021 11:20:03 +0100
Message-Id: <patch-v4-04.23-daead5ec293-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 499c29394ce (Makefile: allow building without
perl, 2009-04-03) where we'd stop cleaning the perl/* directory
because NO_PERL was defined, thus leaving behind litter if the flag at
"clean" time didn't match that of build time.

In 499c29394ce this was done to avoid relying on the perl/Makefile.PL,
but since my 20d2a30f8ff (Makefile: replace perl/Makefile.PL with
simple make rules, 2017-12-10) we can clean things in that directory
unconditionally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b77702e102..a71fba15e30 100644
--- a/Makefile
+++ b/Makefile
@@ -3234,6 +3234,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
+	$(RM) -r perl/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
@@ -3242,7 +3243,6 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
-- 
2.34.0.796.g2c87ed6146a

