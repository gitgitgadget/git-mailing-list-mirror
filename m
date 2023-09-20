Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CCEC04FEF
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 19:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjITTRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjITTRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 15:17:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49231129
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:17:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1ff5b741cso1108845ad.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237442; x=1695842242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHeLP0UMeCcjkmDqQc6oeUTiYBfoEuMgDdgXrw3Y7zk=;
        b=eMYfz4pGImCVQNoftpESsjNPyFvJgEsDX0nB+Buv6YIQKvGdh7rCMbCx2noEcWw4Ew
         Kq1ME3LTkqokzuFsQvdEprqcE9BNHkIF9BHCb+8YhwcV6A1MRkctUPIIliWMqlDqARc0
         lHPosam37rhsK8+qkTQ1qOpzg7n49tVq4HySWgZG0Vc5ydwvBBSwLdtzxymZaaXuy6yS
         EtbYKwI+wBsAJ4jVkHuyZ+88ddgC8fH4e3u+o57AISB3pxNONqpxK2Ot9Bh++A1Nuv/e
         XXcQ70t9ueXau5KzrBnG6wehGJ4rNM2pcbb4KrwN1o25ABpF8PltIvi9TIIfx31feQiX
         58tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237442; x=1695842242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHeLP0UMeCcjkmDqQc6oeUTiYBfoEuMgDdgXrw3Y7zk=;
        b=NKwVeAdl+h/oaynQjS2DW0IPx8t5iB0lMHmdFn9tOxUfYE28DPyG53TGsqwrC+krAJ
         07xAGf9BnSbuaPLFARpHpQUqepgMPA304VQzGXMp+UqdCPwW5ic68WVb7KnfV9hNJop2
         lD5dVCdPDpYBdID/y5QuHYW5gGyrNhUe66cqpbYMPr6AR8SYylxZJhV2CpO/YZsXpXwV
         rNGk+KVYBOEeRqv9LWiQnSuG7MqHO8JE7GToqElRZTKVrGV03/3N5OMSwe2KBYprTIFR
         HJi9VTI4ugwZG7TCmvHMFQ6t+vBzZttuB++lrNCYXNr7rePltJFOv8vXA/fNSsNO7me0
         Il9w==
X-Gm-Message-State: AOJu0YzzLWZ6XZYMzU/w4zVe2j0DIQWcmkwAnQzldDxd7Ql/DoyzTJ83
        tpyiEAflp+cBXG+cZfX2l2DTYVvLmuLnnQ==
X-Google-Smtp-Source: AGHT+IF3EmXQAi6cKYWYXtrPEwAA3obKRCuOIOZPYfOfO2KLCPLLkWs5sLOd7GzRdYn62VXi4/tajg==
X-Received: by 2002:a17:903:189:b0:1b8:6987:de84 with SMTP id z9-20020a170903018900b001b86987de84mr4740274plg.48.1695237442276;
        Wed, 20 Sep 2023 12:17:22 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.110])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001c420afa03bsm11146847pla.109.2023.09.20.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:17:21 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH 1/2] t/t6300: introduce test_bad_atom()
Date:   Thu, 21 Sep 2023 00:35:41 +0530
Message-ID: <20230920191654.6133-2-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.160.g6905eb16ce.dirty
In-Reply-To: <20230920191654.6133-1-five231003@gmail.com>
References: <20230920191654.6133-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new function "test_bad_atom()", which is similar to
"test_atom()" but should be used to check whether the correct error
message is shown on stderr.

Like "test_atom()", the new function takes three arguments. The three
arguments specify the ref, the format and the expected error message
respectively, with an optional fourth argument for tweaking
"test_expect_*" (which is by default "success").

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/t6300-for-each-ref.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7b943fd34c..15b4622f57 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -267,6 +267,26 @@ test_expect_success 'arguments to %(objectname:short=) must be positive integers
 	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
 '
 
+test_bad_atom() {
+	case "$1" in
+	head) ref=refs/heads/main ;;
+	 tag) ref=refs/tags/testtag ;;
+	 sym) ref=refs/heads/sym ;;
+	   *) ref=$1 ;;
+	esac
+	printf '%s\n' "$3">expect
+	test_expect_${4:-success} $PREREQ "err basic atom: $1 $2" "
+		test_must_fail git for-each-ref --format='%($2)' $ref 2>actual &&
+		test_cmp expect actual
+	"
+}
+
+test_bad_atom head 'authoremail:foo' \
+	'fatal: unrecognized %(authoremail) argument: foo'
+
+test_bad_atom tag 'taggeremail:localpart trim' \
+	'fatal: unrecognized %(taggeremail) argument:  trim'
+
 test_date () {
 	f=$1 &&
 	committer_date=$2 &&
-- 
2.42.0.160.g6905eb16ce.dirty

