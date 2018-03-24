Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A521F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCXGen (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41416 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbeCXGeS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id o102-v6so21247570lfg.8
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dICtk/PcIUaKKcHWs7QUmPFQTgcQcj4zRMKHcu7NsfU=;
        b=WAWfp1oCm5Bstn67bEyfWNPWLSN1yq9F/i0YSob555OJPo0i1+m4QJznTWBStiytOb
         Z1qat6VZOC2pC93VvpmB8Cg4M79P8sGmSRLM4ojttquh60WHmB1AuD4znE49tW/gneLD
         mExf19J+AqXVf1ue+GoTs1KpTKuWtkM7+RQ8PUbnmjjel0aV2I8mPKounmDrWTB2i4cm
         w2ymPzpwIU6n20Y4iUQJaVb1I6F84jj8/VgWfr6N3xeQt/Qko3lZcJikFuqhRl2LsRI0
         Q6qfaBoBfIoF4lzMpjnQ1I09WrxIhSF0z+S6jGRdhgZndwV6o1Odo7u2pKt7rMhU+pmX
         h4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dICtk/PcIUaKKcHWs7QUmPFQTgcQcj4zRMKHcu7NsfU=;
        b=ODXmxu4CPZuNeAxMQOG0/u2p4p4M93gKb2ZbTEhCEvkmpf80WU1Dwkau4VRtRvPgFe
         Ko23js8yfDjZHFkoe3vPifkBHSg4CBNMrwDtSyIlCQ1iIBqcLBMeleatlMZgcA+C/r+V
         qWPJwo/idPAzBJsHAKHjF35pAxpf731ShhXX2HmHqc4kMqIe9AOdZ2o9zbx8H7tROJSU
         nIsF3ipkH6wn8FHVBaLve5fWTfGnDsZD97BnFkGZXftMcRhgUsRn0qoTXZNdccWZP43K
         TOrwLPk6O0x+Qx491ttcn9Jia5pv2q/uHBEfdZ8VQbhUvPNSiymAkSNTCST+oVj426fF
         bT3Q==
X-Gm-Message-State: AElRT7EklSr7GQ0veRxjW9zsyEJN88w223ci7tj9qvAwVtffE65TINVj
        OdigRbLDSq/KaXQqHcvL6hQ=
X-Google-Smtp-Source: AIpwx480ux2ssc1nyJLyUfTpMYgb0WjlG2Vx6FhH+kjgGlrMni8vxczlYvycsFUOMLWcKuRK0XKj4A==
X-Received: by 2002:a19:c713:: with SMTP id x19-v6mr3479720lff.32.1521873257121;
        Fri, 23 Mar 2018 23:34:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 09/13] pack-objects: don't check size when the object is bad
Date:   Sat, 24 Mar 2018 07:33:49 +0100
Message-Id: <20180324063353.24722-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
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
index b3e19815f1..da010f7d19 100644
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
2.17.0.rc0.348.gd5a49e0b6f

