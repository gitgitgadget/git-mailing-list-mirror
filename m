Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6401F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeK2Gs1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:48:27 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39569 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeK2Gs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:48:27 -0500
Received: by mail-yw1-f66.google.com with SMTP id j6so4955111ywj.6
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lj5jUb/NBTXHO9GxXovpr15y+MtclDFoiwlAVeYr8tw=;
        b=E2qP6DByuu1uRPTHcMCCZPb8YQz5Rl91X4b5mM/PBLtHo8RI2RcFM2W2gSbGo9gKbc
         y9Ciixpinb11F1dXDB90aT3DbAqTzEoV6b4osglrbKBUrfoE193PUwE3cL7yF4nf+yTa
         dvhHl2zJkMfkART/oCQx7tfTWMaCTYVkAnQbUMR+Kxim8/M7qaBdcGGQkC0cTt3H/79H
         YXVkxOgdYN3PWP2UukJbgNX9xbXXIamwsPXO4Pl65Kqf9JPXaQiNzXxi91I+/nj4mgWG
         Qw28c7MiABdDN+LDWn1n9uU0kYIN2pxkVy6WtPF82tpGN/iUr5mUSiFT/8/ZXsEFCDy2
         j/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lj5jUb/NBTXHO9GxXovpr15y+MtclDFoiwlAVeYr8tw=;
        b=fju7tT+IVwJ3dvNWAXTsnzhYTl5fukxN8mhvk8E0ztdYjgmg8z1WsBeb/OVOLi1b0E
         dAXV6TMbnho4fGcpkwErtuF93C9Zc8UO/D09Ic/6spLymePOUsi6htkZ/4cWJP4xBLAf
         hDejQwcXU1LN74ZlLAFgOzbyiFONwFiarENcpJ+bZh0MuZj84NlBv5+XedxUVPQ8/Apb
         2431HGWE7jmc/4grGV7atDCpxYI1qsw2JsCa2pJDimxiLBm+BHaLZZ7zSbdSU5060Qxt
         cI9Wwa9gPV2lq/lCypl/8rbbbmdDndMM5a0s10c+YrHNZ28fWiMSVzd3u+omYr8nbGlx
         A4LA==
X-Gm-Message-State: AA+aEWYUJYk/lDvrnYXiaUpoPT1x3wAQFtaCT1D602HsIee7/7+aV2nI
        FtaHDe29sSPGazo9HtyFzRDz7gfp
X-Google-Smtp-Source: AFSGD/UZ10Lycdu9g2U5UxqWE9lsE9mvTIgTX1O3A1bXBJJjH2wBpLJZQTsMnZf9IV7GPIz0xGckWw==
X-Received: by 2002:a81:1a0a:: with SMTP id a10-v6mr17370731ywa.337.1543434340129;
        Wed, 28 Nov 2018 11:45:40 -0800 (PST)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id x4sm12375883ywj.80.2018.11.28.11.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 11:45:39 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [BUG REPORT] t5322: demonstrate a pack-objects bug
Date:   Wed, 28 Nov 2018 19:45:36 +0000
Message-Id: <20181128194536.57019-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was preparing a new "sparse" algorithm for calculating the
interesting objects to send on push. The important steps happen
during 'git pack-objects', so I was creating test cases to see
how the behavior changes in narrow cases. Specifically, when
copying a directory across sibling directories (see test case),
the new logic would accidentally send that object as an extra.

However, I found a bug in the existing logic. The included test
demonstrates this during the final 'git index-pack' call. It
fails with the message

	'fatal: pack has 1 unresolved delta'

It is probable that this is not a minimal test case, but happens
to be the test I had created before discovering the problem.

I compiled v2.17.0 and v2.12.0 as checks to see if I could find
a "good" commit with which to start a bisect, but both failed.
This is an old bug!

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5322-pack-objects-sparse.sh | 94 ++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100755 t/t5322-pack-objects-sparse.sh

diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
new file mode 100755
index 0000000000..36faa70fe9
--- /dev/null
+++ b/t/t5322-pack-objects-sparse.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='pack-objects object selection using sparse algorithm'
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	test_commit initial &&
+	for i in $(test_seq 1 3)
+	do
+		mkdir f$i &&
+		for j in $(test_seq 1 3)
+		do
+			mkdir f$i/f$j &&
+			echo $j >f$i/f$j/data.txt
+		done
+	done &&
+	git add . &&
+	git commit -m "Initialized trees" &&
+	for i in $(test_seq 1 3)
+	do
+		git checkout -b topic$i master &&
+		echo change-$i >f$i/f$i/data.txt &&
+		git commit -a -m "Changed f$i/f$i/data.txt"
+	done &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic2
+	^topic3
+	EOF
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt | sort >actual_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --thin --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp actual_objects.txt nonsparse_objects.txt
+'
+
+# Demonstrate that both algorithms send "extra" objects because
+# they are not in the frontier.
+
+test_expect_success 'duplicate a folder from f3 and commit to topic1' '
+	git checkout topic1 &&
+	echo change-3 >f3/f3/data.txt &&
+	git commit -a -m "Changed f3/f3/data.txt" &&
+	git rev-parse			\
+		topic1~1		\
+		topic1~1^{tree}		\
+		topic1^{tree}		\
+		topic1			\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt	\
+		topic1:f3		\
+		topic1:f3/f3		\
+		topic1:f3/f3/data.txt | sort >actual_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --thin --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp actual_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'duplicate a folder from f3 and commit to topic1' '
+	mkdir f3/f4 &&
+	cp -r f1/f1/* f3/f4 &&
+	git add f3/f4 &&
+	git commit -m "Copied f1/f1 to f3/f4" &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic1~1
+	EOF
+	git rev-parse		\
+		topic1		\
+		topic1^{tree}	\
+		topic1:f3 | sort >actual_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --thin --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp actual_objects.txt nonsparse_objects.txt
+'
+
+test_done
-- 
2.20.0.rc1

