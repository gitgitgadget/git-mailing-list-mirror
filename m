Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97479C2D0DB
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6966B20882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWkOdiCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfL0Nrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42730 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfL0Nru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so20281934qkg.9
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6+7kClIqTkX6XCzr5s1xheGNmxoBc7YbAKdesibbR3g=;
        b=QWkOdiCI0ibATItGgWWTMBMHZuxeoJfBWxOrMfBwfLfT715ctdFklFizLBYJw4qX11
         XYZ1DwzoPJjOmHxf5tMHBW7z4KD4TqPrMOsxl6nsd/sIgbK3dZti5xGGx9lioZ3/eSoZ
         aC+fG4Dn5n05UWwFSZGhR/+OTHChXjk6w3yJ7RY30GeXW+Xi8OMTN94W6o+3ToiG4/s2
         iDHf0geDK6mWa2TIURpDPBCRhXZEcQo6fnpAHOsL1+Fg1R8r2R+AmRHE70H4Cu0n8Gtl
         YhmGohb4cT0uOr/sgtaxr0VwqMGjHbsKLwbqfUFe/BJudZKtcthyilmMHpVFxay1MiBT
         huBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+7kClIqTkX6XCzr5s1xheGNmxoBc7YbAKdesibbR3g=;
        b=NgNJ7fu/42f62yq6vAHTp+rnSjAtuy1Fy+8S8WGuwTC0PId3+WchdpxzMTwMUFy22/
         Nh4WmoaVYpX+Yv5JU+KXhycCJLcFbSfgPiR9Y22r6OGagkEDmzWmq8YdAEMm4eHeOvYR
         k8VMOvoIm7RLh/PIqX3uST9yayCT3ON7BAMgYDO99TGA39jaNbxDMWSJQKvaFamyeK4F
         zHBxIcQmGidle6UiI5UfmNsDD5/ic6LjxEpF0KaQVAlZIYrSwMrqLKD4AFv51sPrwjvn
         hI+/18OSAGt1tflKIEuklOTqS8TcfyhHhYfcT52nZ2xQsTjkTxpVKL7HfXkW82U0xlSY
         EVQg==
X-Gm-Message-State: APjAAAUHy0MPIY7I9xpnGKdIMSSrwSPK2tZ5t4tUbVcGrn9e5VDtaI7t
        Noy9O0mp4JDRbA7fB4sLlpEd6heQ
X-Google-Smtp-Source: APXvYqxaF6tJcKwZhfWYm/LfMKiLJNn1HBA8LrV4E/aDaij7/6XmQFzjQ9CHZaLJu//E76s4suRl7g==
X-Received: by 2002:a37:4ac6:: with SMTP id x189mr42342595qka.219.1577454469163;
        Fri, 27 Dec 2019 05:47:49 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:48 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 15/16] t4124: only mark git command with test_must_fail
Date:   Fri, 27 Dec 2019 08:47:24 -0500
Message-Id: <e55a07b6141308062ee0670f5909ee2f78f931eb.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since apply_patch
wraps a sed and git invocation, rewrite it to accept an `!` argument
which would cause only the git command to be prefixed with
`test_must_fail`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ff51e9e789..21a4adc73a 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -35,9 +35,15 @@ prepare_test_file () {
 }
 
 apply_patch () {
+	should_fail= &&
+	if test "x$1" = 'x!'
+	then
+		should_fail=test_must_fail &&
+		shift
+	fi &&
 	>target &&
 	sed -e "s|\([ab]\)/file|\1/target|" <patch |
-	git apply "$@"
+	$should_fail git apply "$@"
 }
 
 test_fix () {
@@ -99,7 +105,7 @@ test_expect_success 'whitespace=warn, default rule' '
 
 test_expect_success 'whitespace=error-all, default rule' '
 
-	test_must_fail apply_patch --whitespace=error-all &&
+	apply_patch ! --whitespace=error-all &&
 	test_must_be_empty target
 
 '
-- 
2.24.1.810.g65a2f617f4

