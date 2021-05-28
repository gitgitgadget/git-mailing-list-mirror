Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3020C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837E5613DD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhE1JZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbhE1JZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47685C061761
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f17so300516wmf.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbRLQzfS7HgmYluama4jW9zElxYkZKF9hzNcmBGBaa8=;
        b=AEVWXrrlDKZo+8E/JR210BararzMO6tN/EAKfywUC21Wm3UVJtWAHpIDhGmvK5Pde1
         OSedh76VOtuXtmBvQWotJPsSle3JCwbp7BLRgqcXHWA6sMeZFTSzYMgnKb0ZJdX+brGR
         MwJh99ATFUJSTgptLmL+NmyZrUodpzvU5yJOL+liEMfJd4CeeOP21e9QljQJu4w87aRD
         pQ4ISfLS1AEcWURZYF3kOCCftVsOxvW7rfpEZ1w7RprZWJgOPFvPRsrnEYXoOx+f+Fy2
         Wuy0QszCQfZ1Oym1YoQaivHrA/Aqz4OmB7HdZ7Nmz332PuNyP3elyHWd/6OHlsc+9Tz5
         /Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbRLQzfS7HgmYluama4jW9zElxYkZKF9hzNcmBGBaa8=;
        b=nKoa/k7mmDe30dzIvIEnKrImWM4YA4FCVUUa3Z7JtNhQcoubMunbB9O9UhssOWLkYa
         a90p54mMjBJayFg0JFEo9wAyb2mMaLn+/y2//aiQzMx3GbAlr2tKWvVSByWVtKId5Mq6
         CBYK7djiav2bOAL0BgSWuwrW78TEA6+OPYBrHraeiKGApJOJAeEmj4p20l+JkXsj72gg
         9fDxZog1jlcu4uoftbxCAneq8f/OLA1gMV+xqQD4BdOehwgRMDWdw/wK5YAhwa6P/1RC
         4PQKLUePpNGVBbuS36BMRdOqzZCpJQZ0otLSEXnaMsBCrvYROE1KYoUalWieYMX9wpbM
         ToCQ==
X-Gm-Message-State: AOAM530Xd+4FsTr6LCoxdFkb1zEp+U4G6hpIz6dPo9micdccIpJ+VoaB
        VCcBEekWYWAo3ZeC+zRUIzmYMI9QASdwVQ==
X-Google-Smtp-Source: ABdhPJzXM2oVEHrc/pnYmLz4LzJPaTRfzKMX+hsJb7Gmkp80tw0d5qL9Tmy4Lz7Q6fJJVWfg1b6KbQ==
X-Received: by 2002:a1c:44f:: with SMTP id 76mr7546475wme.166.1622193841630;
        Fri, 28 May 2021 02:24:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:24:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/13] send-email: use function syntax instead of barewords
Date:   Fri, 28 May 2021 11:23:47 +0200
Message-Id: <patch-08.13-f1a879a8ae9-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change calls like "__ 'foo'" to "__('foo')" so the Perl compiler
doesn't have to guess that "__" is a function. This makes the code
more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 38408ec75a8..44dc3f6eb10 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -706,7 +706,7 @@ sub is_format_patch_arg {
 		if (defined($format_patch)) {
 			return $format_patch;
 		}
-		die sprintf(__ <<EOF, $f, $f);
+		die sprintf(__(<<EOF), $f, $f);
 File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
@@ -792,7 +792,7 @@ sub get_patch_subject {
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
 
-	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
+	print $c <<EOT1, Git::prefix_lines("GIT: ", __(<<EOT2)), <<EOT3;
 From $tpl_sender # This line is ignored.
 EOT1
 Lines beginning in "GIT:" will be removed.
-- 
2.32.0.rc1.458.gd885d4f985c

