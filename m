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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306CDC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0980C613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhE1JZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhE1JZf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D02C061761
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so4187379wmk.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOniThVSCYtkiM3dR38e2nO2uTv+Yd9uJOvEFMzsuKs=;
        b=PF2UIMve8wFL3JhVYybUVhA+5NvwIfg0MAi43NLEUNftaWTRpQfdFg9UwEN9Epabw/
         4E36dSmiEv691rkrLcJWm/50jeHTe44+Q5hDOxmNrkX4kTnjbW2TR/nTzDUG0b9lCBBI
         fEECKkK5LVrIKAxDflbUIfJ3yrEPelkmimrd+/yWe1wsrNnn6WKwe22TJrVu8z5fcpSz
         w8EcEvCpOexUvFEji4ShqeYAoN8Jxmmzv/Y5EFLQji5Z93fsuMeln0Y1YIof+8K7+YbG
         qe2G0CQCD2u+7Cuzdxd+gT5p2zLq+Xyly/HtXnjw/J9aiYRgM3dlMkKMGThuVmB0MHUX
         /GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOniThVSCYtkiM3dR38e2nO2uTv+Yd9uJOvEFMzsuKs=;
        b=Vo/9cdfX8nw720uqYwea0tStmqx/ZpUURC4ZZGTZmgrZphgBbNFZFT+uZHZNiU4Xpb
         EptB3XqptUI7KBrd1oN6bKYLNs9yCcdxm2T+um9yu28i9ZQVsqIx6ylJaOkj7yt8vOCU
         Ye4VU+LEu+94NW7WX/wRu+voDk0eaHSYVyeDRWRm08JhzsASlKsXAOhU6pkEOorF8HGu
         o8YbWDYqOFbqpvVrvYVsPyXxszHzzzRV2nXrilY84ngF1K11S914RF/hArPHgV60+KUK
         3EzEWRp26X1jfdoYzT3kE8usQg6a5uKlk0mc6zHCLSy2tePI1xBvm2h5BDvqX4XOKIpK
         qWgQ==
X-Gm-Message-State: AOAM533E6Yabaq8TcWMvvamWurAqf1LeXlsl/3iJf10vrvdUQ1d/RuJf
        yzYovjHvWdJRMykLV0Pg7Iw+GlQR/y7wLQ==
X-Google-Smtp-Source: ABdhPJxjoIE6NayX5rxcWo86OQAXfjyIjDA9lXLvicKODmPlm7eX+DHrdRLaXhlihNrzN1PItzUd5A==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr7619242wmp.165.1622193838018;
        Fri, 28 May 2021 02:23:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:57 -0700 (PDT)
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
Subject: [PATCH v5 04/13] send-email: refactor sendemail.smtpencryption config parsing
Date:   Fri, 28 May 2021 11:23:43 +0200
Message-Id: <patch-04.13-961ca4c2b2a-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the removal of the support for sendemail.smtpssl in the preceding
commit the parsing of sendemail.smtpencryption is no longer special,
and can by moved to %config_settings.

This gets us rid of an unconditional call to Git::config(), which as
we'll see in subsequent commits matters for startup performance.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9a1a4898e36..e2fe112aa50 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -287,6 +287,7 @@ sub do_edit {
 );
 
 my %config_settings = (
+    "smtpencryption" => \$smtp_encryption,
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
     "smtpserveroption" => \@smtp_server_options,
@@ -387,14 +388,6 @@ sub read_config {
 			$$target = $v;
 		}
 	}
-
-	if (!defined $smtp_encryption) {
-		my $setting = "$prefix.smtpencryption";
-		my $enc = Git::config(@repo, $setting);
-		return unless defined $enc;
-		return if $configured->{$setting}++;
-		$smtp_encryption = $enc;
-	}
 }
 
 # sendemail.identity yields to --identity. We must parse this
-- 
2.32.0.rc1.458.gd885d4f985c

