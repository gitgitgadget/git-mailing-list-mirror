Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50028C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4AC61974
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCVQUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhCVQUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 12:20:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D383C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 09:20:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z1so20104664edb.8
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbLXg8IgY43nbpF2vCd6NyEyScnWa8NPOBn0JGsaHjQ=;
        b=m8yjR/KTBedUS+xF98LdR6hbUehp98koHYRrL+ohuyrSVlModWiaCoM7Exn5vVgbkN
         8vP6mpaU1w2QJSNEGYMp3Hvm7JglA0unPxbtbBdXcW8JpT/tU5KUweM4sUZ3gDQfkBDH
         BKfvizHJjfZ+8Sg6NWYoUTdlKDGS/GGmLQVU3wVUfPwZ2xaJPNwSK2gOAxhEfP1CaTbe
         TIxq8WXllLYslcii79sRsHHts0d6ncocMe6CY9YfMk/kEfAcIf6jTqIPEj9ofVlDxYGX
         Ut4dJb7kTgGrXTm15eJqaR8uAK6ZtQf8aUoKNCtgeG5ZG27KAukl7UE+OT4Qf/5Esp6Q
         64Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbLXg8IgY43nbpF2vCd6NyEyScnWa8NPOBn0JGsaHjQ=;
        b=XTfxktQZiVOfneZRbAukR1roSRGbLBC2Z+jgm20hrEWNpky5b9OpsSEu8YCXOlO4kK
         oxCR1tG4JljyG3z5xaxmH2I+NzSzyPuWz2OehVutBoI0jj3dg90ZAF45m95U9VklKIGt
         Nih/ihkE7CJWAVrYP1B5q2iz9ueXJS5DcmD+3refdOwPSxd9Vd1d2na9YazZlnNeQp4H
         5MXdiciHSnm9jiS0U8fqczn/e7AwzbabEDHkba0EBuYWEA9inZ44u99HHBeyQhc+ZoNT
         qzxHEq11cvCJDPnf9DxZawdToB27S9P4WU0XlbTbSQGgBWg6oRz25i/r+9/6ePCt8sco
         vJXQ==
X-Gm-Message-State: AOAM53191zWVTd5UGrDXECzv6Up84i9X9REL6Of1T+abYxLx+haWPdYC
        bDUft8/GqB6ErkV6jaK/FlmDiXF8DRx+zLdV
X-Google-Smtp-Source: ABdhPJwOikHdADxr8cPvcFtMz1ob8mDIcGhiSI5aHkgTbH/8T4NDyqZUsxbbdMCRsZzdgsD0m9HxDQ==
X-Received: by 2002:aa7:d416:: with SMTP id z22mr318343edq.239.1616430012053;
        Mon, 22 Mar 2021 09:20:12 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id q16sm11921730edv.61.2021.03.22.09.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:20:11 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, Rafael Aquini <aquini@redhat.com>,
        =?UTF-8?q?Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] git-send-email: Respect core.hooksPath setting
Date:   Mon, 22 Mar 2021 17:20:08 +0100
Message-Id: <20210322162008.468779-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get-send-email currently makes the assumption that the
'sendemail-validate' hook exists inside of the repository.

Since the introduction of `core.hooksPath` configuration option in
v2.9, this is no longer true.

Instead of assuming a hardcoded repo relative path, query
git for the actual path of the hooks directory.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---


This patch does not include a test for this bug fix.
This is entirely due to me not being able to think up a way
to test this. So I'm very much open to suggestions.


 git-send-email.perl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1f425c0809..3934dceb70 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1942,8 +1942,9 @@ sub validate_patch {
 	my ($fn, $xfer_encoding) = @_;
 
 	if ($repo) {
-		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
-					    'sendemail-validate');
+		my $hook_path = $repo->command('rev-parse', '--git-path', 'hooks');
+		chomp($hook_path);
+		my $validate_hook = catfile($hook_path, 'sendemail-validate');
 		my $hook_error;
 		if (-x $validate_hook) {
 			my $target = abs_path($fn);
-- 
2.27.0

