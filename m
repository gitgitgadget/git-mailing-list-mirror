Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E71C20248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfDPJfo (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33030 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDPJfo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so10138316pfo.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91YIinu0nc/kMb5fTELwmvN6/lj9eQjDENEHxFqRkk0=;
        b=VKMzGuJHPwrxQxy49Rb7+LjZ3eMYdf6mY9hqUjINZvHFLVM6KDS+zieLkFET1Hgp1Y
         dHQdyZAf8lETUyJD4nh15bjQIKVcTyscD6hMur/dbNwk3LZRo4na/mIXkUwJjT6U2Nty
         AsEvDUMdFe7QrlQ653gHb7hVc+9lT8qaP1mbVdCW3HvvpS0tgKLMYKvlUppnjRB4gdg5
         zgMy8J0iV2Yzi0e/PJkcpqj4hXVDYsfv3otQGrQcAFMc+Fxojf57Emvjf/lhF7GX6D46
         hgLqIt5p9wCt6FBSP5IPghrF7k3E2fB+0rxZetoLsX+MdegzFzMthVwTQ0lYilsqJks5
         NoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91YIinu0nc/kMb5fTELwmvN6/lj9eQjDENEHxFqRkk0=;
        b=jzlNS4VQtWGcu7gk4gyKihfs5iJ2dGMMLhI8aP9YIpjoQnspmf1nf/y1vSam4IAWCq
         qmviyNVV1DOZSsM780izGvEIqKue/1jN+fcKtDEmmRz9Svy19KVZRPLPmRyFjnT8VQTr
         X+aNc7dF/prscQutg7aRa8J2T2zhpU7UczEnktR5Xj4/smhFLhacoJAJfetph9hsFWXO
         clPInNDa0RdvQoJdncE4ddaQ45n7nHbVjFvPhgiodbAmsl8al3JCrxia3rYODCX/xf9T
         6lH/73Kr00/M5HMEdVCzCeoagCougIq8hafmZsd+ksEX7v1bcAeYi1TAXgCDxiB8ghag
         8MMg==
X-Gm-Message-State: APjAAAW58BeSPvwkXuQnPF4NrvW8+WFB4XDdHqdVrHIhV1IVetOE3m/5
        +45zMca51j+EC0EAJNtrsWE=
X-Google-Smtp-Source: APXvYqxUgkXxKqNB7Vyorh9FW/ZnfpljsVrRO6mXdCQ0n8gpyMO/vC0vz62HZ2RKTHQlvYxvByOwUg==
X-Received: by 2002:a63:3fc3:: with SMTP id m186mr77813904pga.151.1555407343729;
        Tue, 16 Apr 2019 02:35:43 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id a12sm60299995pgq.21.2019.04.16.02.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:35:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:35:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 13/34] sha1-name.c: remove the_repo from sort_ambiguous()
Date:   Tue, 16 Apr 2019 16:33:20 +0700
Message-Id: <20190416093341.17079-14-pclouds@gmail.com>
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
 sha1-name.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 15a1107998..7558ce51a3 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -383,10 +383,11 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
-	int a_type = oid_object_info(the_repository, a, NULL);
-	int b_type = oid_object_info(the_repository, b, NULL);
+	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
+	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
 	int b_type_sort;
 
@@ -411,6 +412,14 @@ static int sort_ambiguous(const void *a, const void *b)
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
+static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
+{
+	/* mutex will be needed if this code is to be made thread safe */
+	sort_ambiguous_repo = r;
+	QSORT(a->oid, a->nr, sort_ambiguous);
+	sort_ambiguous_repo = NULL;
+}
+
 static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
@@ -458,7 +467,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		QSORT(collect.oid, collect.nr, sort_ambiguous);
+		sort_ambiguous_oid_array(the_repository, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
-- 
2.21.0.682.g30d2204636

