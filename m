Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C451F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeCXHnv (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:43:51 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45810 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCXHnk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:43:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id l4-v6so17057075lfg.12
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5ge+wSz70nxEp/mrs/C/Zn992ZE3B56lv15eVDwQlY=;
        b=Xpvh5vAlOH8R+UkdBdlFwnJAqFh5q/csNGqo8pEbPC60nbegmtpkU0aRUgGQ0DSqsU
         bDB9zmOktjisAn3UUXzauzOKCxtfdn8N2uC0Yw8u3kL1kgvBztL4zdXa+JqPK9iNEky5
         XGoNaz8nKjJjmGXMha26NhNPRnZO5Mb65SIqa2ceQAp1DXgMhDaYBjcwmPyvlntNEcGg
         inx0S28ASAZbJSbzh1hiOvbeu6cPRoa9QmgMiEt+bM/tfGx5WxOrSNDkUAIsyNHO+R4s
         RSt5Vvb7p6BG0YVV6xJj01YoYMsaMdSDyKh8OYW2IzH9cnPwy1nNjWcuoR0ngcx9hBm+
         ccOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5ge+wSz70nxEp/mrs/C/Zn992ZE3B56lv15eVDwQlY=;
        b=snEsoNjUGLhATl8G+SuJ+mmxJh/I3n9KU1byoysXSwvdHiC7SBj8v27JhRGKAABrso
         lm5OqKqCjzHDK1UJajFl0Jf68dkJqFrHXi0WY9j17Z8MYq5rlW3/1544ym9ROQMVf90W
         1Y+pJrx82p/buSSQiAFrvCWw+RdGujcBXpAdlzAdhu6txgDkVeKkW6vUF/oo8U5+2fk5
         quhnubzrS/ETloC6rBzFsUAmEFEbgrxED/XTbYwQpvvkqbeCsXxcC3aakdirJD6PXmZT
         DVcDdaP5WDlo+AR1k/s+9Br4qFpqBez7i6F+6X6Xmcj5hAJtyvC78wR59GMxDvvkXmPL
         uG+g==
X-Gm-Message-State: AElRT7Fy0RjITq1rQdyWtzs4619KeJNNxvwdrJEG4aWBPsetUgJB1/Fh
        IwB+UwDQYwup6bv25HIEhNiHuA==
X-Google-Smtp-Source: AG47ELsHuZA/EdrQWRjxvJMu05gUNlaD0sBYYx5GLMmXucK2fwT+WjP+FQ+vgdwiNsM7rla/EqBIug==
X-Received: by 10.46.13.10 with SMTP id 10mr22298041ljn.8.1521877418946;
        Sat, 24 Mar 2018 00:43:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o132-v6sm2642867lfe.91.2018.03.24.00.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:43:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/7] gc: handle a corner case in gc.bigPackThreshold
Date:   Sat, 24 Mar 2018 08:42:34 +0100
Message-Id: <20180324074308.18934-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074308.18934-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074308.18934-1-pclouds@gmail.com>
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
 Documentation/config.txt | 6 +++++-
 builtin/gc.c             | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d63db3f12c..cf862d3edf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1564,7 +1564,11 @@ gc.bigPackThreshold::
 	except that all packs that meet the threshold are kept, not
 	just the base pack. Defaults to zero. Common unit suffixes of
 	'k', 'm', or 'g' are supported.
-
++
+Note that if the number of kept packs is more than gc.autoPackLimit,
+this configuration variable is ignored, all packs except the base pack
+will be repacked. After this the number of packs should go below
+gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
diff --git a/builtin/gc.c b/builtin/gc.c
index 53a0500898..74d3aaa270 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -254,8 +254,14 @@ static int need_to_gc(void)
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
2.17.0.rc0.348.gd5a49e0b6f

