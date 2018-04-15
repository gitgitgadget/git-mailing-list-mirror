Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD051F404
	for <e@80x24.org>; Sun, 15 Apr 2018 15:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDOPgj (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 11:36:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44530 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeDOPgh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 11:36:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id g203-v6so18586870lfg.11
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nx23Yw+yakQbw9MJ8BWvMCzAI1Q31HaEYnpxAhz0Ygs=;
        b=TW0hBSoAs748ergIdJqHLXwDAZgkmrjxMkZorVnoytiCsh3HrX3GZ44xg8Yvckjmus
         TSfpFhUqPxq13EvEL0Jch2MYJwxg+zrlQ1qdq5sIqeEyNJFNloTUo/5fyTjax8n/pcTX
         TwHv/j7l5s1ps4T8/Va1FLbqu+0lrU6bMqKIaUw9AHhU4drKBmIT9FwhAcJYI9RJRr/r
         b55Zz0a/u6cLbQE5q1ecWwFZpmhAzcI2loEWwCQJ8oEPULMjcrSpNZSP0BKejrt+STlo
         96+ju21orl8hOVZPvgv96mUhNlPaUEAjV8YDDeqamXE6kv2S3ADakDRjxPKOIeghLVU9
         0nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nx23Yw+yakQbw9MJ8BWvMCzAI1Q31HaEYnpxAhz0Ygs=;
        b=Fi/LyQYt/U+FWgDHzGU9gABG3bFlVpiWKrQ3yE3EX7yjSFoBuHdmC6fq0POuGmlcEh
         l5pikSTWps9Q5iC9ryg4rk7srY7hrYbzHAg1HxjKPa5xm7O4s52xtrehPS9r5YCuvt/S
         aZ6gE9VTcsbzwpagavZz/yVblnev1+TaEN9ZHe7abC6Cwb8RV83OvvVD8fEsu9po2o6M
         lAsZ3kTlqv+7ap3SAmmfP96ZGx0aaXwGdN6MIgyjWjKY/d6rAkFM1CmYkHNAuOtncGLf
         5KPV4Cu91vwY9D+XpXln9yNA1lOniE/4AgnyzoJa9aFvMGPdfiOSBGbeq06B1KfMFPoB
         pvGA==
X-Gm-Message-State: ALQs6tAheO8OlRwqD+B1UT3o+3hBxDlncu2rucOmeURpDeX/e4xWxYzs
        rxczrO4SP2ShizhjP/wnfEo=
X-Google-Smtp-Source: AIpwx4/pmOc7eebCIIhC42AKH5ZuozJ0BUfk7H/iQG9dNd3PwI6/H32Mqs401dHMotc/V3XT5aX5qg==
X-Received: by 2002:a19:6d03:: with SMTP id i3-v6mr12331001lfc.34.1523806595795;
        Sun, 15 Apr 2018 08:36:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w10sm826176lji.47.2018.04.15.08.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 08:36:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 5/7] gc: handle a corner case in gc.bigPackThreshold
Date:   Sun, 15 Apr 2018 17:36:16 +0200
Message-Id: <20180415153618.32019-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415153618.32019-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
 <20180415153618.32019-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This config allows us to keep <N> packs back if their size is larger
than a limit. But if this N >= gc.autoPackLimit, we may have a
problem. We are supposed to reduce the number of packs after a
threshold because it affects performance.

We could tell the user that they have incompatible gc.bigPackThreshold
and gc.autoPackLimit, but it's kinda hard when 'git gc --auto' runs in
background. Instead let's fall back to the next best stategy: try to
reduce the number of packs anyway, but keep the base pack out. This
reduces the number of packs to two and hopefully won't take up too
much resources to repack (the assumption still is the base pack takes
most resources to handle).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 5 +++++
 builtin/gc.c             | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 728ae902e6..4c3f1d7651 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1564,6 +1564,11 @@ gc.bigPackThreshold::
 	except that all packs that meet the threshold are kept, not
 	just the base pack. Defaults to zero. Common unit suffixes of
 	'k', 'm', or 'g' are supported.
++
+Note that if the number of kept packs is more than gc.autoPackLimit,
+this configuration variable is ignored, all packs except the base pack
+will be repacked. After this the number of packs should go below
+gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
diff --git a/builtin/gc.c b/builtin/gc.c
index 81ecdc5ffa..23c17ba7e9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -253,8 +253,14 @@ static int need_to_gc(void)
 	if (too_many_packs()) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (big_pack_threshold)
+		if (big_pack_threshold) {
 			find_base_packs(&keep_pack, big_pack_threshold);
+			if (keep_pack.nr >= gc_auto_pack_limit) {
+				big_pack_threshold = 0;
+				string_list_clear(&keep_pack, 0);
+				find_base_packs(&keep_pack, 0);
+			}
+		}
 
 		add_repack_all_option(&keep_pack);
 		string_list_clear(&keep_pack, 0);
-- 
2.17.0.367.g5dd2e386c3

