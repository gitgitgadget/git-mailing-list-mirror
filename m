Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24E920248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfDPJfC (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:35:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45070 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJfA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:35:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so10032560plb.12
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2mv49Rcq/CDDyOmGqn8mULKECAHZZNGiCtIArDsvgHk=;
        b=F6+4T2oKDEEm79Q3UTJ2uRtYvhcwd0vpPAoWA1TbAe4gioBiIx/5fozI+AK3meOgcl
         om/WRbsVfDTYrH0t1X39BXWeyFYiOajoAEDJClSf0zmtdF/XxN/FhdjQ4Vpnj0L26K36
         Xuz8my0P33kFllP/LvAitOa37dhvMQtepMeT0LxsMez/ODW8d9kV96ogdgZDVT+Gu3sK
         ziuc2yBcFvunP8AqaweWoeHxB0tWudHn7vukSBarTr8EU9f69DYXhS/9ajeqU81IgFO/
         tf3xEFkM7rWiikOGHjabXR7clVnAgre8lMK3y4j9sEp5YWXKktKYyZwqeJjiGyrsNeqz
         T2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2mv49Rcq/CDDyOmGqn8mULKECAHZZNGiCtIArDsvgHk=;
        b=Srav/zvG7zG3k5fBi8aW8ZpU6ilVva1tcclbIXh1S2zw/SzyuywLdYtsu7GWAU19Yl
         vSF/Z6u2D7tFLe3961d07kB07Df98xUzclMO1eCIqgRiWA25Ne807X9QqXAtTJpShRYS
         HZFzFskfSyD+HiVclpUi3a7H5fNbxF/BtBDOK1yyXR9xJi/v7mp83eiVsbJxoprKhD/d
         FCl9lOOQeAaQDR6faPMpSCmTN8HqGy5lH40BivVLrD9BYCooXN/rSgO8SQRJPdD7s9lb
         fz8Bvdf4mC4XuqzFtNwK2Rrj+1ELlFwN/qbrJqETINCjibNYwwZZIhu241wpe04eobu7
         lelA==
X-Gm-Message-State: APjAAAX7D/H7UsexIvhmMPexEq3OpmJs00BJv7GH2NLSEIjosHqzrzjF
        tSCjnCMp4NWumChWxHjIcfOUJwlU
X-Google-Smtp-Source: APXvYqy90WnnuWAXQgJDqI4dVXSohCntRJwWV4BvbwPGIbK9DZPU+a1FJiIWshka7kndfzmKIjiZkw==
X-Received: by 2002:a17:902:2a03:: with SMTP id i3mr81608233plb.229.1555407299330;
        Tue, 16 Apr 2019 02:34:59 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id n82sm84901273pfi.63.2019.04.16.02.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:34:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:34:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 05/34] refs.c: add refs_shorten_unambiguous_ref()
Date:   Tue, 16 Apr 2019 16:33:12 +0700
Message-Id: <20190416093341.17079-6-pclouds@gmail.com>
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
 refs.c | 11 +++++++++--
 refs.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index b869f32d8b..3dde824aab 100644
--- a/refs.c
+++ b/refs.c
@@ -1169,7 +1169,8 @@ int update_ref(const char *msg, const char *refname,
 			       old_oid, flags, onerr);
 }
 
-char *shorten_unambiguous_ref(const char *refname, int strict)
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict)
 {
 	int i;
 	static char **scanf_fmts;
@@ -1247,7 +1248,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			strbuf_reset(&resolved_buf);
 			strbuf_addf(&resolved_buf, rule,
 				    short_name_len, short_name);
-			if (ref_exists(resolved_buf.buf))
+			if (refs_ref_exists(refs, resolved_buf.buf))
 				break;
 		}
 
@@ -1266,6 +1267,12 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	return xstrdup(refname);
 }
 
+char *shorten_unambiguous_ref(const char *refname, int strict)
+{
+	return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+					    refname, strict);
+}
+
 static struct string_list *hide_refs;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
diff --git a/refs.h b/refs.h
index 308fa1f03b..5627570241 100644
--- a/refs.h
+++ b/refs.h
@@ -462,6 +462,8 @@ int check_refname_format(const char *refname, int flags);
 
 const char *prettify_refname(const char *refname);
 
+char *refs_shorten_unambiguous_ref(struct ref_store *refs,
+				   const char *refname, int strict);
 char *shorten_unambiguous_ref(const char *refname, int strict);
 
 /** rename ref, return 0 on success **/
-- 
2.21.0.682.g30d2204636

