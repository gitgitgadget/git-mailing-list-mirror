Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B83A1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404754AbfISVrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51424 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393094AbfISVrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so59308wme.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BD7P4sn+NT52OIe/SHeswONtpvv8STQkxsqVBbNW5o4=;
        b=Us1O4fsYZ9VmPaNAcJXFGO8VK0xX64UAJcM9elJwnakPE71BUvrTotf52OIdFsv0DV
         RFn9odxRFq9Ty/HJLy8L4vmT6Yl+jv/wqSlltZhybeG8UFipkj4R+l8Il/8Re3f0KGI7
         VmW9KLNVGnkKATz9pG90ft3WT8Jq9WW3JL7usd+sH6datdU56CuUUfTmeNTIrmRC5X7e
         JRc939nqD2zNLsznSaOjB21+iuRy0RJ5V2sICfHjzVuWxX8DfS0ZeBxIHGY179P0Q0s5
         PpPRAA4anzMB+2fU8QNrmJUzocU6GAzi27dY7FBosUocJg62jY39VhsGFbrykUR+kKh9
         b3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BD7P4sn+NT52OIe/SHeswONtpvv8STQkxsqVBbNW5o4=;
        b=JWESN3J7L5dBRvUs4pI/DsjIW67nfoMLbyqmrdBCDeHrCHCvvgFPvvXG9seOFO03gy
         LChGHs+i9CeDYdsbZTZOEGm9dzJNlb1VpWZ8Xo1qVCs4pIuh7dXg3Lljk9YArnKWsR+P
         ne5uta6QO0UE5HXtujyZ14wjRJyc+q2BC/TIe2Y9xwJ7wA0U0e3wmlDniHcCi+g+oW6a
         Wh1UYUHECv0UZtHxXE7TmCtyHDeUZUB8fW+HalcLYmHOxphs8rDU0/yGrYg3MUXKSLbP
         ZXfxHhHKJFXc7CKAq//y3wIOwXzWWTMUQgxs7QTPsDJVeeZiAEMR+Q0An7lHsNcK4/ic
         fgVw==
X-Gm-Message-State: APjAAAUzMGW9vcY10xv7uP9Er0iCl/mjN00GNcyVMil7CBQ2Z/BfF0+u
        Nqi4Suj8ryubmZF3bpEMbYM=
X-Google-Smtp-Source: APXvYqwkRUe/l6Pad+uy+lSDx0fDYIc5b6sV6r7hDNbLuao8vFflim4JG4iam6a/loRudV0h+G9ebg==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr44356wmb.90.1568929641447;
        Thu, 19 Sep 2019 14:47:21 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/15] t6120-describe: modernize the 'check_describe' helper
Date:   Thu, 19 Sep 2019 23:46:57 +0200
Message-Id: <20190919214712.7348-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'check_describe' helper function runs 'git describe' outside of
'test_expect_success' blocks, with extra hand-rolled code to record
and examine its exit code.

Update this helper and move the 'git decribe' invocation inside the
'test_expect_success' block.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 0bf7e0c8bc..07e6793e84 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -14,14 +14,12 @@ test_description='test describe'
 check_describe () {
 	expect="$1"
 	shift
-	R=$(git describe "$@" 2>err.actual)
-	S=$?
-	cat err.actual >&3
-	test_expect_success "describe $*" '
-	test $S = 0 &&
+	describe_opts="$@"
+	test_expect_success "describe $describe_opts" '
+	R=$(git describe $describe_opts 2>err.actual) &&
 	case "$R" in
 	$expect)	echo happy ;;
-	*)	echo "Oops - $R is not $expect";
+	*)	echo "Oops - $R is not $expect" &&
 		false ;;
 	esac
 	'
-- 
2.23.0.331.g4e51dcdf11

