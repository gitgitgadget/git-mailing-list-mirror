Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C4C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A6520724
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Y4EypW78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDWVlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDWVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:41:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF78C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so3641028pfp.7
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzX68apARnZkmRg/kLbBj26JvbipzxwMjdqEGeeuZzY=;
        b=Y4EypW78KmYBOMRISHOO8oBjI2M0TbwwRETTaq7k7atEegN3YOZOmPPZd1BPSj2pHa
         XYBWURgt6bz9fY4htEynWIFkklbN4GIExzZiuH1rrmmOngyaMCcWHUyKwFdX9qkjDBp/
         ZnQc1/MiAK4ENXivo4H98ri9YE1JWVJLfebFeULQ477ZmScT/diWleF7RXjxZbUJ65W3
         6nYqvdRXg4eMFrU6tMbAWtFJpa8NGx8MlGs4SIbH26EgIjmqDo+jnASyltP0oA+Ag/S0
         wR4R6d03fDixu4bjo0Szsz77h6aSoxmxMZMQnok9dLpYce2tkJIGFq5ns6pVsPPgSjMB
         nyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzX68apARnZkmRg/kLbBj26JvbipzxwMjdqEGeeuZzY=;
        b=pCEjzmSLGiuGrZ1NyQpPEm4Zlwfbdx0mp7HY39mENUC2RjaHPXd6jnZnWpUGM0qsRn
         PDWHreyaXgp+xtQh+oz9wGBZ9guJyICswUPtsKRWfSHF25/Beh19p7HCn/IKVbWgb2Ly
         5XShYqVcHWND9zzMi97ZGKZ6+GEIixvyzwlZdc2FUCqMKUEkINcSIIfFHfIhE+7z8q/u
         BdLuDQWkl4BSSfSP+4loqWa9LjEaooGEzQu9fu0nKnuzxda/6hKn8l58206zJETMBDwi
         VBprHYLC/I8YOztR+aPtgHw7gyECQ4vEMyu/1gcoHg6D3PvHgRGZP9pk+2NihluSD1pA
         x1fA==
X-Gm-Message-State: AGi0PuYUZwQhO4l7Ge1mTi1ffT/m54CezP7BILEtd7dshAPL2aA7/6bX
        0i0OdDqPZ6a3KaoCFptpKE5tqilzUi0yEQ==
X-Google-Smtp-Source: APiQypIEI6B9vkJ97mglvd/Q2g7cRdLxw3GrNqDj9uUGvO7/gjEa/UR7XCiz4IheY6sgbdiFZCFe3Q==
X-Received: by 2002:a63:7d4:: with SMTP id 203mr2557121pgh.59.1587678067823;
        Thu, 23 Apr 2020 14:41:07 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y184sm3549954pfg.127.2020.04.23.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:41:07 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:41:06 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH 2/4] t/test-lib.sh: make ULIMIT_FILE_DESCRIPTORS available to
 tests
Message-ID: <b374ff0490a9de2708943f41921e55e6a36d72e1.1587677671.git.me@ttaylorr.com>
References: <cover.1587677671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587677671.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t1400 the prerequisite 'ULIMIT_FILE_DESCRIPTORS' is defined and used
to effectively guard the helper function 'run_with_limited_open_files'
from being used on systems that do not satisfy this prerequisite.

In the subsequent patch, we will introduce another test outside of t1400
that would benefit from using this prerequisite. So, move it to
'test-lib.sh' instead so that it can be used by multiple tests.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t1400-update-ref.sh | 9 ---------
 t/test-lib.sh         | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index a6224ef65f..1e7428a379 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1354,15 +1354,6 @@ test_expect_success 'fails with duplicate ref update via symref' '
 	test_cmp expect actual
 '
 
-run_with_limited_open_files () {
-	(ulimit -n 32 && "$@")
-}
-
-test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
-	test_have_prereq !MINGW,!CYGWIN &&
-	run_with_limited_open_files true
-'
-
 test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
 (
 	for i in $(test_seq 33)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9fe390bd5a..03bf2a4b93 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1618,6 +1618,15 @@ test_lazy_prereq ULIMIT_STACK_SIZE '
 	run_with_limited_stack true
 '
 
+run_with_limited_open_files () {
+	(ulimit -n 32 && "$@")
+}
+
+test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
+	test_have_prereq !MINGW,!CYGWIN &&
+	run_with_limited_open_files true
+'
+
 build_option () {
 	git version --build-options |
 	sed -ne "s/^$1: //p"
-- 
2.26.0.113.ge9739cdccc

