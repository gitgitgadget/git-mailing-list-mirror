Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19E4F20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDFLfn (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34074 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLfm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so4491445plt.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNHEfU5Es+iTRROnoumQYR2DGfc6CnyeuJUutLTjvtc=;
        b=TBAemQTMAntX+vhQ5XCYYrG/Ss6E7kap9s3iY8vYyvobUOpVd8kgmotppYLN818SsW
         h5/FhDWsn7D/NeZ5Hq6oA1f/tUquAanhjUNNU5KvXKQ6GnUdNRE+g3baCJM3ITg5BDNG
         b8rjFxk8NatoArMI78eCaGlGUpa1UwXz6T+AyVOruUMPaFaXCx4bV3vPBZ8r3EgncRCH
         Z2oKjWNzm/KYzIy47Z2SKy8OT7P1FmZQmlVfiM2pcpL/+AKCsk6cp+zfdyKlDdRuBDWp
         pdvjfxuwMjd8ciDLFSBBaLfyt3T6S3o1MCdzhj/it1UxnaoXecib1gtRXCs+OJFb4kIf
         ZhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNHEfU5Es+iTRROnoumQYR2DGfc6CnyeuJUutLTjvtc=;
        b=ofVrMRBc7KvPQFNZNMX41ECHXdAph4UoZfunNZ+ajx4Eyuo6gIg80ySwsuUNYNu89S
         wN4mWVSxNmDGWOs8hGdVAQr9DFKkYKMx4vDVAJ/AkwuwyL5MGkZMVuBjJ5FCEF7yT9oo
         KUovPnUxeLcY6p1Rqnvi9dAhsnl9JRWC9Sec+NOou3tpI7e5GTcb/pwFZ4A3Bsy8JwqN
         iEruoPpYUjJwK5oxFqkdZB2ekNWx/7nYq8U3ObEdD95Spp/1hRGQf7Uckf+ibs58diZj
         ZfYDrYnWFinHoV0WewZOlDDnHPa+8CoN+82g3Z8tb+sjrH6HGh0SohHE0hAOT4M9CLxp
         7CdA==
X-Gm-Message-State: APjAAAVlLQQKBEs8f63hwtjZQid6gw7L3k4FgQxbWamXYb/mdKPwZDmR
        OvrqQBxgxRmxuw41+d/MWPNj/KF0
X-Google-Smtp-Source: APXvYqwmlf3GBMDLKsYzz7ox0kH+PghSGo9a3Vza5nOAswOTKoBhm2APFtYIJp3XPykw57J0yGCnCA==
X-Received: by 2002:a17:902:20eb:: with SMTP id v40mr18143680plg.20.1554550541959;
        Sat, 06 Apr 2019 04:35:41 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id f63sm34770584pfc.180.2019.04.06.04.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 05/33] refs.c: add refs_shorten_unambiguous_ref()
Date:   Sat,  6 Apr 2019 18:34:25 +0700
Message-Id: <20190406113453.5149-6-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

