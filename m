Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA7720248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDFLfh (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46752 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLfh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so4466208pll.13
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SILCV0xL0rMhdc8DRhCUAEY33mnaNDt1h5vVG3Tug14=;
        b=A6oHA7YpfdCRe8OKG7NpcSkQeWcrsYBUCVxdz5eULDgFDiqUREeecLwFnq+gymF5QL
         sDkS8+frIR8DHZThiUlHRr+R5n0fXjBs5vPJOE6Qir6JVtczdvAJZLRIpvpDhDlY9lzs
         1V5bKRaSwrGnTTWYIfcsmg96+Sgbnump1Ietdfb7WHyCS53AydUzsHS85paAXok5IaMA
         9hg7DQaOA+utGVPygLQ2/q0odOzESnl9rDVmA0V+w9mOEaNfw+gc29xHplkyyBu2hpHy
         EEAGzpMdGOg4n29n6m/SOxdbDoYd/l3glR49YNxuAdLjcG4ysK8GocMauzXKvLw8MVyk
         6pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SILCV0xL0rMhdc8DRhCUAEY33mnaNDt1h5vVG3Tug14=;
        b=cw2h856nX7y1F8lff1csc4tdLkFglFiAxI1p6k0Y9NSoB5Xogib9E6hgsfccZWnM1c
         HI74HLEanVTwnYDCTTdo5fHyzAEuucxV5RIMTxM+hjzZmHdz6v/Cgq92GRpA+wxza4e/
         Qd2ySVpdT5lBdd2kaARHeO8cekL6CsSY+fSiGUP0fHJZqmoW488eVgVZrUqLRYf4FaJU
         4u6+tTushYYOZgITvla6jLSCpt7jmOe50g0CxLXA9k3GoL7Wr5Zdnwj5mL9HZAgcGXpb
         PKnpScDiN0adgRzf2qqeLJBMqIlRWA95uXxooOEUKoOcd5ZoHaZj1eJuXv/kAM1+mse2
         GAow==
X-Gm-Message-State: APjAAAXlvMSm9jq5RIRcU4RvrPm478SIJCFZJefNsP+M31GKKtBEquJc
        e8YmLmLwPXXWbRHMYgg1ej8=
X-Google-Smtp-Source: APXvYqyMncNPmVN7rczOLNHE2qYZWigNHSUZ5+GHEI2fB1GHBLHwghYr3aW/IULT2D5+3dUT/75hKA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr18518762pld.42.1554550536567;
        Sat, 06 Apr 2019 04:35:36 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id o67sm46921088pga.55.2019.04.06.04.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 04/33] refs.c: add refs_ref_exists()
Date:   Sat,  6 Apr 2019 18:34:24 +0700
Message-Id: <20190406113453.5149-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 142888a40a..b869f32d8b 100644
--- a/refs.c
+++ b/refs.c
@@ -241,9 +241,14 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
+static int refs_ref_exists(struct ref_store *refs, const char *refname)
+{
+	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+}
+
 int ref_exists(const char *refname)
 {
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL, NULL);
+	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
 static int match_ref_pattern(const char *refname,
-- 
2.21.0.479.g47ac719cd3

