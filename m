Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292BE20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934320AbdBQOUh (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:37 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36294 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934383AbdBQOUf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:35 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so4205055pfo.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMnCb91jExWBIeGpNaPNoP7YKhdwsoNlzpavqQeFimk=;
        b=WWzSyuqSwg302rN/ew2nazte3qUBA2DhT4XU7zJtgBxgunGV98QIV4X6Q5wkeXtk0l
         SYDPVCeWo708kg5YSi0tXQ0IcRnhiXLExuxW5ui1+vwKmfhtxWmlZyJn5oO1mhJ3vptr
         SVTqTFphZYbJMsM865JMyP2iMHxlaFZQGrTrmBGxQGRuJxdaoYECKILzrfDrpLzFxmYX
         Hmg9xDtxUtFdIkGOxuhJQz40Sl0DYKyH7k1cqPoD1AhPiFT4rKhegj2BbjdrSQld5jMR
         MJlXF6BAF4G3G8iaCEgNxkzNF84No/wapS0rMuvtPA4EklM0Va8l3bpH+f/VRl0VARCs
         Sg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMnCb91jExWBIeGpNaPNoP7YKhdwsoNlzpavqQeFimk=;
        b=Sz4PojDyM7GQizCodBBoG6k9ImsAOgVNFanugBaNi4I0XLvsdPV2ygmWFjyAnob8AG
         EEkERk0VatQEM2PzkzK/Y9lisNWyxtzSoKp8CvCJDfBYvXjOK+L58MgtmK60hWXjeyzH
         zUKQkoDbOmkRJsL7lGrhIB1DWAwhdcnt08wCG/AMvshJKCZvc+7hzL72WsccdPTqWGEE
         lFl0KrpPvbrOujrGUTwAdS9WP6aqF8Dh1gxqBXIl2xwilBcs6E9FIU1ZoZwgF0UOUtVJ
         b02y2I6L29wyAZDqUuj+svjWSnIgAx+9sWonay8qElEfwg6st5gRAfCoO1G6840zqPlo
         NCqw==
X-Gm-Message-State: AMke39mWvoH48BFkLJxnUKd/qu0UYL1sh8bGwSF4R+Xl08kXH/wFvbYY16MbRVGUdHwOZg==
X-Received: by 10.99.56.28 with SMTP id f28mr3793508pga.167.1487341234572;
        Fri, 17 Feb 2017 06:20:34 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d68sm20038584pfj.92.2017.02.17.06.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/15] refs: add refs_for_each_reflog[_ent]()
Date:   Fri, 17 Feb 2017 21:19:05 +0700
Message-Id: <20170217141908.18012-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 19 ++++++++++++++-----
 refs.h |  3 +++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index ce165c0ea..622c6b669 100644
--- a/refs.c
+++ b/refs.c
@@ -1592,9 +1592,8 @@ int verify_refname_available(const char *refname,
 	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	struct ref_store *refs = get_main_ref_store();
 	struct ref_iterator *iter;
 
 	iter = refs->be->reflog_iterator_begin(refs);
@@ -1602,6 +1601,11 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
 
+int for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	return refs_for_each_reflog(get_main_ref_store(), fn, cb_data);
+}
+
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 				void *cb_data)
 {
@@ -1611,12 +1615,17 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
 						     fn, cb_data);
 }
 
+int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
+			     each_reflog_ent_fn fn, void *cb_data)
+{
+	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
+}
+
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
 			void *cb_data)
 {
-	struct ref_store *refs = get_main_ref_store();
-
-	return refs->be->for_each_reflog_ent(refs, refname, fn, cb_data);
+	return refs_for_each_reflog_ent(get_main_ref_store(),
+					refname, fn, cb_data);
 }
 
 int reflog_exists(const char *refname)
diff --git a/refs.h b/refs.h
index 6665e5c57..5c1b99596 100644
--- a/refs.h
+++ b/refs.h
@@ -572,5 +572,8 @@ int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_reflog(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
+			     each_reflog_ent_fn fn, void *cb_data);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

