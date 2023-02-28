Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A7C7EE30
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjB1Xjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjB1Xj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CB73609B
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id bd34so6869804pfb.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmQIfvR6sGlibKkQsUp0patzTvkeOkSSdQVGwNSYYgw=;
        b=EYhhc6ufcDWUgWdHPypxM6TF30/As5rRT/kT6IJqBTPULYXPwKlbotaSIULX2xVDVf
         9okK1Qu1zabcXmiWkxFd9uek5dXANjtk6r0/ckZiu6rlOLFXfwVdzVKFdLjS3yxMtY2N
         IB8AL8fZ0i9jNcVmFgW3J1imvNZGE+gzq5dW6jLGEa5gaiY0300/EP8JKw2HioYjpU94
         5r8oskMj9/7q5pwaJnXJx8G0Xlb08pidnLXqUFD4aUoCY9VbcnLGV0w/cXN5gEmMsawC
         loXuKX3SN7sXRB9HK02DEjZ6hzCcU4vjnayhgT3YY9wcyWqMzV3n9OfJTfIvKZW+Cur7
         UlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gmQIfvR6sGlibKkQsUp0patzTvkeOkSSdQVGwNSYYgw=;
        b=39VlLCRAITtxkPT1LyIuX/c4/Txw48I0R1p/oQXpbX8JcTo1bPHvPV8XBnRLdVvS0L
         dx0aSozxuO2V0gWMwtaLucWCAQbTQbh/AvM/2CwtjM0p+YRlI/GyioTGGXPHKtOFuDLy
         /gBbCk+ZNmdZWK78fItBSIBeK1zp5vCFw8+vzTN19YcXZkPVPj7KLSH8NvDlYteMmdmW
         NCEhDphoJ3ikLYzmm02mu52sVV4pGStSgBbIdpdb93UIF/OiazvVjzUwHr0Oce3Z/itR
         P60wfv43CL7mlzv+JtQhkts7cCtrWsT0NLzmxDA5QdVR62TSebeYszTRLr6pW+yUwM3+
         aS9g==
X-Gm-Message-State: AO0yUKUL/PlVqcx28ZEG88M9b+nu6uCz33nxLBr/WduIi7aBSnl4fPpo
        yD6W+kL3hR7csqheOw1LLIvkNGWbuBs=
X-Google-Smtp-Source: AK7set+4QrZkJy2hlEzeFW+qE/0YuSTUzeqdhQ3fyqpehRFjzzTSjjpyoQRpeonIvBa4576qnpxUUA==
X-Received: by 2002:aa7:9eda:0:b0:5a8:a263:7f4d with SMTP id r26-20020aa79eda000000b005a8a2637f4dmr3590478pfq.15.1677627559930;
        Tue, 28 Feb 2023 15:39:19 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78e09000000b005a7bd10bb2asm6610996pfr.79.2023.02.28.15.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 07/20] t5551: stop forcing clone to run with v0 protocol
Date:   Tue, 28 Feb 2023 15:39:00 -0800
Message-Id: <20230228233913.684853-7-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In the "clone http repository" test, we check the curl trace to make
sure the expected requests were made. This whole script was marked to
handle only the v0 protocol in d790ee1707 (tests: fix protocol version
for overspecifications, 2019-02-25). That makes sense, since v2 requires
an extra request, so tests as specific as this would fail unless
modified.

Later, in preparation for v2 becoming the default, this was tweaked by
8a1b0978ab (test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate,
2019-12-23). There we run the trace check only if the user has
explicitly asked to test protocol version 0. But it also forced the
clone itself to run with the v0 protocol.

This makes the check for "can we expect a v0 trace" silly; it will
always be v0. But much worse, it means that the clone we are testing is
not like the one that normal users would run. They would use the
defaults, which are now v2.  And since this is supposed to be a basic
check of clone-over-http, we should do the same.

Let's fix this by dropping the extra v0 override. The test still passes
because the trace checking only kicks in if we asked to use v0
explicitly (this is the same as before; even though we were running a v0
clone, unless you specifically set GIT_TEST_PROTOCOL_VERSION=0, the
trace check was always skipped).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 716c9dbb69..4191174584 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -55,7 +55,7 @@ test_expect_success 'clone http repository' '
 	< content-type: application/x-git-upload-pack-result
 	EOF
 
-	GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 LANGUAGE="ko_KR.UTF-8" \
+	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
-- 
2.40.0-rc0-32-ga0f05f6840

