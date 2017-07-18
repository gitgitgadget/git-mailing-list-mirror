Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2715520357
	for <e@80x24.org>; Tue, 18 Jul 2017 00:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdGRAUZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 20:20:25 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33534 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbdGRAUY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 20:20:24 -0400
Received: by mail-pg0-f43.google.com with SMTP id k14so2846409pgr.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E6ie1Huj3ArXt6Rg3NfJfMlnYikLsjCt6Nv6vO/x1A0=;
        b=eEDoP2ac8zCZlXsfWIKtKX5hJO9BpAUkx6ZLoLKM4yWKYZNc76qHTv5EP6AHto0kqO
         wdF9k4RrnrDFSFl8+TerXNWoITLHQoeTBXAlR0dkZ6Rnjb/kJOpPiIWBhWSDziNmkUxv
         WLESK/I0E3aQpXfCMXZYPpIkqdOtsXMRIuCbOTYWDeEDUh9D4CDIlpFdE8+oblFQai8A
         5PbTEGMCaIOfqBrM+one/SDcd/6kjKMLqlxx1g3keI8gMTeGXfUHrl1l8s9QYkOyHYpa
         UU1+CGNrjyMm7fat5dMamJ5LZx7V26iKoSQF+lTdWg+I1++OlShleaCPjY5db3ApHctv
         UJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E6ie1Huj3ArXt6Rg3NfJfMlnYikLsjCt6Nv6vO/x1A0=;
        b=LFMGw/OpX6lTIVRK0mE5isCpe/o7DfROxKCWEcdf62UdMr4GL+q3jahjM2Fyuq/5Qo
         9ISyPV8arcaLkEii/7zlhNd4hP/vyn3XunDGUUxTpAi2BOEz7c+VVuUF6tsKqabOgDE6
         5qqFhPs6l+UznKb0I/d4ciBEDukCEpDuc58X/RT7Necog2mnGyxyPUiMR+UhKsEAG17R
         1KcVbr1I2jZUMuaaQhTjJt+XYuvtPE/erTbhgorYmQGhTipkungCOC0aHZ/jdcvc1Jap
         0gNvIFn98N1KwKinAfk6YRkv+m10p+q9O5XkVOXBRjAwNe/cnBCaEr0JdZAyojgYzatJ
         q+bA==
X-Gm-Message-State: AIVw112gl/7Asg9QGsu/yKNIfww4p7aVko4TbxMwZI7e5IcRgcCv2myM
        t+9wt3XZX9Zo2c8kXl3ERQ==
X-Received: by 10.98.198.87 with SMTP id m84mr209581pfg.122.1500337223514;
        Mon, 17 Jul 2017 17:20:23 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d012:f79:3a2:1afb])
        by smtp.gmail.com with ESMTPSA id 79sm722789pfn.51.2017.07.17.17.20.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 17:20:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] t8008: rely on rev-parse'd HEAD instead of sha1 value
Date:   Mon, 17 Jul 2017 17:20:20 -0700
Message-Id: <20170718002020.14309-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.3.650.g5ebc568d5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove hard coded sha1 values, obtain the values using 'git rev-parse HEAD'
which should be future proof regardless of the hash function used.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t8008-blame-formats.sh | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index 92c8e792d1..49cac4b9af 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -12,22 +12,25 @@ test_expect_success 'setup' '
 	echo c >>file &&
 	echo d >>file &&
 	test_tick &&
-	git commit -a -m two
+	git commit -a -m two &&
+	ID1=$(git rev-parse HEAD^) &&
+	shortID1="^$(git rev-parse HEAD^ |cut -c 1-7)" &&
+	ID2=$(git rev-parse HEAD) &&
+	shortID2="$(git rev-parse HEAD |cut -c 1-8)"
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
 	git blame file >actual &&
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
2.13.3.650.g5ebc568d5d

