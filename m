Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6BA2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 19:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdGZTGh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 15:06:37 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34429 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdGZTGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 15:06:36 -0400
Received: by mail-pf0-f178.google.com with SMTP id q85so74401710pfq.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bm2tP9CjLiAOR2TWey9MbfT8njKGF+98J38ozP/s9PM=;
        b=uXzx24Dq4RjcTYkbuF4/HW3OY7I2HRgB8IPPchRyK3piQRiS3sm5ZvZK0BzNY1lbFQ
         UQxcEN5ea+NEXGev54FDOjCXtIP2Cmh67sUhOzUQj+7f3dmzjBkuvfmgrz8zSrr5XwfI
         o94wewJCjdjIqgCx9dIiDjFALK0/s40WbFhgw3Tdr3va6Qsni90t5igH5qBkcQETqHUY
         aGpzMx1gYlSPJiCLvQnzdiRT8wSWpC/yKJwXrUBGNTFvYpSRg550vAB6d8Qs1p7j0L2r
         DJiLS2tb9NJZuh5a19W0mkwE3DozcRuV1SDaNHuydIziOuVavi9Wo8++drta0aqbxTuA
         PXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bm2tP9CjLiAOR2TWey9MbfT8njKGF+98J38ozP/s9PM=;
        b=mcKufCwvgXf21Rk2JXZBm8js0geABVaSJPAGsQ3um9xeUjj2TK226POvk/ym1sBDC2
         EQN8kiAwO00/plnzr8uy6a8wYbWae0h4cx8kc0W28UJ57mEMpHsUEk9Ekd3CY0w3Bt0+
         kH6g1HLvEabhSa3o3VebQVrTiafcY9v6lfYnzx4Wihh6jINtMwVyd+BdRWIUQVRpxZrR
         kiJFHIDtKDMRH3OO/surpf0oHnZuK0qdrWeATzgso9yuGG7Z+ZiRf2jMA1JJdVl9NBda
         KAeAAODVCVhdjh34pE4vHYxFK8t54Rbm1rizSEvT5S6scOKajXFVGKhYURrnuKtIYMkA
         qxAQ==
X-Gm-Message-State: AIVw112z9gt2N/W8GOFoqvlsAOOH4Xe+Tu1ZQO3ZT0AWHxKIzpMKp27v
        B7cw1HWI/Zetv9Yv
X-Received: by 10.84.232.197 with SMTP id x5mr1872393plm.329.1501095995547;
        Wed, 26 Jul 2017 12:06:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b827:7828:2b7f:c1e7])
        by smtp.gmail.com with ESMTPSA id s18sm11662085pfg.166.2017.07.26.12.06.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 12:06:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv2] t8008: rely on rev-parse'd HEAD instead of sha1 value
Date:   Wed, 26 Jul 2017 12:06:31 -0700
Message-Id: <20170726190631.560-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqk235o7rm.fsf@gitster.mtv.corp.google.com>
References: <xmqqk235o7rm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove hard coded sha1 values, obtain the values using
'git rev-parse HEAD' which should be future proof regardless
of the hash function used.

Additionally future-proof the test by hard coding the
abbreviation length of the hash.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> Don't hardcoded lengths of the hashes defeat this future-proofing
> effort, though?  It shouldn't be too hard to do the equivalent of
> the auto computation of abbreviation in this script, which would be
> true future-proofing, I guess.

Added --abbrev=n to also hard code hash abbreviation. At first
I had the impression of a off-by-one-error, but after reading the
man page for both blame and rev-parse, I realize that blames
abbrev notion is different than rev-parse precisely for the
caret that may occur to indicate out-of-range.

 t/t8008-blame-formats.sh | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index 92c8e792d1..ae4b579d24 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -12,22 +12,25 @@ test_expect_success 'setup' '
 	echo c >>file &&
 	echo d >>file &&
 	test_tick &&
-	git commit -a -m two
+	git commit -a -m two &&
+	ID1=$(git rev-parse HEAD^) &&
+	shortID1="^$(git rev-parse HEAD^ |cut -c 1-17)" &&
+	ID2=$(git rev-parse HEAD) &&
+	shortID2="$(git rev-parse HEAD |cut -c 1-18)"
 '
 
-cat >expect <<'EOF'
-^baf5e0b (A U Thor 2005-04-07 15:13:13 -0700 1) a
-8825379d (A U Thor 2005-04-07 15:14:13 -0700 2) b
-8825379d (A U Thor 2005-04-07 15:14:13 -0700 3) c
-8825379d (A U Thor 2005-04-07 15:14:13 -0700 4) d
+cat >expect <<EOF
+$shortID1 (A U Thor 2005-04-07 15:13:13 -0700 1) a
+$shortID2 (A U Thor 2005-04-07 15:14:13 -0700 2) b
+$shortID2 (A U Thor 2005-04-07 15:14:13 -0700 3) c
+$shortID2 (A U Thor 2005-04-07 15:14:13 -0700 4) d
 EOF
 test_expect_success 'normal blame output' '
-	git blame file >actual &&
+	git blame --abbrev=17 file >actual &&
 	test_cmp expect actual
 '
 
-ID1=baf5e0b3869e0b2b2beb395a3720c7b51eac94fc
-COMMIT1='author A U Thor
+COMMIT1="author A U Thor
 author-mail <author@example.com>
 author-time 1112911993
 author-tz -0700
@@ -37,9 +40,8 @@ committer-time 1112911993
 committer-tz -0700
 summary one
 boundary
-filename file'
-ID2=8825379dfb8a1267b58e8e5bcf69eec838f685ec
-COMMIT2='author A U Thor
+filename file"
+COMMIT2="author A U Thor
 author-mail <author@example.com>
 author-time 1112912053
 author-tz -0700
@@ -48,8 +50,8 @@ committer-mail <committer@example.com>
 committer-time 1112912053
 committer-tz -0700
 summary two
-previous baf5e0b3869e0b2b2beb395a3720c7b51eac94fc file
-filename file'
+previous $ID1 file
+filename file"
 
 cat >expect <<EOF
 $ID1 1 1 1
-- 
2.14.0.rc0.3.g6c2e499285

