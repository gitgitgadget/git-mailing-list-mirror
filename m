Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F31820323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdCRKMh (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:12:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36846 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdCRKM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:12:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so7475423pfr.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZOLkoswUf8UV6zBQ9BKyX1LPdt1QlisLvTzko6vXjc8=;
        b=hkW7Wz10RE1ITImPAKIFk0mlI7nI5xg1U0KhKOW5lDcld2IyTIiZlZgckI9jgJxvSo
         KqWw6zroJ9XrOPjumEwt7cWnOT9R8WTK1Ay3lCkTa3SueXSBGJxPFoXdcW2PewDlS1TP
         Wka/FJCD0V/hG/jGCdHJmj1QI8eAkl0gFWH6j4VrPhpW1As0rwQUqmYK5ic1Ugl7gfVG
         CibsHVk+Gb0IJesUKQ6v0gX65lX9Bgv9Gpy84aitCpW4jqRUu7feD9MAThHxm4S6lLH9
         wJA9DkPadkKVZA+1XXeOFQGQlccr33qd3LS7Ymvc6esM1ZRc2iT7V3wfH5H51leie0jF
         DA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZOLkoswUf8UV6zBQ9BKyX1LPdt1QlisLvTzko6vXjc8=;
        b=j6P3mj78ITicNIXIwIe/PjaDdmrWkjtMpT0IDR5a5j5BGWwwqJt5SetRgKTyN1+Jdt
         g1/X2XsJ+upsZAm5beDMXwTEY0Egg+B4vJeyA7VP5dW/z4SnX43FNxdIQI9NhD3CsmId
         niSNncz7TFB3tutUro57n4Tc5GVCBpO6XpZRfM0WMmUqx4Mf7M1N4xEQepU/DwJhhYCd
         KNXruDUKz4DYGzYfYRMblrIA5UxNViGj3FOtw5uDB3DVXonpLTZcSGEM0LOs1hlsUzFe
         Z40I1ShTA6tJjSwFGiRK80Dp9XgH4rcFR6tIrcje5AKw4gQ2kWunAmiEVDS75gwTHkD/
         MW8g==
X-Gm-Message-State: AFeK/H1bfiozxoDHLbjuBscQNK67pTT9LT32W9o6pqIb01bDOSoTZvbtL4bw+e1lZ1gEAQ==
X-Received: by 10.84.238.22 with SMTP id u22mr12362716plk.137.1489831943950;
        Sat, 18 Mar 2017 03:12:23 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id h9sm21798012pfd.103.2017.03.18.03.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/12] refs.c: refactor get_submodule_ref_store(), share common free block
Date:   Sat, 18 Mar 2017 17:11:45 +0700
Message-Id: <20170318101153.6901-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 refs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 6695140cfe..8912798c1d 100644
--- a/refs.c
+++ b/refs.c
@@ -1571,25 +1571,23 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 	refs = lookup_submodule_ref_store(submodule);
 	if (refs)
-		return refs;
+		goto done;
 
 	strbuf_addstr(&submodule_sb, submodule);
 	ret = is_nonbare_repository_dir(&submodule_sb);
-	strbuf_release(&submodule_sb);
 	if (!ret)
-		return NULL;
+		goto done;
 
 	ret = submodule_to_gitdir(&submodule_sb, submodule);
-	if (ret) {
-		strbuf_release(&submodule_sb);
-		return NULL;
-	}
+	if (ret)
+		goto done;
 
 	/* pretend that add_submodule_odb() has been called */
 	refs = ref_store_init(submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_submodule_ref_store(refs, submodule);
 
+done:
 	strbuf_release(&submodule_sb);
 	return refs;
 }
-- 
2.11.0.157.gd943d85

