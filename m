Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F9320136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934450AbdBQOTp (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:19:45 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36087 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOTm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:19:42 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so4203633pfo.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLdHtS73ZFxnvXEm7ImURFsbhaYHMVlhGGRJUWApfgY=;
        b=KeF7e3413xIRLoj2fQNX4dAIaHmkfns4W3G6AyLsYb/FqMscdKgEtpU/t96nahk0Io
         GPjbcsfYm/3GLcelntNNhJLHZ4bw29RbntdyAJWQwYUwWCINsn+CyuIVvrrIvcGWr1LB
         p7enwFtpObcGlYn6ksEERO0reoKjptagZJIpSLKfk0ildixM+nbsZ17zI49/jlDIxfU0
         IxXlYlIjcTkBlrFDzuPgoBk+lxLgGe5DuOz6URm8k5SC/ZoW60hSMrVpBmYyMrZmEGl2
         9wQyAY9ym12x7Ykh1VcQHAnnSTDEim3HTycEa70BrS9+9nXAypt/NaaacDY6kazNlZ6m
         HUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLdHtS73ZFxnvXEm7ImURFsbhaYHMVlhGGRJUWApfgY=;
        b=UuSW4iy9V1I1tj7LQo4Zfp7FtgWon3PcnHaAK0z8FjbTFzgn/J/4SsnhfTrbmaum/4
         LFkv0iCcdcvzQhFGppGQv7s1S7shKBydMUh8jY8hKYenJdo26ErgrjhYdulUl201PTFR
         7d2ygC3dk+FPfUEYBE727/owHlOumhN54oyj9VIfqktyB66WGOQ6ww+0eBeXKqPvOdcM
         7ShYgBNMBjCewPGcnps5UCT+MBL/hys2xG4d9OocCrIiO/y8PMH5/JauPQqmLSr20bXH
         wAdUmCEfMe5SBb46klxMAkbLb33tbsQkCAal72kfay9Wn2Ct3ExqgCLOR0M/bxRFIWZw
         sN4g==
X-Gm-Message-State: AMke39ku9jrnKMt4fUhg2kXd6saHYJH39yL3GSp1FwOw0+9AKwvrfs0DTFWx6x07wKQWqw==
X-Received: by 10.98.215.70 with SMTP id v6mr9629502pfl.141.1487341177172;
        Fri, 17 Feb 2017 06:19:37 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 75sm20043924pfp.80.2017.02.17.06.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:19:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/15] revision.c: refactor add_index_objects_to_pending()
Date:   Fri, 17 Feb 2017 21:18:55 +0700
Message-Id: <20170217141908.18012-3-pclouds@gmail.com>
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

The core code is factored out and take 'struct index_state *' instead so
that we can reuse it to add objects from index files other than .git/index
in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec37..ece868a25 100644
--- a/revision.c
+++ b/revision.c
@@ -1263,13 +1263,13 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 
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
@@ -1282,13 +1282,19 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
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

