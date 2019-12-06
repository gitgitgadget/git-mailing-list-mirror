Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421C5C2BD09
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199C52467A
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNGUjWd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLFTDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:03:42 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:56127 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfLFTDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 14:03:41 -0500
Received: by mail-wm1-f48.google.com with SMTP id q9so8913746wmj.5
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fwPXjASxH3no/NHT+7kGWTTNWoUr4pIhbWUCcAUyvc=;
        b=VNGUjWd7V7AhLo3QbmrbrFrT204AQlgI2Okg/9Vr3jfLZACZu6ewmfs15jfmbdroJZ
         OmN0ZhRVcVDRlS4o5FS+Em07cMTTQXrREQXIWihKXrRdCaeFYWMIwuwi1CFCoQsBoXOt
         QlzRqX+sd+Gi/5edn4hpITWfTjWTVS7pzDJWJ9Cc2JP+CwJ71DbqJVkO2+hD/ZSlfUbw
         rzvPFTipGVXbRANOsn9sOMKroy8P3yXa2Q6St9j8qD+IRmHZJL2xlHjj9vCFCTFjsNps
         rcA8fMhY8zi9hTzJCZqVDxkyup5O4qTxWgvyJNNFSaFf8izV5HzdDNF2kHgW7OWyVAlt
         fbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fwPXjASxH3no/NHT+7kGWTTNWoUr4pIhbWUCcAUyvc=;
        b=gw0SQXTrDNeMvzMKDsAayikJ+Duw01g3PqBUOvdh2tyd4ZsBNCA+uFnHee1oG7vYtG
         wb+ae6lPLJlZsP1VbYnQ0IPkWcj0I2E6vrE84mJRVG7mPGRQKWkkjoBNFIZwPo0Ky3pi
         QgQXlu9EO0z50siXwe93kABvPphUNaYn04sdudPnrKs07/waKMMS64OA2RDfqRIZDTfZ
         lXnmCcaTTztDcCBQnMvKa3c7SdgYvIA4ZuQTuJYC0WYDsqvGWGmMTjrqoNTeeqLbnLqQ
         G6dGsqwdFqR0WMjMsSEseXWa/GL5/vLNu2rcXg3vt3RT8qWvUQjarWhcJYgi52cM7Icf
         hBvw==
X-Gm-Message-State: APjAAAW4Wvk8nU2vJd0aVNAyS0I01Nqs5gbI8drkBnA9Cith3cYBLEH2
        ObxPaKmcmgG79OYAnsJrhCBiE97r
X-Google-Smtp-Source: APXvYqyD5WEXJjaulWFrKaQbxUcKaVfi6WjeCUPmc+PEhfTPq3DOzQCfTxzwuafzpafrZ1lqJvrNoA==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr12091514wmg.79.1575659019750;
        Fri, 06 Dec 2019 11:03:39 -0800 (PST)
Received: from localhost.localdomain (x4d0c7a95.dyn.telefonica.de. [77.12.122.149])
        by smtp.gmail.com with ESMTPSA id d19sm4399100wmd.38.2019.12.06.11.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Dec 2019 11:03:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/2] t9300-fast-import: store the PID in a variable instead of pidfile
Date:   Fri,  6 Dec 2019 20:03:30 +0100
Message-Id: <20191206190331.29443-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191206190331.29443-1-szeder.dev@gmail.com>
References: <20191130104644.17350-1-szeder.dev@gmail.com>
 <20191206190331.29443-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The five tests running 'git fast-import' in the background in
't9300-fast-import.sh' store the PID of that background process in a
pidfile, to be used to check whether that background process survived
each test and then to kill it in test_when_finished commands.  To
achieve this all these five tests run three $(cat <pidfile>) command
substitutions each.

Store the PID of the background 'git fast-import' in a variable to
avoid those extra processes.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9300-fast-import.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e707fb861e..6820ebbb63 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3165,12 +3165,12 @@ background_import_then_checkpoint () {
 	rm V.output
 
 	git fast-import $options <&8 >&9 &
-	echo $! >V.pid
+	fi_pid=$!
 	# We don't mind if fast-import has already died by the time the test
 	# ends.
 	test_when_finished "
 		exec 8>&-; exec 9>&-;
-		kill $(cat V.pid) && wait $(cat V.pid)
+		kill $fi_pid && wait $fi_pid
 		true"
 
 	# Start in the background to ensure we adhere strictly to (blocking)
@@ -3202,7 +3202,7 @@ background_import_then_checkpoint () {
 }
 
 background_import_still_running () {
-	if ! kill -0 "$(cat V.pid)"
+	if ! kill -0 "$fi_pid"
 	then
 		echo >&2 "background fast-import terminated too early"
 		false
-- 
2.24.0.801.g241c134b8d

