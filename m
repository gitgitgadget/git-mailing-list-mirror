Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9F81F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934535AbeFYOf4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:56 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:41767 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbeFYOfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:36 -0400
Received: by mail-qt0-f179.google.com with SMTP id y20-v6so12110371qto.8
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMJ7fiQD0SHQM1EHq5zoRv0f8dYME72gHGRBGvHzeUw=;
        b=ENBD/pLC47u+yMipQlIC8/9OPK8p4dHMChVT4GrjN9KT9A4fUFPL8FetRfabzqCA8L
         8+BaTJlmy5wgBvOAyOI3QAVFzDhWiV1wRSGF+/qrE9DtlwIZubtydztvVCUC2b96XY99
         pIyl34SIx456PY9lHF6X7x3PHrlSZSbqTXin5Q8dYqGTal52fmhG3Ltgik4Anj7pipzM
         w2cm9L5szeiP1ZCSXukgohbowEGIJ5X49Vyg1UZozV87fjeUlVhmSOv7fT7jlxu0FrHq
         RZf7AH/qLs3h7bFthT8gAwt3PfzAFWjFn+SJ5mskeI8+i/pmaqdh0bn7F8MIyvnKCWGz
         QTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMJ7fiQD0SHQM1EHq5zoRv0f8dYME72gHGRBGvHzeUw=;
        b=Hd8IBdluXTpdR8hdZSSKkYheGGmPEzAnBshaEYm2Gn45xirD4HUhivf85NlKRfkZev
         m5XowFRveNM0e+k1YH6cY5cJK3psle2UrTsbB/rR7tZgmiy1TpvhZRiedgEKavbqCT9u
         fFQmrdEs7eJ/SAXO3hZtofJvcHCAUou6+JLv85ARnNkbK9my0cUHM6a0D0qJnouuOW9R
         cAOnplw7jCKJ3XaN1Zb5kdhRmwn3MXXQAnNAIGwtx6R1vVvbBWDWSQ1Gr6IiI+xkz20O
         qAVXuxKNGMd/+1AvUORbNXhK9wi9TpWzGmzn5qYnIPIaBndEj5FMDEysSqj3IvrGdGtx
         frRQ==
X-Gm-Message-State: APt69E1iSXJMdaed/FW7iNOz3envGezBS8swyPaweZO1InoBE6eVy9yv
        x6fHbyKemTokDuCBQkERYIjZCLnu
X-Google-Smtp-Source: ADUXVKKU4DUz5q6r4p0JpCqxECFINNTDgxbCFuTW+qnlaat1kJc1E1VUn74Im+W3FImAD2JgxvcvTw==
X-Received: by 2002:aed:25ac:: with SMTP id x41-v6mr11114986qtc.286.1529937335495;
        Mon, 25 Jun 2018 07:35:35 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:34 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 21/24] midx: use midx in approximate_object_count
Date:   Mon, 25 Jun 2018 10:34:31 -0400
Message-Id: <20180625143434.89044-22-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 20b743da91..e72e8a685d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -863,11 +863,14 @@ unsigned long approximate_object_count(void)
 {
 	if (!the_repository->objects->approximate_object_count_valid) {
 		unsigned long count;
+		struct multi_pack_index *m;
 		struct packed_git *p;
 
 		prepare_packed_git(the_repository);
 		count = 0;
-		for (p = the_repository->objects->packed_git; p; p = p->next) {
+		for (m = get_multi_pack_index(the_repository); m; m = m->next)
+			count += m->num_objects;
+		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
-- 
2.18.0.24.g1b579a2ee9

