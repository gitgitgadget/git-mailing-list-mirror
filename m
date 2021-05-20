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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3D1C43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB5361184
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhETIUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhETIUk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF01C061761
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u133so8608183wmg.1
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaBdfw3GdZpYoGXSbn8rz6bzLF2PZkxjP1/zYS8+YnY=;
        b=EaeJD8w1/lq4KGDp+MG3c/L2YA/9yQH5L+YCW1h4x2Jw7k1UT05eGoSMUWmCxVcX7c
         FY2o0zbBIE+/CbSnLt9KXmsl98oJaCtMfiwUXg1ADrakFZdeauEoIEHFT5cT+7QXhgsZ
         q7qdb7gquNPP6bQ1IFgGbZa3v/+QY+k84HtV5BWJjH6XbDELjlg75EDbKc0SCM0sZGQ6
         S8UZeMYw8HGU5a2Ow4OABytzpjzeMke0ZlCfjVzJRbQGzrMkuu6UOA/5HA6MwHHL4BkJ
         HyR+yquD6iMbHrb2teINQFqadvVfBqCXoTCxJe7QEQHJMmnEbK9TfRhkGqcb7jSDhdzI
         /Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaBdfw3GdZpYoGXSbn8rz6bzLF2PZkxjP1/zYS8+YnY=;
        b=aX4GNGbA2Bsm7U7yXnll/2BF4MVJ6gKdtsqm+OzjbhZi+5Sdhf1nUi8eoinLUOtTj8
         T0KfuT62Ha4zJD2UlELtqhPYzFN22iYKMMtD6YeHuGrLWnKMWeTfe6kma92+qWKfkfx7
         TS6tR3LXZTEWTdXP/5DajlieX3QSBwXtZ4aDnxQhP5bDKyMokh7v3l2vXONssvGGwE6Y
         T4QRcN1O21qPlqCSQ6rplugMkzzcz/cT/lgvMV4hWs7jW9df/hOarUfpvH6+ClN8dAXI
         6CxRXZS194ntsFqSsF+7eaaEvG8TpJ1p9GH8TvnEKmuoaLwVybGq4VbwzYl//ucxwoWd
         xrog==
X-Gm-Message-State: AOAM533a0ueor13RJM1M2BJabDaN02pxQFc7s9F7eVk1a1wVSSC/bDgu
        lMa+YTiTicnG5cWzXdNNOObMYM2r4KfYfg==
X-Google-Smtp-Source: ABdhPJz4iu9/jJygDlPI6zi5hnJz9Npp+LO5mTedXYSnrA+EJiNd2aPiBjYXf6gI78iCwwqZm+cVCA==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr2345488wmq.83.1621498757423;
        Thu, 20 May 2021 01:19:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] send-email: use function syntax instead of barewords
Date:   Thu, 20 May 2021 10:19:02 +0200
Message-Id: <patch-05.10-f317cd1c01e-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
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
index 9ff315f775c..da46925aa05 100755
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
2.32.0.rc0.405.g5d387561bb3

