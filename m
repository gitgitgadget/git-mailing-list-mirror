Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E771C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043D320719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPAbnhzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgCZEiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:38:03 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53837 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZEiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:38:02 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so1952944pjb.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWRiskax7tm9yH3inDrU/u9x8duAw9U0FkyXTN++6Xs=;
        b=iPAbnhzGLDJbn5iTRMFdixJP4HKyjl53uknjPSMryvw1t1f3N3sN4rgM0BmpS7yn9p
         yvHgINigY+5EpqRX4z+wXfv6QdPQWYPyDtL9GsDMM4h/O3Pm4LWSzAe9dY602l1Hel+4
         XLpyYUATSRI+56Gim65LJH15pGOmdFZm5UQPN2SAtykzkeetHlptjZ5GvXx0ZModqK+9
         xT66Hi/I3vvtPf80lGsHUwsoaZzSB8r855JuJ8ct3gdDoel8UwvdJ2qHgqIKV22Dka8+
         vedH/uAyqfisKFxQnpqFzxz5xGnEfL2kg0kybN+q+2uDLYL+bV2mFFpNbI3xVYfLPsn0
         GVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWRiskax7tm9yH3inDrU/u9x8duAw9U0FkyXTN++6Xs=;
        b=Isq0uNueegvPHHRK/3FKrd1sEmyMjsgEmbSnVoRINR4eAV/FmA7jb/FoaWuCFRWTw7
         6QxMBa6KVgCsoBjrSTs5Nj4mrDjHBkq9sUX64ymsT/cZ412AY+p2pQu4PGdu+AEb/zmc
         x9vEK/rnHJmjKxicsfdHczjfjcqapeJQrpHfkd/6PIzXG7rv6KtmmxPG/NNtPjplJrhD
         Ey66JCsPV/Vb8gOySy19RFXlE04GWaqXgY5GM2t31KAKaLKTGHrNf5LxTk0HBLQqUco7
         9fqIPJg+QODd4dlxrVgvTsxAzsIZ8tOXRji/diQVOWMZ6Ddc31N5m3s4xrTDpKbATpKn
         RKRA==
X-Gm-Message-State: ANhLgQ1O/ul7b5rJHhvlksnmB9ZVmc85y/rCxd+r5Qr6gjRqSm1hoeE+
        +xMnDwMYipe1rNrBzmYlhGlxuMgr
X-Google-Smtp-Source: ADFU+vtgaw8TPsB+Smr2QBjO8nwC+Wjp/dfWplQ7/pTt17piCXLknsTN2KfsRQU0zTGyMjWm1XX5AQ==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr6657686pll.34.1585197480632;
        Wed, 25 Mar 2020 21:38:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:38:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 8/8] t5703: feed raw data into test-tool unpack-sideband
Date:   Thu, 26 Mar 2020 11:37:38 +0700
Message-Id: <2b8e75aaa5b196fdd1ffca02ae53cc859fe1e522.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585197360.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com> <cover.1585197360.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

busybox's sed isn't binary clean.
Thus, triggers false-negative on this test.

We could replace sed with perl on this usecase.
But, we could slightly modify the helper to discard unwanted data in the
beginning.

Fix the false negative by updating this helper.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/helper/test-pkt-line.c           | 2 +-
 t/t5703-upload-pack-ref-in-want.sh | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 282d536384..12ca698e17 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -67,7 +67,7 @@ static void unpack_sideband(void)
 		case PACKET_READ_NORMAL:
 			band = reader.line[0] & 0xff;
 			if (band < 1 || band > 2)
-				die("unexpected side band %d", band);
+				continue; /* skip non-sideband packets */
 			fd = band;
 
 			write_or_die(fd, reader.line + 1, reader.pktlen - 1);
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 7fba3063bf..a34460f7d8 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -13,10 +13,7 @@ get_actual_refs () {
 }
 
 get_actual_commits () {
-	sed -n -e '/packfile/,/0000/{
-		/packfile/d
-		p
-		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
+	test-tool pkt-line unpack-sideband <out >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
 	grep commit objs | cut -d" " -f1 | sort >actual_commits
-- 
2.26.0.rc2.357.g1e1ba0441d

