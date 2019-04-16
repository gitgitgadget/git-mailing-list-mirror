Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAAC20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfDPJfu (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39535 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id a96so10049892pla.6
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V37+YZWHxLbHM8g82jNygWNvWMjgGALD0kSTQcyltVU=;
        b=ppi+XuLEk7o4nqOZmacWoCkKeZtegkCEhtNwvpMwNWMFjhu0xYYWyq/jDBSBkMg03Q
         KsCr14cFjtyvdfAdmOEc39xdhieY5y4EWRNwfEo0HeeCUWUEyPNCSC7/tEBQu+a8+RY3
         l7ljwwmJIpA7+nQ++hVccpV7VHG8D6p2ZXq7k9j5U4lwJitna6LH3sNw9EuHPOkf84UA
         DbrCYspCyGU3YgX3S+iqAbXlQiw+PI3L4y5wnJtHQIUR40fJ3hbC2FGn6ZGGJsD4I5Ta
         I/v0cHV4jXsC96MC6utZyyrgt4Ob45IBSFuK2VXFmXEWvsKFoxQRotuEW2NG4wtHcKmz
         LNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V37+YZWHxLbHM8g82jNygWNvWMjgGALD0kSTQcyltVU=;
        b=E2vqHRnTRNBPtIVpsilzgraNQp5XIxHkB7jIQwWhB8Q9p0I2qBJFad7Fqc2n853MHu
         SmTMpAAkjW+K8oabjL9/DwFXGXKPobHTmlR/hj3iqfvWJQYLTEVDFNiOwHaRjmEPUJKw
         f7h2wQISDYRhFSCWVQ/Kh5mew6UJvsT+D5ziRU3AzxtFWo9iSDtkaRJny1tURoFHr2vt
         4K0hYIg69Exm8KNuR7X9g7rSMCQRGO4FqJtYZTZhhBcePRFfeFE5xwinHUdnda6sLtim
         uU+Jj9Ob2QQ6vr0LEnfKTdl0fVOiwxZzuknMUFN0lCuFSbCMh/qnXGrZtBuYdnlyV3HS
         Nygw==
X-Gm-Message-State: APjAAAVqeqEYEzFxwI1tFsz1wuEUHAaV71Kon7dpq1PDoQD8fIehoz+o
        IBamZywDmNASbbY/HxuEzQo=
X-Google-Smtp-Source: APXvYqwWUR1S5mk85ltf4/c0wbd1dwRIOpDajjS66C6h5I9sHbS2HM6yQgj9PEk8+Kl4ozTarpXS6g==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67mr59425087plb.158.1555407349237;
        Tue, 16 Apr 2019 02:35:49 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id p66sm76310138pfb.4.2019.04.16.02.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 14/34] sha1-name.c: remove the_repo from find_abbrev_len_packed()
Date:   Tue, 16 Apr 2019 16:33:21 +0700
Message-Id: <20190416093341.17079-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 7558ce51a3..b9381aaba6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -514,6 +514,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	struct repository *repo;
 	const struct object_id *oid;
 };
 
@@ -619,9 +620,9 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next)
+	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
 		find_abbrev_len_for_midx(m, mad);
-	for (p = get_packed_git(the_repository); p; p = p->next)
+	for (p = get_packed_git(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
@@ -658,6 +659,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == hexsz || !len)
 		return hexsz;
 
+	mad.repo = the_repository;
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
-- 
2.21.0.682.g30d2204636

