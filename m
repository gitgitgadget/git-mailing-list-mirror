Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605451F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeJBVmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:42:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39766 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBVmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:42:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so1824767plp.6
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rdM8CsWrGFbyF/WMo7PncykA222x6fhLBIpxan5tuxE=;
        b=EZZ84iEJ/Mm427h1TLWzxrOeHaBbLHNfAEXTfCafMu0bcmnFzoyRRPuLZPmiPAEHDm
         OtTh+UgDxHXyIbq3L5vnQTUjSgk1QwXXu8vZgdnkvmuEV7xRsrKLMQW1ouJFMTQ/865b
         41Qh7krQm2ENTXNE8vQPlG5witBW1lSrwN2IV4V0uhTEagOD5euDM31Vk/W864uA00tc
         QnpAmthUuT5R7zEYJkfcwc3FKDmcUufPksD6SvfExw60Tpt2DNE7dTH2d6d95YEsa0iq
         uPlor3K6gS54ouJWJ54tPyBoIS+kjHOtdNSIosFUmrV7Lr6j90GedImmqyfwEbM5kd5D
         rYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rdM8CsWrGFbyF/WMo7PncykA222x6fhLBIpxan5tuxE=;
        b=UCxPXgZAHxa3EsgbWhadhapEa3KKFJB5o6Dj62h6mWI4CWohkfxrL+ypia8mtUf/hk
         NXauDSXtimtl5lVVV9LalzEClXOOcSvrRwXb2/tKKlQmhZrXCOITpShn/JAPRT9J+hYh
         GwYwRJVTUbL6yTzPP34mFh9qRN4YbLJK8xMvQaVJInO6beVOqRaXRS3dO9rxDC457gDV
         G6oklLi2l2Qs7v6FbUjPVYyBq9kkLBWLoQ1GMycsW52LURLZdHoq8cqzjySDZeE+rgnb
         dpYYigJj28k5Zo7m9cjgXoXhxHsWSBlQtomzHFbPVMpKIKGPUM58/s1PU9X5j+dtXCUH
         AHjQ==
X-Gm-Message-State: ABuFfoio/ozgjI4ZqC81zZHPClb/MtKWm6qC02d8Ygv0sA2lelUW0pTf
        OO9wcr+WlDOHr81q5F4hKSUNoQFX
X-Google-Smtp-Source: ACcGV604oMxWHgjEJiBRiSioOlC9Gu5dol7Aex2wlbo1vZwo43+WHO/uwQre/Ft/ozYiRXbh5jg/Sw==
X-Received: by 2002:a62:d046:: with SMTP id p67-v6mr16939625pfg.147.1538492326038;
        Tue, 02 Oct 2018 07:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l3-v6sm21265435pff.8.2018.10.02.07.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:58:45 -0700 (PDT)
Date:   Tue, 02 Oct 2018 07:58:45 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Oct 2018 14:58:40 GMT
Message-Id: <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.42.git.gitgitgadget@gmail.com>
References: <pull.42.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] commit-graph: clean up leaked memory during write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method in commit-graph.c leaks some lits
and strings during execution. In addition, a list of strings is
leaked in write_commit_graph_reachable(). Clean these up so our
memory checking is cleaner.

Running 'valgrind --leak-check=full git commit-graph write
--reachable' demonstrates these leaks and how they are fixed after
this change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2a24eb8b5a..7226bd6b58 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -698,6 +698,8 @@ void write_commit_graph_reachable(const char *obj_dir, int append,
 	string_list_init(&list, 1);
 	for_each_ref(add_ref_to_list, &list);
 	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
+
+	string_list_clear(&list, 0);
 }
 
 void write_commit_graph(const char *obj_dir,
@@ -846,9 +848,11 @@ void write_commit_graph(const char *obj_dir,
 	compute_generation_numbers(&commits, report_progress);
 
 	graph_name = get_commit_graph_filename(obj_dir);
-	if (safe_create_leading_directories(graph_name))
+	if (safe_create_leading_directories(graph_name)) {
+		UNLEAK(graph_name);
 		die_errno(_("unable to create leading directories of %s"),
 			  graph_name);
+	}
 
 	hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
@@ -893,6 +897,8 @@ void write_commit_graph(const char *obj_dir,
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
+	free(graph_name);
+	free(commits.list);
 	free(oids.list);
 	oids.alloc = 0;
 	oids.nr = 0;
-- 
gitgitgadget

