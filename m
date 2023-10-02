Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C67E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjJBClz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjJBCl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:29 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F92CDB
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:41:03 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fb70402a7so456212739f.0
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214463; x=1696819263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lEoBpkJLVvzE2xIITImYwnRjfOno4E1sdAiC3yAWps=;
        b=Xf4JhLAQEDaKLejG95nUHX2Ph6AHleR5XX4UaQfwKnanmaRf7aFro/wItHFGgDsomj
         DCXPHKeWmKwpYE8kkcmKSA6ncCThf7tmMMM9iunOaRCH4SpgTPkjUpjSb8lW/uMAVupK
         Y6wnv3YK8P3v1C7Cf7MIxfnDDPDu14yI+MjmnMMnOJK894HJ+PbG/SEYQ/041lWioOtE
         AU/IpO/9XZCAytYxjDz1Fshb4L6CuQPCViYW6OpWKjH5iq/hEIl02j/lzAKaZOlkwIwm
         lkIEilcocF6DqDCTgypql/O+jSX2XSXVgj7sbLf8yZnIpP7jYeJDHFs4HtoaxQNl7Sbv
         QoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214463; x=1696819263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lEoBpkJLVvzE2xIITImYwnRjfOno4E1sdAiC3yAWps=;
        b=USlTxSpJpD7+nVNCnry9F7pP0YBkoBvpg+dKqInWRpWSzyjdgIiWlQ9LsdB2a9JbT3
         jfkigpsc5wZzx1LRduTnSYc9Vnc9B6aMH1OAKpRHY8/NZW2SXYeyYrCenhiJAUTsKyHH
         0CSqQcXOvpU622SFZRIRYLJ0ZAoocUYQYDnSeorJh5nhfGC7RTI4kfHgf5bgcEUrO0Ja
         qkSxargEETj6Ok3Gbc71obEMEXLiF4sQvi+MFxdqEIdf6RnuCpRH/gjnkCpOsxG0WU2S
         zxJ0WqExB/4gBMN0ZWVUMp1L/2ryvyGeV4sn0XrX0xz6ceBH6gyNCS6fJTHMOx77xlyk
         0H5A==
X-Gm-Message-State: AOJu0Yz+2fFxUHjAfXA+t2Nvc6Zioj3CBAb3lopBj+E9yyxntkZTfyLa
        sGJ+iaywvcUIrlone+A1F4yq+1CvUTqjCw==
X-Google-Smtp-Source: AGHT+IHt1Epru5K4RxLCwCNwGp9vNUKcmVwLshPgecsa7VZveE0BiWUGp8yXKK0uLCONVbnFSGbKKg==
X-Received: by 2002:a6b:5b0d:0:b0:790:c3d0:8f87 with SMTP id v13-20020a6b5b0d000000b00790c3d08f87mr11777546ioh.19.1696214463018;
        Sun, 01 Oct 2023 19:41:03 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:41:02 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 27/30] test-lib: compute the compatibility hash so tests may use it
Date:   Sun,  1 Oct 2023 21:40:31 -0500
Message-Id: <20231002024034.2611-27-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
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

