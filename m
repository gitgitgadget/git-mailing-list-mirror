Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2032095B
	for <e@80x24.org>; Sat, 18 Mar 2017 15:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdCRPM5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 11:12:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33691 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdCRPM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 11:12:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11so7593903wma.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVJxZRssMZBo11Vr5tJy0IWO741tr/RnXb//mKo9hO8=;
        b=rj2cffYzaZKQ6bnFowsnlTRe7Xk2t8wdEy0xGSyXktJ8Of6KI3iW+MA/nEN50kegKY
         uIYOmLgIuBLwD9Fe8l4t82XveJnsV3hI13CZZ36JQfD6BzvZn5fPHkRtBQDV/rejzW3N
         asuiMADSWZCZ2bKRyFcMXkonDAbHtFU2LyCEyqBapThimDonnyrdtTJcHYc8t/gwzFv2
         fmWzAjIfUPQjeJtFsaqYJC4IpXlS/ZINcQEDx7FG90JjLm6PaBGUX6Efu/XGiqv2jeke
         EPigKhk8yN773G5ot/i170z0lkbCl2xeSvBBLudOblQ9GBS9hf4Q6iBqG6AtoWJrGzR9
         rZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVJxZRssMZBo11Vr5tJy0IWO741tr/RnXb//mKo9hO8=;
        b=DY07dIQtYA/LC0c+42LDLfOS53KxVXWyPjB24BC2tb721ZSIPLC24Wzslet0GhUzfu
         nMg0DeFBh+nILkt+pQyMsXldrbqmAFl582SONk/pUOwacTs5nEQ2jox8+ypgwqbMxyMP
         7rSLTxrmyeGVCMmIXtGtqVlqD+xdXJDgkZSTvmlWtZSvN6Y1RsQDmqERlWVsVuI6nvEL
         usgYm9KzV2V6dACmyhIZTchRVLYChFQsIkHECtPXvDci0G48RmHp2XvrsxZ2pG4WLnXt
         207rKJZvhZk5xt60xOIhT8DDfKUG5ySWSiy3rOaXOsN/HPQZTx6s3gNiQRJO2nEnWbZV
         WZqg==
X-Gm-Message-State: AFeK/H0H7UUaI1aVJaJdRQADh9qaXQAvDucExbP2Oy5e3BEhKwuWff/eqXS5ulsmH4LGyQ==
X-Received: by 10.28.178.142 with SMTP id b136mr2915220wmf.57.1489849974301;
        Sat, 18 Mar 2017 08:12:54 -0700 (PDT)
Received: from localhost.localdomain (x590e29c6.dyn.telefonica.de. [89.14.41.198])
        by smtp.gmail.com with ESMTPSA id u11sm13930844wrb.45.2017.03.18.08.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 08:12:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] pickaxe: fix segfault with '-S<...> --pickaxe-regex'
Date:   Sat, 18 Mar 2017 16:12:39 +0100
Message-Id: <20170318151239.17196-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.0.377.g15f6ffe90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git {log,diff,...} -S<...> --pickaxe-regex' can segfault as a result
of out-of-bounds memory reads.

diffcore-pickaxe.c:contains() looks for all matches of the given regex
in a buffer in a loop, advancing the buffer pointer to the end of the
last match in each iteration.  When we switched to REG_STARTEND in
b7d36ffca (regex: use regexec_buf(), 2016-09-21), we started passing
the size of that buffer to the regexp engine, too.  Unfortunately,
this buffer size is never updated on subsequent iterations, and as the
buffer pointer advances on each iteration, this "bufptr+bufsize"
points past the end of the buffer.  This results in segmentation
fault, if that memory can't be accessed.  In case of 'git log' it can
also result in erroneously listed commits, if the memory past the end
of buffer is accessible and happens to contain data matching the
regex.

Make sure that the buffer size is reduced on each iteration as the
buffer pointer is advanced, thus maintaining the correct end of buffer
location.

The new test is flaky, I've never seen it fail on my Linux box, but
this is expected according to db5dfa331 (regex: -G<pattern> feeds a
non NUL-terminated string to regexec() and fails, 2016-09-21).  And
based on that commit message I would expect the new test without the
fix to fail reliably on Windows.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

 diffcore-pickaxe.c      | 5 ++++-
 t/t4062-diff-pickaxe.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 9795ca1c1..03f84b714 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -85,8 +85,11 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
-			if (*data && regmatch.rm_so == regmatch.rm_eo)
+			sz -= regmatch.rm_eo;
+			if (*data && regmatch.rm_so == regmatch.rm_eo) {
 				data++;
+				sz--;
+			}
 			cnt++;
 		}
 
diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index f0bf50bda..7c4903f49 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -19,4 +19,9 @@ test_expect_success '-G matches' '
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
+test_expect_success '-S --pickaxe-regex' '
+	git diff --name-only -S0 --pickaxe-regex HEAD^ >out &&
+	verbose test 4096-zeroes.txt = "$(cat out)"
+'
+
 test_done
-- 
2.12.0.377.g15f6ffe90

