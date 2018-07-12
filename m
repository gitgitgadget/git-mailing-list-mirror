Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2D41F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeGLTvm (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:42 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35237 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732395AbeGLTvl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:41 -0400
Received: by mail-qk0-f195.google.com with SMTP id u21-v6so16068582qku.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7QrX80NkK7qSrQnM10xlJagNOI523/RXVGm2aeTrajE=;
        b=vAY/YisCjOFEz+mkEyIPGGnWBIbtJRCM1jFgoqkGfesyhZREYnFo9CmdUpb0Qhrwfs
         d0LzSs1wCBrydMPj+RPhEGjxyBDd2ps1mKamwCxLmacYpFRJNzW9VnjLNbC9viSMdnFi
         G3JPRvKc8q716ZAILc043n7cPVBCiv6yhl8Q2tT5cUmjSnZXcjmP8ATjqUspSJZh+JOf
         kCbxxjBYBKloBqPqcPU7N8W3Xa8VwvRtJHCl3XzMfRxuES7gVPhhGFyCZlv8jZn9ISqb
         /DJbpOMoV1v/x5Xc3xbU/EWOU+E8d3UpJfvn1bdRT0cAaiec+lO2YT6viABPMEySMCts
         XIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7QrX80NkK7qSrQnM10xlJagNOI523/RXVGm2aeTrajE=;
        b=O4dJC7tmkFw+V/spEB10G4ITUrP6BqVZmCcBxamnS6Mv7NLmOqu4A/DIasGPVlIQb/
         UQ2XX58zdlTgAh2S0RPnWLqLFl4S/aVXW3wOD7eFd6xJXbj8W09LtxaxhuPyRtqtX+Az
         ThIONzxiw3FoSDGEyZKEgxonNYIiQZ8RT7bHBe0TP9VNlo6W2YJci8R7t6MUd5g3QRa/
         gCi+18DljbegZfYqhnT0CCbaWJO7SWxqYC1XgDQpOQ9shqo9L3arTuVPM6b9bMOxMait
         yzZaZ4p5iZyaykU6YvmsWwLi0x9doRJNgvjSgIVveZqhK+zTY9s4aWEeIUE08Po3MitH
         z+ZA==
X-Gm-Message-State: AOUpUlE/9v84xc6xZ21926ilWqmYS/TQAFh2RWZ2gu690qTNaXTpjovC
        A3R7Rviyks0+0ITc6MLNti7AxA7ySDs=
X-Google-Smtp-Source: AAOMgpfgS+jBSOGoHgUFbh35xLsw3OVz2FogMlLBfPFYtRPYP27Sd8xkVBSwcgmGm9TplsHCgG7cbQ==
X-Received: by 2002:a37:9e8f:: with SMTP id h137-v6mr2969976qke.58.1531424441651;
        Thu, 12 Jul 2018 12:40:41 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:41 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 20/23] midx: use midx in approximate_object_count
Date:   Thu, 12 Jul 2018 15:39:37 -0400
Message-Id: <20180712193940.21065-21-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
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

