Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A331D20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbdHWMho (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:37:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37454 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMhn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:37:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id r62so1345172pfj.4
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kir9vUduUB8Hm6rN5L5av3xA7jIr7oXMJKipj5cuiGQ=;
        b=rNQOt2veDML3l9c2lsO/a0hZXMZF2EFeylk3Umo+8goVWCa7JjCh2CC8MDChpyRaN+
         DiFeZaI+O9iqzf4df6Mi927jopYD/Tp140JUXz+ENhF/GX8fuZhdChIwRRp4vFM5GzC5
         hnT8awiDKn5PFC88blPezMWWLO70omCA7SJXVbM+PlEWzT/LK9p+hzOMnQGDQlDiEiP6
         eB2nJATA19XVNj6CPoQ1hs7RlEi08OPt/gSUNKRLcputAqz7w7mr22m/ijQGhOTqiqDR
         tq1aGNs4wFysMzbngFzko90TtB+LuwEeULwpoyPWvRl81DDz4FZFHLnO9QwT0WnyW4DZ
         7/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kir9vUduUB8Hm6rN5L5av3xA7jIr7oXMJKipj5cuiGQ=;
        b=Jdj+1eSRS73UCOay3ND3iM1D4OWXFXBvqDKVO4XZg3h3tdS1RPv+oxqlnpFfrFrjpO
         iusYHKivl+8jcz/BAJggVAFx2zqZUgOoIsitGDDtUxfRppMezNkGFjkmxoZYS1+7DAKt
         /4/NIWXeGgH/XDtr7sZ/0ORG7jmZCTHF3OLsUG9FFtItdpY8/spqqV6jX0fT5HQeC9J0
         PYVaV/nNtah1ry2kTM38wjTyr+SbW85IYAnWW5RqRhxZSj3nZiAX7k/rvfXjuDs9Ono0
         d6bEAoXyNSiU4Yg2BOqiDufTFHnTCfHHuw5JJ9Qlgl9GYE/j+32eaCYGcKsnERbZr500
         LBFw==
X-Gm-Message-State: AHYfb5jExgajRjkm5gbukZoMRCe/v6va5XB+voICh103wrbyerILEy+j
        DsC5OBFv4mPreiKH
X-Received: by 10.99.147.8 with SMTP id b8mr2577781pge.384.1503491862284;
        Wed, 23 Aug 2017 05:37:42 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id s11sm2792609pgr.53.2017.08.23.05.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:37:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 03/16] revision.c: refactor add_index_objects_to_pending()
Date:   Wed, 23 Aug 2017 19:36:51 +0700
Message-Id: <20170823123704.16518-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core code is factored out and take 'struct index_state *' instead so
that we can reuse it to add objects from index files other than .git/index
in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index aa3b946a8d..6c46ad6c8a 100644
--- a/revision.c
+++ b/revision.c
@@ -1262,13 +1262,13 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 
 }
 
-void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
+static void do_add_index_objects_to_pending(struct rev_info *revs,
+					    struct index_state *istate)
 {
 	int i;
 
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 		struct blob *blob;
 
 		if (S_ISGITLINK(ce->ce_mode))
@@ -1281,13 +1281,19 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 					     ce->ce_mode, ce->name);
 	}
 
-	if (active_cache_tree) {
+	if (istate->cache_tree) {
 		struct strbuf path = STRBUF_INIT;
-		add_cache_tree(active_cache_tree, revs, &path);
+		add_cache_tree(istate->cache_tree, revs, &path);
 		strbuf_release(&path);
 	}
 }
 
+void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
+{
+	read_cache();
+	do_add_index_objects_to_pending(revs, &the_index);
+}
+
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 			    int exclude_parent)
 {
-- 
2.11.0.157.gd943d85

