Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3482095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdCRSYV (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:24:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36110 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdCRSYU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:24:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id l37so13156497wrc.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtV+yJdMu7j8mHTSXfB7Vle48MZt2uEGu8QYZlRUzaA=;
        b=cNdxINvCBxQuSGA3x6V839rNRNu9B1FtdTki1Zm8KeWVR1ozEkHU+WMDGd9lmgZAWM
         /DF0Aj85Ws0C6ift505cjPm0zAbTykS9KYfgUk13kgbyrLMKb7R41QvgK+p8Cp/OmBel
         sY3BnBO8my6JJpiGUPlhVTsDQkfIZoK9qg2kRuQBPsbnRorhws9GVeywzeEHPqHkWthk
         H6jDy5/wOITzhEyQ49v9EdMRWTuga/ypCxEWJM6v3EogCJ6OoVwZR0oyDandF2fvyTp/
         /kt0yzvvfaldC2Sx/6X+gbKOHGZd3/cqb4Y6lwUtnJraGTZB3JU54yG6KQkI+LzqaCAV
         JHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtV+yJdMu7j8mHTSXfB7Vle48MZt2uEGu8QYZlRUzaA=;
        b=WdX2mqAAKMLw7F4t9ZH4OY9W+XxBkkFehCEeBAjPJBd2NOtE1oghGOJEFKIF5fAZVR
         /61jfyv21tyrUGz2D4JfiVk3OZZ5tQQg8uXEJL+ypx9CHMG3HNDyiqWq+at8x5MoMqC+
         R+rfKRmMAkiapEOp4CF2x72+IZm+EYrrEIbAo8ZCEcnnSAawhpQgqeBQvXHeTQxuQItd
         K3jZumpFmotTjU1t3Mauh0X45Qx3DNnE+dfXcolzqkpx3fjfb1Plbwu44xYXx5rxGxq+
         o108j3qWsn59Q6q2L0V/6cvhcKst42wf5vTnTSLJwlQIkBP5UhL5V0wL1pE8afhwCu4g
         dWeQ==
X-Gm-Message-State: AFeK/H3diwOCZ92v9SlbLSPK3D6acMlT2JH/nDQEEaMhsoO/h/QOjDoEcvFIFM5cnJUU1w==
X-Received: by 10.223.176.87 with SMTP id g23mr17669336wra.12.1489861458154;
        Sat, 18 Mar 2017 11:24:18 -0700 (PDT)
Received: from localhost.localdomain (x590e29c6.dyn.telefonica.de. [89.14.41.198])
        by smtp.gmail.com with ESMTPSA id g6sm7037165wmc.30.2017.03.18.11.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 11:24:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2] pickaxe: fix segfault with '-S<...> --pickaxe-regex'
Date:   Sat, 18 Mar 2017 19:24:08 +0100
Message-Id: <20170318182408.4444-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.0.377.g15f6ffe90
In-Reply-To: <CAM0VKjknLpCyQfY+ie3sfGemwhyad3Tk-5fHdeTSz2-WTw7NoQ@mail.gmail.com>
References: <CAM0VKjknLpCyQfY+ie3sfGemwhyad3Tk-5fHdeTSz2-WTw7NoQ@mail.gmail.com>
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

Reduce the buffer size on each iteration as the buffer pointer is
advanced, thus maintaining the correct end of buffer location.
Furthermore, make sure that the buffer pointer is not dereferenced in
the control flow statements when we already reached the end of the
buffer.

The new test is flaky, I've never seen it fail on my Linux box even
without the fix, but this is expected according to db5dfa3 (regex:
-G<pattern> feeds a non NUL-terminated string to regexec() and fails,
2016-09-21).  However, it did fail on Travis CI with the first (and
incomplete) version of the fix, and based on that commit message I
would expect the new test without the fix to fail most of the time on
Windows.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Changes since v1:

 diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
 index 03f84b714..341529b5a 100644
 --- a/diffcore-pickaxe.c
 +++ b/diffcore-pickaxe.c
 @@ -81,12 +81,12 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
  		regmatch_t regmatch;
  		int flags = 0;
  
 -		while (*data &&
 +		while (sz && *data &&
  		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
  			flags |= REG_NOTBOL;
  			data += regmatch.rm_eo;
  			sz -= regmatch.rm_eo;
 -			if (*data && regmatch.rm_so == regmatch.rm_eo) {
 +			if (sz && *data && regmatch.rm_so == regmatch.rm_eo) {
  				data++;
  				sz--;
  			}

 diffcore-pickaxe.c      | 7 +++++--
 t/t4062-diff-pickaxe.sh | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 9795ca1c1..341529b5a 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -81,12 +81,15 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 		regmatch_t regmatch;
 		int flags = 0;
 
-		while (*data &&
+		while (sz && *data &&
 		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
 			flags |= REG_NOTBOL;
 			data += regmatch.rm_eo;
-			if (*data && regmatch.rm_so == regmatch.rm_eo)
+			sz -= regmatch.rm_eo;
+			if (sz && *data && regmatch.rm_so == regmatch.rm_eo) {
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
