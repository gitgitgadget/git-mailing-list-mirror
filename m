Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2CCC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405E360F44
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbhJOMmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbhJOMl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:41:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD3C061769
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so26176718wra.12
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFTIXhP8lDlllIn/XqhNjhOf45mlN70G6cOQFLUsXYg=;
        b=nSgQ2VUB8zWBV67EU728ILcyPmOqm4Vg17bJDwYXB8NYfVUMByRmY4h226qfBcd84H
         kOusfoCkyca/Ibz3gr++aI39zDWvtiI61kUm/nAmwn02sJ8WRwjo19F7jGZcDfAWUFQv
         uM6MNcHPePRjJzRHtaZ2R1SZEWuI1iqL+g/v6rB99emphfgWmBQqScfG8SqKNbKVpbIG
         i4sRQFpbB4SJVXeIyFL5uTdnhPtXwW8Hqn1MlBLaXv3oDMwnw47WOvw4HSjMfZPBe4wW
         M5Wd4YSRhvo3unX1lMtw3J/iCfqFYIdBXBgoIS9V9Az40ZJFT17BZ2dT8nKwuXPahmVA
         BE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFTIXhP8lDlllIn/XqhNjhOf45mlN70G6cOQFLUsXYg=;
        b=SkfD8X/dLPRwTShcU0TubwN2YcEIbS7wWzaf8ZQe1BQoxVvdZ42R2WouNej8Xnefk1
         TAp1hZ5tEuZs8aogHV7AoL4oJ5T2hMxKaNvH7Dfzw/xzT2C26E2/f2pNGliz7AVKNyVB
         meon+rINILamRgllBHo3P1BNw9vlD1jdz6/EcyI17ajyu+Pi+srUKEzo9+dXL/GSRJqp
         SyWGa25aTEq+rCHNPs9j6a6piQ/H16FTNPnFJE+MPjNy5O0jNyqt7Zh2o9u+DuTihXJQ
         uzS5S+CmYYqrZ8yq3etpdoPTpbwfF2GwhHWw0h7sPUDjjrWRgMZ0hKWNgvJObvEFc73W
         w+yw==
X-Gm-Message-State: AOAM532zndSE0wH5i0g4NVJFX2UpL0pFA7hiY80vSo+AqKyK38Q32LLM
        vPdN+y9D/vddS5bUYvmme6UdMzhqKSFnRA==
X-Google-Smtp-Source: ABdhPJxgCRIumMD4v4WxQKwvoKDfkLT1hVKdUINIb8UIUQfVY6mP06AlN43kjWa5xtSYEv2Ny9jX/Q==
X-Received: by 2002:a5d:524c:: with SMTP id k12mr4049545wrc.88.1634301557934;
        Fri, 15 Oct 2021 05:39:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d1sm5388824wrr.72.2021.10.15.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:39:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] doc lint: emit errors on STDERR
Date:   Fri, 15 Oct 2021 14:39:12 +0200
Message-Id: <patch-2.4-3e44cdc86a7-20211015T123619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have all of the scripts invoked by "make check-docs" emit their output
on STDERR. This does not currently matter due to the way we're
invoking them, but will in a subsequent change. It's a good idea to do
this in any case for consistency with other tools we invoke.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/lint-gitlink.perl           | 4 ++--
 Documentation/lint-man-end-blurb.perl     | 2 +-
 Documentation/lint-man-section-order.perl | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index b22a367844a..076701ccfac 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -30,8 +30,8 @@ sub report {
 	my ($pos, $line, $target, $msg) = @_;
 	substr($line, $pos) = "' <-- HERE";
 	$line =~ s/^\s+//;
-	print "$ARGV:$.: error: $target: $msg, shown with 'HERE' below:\n";
-	print "$ARGV:$.:\t'$line\n";
+	print STDERR "$ARGV:$.: error: $target: $msg, shown with 'HERE' below:\n";
+	print STDERR "$ARGV:$.:\t'$line\n";
 	$exit_code = 1;
 }
 
diff --git a/Documentation/lint-man-end-blurb.perl b/Documentation/lint-man-end-blurb.perl
index d69312e5db5..6bdb13ad9fd 100755
--- a/Documentation/lint-man-end-blurb.perl
+++ b/Documentation/lint-man-end-blurb.perl
@@ -6,7 +6,7 @@
 my $exit_code = 0;
 sub report {
 	my ($target, $msg) = @_;
-	print "error: $target: $msg\n";
+	print STDERR "error: $target: $msg\n";
 	$exit_code = 1;
 }
 
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
index b05f9156dd9..425377dfeb7 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -46,7 +46,7 @@
 my $exit_code = 0;
 sub report {
 	my ($msg) = @_;
-	print "$ARGV:$.: $msg\n";
+	print STDERR "$ARGV:$.: $msg\n";
 	$exit_code = 1;
 }
 
-- 
2.33.1.1338.g20da966911a

