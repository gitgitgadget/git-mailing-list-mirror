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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDADC47084
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149E26120A
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhEXHyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhEXHyj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB47C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so10457767wmf.1
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9AcjIYqKmFcagt4/PES6mLGK4BT9EqzTlgwGxsC3vs=;
        b=Zt/E7aTZ2DnH9IrWYkfvx0ylEU7Qnhw1Ejexi3yF28hCFsfVPDt70+LcwNiKXeWbrU
         l8+Moe+84JIgDx6a6KEm4bbKmoLQJxKaRotzybIoxQhxD9IYa+Uw6THPXXdSnh91Y4BX
         6pE+PQKHA8VuuvrN/ncO2yKJNIdXtopWaPl7v//fo6e0z/3oTg0jlwgyrti9Yssf9DRe
         ptI0iV9ZJObNZFr5ZiKAiZTMYEdihTu4kRY184LXzAPfM/qeSfIcriQbu7hXmE83wjKg
         pz769k9nm2d3QVbS+DOgRe+VCUxQ8DZwK+j/SmgkKFzBDX7zOqwye43TatZuiqg25Bnt
         jHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9AcjIYqKmFcagt4/PES6mLGK4BT9EqzTlgwGxsC3vs=;
        b=Ues1r+q2YAOZqq15FLJ4+l/5oVWR0AaQDXL+G8uEyACLHOrbM4cKapvdPz4KWl2zJA
         uAK69ARWIf++vVsYTD31AkZY1trwDgF8/2fS4YCHJfYjG0Ql3rf6FgbVEsDqF8D555kt
         JpE5Og2dDbPOTeovq3ZJDO5oPp4wErLB8D6A6zi7vIGcG1avkvXbtdEhYsfpYcBF3/eZ
         hbsWU5gTBmfrWgKiZVUrDrmMt8w+myLAz6MqYJ+XgajK5/16dTEsJPZbowxty5zroUjA
         bieTztu9iaRNbJ99lSelVN4YHpCYwJD5uHf5G370eK/NhaTcAK2Nalj70ppkWHTo8UtT
         GeSQ==
X-Gm-Message-State: AOAM532Emtv4HkqfJpbTMTSvisXXdJNdzVlPKV82JKEb3iLNXigNP3Da
        eEqFXuL+PbvGDCfUnu2WKFgZVoxSIAG9EQkx
X-Google-Smtp-Source: ABdhPJySQZpVraVZ6t73Q/WIQvwp6vhHsL+q8+rsO09qRmjb/nRz928egJeqjSgxIrGR30licRQU2A==
X-Received: by 2002:a1c:f316:: with SMTP id q22mr18373458wmq.152.1621842789118;
        Mon, 24 May 2021 00:53:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:08 -0700 (PDT)
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
Subject: [PATCH v4 04/13] send-email: refactor sendemail.smtpencryption config parsing
Date:   Mon, 24 May 2021 09:52:53 +0200
Message-Id: <patch-04.13-7356a528589-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
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
index 24d73df5a3e..3d8362b5f07 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -277,6 +277,7 @@ sub do_edit {
 );
 
 my %config_settings = (
+    "smtpencryption" => \$smtp_encryption,
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
     "smtpserveroption" => \@smtp_server_options,
@@ -377,14 +378,6 @@ sub read_config {
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
2.32.0.rc1.385.g46e826f1e55

