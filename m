Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957C01F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeKCR74 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40532 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCR7z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id n3-v6so2853461lfe.7
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ut5Bg3EmlKu6YigAMO4KRWJjmbiR4VAow+fxed/TxV0=;
        b=PkrfxrXcdlkfkemq/hM4otHAUQcleuy1ZcaCsNoe0t+69JF2f2vMiiFICEt20RpN+n
         mqU+nKWhgIgWmDgCzQb0o/hDha9ELpGhQOUQ/o14ECV/Ufk7CRkMs0emfLXsLCQnuACc
         nCoQjBIttbhvHBfgGu1j0i8qEDLAcVxwu9Bq5udRPqiQkfqJOZNDOuryDqAQf5Xt3RWa
         y6Mx+XDNL/sjoqruBfQTpn95288+KDX/eOzMYClNVetugPbr9uO7bWpLhfFCa6Q0xD8n
         8A3/khcLG0t4EjxdxVxQKj+WKSiWJWaInnHDNaAso9mpG/LhP3Zfxoo9eVwLnCWSCN1T
         OQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ut5Bg3EmlKu6YigAMO4KRWJjmbiR4VAow+fxed/TxV0=;
        b=arRWDnOzlNVe51e5DASF8GbrfliSVr5VlYjvzoy+E3Jzqs4nY1BqPl/WY8XUzGWTDT
         QEKEX3JElxf50JmYmlKJ0QyToQvMjewTAk8WeY2dUniodiFomiOE7cwEIrHB7glx/KbG
         PhMQ9ljmezGPXvSEwxHajriFR/lKrduXJgR8Z5DJ7cICasGge6Fh8loBji2fFlKEA+1z
         sb3PwlNuXdRqmadTtLEJuAWNCy7tL/AX7HTmQJhPfHR8LpglpZCOzZ5aHeG5/hETQGq6
         jAlBrmEL++5w+QZu8YQVKEzRLosKeGYSejmUFM150RVgYEbLAWjEQNevZJ65aFFaDQbL
         5qfQ==
X-Gm-Message-State: AGRZ1gJNR3XCFFT4ZzkynoEzVeVPOrVkybZ9YQ8nREekzfCrEmrbkucQ
        eNoO4NhUvLgm/fpsvOm4lNrDMxpa
X-Google-Smtp-Source: AJdET5fIDyTZZ3dajic88wF9koonLO2PRgPUvkywGuoQ3/VPvjJESqCIYo2CCWsu0K3w6sCB8ptVIw==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr9121568lfi.21.1541234958132;
        Sat, 03 Nov 2018 01:49:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 14/14] Clean up pthread_create() error handling
Date:   Sat,  3 Nov 2018 09:48:50 +0100
Message-Id: <20181103084850.9584-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally pthread_create() rarely fails. But with new pthreads wrapper,
pthread_create() will return ENOSYS on a system without thread support.

Threaded code _is_ protected by HAVE_THREADS and pthread_create()
should never run in the first place. But the situation could change in
the future and bugs may sneak in. Make sure that all pthread_create()
reports the error cause.

While at there, mark these strings for translation if they aren't.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 name-hash.c     | 16 ++++++++++------
 preload-index.c |  8 ++++++--
 run-command.c   |  2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index b3c9ac791d..623ca6923a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -494,6 +494,7 @@ static inline void lazy_update_dir_ref_counts(
 static void threaded_lazy_init_name_hash(
 	struct index_state *istate)
 {
+	int err;
 	int nr_each;
 	int k_start;
 	int t;
@@ -526,8 +527,9 @@ static void threaded_lazy_init_name_hash(
 		if (k_start > istate->cache_nr)
 			k_start = istate->cache_nr;
 		td_dir_t->k_end = k_start;
-		if (pthread_create(&td_dir_t->pthread, NULL, lazy_dir_thread_proc, td_dir_t))
-			die("unable to create lazy_dir_thread");
+		err = pthread_create(&td_dir_t->pthread, NULL, lazy_dir_thread_proc, td_dir_t);
+		if (err)
+			die(_("unable to create lazy_dir thread: %s"), strerror(err));
 	}
 	for (t = 0; t < lazy_nr_dir_threads; t++) {
 		struct lazy_dir_thread_data *td_dir_t = td_dir + t;
@@ -547,13 +549,15 @@ static void threaded_lazy_init_name_hash(
 	 */
 	td_name->istate = istate;
 	td_name->lazy_entries = lazy_entries;
-	if (pthread_create(&td_name->pthread, NULL, lazy_name_thread_proc, td_name))
-		die("unable to create lazy_name_thread");
+	err = pthread_create(&td_name->pthread, NULL, lazy_name_thread_proc, td_name);
+	if (err)
+		die(_("unable to create lazy_name thread: %s"), strerror(err));
 
 	lazy_update_dir_ref_counts(istate, lazy_entries);
 
-	if (pthread_join(td_name->pthread, NULL))
-		die("unable to join lazy_name_thread");
+	err = pthread_join(td_name->pthread, NULL);
+	if (err)
+		die(_("unable to join lazy_name thread: %s"), strerror(err));
 
 	cleanup_dir_mutex();
 
diff --git a/preload-index.c b/preload-index.c
index 0e24886aca..ddca1c216e 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -121,6 +121,8 @@ static void preload_index(struct index_state *index,
 
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
+		int err;
+
 		p->index = index;
 		if (pathspec)
 			copy_pathspec(&p->pathspec, pathspec);
@@ -129,8 +131,10 @@ static void preload_index(struct index_state *index,
 		if (pd.progress)
 			p->progress = &pd;
 		offset += work;
-		if (pthread_create(&p->pthread, NULL, preload_thread, p))
-			die("unable to create threaded lstat");
+		err = pthread_create(&p->pthread, NULL, preload_thread, p);
+
+		if (err)
+			die(_("unable to create threaded lstat: %s"), strerror(err));
 	}
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
diff --git a/run-command.c b/run-command.c
index 3c3b8814df..decf3239bd 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1213,7 +1213,7 @@ int start_async(struct async *async)
 	{
 		int err = pthread_create(&async->tid, NULL, run_thread, async);
 		if (err) {
-			error_errno("cannot create thread");
+			error(_("cannot create async thread: %s"), strerror(err));
 			goto error;
 		}
 	}
-- 
2.19.1.1005.gac84295441

