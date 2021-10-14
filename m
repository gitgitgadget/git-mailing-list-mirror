Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB33EC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9812610E5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJNAtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJNAth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:49:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9BEC061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:47:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so13983071wrv.9
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPjZgzaHthQk42Wvcs+sm3GH3F6OuRygWQl9+LdOwUo=;
        b=E5d7vPDRW0DzRdRGNLos8/HWaDhqrB+lrS8bSODRBtBAtaWwrNwlUh1Ln+S1EFlStR
         75q5zMnPF+Wmkdur4E+I/m6Yv9nHiv4KYS9uoao71MEVcgkme1Q4Mns2WOIeRNfZqU4M
         LD1xvVySTRudlkQgPIHT4qYOLRv/gX9oSCBPA377k9koVB+LUSfkoEYF/hrqnpzaMeyL
         vNWxTy0bDQ4GPwhrw/qQhA0eNr0wg4IJzSUp9EMr2pJ12DicvYywtNZ6NjiCeAxeWe3D
         CfmloHTF0w5i6b5kpa8tQ3fcCNGnoTpD9Llueyiaoiv+rIU++TMx04e5t/CFZhXcfTC9
         iMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPjZgzaHthQk42Wvcs+sm3GH3F6OuRygWQl9+LdOwUo=;
        b=ENCr6jPR3iUoC03WolUgHbjIcIR53lPpO2JM8qfMsJ6Qwt61lVeQTUlDruYFDjhb3A
         ehTNKNVFATbwvCqtcMxNDod7BoX/0APUuqqLqLn+f2BIPFjp1pYtMB8LySJf7EnZ+jq7
         ecRTuIAHxzP5hkKYxZ8/pvYa2irS8QzKSv6/IBff+W5HMuc6ITv62p5/K8XPNX/psYSz
         RKLvhybuSxdw7vO0smKfWZCxxDhYb97I91KRG2qoD31QiEd8aAy7NNfx1tHAZ4exBF9y
         d3+isK6yvCljw3Hg6hKlrq6UFNfO+M9Iqk2sStRX/BW8iCeD76l61ijSacMk9lqr79gr
         ThxQ==
X-Gm-Message-State: AOAM530KvBRmbwhNYmWYy2+XMY2m816h5GtKg2VDdmVQH+gqQRIPq1DA
        5XhUsKju+mH47NIRHnGDKEFeDZOz/2abig==
X-Google-Smtp-Source: ABdhPJwr4MFS9yJ2p3B3IO4SItheu59eAz0IPDcBVhl5REf9oItpJYRbwJWjovshBiZ8xfShmD8f+Q==
X-Received: by 2002:adf:a2d8:: with SMTP id t24mr2790554wra.91.1634172451539;
        Wed, 13 Oct 2021 17:47:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w11sm736126wmc.44.2021.10.13.17.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:47:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] test-lib.sh: de-duplicate error() teardown code
Date:   Thu, 14 Oct 2021 02:47:28 +0200
Message-Id: <patch-1.2-d4c67829076-20211014T004542Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

De-duplicate the "finalize_junit_xml; GIT_EXIT_OK=t; exit 1" code
shared between the "error()" and "--immediate on failure" code paths,
in preparation for adding a third user in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8361b5c1c57..c610f09ddb1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -589,13 +589,17 @@ USER_TERM="$TERM"
 TERM=dumb
 export TERM USER_TERM
 
-error () {
-	say_color error "error: $*"
+_error_exit () {
 	finalize_junit_xml
 	GIT_EXIT_OK=t
 	exit 1
 }
 
+error () {
+	say_color error "error: $*"
+	_error_exit
+}
+
 BUG () {
 	error >&7 "bug in the test script: $*"
 }
@@ -720,7 +724,7 @@ test_failure_ () {
 	say_color error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
-	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
+	test "$immediate" = "" || _error_exit
 }
 
 test_known_broken_ok_ () {
-- 
2.33.1.1346.g48288c3c089

