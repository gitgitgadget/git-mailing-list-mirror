Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5EC19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 04:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiHGEN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 00:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiHGEN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 00:13:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D52BB482
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 21:13:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f65so5878355pgc.12
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 21:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1glDHHPs34NyLI2qDVY1GS9geIHtpVd4Lz4mGVfXKm0=;
        b=ecKlQmLnjENqQvWK5qe8g8ifwUT2lFKJ7j155JWTO9ULE8Mmq+z79jdS8gTDo5/Sc8
         2D8/7PEQxph+KDGDNu/1C2jCl+7up22fjTonOPLYNwHaUhHMRlzyL8g61VA8MnbGpgTZ
         4CeK+ZlOU40WLovxEaSpiQ3uFUB927S9bqROBsUnhDS+jmblEvD4dBqs0KkpDyez4jwq
         JA+GH1ApeUip/O49I6Ri1wfbAWJjkpi3ODHnCsGtpM1rPVq8rkdtobJJreY2NL4LCgRN
         7kCkP4DMhTZRpjxOQoXpwv2YglNl8R5Q3EINbRyAgEutprDDNNrydQlEwlZkUHXYwE0z
         NWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1glDHHPs34NyLI2qDVY1GS9geIHtpVd4Lz4mGVfXKm0=;
        b=QFSNS+qfHaP+O/s6HDMftrGyj6JVbIBBerdDL8ca87X2JzvfcdqThNAkzt5/rKDVMv
         KBxsT8Go1NBe9MaArih7Waj2ppZM8WtstvvsKbuzslZ/7ESBI3clqoimn2ls0gbmxASK
         zbEDf3YrUjVq3/Onytliglj7H7/MAk1BY7yccfq6vk7BJsw8DMDviHpMdd9GOTmvqLCv
         OoGpnqQjeY/dHLnDIaQVcrGpTx7gDgIr2MMXO3BW9fP0mtiIrfkd4swZYILZyXvWsgDr
         Wlx6XpTHnJQA9BrrqlyLsDv2L2M+Uns8p/NkaXDEYKsW88xKucGpK53SKxBVjmg9VN2G
         5uNA==
X-Gm-Message-State: ACgBeo1dQArIDawwXaOFlxWst2ER81SeqzypVD8fPOo/RLpxe1TL4+9j
        R5FwnzOdRlxewgPN9LArNbu4eUXVNJZ2Mw==
X-Google-Smtp-Source: AA6agR6JA0xytcJlO8DRIQ5mswAjQj0yxE9Cd4bw53PQlMQASGeWxq6h8i9YEuKWhMlhJw8dzN2KCQ==
X-Received: by 2002:a65:4388:0:b0:41b:c071:d21f with SMTP id m8-20020a654388000000b0041bc071d21fmr10937161pgp.335.1659845635718;
        Sat, 06 Aug 2022 21:13:55 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.209.111])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090a0e1600b001f333fab3d6sm8057027pje.18.2022.08.06.21.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:13:55 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 1/4] t1092: add tests for `git-rm`
Date:   Sun,  7 Aug 2022 12:13:32 +0800
Message-Id: <20220807041335.1790658-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for `git-rm`, make sure it behaves as expected when
<pathspec> is both inside or outside of sparse-checkout definition.

Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 763c6cc684..c9300b77dd 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1853,4 +1853,61 @@ test_expect_success 'mv directory from out-of-cone to in-cone' '
 	grep -e "H deep/0/1" actual
 '
 
+test_expect_success 'rm pathspec inside sparse definition' '
+	init_repos &&
+
+	test_all_match git rm deep/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# test wildcard
+	run_on_all git reset --hard &&
+	test_all_match git rm deep/* &&
+	test_all_match git status --porcelain=v2 &&
+
+	# test recursive rm
+	run_on_all git reset --hard &&
+	test_all_match git rm -r deep &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_failure 'rm pathspec outside sparse definition' '
+	init_repos &&
+
+	for file in folder1/a folder1/0/1
+	do
+		test_sparse_match test_must_fail git rm $file &&
+		test_sparse_match test_must_fail git rm --cached $file &&
+		test_sparse_match git rm --sparse $file &&
+		test_sparse_match git status --porcelain=v2
+	done &&
+
+	cat >folder1-full <<-EOF &&
+	rm ${SQ}folder1/0/0/0${SQ}
+	rm ${SQ}folder1/0/1${SQ}
+	rm ${SQ}folder1/a${SQ}
+	EOF
+
+	cat >folder1-sparse <<-EOF &&
+	rm ${SQ}folder1/${SQ}
+	EOF
+
+	# test wildcard
+	run_on_sparse git reset --hard &&
+	run_on_sparse git sparse-checkout reapply &&
+	test_sparse_match test_must_fail git rm folder1/* &&
+	run_on_sparse git rm --sparse folder1/* &&
+	test_cmp folder1-full sparse-checkout-out &&
+	test_cmp folder1-sparse sparse-index-out &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	# test recursive rm
+	run_on_sparse git reset --hard &&
+	run_on_sparse git sparse-checkout reapply &&
+	test_sparse_match test_must_fail git rm --sparse folder1 &&
+	run_on_sparse git rm --sparse -r folder1 &&
+	test_cmp folder1-full sparse-checkout-out &&
+	test_cmp folder1-sparse sparse-index-out &&
+	test_sparse_match git status --porcelain=v2
+'
+
 test_done
-- 
2.37.0

