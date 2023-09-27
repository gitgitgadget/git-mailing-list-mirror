Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C581CE82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjI0T5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjI0T4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477BCE8
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79fca042ec0so242158739f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844570; x=1696449370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lEoBpkJLVvzE2xIITImYwnRjfOno4E1sdAiC3yAWps=;
        b=cE1v/nPY1K8jW13vvqDOoQZoFpLKKmzUsLHD3bTU7a6dL9R2fCwO6FONjQ2hVCUd+1
         Sv/6swfPlnxcYPG2BPAHNXTb+jSjw3hslSycL7yhwFO0AH1XJSgxBJYMurjcDFUSiD2m
         N+QO5bw/A2Qtp8eppkUtttgKDkh7ssM+VWV0fHZ5DOYrxvfF5h1FcLrgxmgjYLisxoFv
         KPmfb56vPEPbTKeu14nmM9ofjxAT3SU7VV9P/rWCPYGEkrLLXVAmL09cILWH2xeJ1Bn3
         qv+Isw/FiX7wr5nHIZR77dGWvM2oMXtwNoqkvFSVIV8Idy/hoNXjxYOFOCaDqTcnVSh2
         d+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844570; x=1696449370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lEoBpkJLVvzE2xIITImYwnRjfOno4E1sdAiC3yAWps=;
        b=XjFLGWJ3td1S+UlZOCLQOF5JkU4palKlBxPiY48T3gvTRgS/TKc3M9sTt1vLP/GJEG
         w84kRVyThCY1V6ooUz+MRPRba/bZksEnOBPuoSW51Y8BDXoLOpcsmCRTL2tzUtVZCpG8
         oIVdNjhthtxBHz9yP4iiaqby/trNL7yB+8EzVECnXOxpd9CIxfOBrJyz3BdABfRIePr8
         Th87JgbHopwXM55eUC4xgSWRa6C6YwYQvhmaKB89c3Eij1kq/U5cyesrYNMPkQ0G6BjS
         1BXN9Y6lzfAS4Im5XppLSH9Uo+T05qRxZHkqejvd4ctWsI6KuMEFC4c6FJWvCrYF23+2
         iu3Q==
X-Gm-Message-State: AOJu0YxTs7YHHqaz/Dnopczq8BFgQKoy9bKoJhy8v82+8htmIs8Gz33P
        95BHhtp9e6DEG4VymV6j+B9Pe8F0/UU=
X-Google-Smtp-Source: AGHT+IEsjdD5PSpTih4Njd5AFGe3RGvqOsgXr7W7u9NlHatb3CfbIhsswlak8o9bYYINYCuvO94m3w==
X-Received: by 2002:a5e:870e:0:b0:792:931e:a93a with SMTP id y14-20020a5e870e000000b00792931ea93amr3239509ioj.4.1695844570558;
        Wed, 27 Sep 2023 12:56:10 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:10 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 27/30] test-lib: Compute the compatibility hash so tests may use it
Date:   Wed, 27 Sep 2023 14:55:34 -0500
Message-Id: <20230927195537.1682-27-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 t/test-lib-functions.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa171..92b462e2e711 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1599,7 +1599,16 @@ test_set_hash () {
 
 # Detect the hash algorithm in use.
 test_detect_hash () {
-	test_hash_algo="${GIT_TEST_DEFAULT_HASH:-sha1}"
+	case "$GIT_TEST_DEFAULT_HASH" in
+	"sha256")
+	    test_hash_algo=sha256
+	    test_compat_hash_algo=sha1
+	    ;;
+	*)
+	    test_hash_algo=sha1
+	    test_compat_hash_algo=sha256
+	    ;;
+	esac
 }
 
 # Load common hash metadata and common placeholder object IDs for use with
@@ -1651,6 +1660,12 @@ test_oid () {
 	local algo="${test_hash_algo}" &&
 
 	case "$1" in
+	--hash=storage)
+		algo="$test_hash_algo" &&
+		shift;;
+	--hash=compat)
+		algo="$test_compat_hash_algo" &&
+		shift;;
 	--hash=*)
 		algo="${1#--hash=}" &&
 		shift;;
-- 
2.41.0

