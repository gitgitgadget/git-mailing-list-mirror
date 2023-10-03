Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38694E75434
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbjJCI2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbjJCI2B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:28:01 -0400
Received: from mail.smrk.net (mail.smrk.net [IPv6:2001:19f0:6c01:2788:5400:4ff:fe27:adaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF2AF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696321271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+geRCDzVrPyxE8PS1rjWVQ6qwe82aiTMw24SImXsLWA=;
        b=RTPxK1VZwrLyX/mb7SaDx05sDFatD/xE5NtohEtj1NdGeA6O7i2b2GEN1Dymgpi/LNZ4dq
        MszD/Nl8aVKpgchuQZfN7yNYOtV3IN9trICkMdOhVSWOxCMdkiHH2lEznWbGBIm4Ej8JeZ
        iepYP2xmNcq6HiL+VXiLytv0EkZV0aj+k8eSw42E4vzhONHJU+XNwGEAAeN+cTDTc9L4ft
        Q/98GX+DjzOkGOJ5CtGQnzaf0h0tkVU1vs4cd9UHAplv7t6N2x69zhOEwdKp66ouKiAfvh
        eONfJE3fe31LG+B+zD3Q56cZZ5E/EippuWvjG9RsmhI+ayQKUkzT4b3SxaYvzw==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 29dcda1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 10:21:11 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] t/README: fix multi-prerequisite example
Date:   Tue,  3 Oct 2023 10:21:07 +0200
Message-ID: <20231003082107.3002173-5-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003082107.3002173-1-stepnem@smrk.net>
References: <20231003082107.3002173-1-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the broken quoting the test wouldn't even parse correctly, but
there's also the '==' instead of POSIX '=' (of the shells I tested,
busybox ash, bash and ksh (93 and OpenBSD) accept '==', dash and zsh do
not), and 'print 2' from Python 2 days.

(I assume the test failing due to 3 != 4 is intentional or immaterial.)

Fixes: 93a572461386 ("test-lib: Add support for multiple test prerequisites")
Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index a3e87385d065..5b6b8eeb2a5f 100644
--- a/t/README
+++ b/t/README
@@ -886,7 +886,7 @@ see test-lib-functions.sh for the full list and their options.
    rare case where your test depends on more than one:
 
 	test_expect_success PERL,PYTHON 'yo dawg' \
-	    ' test $(perl -E 'print eval "1 +" . qx[python -c "print 2"]') == "4" '
+	    ' test $(perl -E '\''print eval "1 +" . qx[python -c "print(2)"]'\'') = "4" '
 
  - test_expect_failure [<prereq>] <message> <script>
 
-- 
2.42.0

