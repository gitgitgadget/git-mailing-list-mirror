Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A031F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeGFAyS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:18 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46462 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbeGFAyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:54:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so8702219qtm.13
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7QrX80NkK7qSrQnM10xlJagNOI523/RXVGm2aeTrajE=;
        b=gkVziuakXaMybMVZM+kAbc/RD7WqMDl0ZFqNBks9RtcCipETS94edqOu5qcnd7b+Ew
         QSTnsr++3nrKnNy5G0h9lCTmA0dWqo6q/tBcn4LihDEBa7diAyNHk9MVOwVafcUHVsk9
         tyTxwtW87GAZOCuvVVQgxm5ooOTMo3Qn99i7EiD/hGYij9wuPdMrXJ1XN9zb73hpXwVq
         v5c4yUiFz5HtQIyxwAApk13vyPxM+UDUyFxe4f1moIqRWSRW8l/OX/CMZ9VFJ8ojers3
         s8eChsp98xoPy0EpdAZMYV+Cs+6dBPOYKAsQIisTp+t7QHK2ajmId0lY2HWUNM5E32A0
         yR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7QrX80NkK7qSrQnM10xlJagNOI523/RXVGm2aeTrajE=;
        b=fequoiataxuCso/1Yy7EMGQH/c5GNsdxYZXvxpSK1INnEJ5oE8Ob0D2kmQBKjFUHrD
         Fs2bCCjPtjbtFaP97kr2/RO9UkXzS78k6dGL7rZ8oS+MWP2En5N2VOWdJ5avi+g1uVKI
         SRWhc7JiJzMvsU2pu5mJkO60wFzYewkM2K7v+Vp7DFxKybBY9XdxEAarhHUwzhcnr1L/
         b0ppK4iNa55Dnun/4D43cACq15Ss4KIWn78t+8779Jk40L+FyRLPk+gd0rOKgdWqaork
         H4e7lCPpdB/qHckbbVCRXfYoIVAfXCkd+E8A3Vlbcoigzw6Ouq8m47AE32tjFnbUf0AR
         ktpQ==
X-Gm-Message-State: APt69E2ZBbLtVuG04Nkk2KlV0NB/ocqhZrZDiK21EYDk5Y9FUdycx5D7
        NoCYC/yHT7IQ7KFU021QPFhUrcuO
X-Google-Smtp-Source: AAOMgpe/TqCPMPJP6A86UtdYzalIkGyMvnM9V/Jz4LPF/oCJ5ryjpLnyZzxLeoEMgzBU8G3zfUKSaA==
X-Received: by 2002:a0c:e792:: with SMTP id x18-v6mr7093482qvn.3.1530838447096;
        Thu, 05 Jul 2018 17:54:07 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:54:06 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 21/24] midx: use midx in approximate_object_count
Date:   Thu,  5 Jul 2018 20:53:18 -0400
Message-Id: <20180706005321.124643-22-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/packfile.c b/packfile.c
index c0eb5ac885..97e7812b6b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -861,10 +861,13 @@ unsigned long approximate_object_count(void)
 {
 	if (!the_repository->objects->approximate_object_count_valid) {
 		unsigned long count;
+		struct multi_pack_index *m;
 		struct packed_git *p;
 
 		prepare_packed_git(the_repository);
 		count = 0;
+		for (m = get_multi_pack_index(the_repository); m; m = m->next)
+			count += m->num_objects;
 		for (p = the_repository->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
-- 
2.18.0.118.gd4f65b8d14

