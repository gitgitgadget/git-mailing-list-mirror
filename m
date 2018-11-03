Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5D481F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeKCR7v (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43432 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeKCR7v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so3715707lja.10
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VLQ9JxryHxaM8p03XiMFucrsrJ5I0K2B3viP+y2dPqo=;
        b=EYzDJRLjxmpOBBnCWqT3gbFIiAM7Azt27vnfSAQC4Y1/32jqXkXs6knyD1CFZEzgGJ
         nq5Gf4Xgj6NGC8jNhhae61TAfUeUnworXz4P0HbGBH4triw/us/FTLf6RGaZw6a39VWF
         Gci9VNAtgAi/pb0shFGwQjFdBJp+ikGfJo4FcgksgFnf7XPZni2O4uoXUmf9Scmhz+iW
         684LFB9kqZY3qKUk42S+1z2mtt3jG52CDmx1yMa5oZSzhig1c2CAHIwewwSpW68sG1Yv
         tq2UG7YxD55jJkYRHK+/jH5/zAfP/MnUHmnBjQFMmszDzXwmMSPbsKOwrjStDO/xXJfX
         iZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLQ9JxryHxaM8p03XiMFucrsrJ5I0K2B3viP+y2dPqo=;
        b=bsGgmgQyNDTniMA/cFEJnP+RpBvD27UiMJMdQsWyVqA5ABppiWqu5fDjvCgQz8ad7o
         Yz1KSTIhVOXznbEQ+XciDXv1HdtAqmClr+zTRf8rRHboDpGEoow2MRhKHm3eGa07AZ/0
         lMQUPV2Y3aUdmgRB2BSFYdz2zlaRLtxAMMON+MD+rcLl2nGRv5JcVCiQWewC2fVlt9ka
         BZZjo8GjIamF1KeY8PTfa83Ja+Ly5+iMhSTvEa8vBmBD/aADK3jUFJ8VSkwLqIh+eO1/
         qy9ImRG70PlooBbrAunG9eHm84AICrgsG0N22yum1mtFS6hd9/wPypKAPA0aofCds773
         Yq/A==
X-Gm-Message-State: AGRZ1gJlqlhg2J50dO2L+QQ0QczHY6GQZwchgbLkJPIyTfFz8xBO+X6w
        uNDFvddgBxl8V9+WbgjLjp1MJNvp
X-Google-Smtp-Source: AJdET5f1ob89DoK7gGxcxZuyqndG+PSUu9MqMs0BB34Ix9A36NxJl5l8+O6zHUJsD75Ja23bpVmJVw==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr9493236ljg.150.1541234953327;
        Sat, 03 Nov 2018 01:49:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 10/14] pack-objects: remove #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:46 +0100
Message-Id: <20181103084850.9584-11-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 26 ++------------------------
 pack-objects.h         |  6 ------
 2 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b059b86aee..12edd6da16 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1953,8 +1953,6 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
-#ifndef NO_PTHREADS
-
 /* Protect access to object database */
 static pthread_mutex_t read_mutex;
 #define read_lock()		pthread_mutex_lock(&read_mutex)
@@ -1979,16 +1977,6 @@ static pthread_mutex_t progress_mutex;
  * ahead in the list because they can be stolen and would need
  * progress_mutex for protection.
  */
-#else
-
-#define read_lock()		(void)0
-#define read_unlock()		(void)0
-#define cache_lock()		(void)0
-#define cache_unlock()		(void)0
-#define progress_lock()		(void)0
-#define progress_unlock()	(void)0
-
-#endif
 
 /*
  * Return the size of the object without doing any delta
@@ -2347,8 +2335,6 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 	free(array);
 }
 
-#ifndef NO_PTHREADS
-
 static void try_to_free_from_threads(size_t size)
 {
 	read_lock();
@@ -2578,10 +2564,6 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	free(p);
 }
 
-#else
-#define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
-#endif
-
 static void add_tag_chain(const struct object_id *oid)
 {
 	struct tag *tag;
@@ -2734,12 +2716,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		if (delta_search_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    delta_search_threads);
-#ifdef NO_PTHREADS
-		if (delta_search_threads != 1) {
+		if (!HAVE_THREADS && delta_search_threads != 1) {
 			warning(_("no threads support, ignoring %s"), k);
 			delta_search_threads = 0;
 		}
-#endif
 		return 0;
 	}
 	if (!strcmp(k, "pack.indexversion")) {
@@ -3402,10 +3382,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
 
-#ifdef NO_PTHREADS
-	if (delta_search_threads != 1)
+	if (!HAVE_THREADS && delta_search_threads != 1)
 		warning(_("no threads support, ignoring --threads"));
-#endif
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
diff --git a/pack-objects.h b/pack-objects.h
index 2ca39cfcfe..3a42727c7d 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -145,9 +145,7 @@ struct packing_data {
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
 
-#ifndef NO_PTHREADS
 	pthread_mutex_t lock;
-#endif
 
 	/*
 	 * This list contains entries for bases which we know the other side
@@ -169,15 +167,11 @@ void prepare_packing_data(struct packing_data *pdata);
 
 static inline void packing_data_lock(struct packing_data *pdata)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&pdata->lock);
-#endif
 }
 static inline void packing_data_unlock(struct packing_data *pdata)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&pdata->lock);
-#endif
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.19.1.1005.gac84295441

