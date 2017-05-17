Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D2A2023D
	for <e@80x24.org>; Wed, 17 May 2017 00:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdEQAu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 20:50:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33199 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdEQAu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 20:50:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so11320966pfe.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xiCpD/7pJC5z0Q66e2q1rR3K6Qp93dAdeLkrE5W7FiY=;
        b=JRku2doPsOqpvKSKOOt5WZLIbWH0TSjq/33+XJAarf8V/3fMl6UCvPpIVyfVZkFxL3
         5nE32PjqvqUcfyjbTfj12xMWRmQCbUibPomqTP/PuaodF6ntDJoekHyhlu9+PujamcLi
         ZnLKyUjkvn6U6yNbqgUOCo0OIujCMJUPDW1ZjAjG3e/r2KPpW4cvfssFDQ8qMCtZFfUB
         VwRLkbvsoRlTTV3ofg7mdogCrN+i+Y843CIOjUkWfS37l3+YR3cro4PLrBz99V8efPUO
         h12HIqAF0KArB3Yh5zn1IsPXNy+2MenK/8EOo/Air5vHGcIQFn/7oa61Kfd0F1H+qzTT
         O9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xiCpD/7pJC5z0Q66e2q1rR3K6Qp93dAdeLkrE5W7FiY=;
        b=qqfZ0clVebI3fLNQ59czhiQ0N51Kov1NN9Yyh5gfYH334WwRhPpPjxaHj9kIqGOmDN
         JvWvLd9aTqSz90gP+MrMJkkxmJKECSwkdX2eEEyeO8Cjh5zRXixMi2i4AWja860anXFk
         /mLTw/s1U5BAE4loIadBYtXegLfRJ+C5dhQYFcj/q2k52uYFUyAudCnKcSkyKyrvfIol
         8V13KfDyr9Yl86ABGIN5CKPa2hDiOJPUGIij76ZbasAc6Dl6/gO2aVF3Ddpn0XlQVlSE
         lxbGRPTR4WMKGZnuvGVD38GZm2C+UpUMltNKAl3+7rrHSqD0qJ+yHxTVIvmsSLqXYm82
         DeDw==
X-Gm-Message-State: AODbwcAlgNL4AGSKBvPxo82Qu3NMXLi9jYRnYHEdyJ88lqbtM4llPJWd
        rUbseLqMejwgew==
X-Received: by 10.99.55.88 with SMTP id g24mr819838pgn.176.1494982255652;
        Tue, 16 May 2017 17:50:55 -0700 (PDT)
Received: from ligo.sfo1.mozilla.com (corp-nat.fw1.untrust.sfo1.mozilla.net. [63.245.222.198])
        by smtp.gmail.com with ESMTPSA id g27sm372699pfg.63.2017.05.16.17.50.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 17:50:55 -0700 (PDT)
From:   manish.earth@gmail.com
X-Google-Original-From: manishearth@gmail.com
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Manish Goregaokar <manishearth@gmail.com>
Subject: [PATCH 2/2] reachable: Add HEADs of all worktrees to reachability analysis
Date:   Tue, 16 May 2017 17:50:41 -0700
Message-Id: <20170517005041.46310-2-manishearth@gmail.com>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20170517005041.46310-1-manishearth@gmail.com>
References: <20170517002825.GR27400@aiede.svl.corp.google.com>
 <20170517005041.46310-1-manishearth@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishearth@gmail.com>

* reachable.c:
  mark_reachable_objects: Include other worktrees

Signed-off-by: Manish Goregaokar <manishearth@gmail.com>
---
 reachable.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/reachable.c b/reachable.c
index d0199ca..439708e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -178,6 +178,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	/* detached HEAD is not included in the list above */
 	head_ref(add_one_ref, revs);
 
+	/* worktrees are not included in either */
+	for_each_worktree_ref(add_one_ref, revs);
+
 	/* Add all reflog info */
 	if (mark_reflog)
 		add_reflogs_to_pending(revs, 0);
-- 
2.10.1

