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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D66FC47081
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D22C6128E
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhEWI5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhEWI5w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BEC061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so2814944wmq.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byr4yJC9ROPMCKi7PPdnsfcvJT5jvK/p2/l7tGio7C8=;
        b=nUESit1rRvAdGpOtEIIYJy9Jt1hktAyp1LBAFIm1TwpKUi5Is2mFvh8YGiRwxYUf6T
         9iPY9pi40x0cOiOhV4mdQUhQxddJP6xIhfnBtYHKLlNGHczkmbqTajS19EOJSyDa1asI
         MIbon0zLaWh6k7ixRR/vKIT6OJpOHAYJt8QqqVRqp3CEnR+hVbU/UmwP6Jms3s27uxLA
         Eoy0W1xv32goZ3IVRHS9PoHuNPeshXD3uWlfrgV3RtcCz6H96Kdu6n6PnJN2NqpWOVrM
         ziDX/SkZ5HZzTu3NSF8KOxzt+DcFa4+zhU9ph3docoeOYiQyYcpzIcFia+6ymAeujtYD
         IvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byr4yJC9ROPMCKi7PPdnsfcvJT5jvK/p2/l7tGio7C8=;
        b=IeHdRXXOdLPmA0g1Gh5g5QKxE8cm+nkO61ygmbSR9O03SvYUDT7thLz+gpjpqAMPPp
         WsiVh3J0tk00C18UUUzulUXt7fdCKH7lAAMU30MoHQINsR4W5MWxMSFc97na2tcZlLmE
         BiTDyqBi+78eUirxIFWGF4kJEf/ifI4CFKnXvGXoSwmtuKx84LNc6br7jXum781ydJru
         p6BarF4k8EC7dMUpbrCoNNBJpNBjfc4TEoym4AWqumig8sNiJ+fczYV/G3I3TGfZKfNn
         AYk3x8ouPMeT/A/gyFh3jfnLxjZIFvG9uBhweX97Q8tBh+t9Zez3tV5RDHJ1POiwHcsI
         O4tA==
X-Gm-Message-State: AOAM530K1PBhCJJwF37ALH3E4SpMDlG7s4RaRje+saRjLSxEwF9k9cYh
        +jOQI0qXFmwKeCHCnEiZNMffjs6XpnlUtOfc
X-Google-Smtp-Source: ABdhPJxRWEmIE+kcI/87HHX++15jkOo6/TK9rKGP7jjz+X1gVrpYc1lNP8P5K5TA3Ggu4hfNr0aPcg==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr14946298wmd.80.1621760184399;
        Sun, 23 May 2021 01:56:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:24 -0700 (PDT)
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
Subject: [PATCH v3 04/13] send-email: refactor sendemail.smtpencryption config parsing
Date:   Sun, 23 May 2021 10:56:09 +0200
Message-Id: <patch-04.13-bed0f98d68-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
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
index 24d73df5a3..3d8362b5f0 100755
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
2.32.0.rc0.406.g05cb3eebfc

