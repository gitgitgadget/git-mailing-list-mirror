Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1FE1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030317AbeF2BXa (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:30 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:34580 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2BX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:28 -0400
Received: by mail-vk0-f74.google.com with SMTP id x67-v6so2815158vke.1
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=T5pQ2594ER4v6UszNa3BlrO5R4yeeUBD+H1jfytr+Ho=;
        b=XRfAryry80Mn/qhL+WcqNAfq4Q2unR6jpWJ1lKwpi6UdL2Fz9WboNx6lAP2VKpM9ih
         If7Hv/+SzpuuauO4esLYC+TV4Px7nJEdisbJ+/JBjEORZ0QHTrlndDhbvYVBz7fO43Qu
         kqQOAoYl0Ih9RzFOvKVECrxGcw/bivi3AssfxfqNvbFC5bXtJrufEEuvUX4LZizpAuqq
         GLGPY2d1pWmoLzsgdowq4O20+dzZUS6kKSAlfSeKJBbYZKEawMiSjEJvpcrxxg0gomX5
         vINKhUykvCwfSetbZ3Mzpoa1zKtVDvhJKSJ/doqGrI1kkXCN/mGeOSLI6RWEudY9sm7o
         k3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=T5pQ2594ER4v6UszNa3BlrO5R4yeeUBD+H1jfytr+Ho=;
        b=cPZY8+FTRyaGSf5fYLKpsIk47VQc3Dfr0+XzvBAsowI1n8VyN3kSd9f7FttRvjZZeC
         rsp8as/iAmaOP5Ijf6yyUoYmfC5vKTeCA4Wn6JYN+4p2UB3CydfREKUNrUHrCISxyBD7
         ng8DJSJeFyRUJqccmtgjD5h8llCwqXp5MLu6SjWKQi8ICwAWR8i8i+HagA/O1M4JdH5S
         jfm+KLvnfD3ZiF6uxeYKuC1Uar/0Yo2A8qTfSerV5c/ICqZAx91PBjMehH7hwyOn70UY
         QF3dTVuIQQC46cGVxmM3iANbzteykUMIsimzIMwFOwGEISFvk7g4kuj9Rr/5sPWqnvyP
         AzcA==
X-Gm-Message-State: APt69E1vU4DWL6AHVRS5aO0q6kGSS+jgoX1bT2/pWWBKALoSQG1SetX9
        /4zFOX791OgVftQDJ7xwUmVPpokoZUuPYnlq5EQEzBgZ8j5q8KUZoUGYOdVRwVWmDw3vUk8c7lI
        +ZspR0wHvEyALJMkTJvY+OiXYQOLksy+/m/XsdYoMSKAWrw95mdBNiA6F6zoa
X-Google-Smtp-Source: AAOMgpco98w1MGzWB2KjldFlnSYAwbUHFy4V5VaNrxwrfdLTeGGaPfoXaWfoDnSZaqWjCllz3gB/7TKM2XgU
MIME-Version: 1.0
X-Received: by 2002:a9f:3586:: with SMTP id t6-v6mr5197492uad.34.1530235407947;
 Thu, 28 Jun 2018 18:23:27 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:14 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-25-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 24/32] commit-slabs: remove realloc counter outside of slab struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The realloc counter is declared outside the struct for the given slabname,
which makes it harder for a follow up patch to move the declaration of the
struct around as then the counter variable would need special treatment.

As the reallocation counter is currently unused we can just remove it.
If we ever need to count the reallocations again, we can reintroduce
the counter as part of 'struct slabname' in commit-slab-decl.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-slab-impl.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 87a9cadfcca..ac1e6d409ad 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -11,8 +11,6 @@
 
 #define implement_commit_slab(slabname, elemtype, scope)		\
 									\
-static int stat_ ##slabname## realloc;					\
-									\
 scope void init_ ##slabname## _with_stride(struct slabname *s,		\
 						   unsigned stride)	\
 {									\
@@ -54,7 +52,6 @@ scope elemtype *slabname## _at_peek(struct slabname *s,			\
 		if (!add_if_missing)					\
 			return NULL;					\
 		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
-		stat_ ##slabname## realloc++;				\
 		for (i = s->slab_count; i <= nth_slab; i++)		\
 			s->slab[i] = NULL;				\
 		s->slab_count = nth_slab + 1;				\
-- 
2.18.0.399.gad0ab374a1-goog

