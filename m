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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8167C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53DE613DE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhELNts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhELNtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D785C061761
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n2so23762155wrm.0
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqkCWWSZf10R+kKta5u8bP+4gaFnpWyVXVqz97/pL9c=;
        b=Vj+OhGO4DcHJRMqFS+jbNRg7wITjXkQpEe/y1s2jLbwDHqGXH8ihiG3/6SDozCeb8x
         ZYBTjZ9yhr3DLUV7USCsPs5bpxrg2GbJwbVoBb3Je+H3NiRdLTcpOjvG5rxA/uK2sJAf
         rt9/tfxXCtxVlNFm8uvqAxk6QAwOWpWF67BBgSv4ozac2GFgDzD/0QvRSJnaabtnUAdr
         SSOSVlwLHYqSVDzi9Ikk7BZgDld1rON00TE8EBOJ1hBiQQIzIcdgfJ7hSeJ6Bz4w/tdz
         CiyU+JQu4Q1Jl6TLFSuh0pLAO0QG9A3qqCUPQPkuyhgDRWq3mcdMPYe9Fe0e3PSQ8v+U
         i89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqkCWWSZf10R+kKta5u8bP+4gaFnpWyVXVqz97/pL9c=;
        b=fSE9M34GSmQuFv0Ynczd7j/dy73Sy+Qw38xB27JOJykEVxGLQ5j6LQa2bKyEcLFqOw
         7plccyYj17tgqynUhV2erWo/YDLHmyT1C/1jT+EaxHEJo2RnmptA05706pq3Kg9MrUor
         9Sh/72pFdxHExhwHjivlP5BnB5MOsxv5uze1D8oXTpMU6/T1lI/tbt7k7+9EX0uormJY
         WchKLj5HReMREU7IdRqmd1vRRXvXFgWbdjeallvo+OQKYedTxv9/ALUw8vk4vzeJS8eK
         V74uvNSn3kozTk4uzmeejh7zh/vItl68EMNBh3+MpcaIFQBcRp/zSC4zAr4lYUtnQ0p3
         0VIw==
X-Gm-Message-State: AOAM530z4tQl7FyFhj5um++IfOuJ2FVgBdtLhdPATG3yaXcapZeYxnA6
        WJIv+gDGg2eIGlh0MtacWVtnadiC0GB7xQ==
X-Google-Smtp-Source: ABdhPJxFm/0DYc6fRLvfSA/kD4tRibwQZJ1jZDFMtaUigPvvJqCLwMu56YTagC1xOxkoSqMT494sDQ==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr1331318wri.244.1620827311551;
        Wed, 12 May 2021 06:48:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/9] send-email: use function syntax instead of barewords
Date:   Wed, 12 May 2021 15:48:21 +0200
Message-Id: <patch-5.9-8846d40fc0-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
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
index 9ff315f775..da46925aa0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -678,7 +678,7 @@ sub is_format_patch_arg {
 		if (defined($format_patch)) {
 			return $format_patch;
 		}
-		die sprintf(__ <<EOF, $f, $f);
+		die sprintf(__(<<EOF), $f, $f);
 File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
@@ -764,7 +764,7 @@ sub get_patch_subject {
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
 
-	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
+	print $c <<EOT1, Git::prefix_lines("GIT: ", __(<<EOT2)), <<EOT3;
 From $tpl_sender # This line is ignored.
 EOT1
 Lines beginning in "GIT:" will be removed.
-- 
2.31.1.909.g789bb6d90e

