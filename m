Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FCA01F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeCaKDj (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33264 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeCaKDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:35 -0400
Received: by mail-lf0-f67.google.com with SMTP id x70-v6so8291925lfa.0
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoEZrTeJe/Twz7GLlTfPUi1POBdCGgZg8Sxr4K3hSXY=;
        b=HFQ8y+9XPL5xGHllpM1Ewulv/d2pwjYrZKx76LrgDxlwaHxu9mMjd1Xdb2hA/Wn699
         VO2awqXq2tUhzJFofo/wYZh8nvJCuNiobLF0DNhD0uYYskxaAybY7gQyR/+7oB/X1n4o
         8zsncTht+mzEt7VoH7GLr6JWDJIB/3UQ0OryYMO/30c/WJWz/kT5tTmGUrG5yV3RcDOZ
         10392e2rarIdaeQfaf39uwYL16XMwVjF6HcGjrpo7dG/Zta0U9Yd6VV7oX8xIVDDxuVz
         nZc8T33AiXtDmUs/0dBxFFg18rQGlytM+V1tPkmpb+rgo6gxjYcmunaKZDkpi5+gvJzQ
         hJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoEZrTeJe/Twz7GLlTfPUi1POBdCGgZg8Sxr4K3hSXY=;
        b=Kc1YdQusMm8t9gGfcmdPzQyWZyUcEACL7LpiyXn9MSNMrBknH+unhJGrbbRfTWXHSn
         yI1SfS7uojfXh5uwxBV+J5TiVCM9XbTY9dYcncPejHDpebMXQtn1HUtOuKjA4spg1KbI
         6Qap6CvxjTecIwVg5zhllkUsWFrFv/uLjYrXShL7TkGaIJova6eOc2u8nODsPcZi+F55
         1Vxkrx0GZ4PVMHfu1S3Tc2Xac/lqpT/g22xQMCdoBWrIdhiJwzeTVs4mhaiWe8wXlAFh
         0MTeuwnKc3XGeS9i3uaYPkZ+TNiG4CfaQnpi4D7nmdlOQQ99VtyFzRd9o6JFYG8r8RYH
         lzkw==
X-Gm-Message-State: ALQs6tDuI9nmtu6rRKqMZBQNwvyLB1Bv3XaRNNru6xdFmtAVzHMoSmwb
        W9MZ424+iuA/O6lYP3oli08=
X-Google-Smtp-Source: AIpwx48kMoCt7utmx4nCumeZxxRLsYKgaW4/YTBJTx4yLD/oEcS4lCvt1MZPPUInQHUhz2yBxwk0WQ==
X-Received: by 10.46.99.93 with SMTP id x90mr1507933ljb.2.1522490613736;
        Sat, 31 Mar 2018 03:03:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 10/15] pack-objects: don't check size when the object is bad
Date:   Sat, 31 Mar 2018 12:03:06 +0200
Message-Id: <20180331100311.32373-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sha1_object_info() in check_objects() may fail to locate an object in
the pack and return type OBJ_BAD. In that case, it will likely leave
the "size" field untouched. We delay error handling until later in
prepare_pack() though. Until then, do not touch "size" field.

This field should contain the default value zero, but we can't say
sha1_object_info() cannot damage it. This becomes more important later
when the object size may have to be retrieved back from the
(non-existing) pack.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 34e285a1b7..481b55c746 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1741,7 +1741,7 @@ static void get_object_details(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
-		if (big_file_threshold < entry->size)
+		if (entry->type_valid && big_file_threshold < entry->size)
 			entry->no_try_delta = 1;
 	}
 
@@ -2454,7 +2454,7 @@ static void prepare_pack(int window, int depth)
 			 */
 			continue;
 
-		if (entry->size < 50)
+		if (!entry->type_valid || entry->size < 50)
 			continue;
 
 		if (entry->no_try_delta)
-- 
2.17.0.rc2.515.g4feb9b7923

