Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C26C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 15:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5F020578
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 15:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s29rHtut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCJPbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:31:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41691 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJPbC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 11:31:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14so2783815wrt.8
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPC9Agr5H1n3rv1cty3TQKSIAl2fpEma5ZNdIskFcao=;
        b=s29rHtut8ovmVO/36YZR5PdAXRQsbMMb5qDkrN48sLIBl+ZGoFYuRKtAmtADz7aAUi
         z16PPrI0GFgNj79Oyi80JanyuHggfyXc5x6Ye6wcKjidW4h9sF7ZKE60K4hZVtgg5QAk
         XappU+rX5CQvVf4Hd0iVWgEd1pLZ96Cr3rKgL1t1JOEx0KFrLbkonx/PifJaeiZh3qcU
         IhiI3c7sooOZ+mnd+QkWMqU0pWfyLvfmvY8tUeo7cPYOe/ihe7/gzf+gkG1ypnVslS6G
         E9KqbXGGdcRjKTvHgovZMNXafE4FVtNlBmSYefab+615KpgC6QdW4TISlHMhsOXQRdcz
         DNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPC9Agr5H1n3rv1cty3TQKSIAl2fpEma5ZNdIskFcao=;
        b=ShCPNtLe0cJdVURCLOv3oofzbNOgSneLc3I5IvsjMiEau1CUwMHhJPGjpVL+2K5Fvt
         w+aFDW6eJ+bXtHb8mDai+rjnvWbLqp3W3gIQEEfI+8Q1KWgF0mMa12BuXn32V4wytowk
         uB0kReMJYFsibYi1Jtdso/J+B6kwiNXYHbSZmfoAVNOfAzO0EtexGslfWpFmBRQxQB2/
         sjj16BE7N+PdGa0S4elQ5hU3RxSvAILKzQGTZSP0lDymYfZPQ83xagNMNru3IOuMI4bT
         A4zUan4E/YtfaEItmT7ftQQ9xN2t9m0Zzpf3ht1EVY0f411afkAFUKGFn/67LMDK5fiu
         NqMw==
X-Gm-Message-State: ANhLgQ3QCA5UZUVXzO6ry7qmpm+ytqPWPOuKe03O56R336oxJNc9VYTv
        aERJNLh8cd/yzRd8M880krI=
X-Google-Smtp-Source: ADFU+vs2WEdVauvH1w9t9JnyIE4ZcQBQKnmp9jnkwLCJZzpyiRydvwo34IRkoXYAOhYJCUs6ihh3PQ==
X-Received: by 2002:adf:fa09:: with SMTP id m9mr27587018wrr.113.1583854260565;
        Tue, 10 Mar 2020 08:31:00 -0700 (PDT)
Received: from localhost.localdomain (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id h15sm10668wrw.97.2020.03.10.08.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2020 08:30:59 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] commit-slab: clarify slabname##_peek()'s return value
Date:   Tue, 10 Mar 2020 16:30:49 +0100
Message-Id: <20200310153049.3482-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0.366.gb2d359bb99
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since 862e730ec1 (commit-slab: introduce slabname##_peek()
function, 2015-05-14) the slabname##_peek() function is documented as:

  This function is similar to indegree_at(), but it will return NULL
  until a call to indegree_at() was made for the commit.

This, however, is usually not the case.  If indegree_at() allocates
memory, then it will do so not only for the single commit it got as
parameter, but it will allocate a whole new, ~512kB slab.  Later on,
if any other commit's 'index' field happens to point into an already
allocated slab, then indegree_peek() for such a commit will return a
valid non-NULL pointer, pointing to a zero-initialized location in the
slab, even if no indegree_at() call has been made for that commit yet.

Update slabname##_peek()'s documentation to clarify this.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-slab.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/commit-slab.h b/commit-slab.h
index 69bf0c807c..05b3f2804e 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -24,7 +24,12 @@
  * - int *indegree_peek(struct indegree *, struct commit *);
  *
  *   This function is similar to indegree_at(), but it will return NULL
- *   until a call to indegree_at() was made for the commit.
+ *   if the location to store the data associated with the given commit
+ *   has not been allocated yet.
+ *   Note that the location to store the data might have already been
+ *   allocated even if no indegree_at() call has been made for that commit
+ *   yet; in this case this function returns a pointer to a
+ *   zero-initialized location.
  *
  * - void init_indegree(struct indegree *);
  *   void init_indegree_with_stride(struct indegree *, int);
-- 
2.26.0.rc0.366.gb2d359bb99

