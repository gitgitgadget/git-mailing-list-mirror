Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD621F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeGQMjK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 08:39:10 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41584 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbeGQMjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:10 -0400
Received: by mail-wr1-f51.google.com with SMTP id j5-v6so995616wrr.8
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=o79kwiUUwDri31ZvmJuOaIn+APGMBiLQ8Buv2gRITos=;
        b=ctKwG9aWlZQVUIUFgcGYYbOrqybL1t2WXfxWo6dssKT+PshaQqLjJCcp4Dln+SIp2e
         sdiP08hj5IZCglT2nZDauUA1bDuSywoLg7VjPT2U2P+9VwO9TE1ZKVc3EMdw93Z94zpJ
         68J6aGsj8pMtMIgeafrCxGu/iOX849BQCB3ia+/5uJmhAg0AAjK2nX0wP0ZGb2nhWU3V
         Wotw1e3jPiEPnfBHkWECmt27losPh/WbSP6x/PApUPs2tj7bPWls4gd2kFMZdznoQimT
         AVpof9RPFpGcOWFWSwN2yaMm5RQaEsjxNuv5OzfrHJY2gtu34LHr0Vwg9mqDqbVRvN27
         HBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=o79kwiUUwDri31ZvmJuOaIn+APGMBiLQ8Buv2gRITos=;
        b=Lczd/BTUU2afZZJK0TGydkdaRW4PU6unqwAvgFZj4q5qmVFEGkauRzos6OQwjn7SBA
         ZHN63Ug+0vwJVeEXwXLLvib+rAICUaYyLqOWzx2l2bdCzN4W+lhv3NT+sSJPFDK+6xrd
         dzOQI52GEC1jc1TEZrqEYbbHnUTUjV2GihKpOvu2eL26YiYAc7fWr4yxPb5zp0IB9rFx
         LVPhqYVCiEW0V8jCOob+Dr/n/MSHEhHcaJgiS6RJlUxfi8p/bLAKvIoDkC2iQb0UG6Am
         Pk4Z0yzEJHyYZp5UUkiOHrSuwpW3D3WDhyC3G3/1hYJx1AxWLLZ6aiaw8NB6Dhy/3lUY
         kAig==
X-Gm-Message-State: AOUpUlEea6QU/wyBya0ysp7tUdCGsYDGUuAeq3pjOYVA4iEXg3iSIbYz
        ySFs5PyjfHaXQh1PJ31NLvnr/w==
X-Google-Smtp-Source: AAOMgpev9IyJtxNAIoEDQOudcPRRg4Jqu0+E1+1ev6sHvcZPeHfHsIXVPJkP6z8K1G/6l7H9WYL5OA==
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr1220074wrt.265.1531829208445;
        Tue, 17 Jul 2018 05:06:48 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id d4-v6sm542099wrp.51.2018.07.17.05.06.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 05:06:47 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 3/6] refs.c: Teach `read_ref_at()` to accept `GET_OID_GENTLY` flag
Date:   Tue, 17 Jul 2018 15:06:33 +0300
Message-Id: <c62fecd41db87b22d3605029685eb0281d67fc96.1531778417.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.184.ga79db55c2.dirty
In-Reply-To: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces a way to call `read_ref_at()` without
exiting on failure.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index 0eb379f93..4a470158e 100644
--- a/refs.c
+++ b/refs.c
@@ -932,6 +932,8 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
+		if (flags & GET_OID_GENTLY)
+			return -1;
 		if (flags & GET_OID_QUIETLY)
 			exit(128);
 		else
-- 
2.18.0.rc2.184.ga79db55c2.dirty

