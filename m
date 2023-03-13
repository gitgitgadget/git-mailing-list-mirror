Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00EEC6FD1C
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 05:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCMFBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 01:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCMFBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 01:01:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA9457F7
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:01:38 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-176b90e14a9so12542059fac.9
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678683698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UItSxR2bT+7IPmVLwgr5Ki2DUIBcnwajgZjOleygU24=;
        b=f6dLYevltjLFK2FWkAU7J9qmkeskYGRR0vysUNvUaM4DA2g/n8W7PN5T7fI2m8vFKe
         TjKT+t8EO05s64VkyvkbCyD/bixJGZ3l7p8qJ39GkMZdoFFfx8UYvgzpKdmD7yc3N3vK
         wFcPB8Ir6cM7tdmjA1stdaN4MsIu0XnSuvkLEXZ+fBU2ro+Sur0eNu+Lj8Ji+4z4K7SM
         LnUBZe6i4MtjPB0Jg8l2pFhZyYovNyPG4kpEpeRwygF9iZleV/maEG+XHEP1DpZc6FjC
         LfZAcxE/FXOJPifErfJWzTEvudIfj6rKdcWoRY1GIYnQPvpdi42Q7sO4LMJ2MnQgCt5+
         qJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678683698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UItSxR2bT+7IPmVLwgr5Ki2DUIBcnwajgZjOleygU24=;
        b=vgUlae0oJh2onKri6X+bOwFmIDGcxIDbYdNLbGNog28vuMSyuGwqUqy2UepQkVwnWz
         SSY0oHKAk0zirlKmxb/ZTgvWZSIM7OzSlwt5XdT0U2g0IRFch1e3mc+dz/Q2O/okK/oA
         Z62l3qv7x99hxzHJLpB0Z2XfpsbPqWqPC5mRY53UoQr3YtymtAuQ37NTMeDPS8BYYBEv
         p+y73mYsLfaPerDXMXvJccm8JguWb0i7IXwiRf4T5h04s07y+iYvaRrn6MBCt7hPb9cA
         FToi+ucwHSf+V/2Q/LlGlDg/i7MKgg/rCfLsqBOS27MNJTdvCxLvpOp6xJHE+1D6060m
         8jsw==
X-Gm-Message-State: AO0yUKXB5Ju4PRfJhxZRU0MMG41Tx8dCC3A3JYWNoF8N9mCRvyFC8UBx
        Q5t3+oeJiWaFMYVSh7PQWZG50iLPKak=
X-Google-Smtp-Source: AK7set9gI+vleNSSQHDCHZnHeCbV5ZPXlRmq2lmn/a1qzEMnbRcluS8RXK7vlteiHT3QWugY6QQMZg==
X-Received: by 2002:a05:6870:5249:b0:176:5815:eb2d with SMTP id o9-20020a056870524900b001765815eb2dmr22002075oai.50.1678683697790;
        Sun, 12 Mar 2023 22:01:37 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r7-20020a056870414700b0017703b8a5f8sm451665oad.49.2023.03.12.22.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 22:01:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/2] test: relocate yes
Date:   Sun, 12 Mar 2023 23:01:32 -0600
Message-Id: <20230313050132.3464802-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230313050132.3464802-1-felipe.contreras@gmail.com>
References: <20230313050132.3464802-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a command meant to be called by the subshells: therefore it
belongs in test-lib-functions.sh.

Cc: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/test-lib-functions.sh | 21 +++++++++++++++++++++
 t/test-lib.sh           | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 49a850989a..da39d98391 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -87,6 +87,27 @@ test_decode_color () {
 	'
 }
 
+# Provide an implementation of the 'yes' utility; the upper bound
+# limit is there to help Windows that cannot stop this loop from
+# wasting cycles when the downstream stops reading, so do not be
+# tempted to turn it into an infinite loop. cf. 6129c930 ("test-lib:
+# limit the output of the yes utility", 2016-02-02)
+yes () {
+	if test $# = 0
+	then
+		y=y
+	else
+		y="$*"
+	fi
+
+	i=0
+	while test $i -lt 99
+	do
+		echo "$y"
+		i=$(($i+1))
+	done
+}
+
 lf_to_nul () {
 	perl -pe 'y/\012/\000/'
 }
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 388075a6c6..24aedc122d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1694,27 +1694,6 @@ OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
 
-# Provide an implementation of the 'yes' utility; the upper bound
-# limit is there to help Windows that cannot stop this loop from
-# wasting cycles when the downstream stops reading, so do not be
-# tempted to turn it into an infinite loop. cf. 6129c930 ("test-lib:
-# limit the output of the yes utility", 2016-02-02)
-yes () {
-	if test $# = 0
-	then
-		y=y
-	else
-		y="$*"
-	fi
-
-	i=0
-	while test $i -lt 99
-	do
-		echo "$y"
-		i=$(($i+1))
-	done
-}
-
 # The GIT_TEST_FAIL_PREREQS code hooks into test_set_prereq(), and
 # thus needs to be set up really early, and set an internal variable
 # for convenience so the hot test_set_prereq() codepath doesn't need
-- 
2.39.2.13.g1fb56cf030

