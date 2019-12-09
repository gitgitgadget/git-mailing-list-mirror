Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E2C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663B9207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBuVsG7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfLILxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42634 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfLILxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so15827197wrf.9
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8NNLvrdN7Pb6LZo+9rN6z+GLFhV814LS67TSzQ/mco=;
        b=uBuVsG7O9jVODe6WC9wAyZcSWkuW4EYxeJKduAXuvQg/XqyklFKLwjNdqToF0ODwAp
         2CYyZY8RjpfoacUWQVKw00529ArpCJ79m0joHtliEXmt3Z7uJntImGNnwWgq2Ua6sLpm
         6f/xWwLWVpW3+0vzx7ba+7GjmwNsifvXaB5Zeh16jSj+rjs23AkOutZNqZSUDWWa9fmt
         2tHK6A7dZ6EtjTMOT9GNR6JY1TovpS+yRzRxWIiImcPte2KCKsYkl3/4hsvoNQnfuvy5
         lrNIF+wkRbwQWeRHExoXCXgVPnbkuBrwRohGXMHIDpQsnQtJIkGS1FNlYjrGkEk6bxNF
         8TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8NNLvrdN7Pb6LZo+9rN6z+GLFhV814LS67TSzQ/mco=;
        b=n5jB0PrBfzJZB3Bzo9wAAvcp2DcQSywBc7TBcjYwGL1wZe7/4PgVonrbaCEczn/Hpm
         S3Z2mgbD4HT/HCAe3KShZOmOpkU3X3vKTUEl35GSE6Mn4i9PERSXDEGVL8ohf2fZsGIA
         iddymQhRQr3QPJsE0ZcWMv9UVFZ48852K6kqbVXz0DOb968/HwTxnN/rUCNiqphOhsOT
         /qInP6S9/0VBz9+e1AtgOcuzkOoWn9zKjTngroYyB2ZFYHY1RCarqJi7uj2izL9yOfRn
         zJYIPQZ3STgFRtpU66kT+D+Luf3oKGz467ohbLG2xgsoSDOf9tJKoXwQM0djSHmUadT/
         RcOQ==
X-Gm-Message-State: APjAAAUDfTUhmaKWPHW6wd7zM6MPVMDaiL24Uosq42D0DQ7FmRl27WzN
        5i5f7IeNWOKQJw5dxcm5K+Wky0Nk
X-Google-Smtp-Source: APXvYqzgr19CSHKJkz1vDwNJrOSVN23bkiAAJVT2QF64t3YBI9htspIgaSFd8tQJny6k0VRcAFX/nQ==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr1803902wrw.246.1575892385404;
        Mon, 09 Dec 2019 03:53:05 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:04 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 02/14] t6120-describe: modernize the 'check_describe' helper
Date:   Mon,  9 Dec 2019 12:52:46 +0100
Message-Id: <20191209115258.9281-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
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

Update this helper and move the 'git describe' invocation inside the
'test_expect_success' block.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9b184179d1..a2988fa0c2 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -16,14 +16,12 @@ test_description='test describe'
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
2.24.0.801.g241c134b8d

