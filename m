Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D9CE7AB1
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 17:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjIYRvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 13:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIYRvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 13:51:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391911B
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:51:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-277584cc03aso1839115a91.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695664267; x=1696269067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICWRueSFm3yjsl2s8OXdj7AlTKfpnVYdyNn937xNIHc=;
        b=mHb+3gTId2Bc+ubtSHromBDDkuwSqgB0R/hjGHY/8UQW8r8mDPebzBiZb4gDivV9uL
         k4ZYHaYPXB0/yJv2KSD/SD/3fc8/fpw4ViRhWvYGFvsx6OFKSVFZfvTpDKwnKC5diZLP
         5T3wqBzlPbrJNs0xUxG4I4sc6tqJU8KGa2O//owJRc6ed8dO96TaAkfTaYEfgoX9xWtv
         WR+JNKNMxgvnkUF6+Mr/fkdrgNLPO7YZt5fB0bAW2VG5LnYgLlSZQC6G+D6L5U05NL1r
         21OiB0X/7BWjfvqEwblnWqOf7lVKxHPwdyJNgcyeWzUgbHoOvS6kr/Q7wTUANfP25nYK
         TCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664267; x=1696269067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICWRueSFm3yjsl2s8OXdj7AlTKfpnVYdyNn937xNIHc=;
        b=lssfZenlyCYXl7yfrGOfetgB2FSr+aw+KfdkjRkR409W1g79uxZJ9t/ambgmGsBBQ8
         5ztVc0uKKlNekwyBRB7B3ym3+QfqRztTu0RnrMP6af2UMlO2aR3aD/XQg+1add0P7a/J
         zcSvYLJe2awnc3Ndok41RQTtj8CawQKAi7ww44riQimanDy85+0MlABVz/rdJ2PLOzcX
         f4Fg7QDZLdArmHvKj5da5+hMV4UYsu3Vz71fYN2/Vc48M2otsWKvOIJR2RnbDPZpxRBy
         LdqvxfarAWtJixgCxi2K51EFFG4YU5bBEgvu6iRnnuyuHhpTI9/a8L3YXLnf/WUoIeex
         Qx1A==
X-Gm-Message-State: AOJu0YzabzYSKvlzDhyYHESzBJro6I8gEECc/cnjJ2IDVtUxQiKbtbXF
        ZR4HjnOiRBL5g4DNsbcjoS9W4fOPE1c=
X-Google-Smtp-Source: AGHT+IHPlcAdx3N7zAr6LdewtXuk6ZeCG/89efBmbmaM4Op5SbG3Q4R9Pm0/93kqsmNzB743Xb6DKQ==
X-Received: by 2002:a17:90a:5b02:b0:263:41d2:4e2 with SMTP id o2-20020a17090a5b0200b0026341d204e2mr7138099pji.32.1695664267555;
        Mon, 25 Sep 2023 10:51:07 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.157.220])
        by smtp.gmail.com with ESMTPSA id gw7-20020a17090b0a4700b00273f65fa424sm8417874pjb.8.2023.09.25.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:51:07 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v2 2/3] t/t6300: introduce test_bad_atom
Date:   Mon, 25 Sep 2023 23:13:09 +0530
Message-ID: <20230925175050.3498-3-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.273.ge948a9aaf4
In-Reply-To: <20230925175050.3498-1-five231003@gmail.com>
References: <20230920191654.6133-1-five231003@gmail.com>
 <20230925175050.3498-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new function "test_bad_atom", which is similar to
"test_atom()" but should be used to check whether the correct error
message is shown on stderr.

Like "test_atom", the new function takes three arguments. The three
arguments specify the ref, the format and the expected error message
respectively, with an optional fourth argument for tweaking
"test_expect_*" (which is by default "success").

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7ba9949376..e4ec2926d6 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -271,6 +271,30 @@ test_expect_success 'arguments to %(objectname:short=) must be positive integers
 	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
 '
 
+test_bad_atom () {
+	case "$1" in
+	head) ref=refs/heads/main ;;
+	 tag) ref=refs/tags/testtag ;;
+	 sym) ref=refs/heads/sym ;;
+	   *) ref=$1 ;;
+	esac
+	format=$2
+	test_do=test_expect_${4:-success}
+
+	printf '%s\n' "$3" >expect
+	$test_do $PREREQ "err basic atom: $ref $format" '
+		test_must_fail git for-each-ref \
+			--format="%($format)" "$ref" 2>error &&
+		test_cmp expect error
+	'
+}
+
+test_bad_atom head 'authoremail:foo' \
+	'fatal: unrecognized %(authoremail) argument: foo'
+
+test_bad_atom tag 'taggeremail:localpart trim' \
+	'fatal: unrecognized %(taggeremail) argument: localpart trim'
+
 test_date () {
 	f=$1 &&
 	committer_date=$2 &&
-- 
2.42.0.273.ge948a9aaf4

