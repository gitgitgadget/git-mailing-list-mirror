Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5881FAE2
	for <e@80x24.org>; Thu,  1 Mar 2018 09:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966791AbeCAJLw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:52 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34143 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966685AbeCAJLt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:49 -0500
Received: by mail-pl0-f68.google.com with SMTP id u13-v6so3299574plq.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZglhdqBDf4ZAm42es5fNXKI+JV5M2NxeNPFC02IIGQU=;
        b=KiFCSmVdX9xBrKHHkyu4e5K89ecRE/JwihKOoNR4U3xqyPFg56jNQ7rj8AdBOdAZfX
         p5H3y8MQrKoO1fV4If6DVYkuGVMDWIc5upkJsMOzS9HyRYU5QJ/kIhZQedTStxiJ5/W9
         Kk2nIpY5fcSgrUuPkYLettvC93Cw0agRSGvSyTxc43ogT3a+OUTTE7d5bab+dyCogj9G
         H6n/tJrvVnneA1DrWWNxk9qKD2OGgZNrJoI1Vx3BGgFCluk5HiTspvUINFz02KS7oBed
         QahcMYMsJwSlPUQ2dx6+l0nYyZGb1tvlz9kq72zkTTNxh7HSHZfAxb5ViFL+I38nHKow
         4mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZglhdqBDf4ZAm42es5fNXKI+JV5M2NxeNPFC02IIGQU=;
        b=QwSTu8SaWaS7oJrNLypq4xnN/2/PJglCbK9i+6yYOVOTyovjyi4lYScbHtmSJR95U+
         HloYvuhJe/2xMuL7ZbT9x0ewj3vgs6gEUPBvvvK+DTkaM448RViN4zaBWirmZ3/bV0/l
         kp1eLCn4JcMeEfFG6kjiS/WxsrK5Z/nvj4B1dRlD5PkcasoC+BiEpxAgYir5h4JCq83Q
         fTsQ1I4OuIlnTxBhLhhm0ZZBAa0y9IS+hwg8xJYyorYAQbW9GAtKFS666gJmTKFxmJbd
         ze6b/8/R71iCxIQPg3nSHoAdkux12u0DIwsZ4UDMyRSO/DMjz9wdZjtkR5vYbnZaJ94a
         4hHA==
X-Gm-Message-State: APf1xPBSP2N7kLlUf/V4rbioU2txKT4sv7LIIyCthy0Jt0uZJpaqzKlU
        Fbds2VkkUD4Pw/z27ecNpc242w==
X-Google-Smtp-Source: AG47ELvsQ0lAsk5vByDLyHte4h8hR6sFxqLc0MiAjhPVuC6ZL+vJHLyDOvfh8SAhsi4E1VDvmgE+KQ==
X-Received: by 2002:a17:902:e83:: with SMTP id 3-v6mr1291074plx.158.1519895508611;
        Thu, 01 Mar 2018 01:11:48 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id v12sm8598249pfd.141.2018.03.01.01.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/11] pack-objects: faster reverse packed_git lookup
Date:   Thu,  1 Mar 2018 16:10:49 +0700
Message-Id: <20180301091052.32267-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do a linear search for in_pack index in create_object_entry(). This
function is called for every available object in the worst case (and
on linux-2.6.git, that's about 6.5M). Try to avoid that by saving the
index in packed_git. Since we should not have zillions of packs, this
extra space should not be a big deal.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 11 ++---------
 cache.h                |  1 +
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d0d371714a..1fdb85ebb5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1074,15 +1074,7 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		int i;
-
-		for (i = 0; i < (1 << OE_IN_PACK_BITS); i++)
-			if (to_pack.in_pack[i] == found_pack) {
-				entry->in_pack_idx = i;
-				break;
-			}
-		if (i == (1 << OE_IN_PACK_BITS))
-			die("BUG: pack not found!");
+		entry->in_pack_idx = found_pack->index;
 		entry->in_pack_offset = found_offset;
 	}
 
@@ -2980,6 +2972,7 @@ static void init_in_pack_mapping(struct packing_data *to_pack)
 		if (i >= (1 << OE_IN_PACK_BITS))
 			die("BUG: too many packs to handle!");
 		to_pack->in_pack[i] = p;
+		p->index = i;
 	}
 }
 
diff --git a/cache.h b/cache.h
index 862bdff83a..b90feb3802 100644
--- a/cache.h
+++ b/cache.h
@@ -1635,6 +1635,7 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
+	int index;		/* for builtin/pack-objects.c */
 	unsigned pack_local:1,
 		 pack_keep:1,
 		 freshened:1,
-- 
2.16.1.435.g8f24da2e1a

