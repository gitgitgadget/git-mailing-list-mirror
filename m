Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0237B1FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 17:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCWRVx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:21:53 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33778 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeCWRVq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id x205-v6so19396379lfa.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9x3SRjMB+MlW6iOUQgLtfe9mSKDuOIgD3eNrS8+FmeY=;
        b=c21Q2VUaH7+jBVoaijHhKtqlCTbzoWjqLPII+aOVGOOATM53969o1n6SIcj0O97+OT
         iai3hm5yOrx5QBZR8PqGZqo2BYMMuWatEl7qei5A11yuk7JHTXjoAkCRB/rbmcYqIHOU
         qgS01XpDeiTNIOSrBnScIIcabKNaP33jxVnfrnQsD6u2DERdGmRnIXLqgLeuTGZUjyuf
         wgIyCjMfwfucFjI89ipGofRnirNWcM1ArJe9pcS+2lodwKdD5Zi6KoRf13X0A8OorcCU
         I/3TNYghYBurNNpRBmTPEEPwVaYtm/kG+rSHc9MpeQowa6NfmBsbH9iHQMYII/boRmM2
         0QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9x3SRjMB+MlW6iOUQgLtfe9mSKDuOIgD3eNrS8+FmeY=;
        b=OGFCrmfNnBh9ODlkXSos0/60B/oTJ/qEhDJNL/EOM4/rjvMuYQa8XmC7xEEaB8BuBV
         kxJaoH0vpWlFywmt5y0kvCgL8D33xO8fb0XW+jWylMjOAhUmgTbU9Xn7aMleVUm+Znz0
         4xrlqmFodRZwIfC8gINgZiksNRFTZhhNsanm+gFKKU66T5rPPY8DtUu+bq3wbL4KAVc7
         g9PN5knh2NVHoVYVJf6XbyTkN1+Ug/3or2qx0uRiISg/2cZQ1IxFBIm+qz2ieky3zAAt
         zI0MjqPuCRpfHvd5WSUUmtFuI8U32gjipSVytCRO7mqNCN/A5u25vSr+eucNZR8fCfpx
         IfRw==
X-Gm-Message-State: AElRT7FfwDiV6lmxiT2WX33XoRBTiBHIj8Ap0m7QjAigQ7c6k5hdeCij
        72ytFGWbjrBK1FuJb4bgxOc=
X-Google-Smtp-Source: AG47ELsNGbra4eroX7kXHzDXRQMxyTmFkDNX7bve5cLljr6X/3RfasEOfX0MSp2p2jLIWDcMwhiVnQ==
X-Received: by 2002:a19:5411:: with SMTP id i17-v6mr19571988lfb.137.1521825705347;
        Fri, 23 Mar 2018 10:21:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/27] object-store: free alt_odb_list
Date:   Fri, 23 Mar 2018 18:20:58 +0100
Message-Id: <20180323172121.17725-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Free the memory and reset alt_odb_{list, tail} to NULL.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/object.c b/object.c
index 6ddd61242c..581347b535 100644
--- a/object.c
+++ b/object.c
@@ -454,8 +454,30 @@ struct raw_object_store *raw_object_store_new(void)
 	memset(o, 0, sizeof(*o));
 	return o;
 }
+
+static void free_alt_odb(struct alternate_object_database *alt)
+{
+	strbuf_release(&alt->scratch);
+	oid_array_clear(&alt->loose_objects_cache);
+	free(alt);
+}
+
+static void free_alt_odbs(struct raw_object_store *o)
+{
+	while (o->alt_odb_list) {
+		struct alternate_object_database *next;
+
+		next = o->alt_odb_list->next;
+		free_alt_odb(o->alt_odb_list);
+		o->alt_odb_list = next;
+	}
+}
+
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	FREE_AND_NULL(o->objectdir);
 	FREE_AND_NULL(o->alternate_db);
+
+	free_alt_odbs(o);
+	o->alt_odb_tail = NULL;
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

