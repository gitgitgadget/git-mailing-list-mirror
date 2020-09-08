Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C7C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50884207DE
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hhpy1py7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbgIHTtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbgIHTsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:53 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD383C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:48:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y2so8083qvs.14
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QPqg6xo/A1IkEKrq0zVtesvZ6lQPk6hHuSHsAkiOGjI=;
        b=hhpy1py7pBg9oIbsW+QpW9dCLk2KOw3Vo0TMZMOlSQz7nairsgodAo+wuwGqqpQxfh
         15ArkXtAugMX65LCbJGP/nE2EHvdvH2YYT4bHCKyocDTZOsKoLXhUPCpzjDRpa6IzSVf
         2RcRnepndaXaFzF/bqhaQCIE0EJ51RIk1P26+Qm7lq4Zw0KONwzRiegxq0cEhZ/7V10H
         zoIXBUuT4eCAygL/R5D+QhQN+vBJA735bKoXF21FNqFNlBGxjYSJw5J7DqBJsdOa9mY4
         q7eu4sOeM++hRI3DCdl7W8203hgvlX1keYqvPi3KkqUEoPhGKNpf1txS3CGhFip5yFWw
         qMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QPqg6xo/A1IkEKrq0zVtesvZ6lQPk6hHuSHsAkiOGjI=;
        b=AEMlz0olSl/ZOxwKj7pH5qEquSWh/EDgj60BggVZILfuowJxt2uqGMc24JHZrKmLk6
         VfKAbl4ZRtEkrE6GBfq8xQEwP3KHUYuA1ToY0lUd0M9p2QdqEupmYRF/mmu9H0LNutX3
         uG8C858Rdrb1f/rnoTc1H2dbYokVg92sfBDy2wNs/1fPCCo/BdMYGN7S7A9b4OLb7d+4
         p3JE2/fosPJFjQzWQWXntMMBR3les4HPtVJR72v0wMrAUOALBiOpioJGywEtYjR8Jyt4
         rLvJbVEmDEdBoZY6AKMG7/SMQ75aPbPbUsLoZoOomyks6qbJg7lLsMefisyRuXX5xAq9
         K5Yg==
X-Gm-Message-State: AOAM531JOtAaxoYoHjQV3aNkenUrfD6CQJCS6vORXVZFPAgtUMIEB8S/
        6aRbR2Z7J+hS2JMi4TTjPv8/sgO5gzatupTj9SumyvHW5RTibBv7m0Y0YkCeL5/S9Mmyef0+0HJ
        VYJrBCF58tcYQU7TvDOn1VEeB3+RrhWA6I6dgpToEbbn4o0Nxpjg5+nW57oABgqyCmpooSTIpUI
        ZD
X-Google-Smtp-Source: ABdhPJxJb8WGX9WIT2oSVSzP1y6x4fs8GSZrTExzX9G/nQn+d3tDCs9QntHkVQl7w+9SZlbvyH0so4/Yat2QT3bpz/0Y
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:292:: with SMTP id
 l18mr695176qvv.3.1599594531828; Tue, 08 Sep 2020 12:48:51 -0700 (PDT)
Date:   Tue,  8 Sep 2020 12:48:34 -0700
In-Reply-To: <cover.1599594441.git.jonathantanmy@google.com>
Message-Id: <34b53f268fad32aca499f5f4b73ceedca693e9ef.1599594441.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com> <cover.1599594441.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 6/7] index-pack: make resolve_delta() assume base data
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will make the quantum of work smaller, necessitating
more locking. This commit allows resolve_delta() to be called outside
the lock.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 94d0f53b03..f69a50d46b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -927,7 +927,7 @@ static struct base_data *make_base(struct object_entry *obj,
 static struct base_data *resolve_delta(struct object_entry *delta_obj,
 				       struct base_data *base)
 {
-	void *base_data, *delta_data, *result_data;
+	void *delta_data, *result_data;
 	struct base_data *result;
 	unsigned long result_size;
 
@@ -942,8 +942,8 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		obj_stat[i].base_object_no = j;
 	}
 	delta_data = get_data_from_pack(delta_obj);
-	base_data = get_base_data(base);
-	result_data = patch_delta(base_data, base->size,
+	assert(base->data);
+	result_data = patch_delta(base->data, base->size,
 				  delta_data, delta_obj->size, &result_size);
 	free(delta_data);
 	if (!result_data)
@@ -1003,6 +1003,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 			    (uintmax_t)child->idx.offset,
 			    oid_to_hex(&base->obj->idx.oid));
 
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
@@ -1017,6 +1018,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 		assert(child->real_type == OBJ_OFS_DELTA);
 		child->real_type = base->obj->real_type;
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ofs_first == base->ofs_last)
 			free_base_data(base);
-- 
2.28.0.526.ge36021eeef-goog

