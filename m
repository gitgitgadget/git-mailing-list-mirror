Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37367207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbdECKSx (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36098 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdECKSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:51 -0400
Received: by mail-pg0-f68.google.com with SMTP id v1so27633091pgv.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alkdjtI7YWWwxraW69WAH/1vXMEWJmkb073xnaG0gBU=;
        b=CNz2aC9cpCzPmqOwQj5c5637qB68jBWUDtEN3qfLB5vuzeG0a8Lv/WplbcpktiH2S5
         CpMc3X4nn4q0Gn3pTS6OEALvv7iBi1Fx9Wjl4inZdL5KgxJunyBDnemPAQ/BF0VhDCl2
         ufxgLnwPoTwsX4zmg7YpMbdMg+72kKPV5Prhj2whH2DHVZEQpiqO7DLkkxIv5ScW9JnA
         7VpsjRZVLpRZyRIjmRHpFeX4edssBlBQasDn3Hoi1uq6FXpJyaHEt5ASqQIaZBqr3Idg
         yeNv2B6jSGG0u2J19i3+vxCESVvgR1guagSyHvOZZyhh1bGaLBkrVNoECOu8XwjKQ7/m
         UPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alkdjtI7YWWwxraW69WAH/1vXMEWJmkb073xnaG0gBU=;
        b=aAPkamONgHtFbBG18khEpZV8UDaq2BhkND/LIQLWl5BkJljiXeWdn+TlBl2+ErXKD6
         hTZ9U383kMzN2co71jHN9PCOhWOkxTM24CUeUgSEfL52xvccpRpQIRJX9RUxo0o+9A0A
         c0DaVGCYyzWzwThNoc1hIJzKx6Hf5M0K0Any4s124Q5ReT2RsM5beqttnsZTje+GBx/b
         YMO0Q5ycE9fdp7wPdX7ST94mfg/DyJru1vsAPuO9QyXsw/IGa1BBu1WgZIz0yH8JbW09
         hiqeVBm0tAvJNdMEmyC2qg6Lv84hqtuwbhm8LcWSjVstj5KFF6u2QsvCYylneVDjETLr
         B6sg==
X-Gm-Message-State: AN3rC/70YYRxZVrLOVrm0s5QkD8tBa5BQTnH9okqFNG4Rcz1FTeyUlBt
        aRQq6einxgQRbg==
X-Received: by 10.84.229.79 with SMTP id d15mr7217670pln.93.1493806725392;
        Wed, 03 May 2017 03:18:45 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s89sm3813571pfi.79.2017.05.03.03.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/21] bisect: report on fopen() error
Date:   Wed,  3 May 2017 17:16:53 +0700
Message-Id: <20170503101706.9223-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main thing to catch here is when fopen() is called on a
directory. It's safe even without this change because a few lines
earlier we do check if "filename" is a regular file.

Regardless, let's stay on the safe side in case somebody changes those
lines. Unconditionally printing to stderr by warn_on_inaccessible()
should be fine, because the caller does unconditional fprintf(stderr,
too, no checking for quiet option or anything.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 469a3e9061..bb28bf63b2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -666,7 +666,7 @@ static int is_expected_rev(const struct object_id *oid)
 	if (stat(filename, &st) || !S_ISREG(st.st_mode))
 		return 0;
 
-	fp = fopen(filename, "r");
+	fp = fopen_or_warn(filename, "r");
 	if (!fp)
 		return 0;
 
-- 
2.11.0.157.gd943d85

