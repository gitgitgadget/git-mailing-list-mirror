Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C533C38A29
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE0021D93
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1N0/87E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgDRUSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUSx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 16:18:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33023C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:18:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so4709760lfq.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84hnXTm9qNUGMODcL1hCAyLQDgXtASTHAvb2L4PIv4c=;
        b=q1N0/87ExXXGsSl2zOd8oUfURLX2VZd1Z598rg3+agRhu8mu6f0TLT8joa0UJvyKNS
         UfhlGLhXcVipDWoJqfsYCuIizFXjypS6eNZatvaOCir2BDHvOZYDpqqFlU9wn9C7okD8
         yis79yd/5Lss7U3SHoOZspZxJ0ZS4Mn4GSoMleWTmOdIGTsUnFE8uSrJduxvng/d1ybN
         e8BAmqcfTV446JLpp+TGRjVGtpIsc6ADrAfP5RbaA1pbcW024pvgWdA5yEvOYi/zLROf
         mZCeP6KwHy7R+YoELGvMGpQKTnbXbpfAFbRR6Jd9aAZjH3zZpaEFr1wg4YWbAjWl8o3y
         NLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84hnXTm9qNUGMODcL1hCAyLQDgXtASTHAvb2L4PIv4c=;
        b=jQnjPfu1XdDi6cCi+68ml6IXg2eC4d2Xz/XhD3hhN1yZ38i08kL+Cxoe1e1aDXtuIc
         7FwauwTkz4xz5dqI8+8lV9VRLxRvMd7UXN5Pn2HOJ6vm5o6+lpn4QCAo1OTe6dgjbcuI
         gEAgSqV6Y1z9iEer7m+j+GEKG4MlKz1d6h9/e84btadnS3iptZlda92aAX5dC9SzQfvF
         JQI/dIcTQrhwrgwzZdp4SPptIyno+uhpaJtonBYfSSGDhKUskzo+tAMhhUq5K/lsZkfE
         2xwcn3Nco6ZxouzyQNyxIW07La1po8EBlQT5E9ru4PLQJhRl2BwyRe20hRZxghZb6L+Z
         Xe4w==
X-Gm-Message-State: AGi0PuYele1yvXDb34+usBYGUTFZNBN0+MVoumeVhNeJnehmphqWvwlt
        rHQ20MKztS/Wd6i6Lcnq5/hyNBbJ
X-Google-Smtp-Source: APiQypIpEkrgLEMklVmgvKU6Ees6f5d4E9fAlxNxQUc6dGcrjlu0EldJy50fxi8uOSF4axLDAYTqpQ==
X-Received: by 2002:a19:1c3:: with SMTP id 186mr5728684lfb.191.1587241131477;
        Sat, 18 Apr 2020 13:18:51 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm218713ljj.72.2020.04.18.13.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:18:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 1/6] am: use `strbuf_attach()` correctly
Date:   Sat, 18 Apr 2020 22:18:24 +0200
Message-Id: <fa514ce7dad31b8aba0eb693eef9648d509b5334.1587240635.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com> <cover.1587240635.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among other parameters, `strbuf_attach()` takes a length and an amount
of allocated memory. In strbuf.h, it is documented that the latter "must
be larger than the string length, because the string you pass is
supposed to be a NUL-terminated string".

In builtin/am.c, we simply pass in the length of the string twice.

My first assumption was that we'd end up with `alloc == len` and that,
e.g., a subsequent `strbuf_avail(sb)` would evaluate `sb->alloc
- sb->len - 1`, resulting in a huge return value, which could be quite
bad. But luckily, we end up in `strbuf_grow()` where we reallocate a
larger buffer, after which we reinstate a '\0' and everything is fine.

One might ask if the function was documented incorrectly in dd613e6b87
("Strbuf documentation: document most functions", 2008-06-04), but on
the other hand, one really has to wonder whether it's actually useful to
be able to pass in `alloc == len` only to end up performing the
allocation, copying and freeing which this function very much looks like
it would keep us from having to do.

Pass in a value one greater than the length for the `alloc` parameter.
The string has been allocated correctly using the strbuf machinery in
`read_commit_msg()` and we really do have an extra byte at the end with
a NUL. This means both that the buffer is as large as we claim it to be
and that the addition is safe.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index e3dfd93c25..e6a9fe8111 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1101,7 +1101,7 @@ static void am_append_signoff(struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
+	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len + 1);
 	append_signoff(&sb, 0, 0);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
-- 
2.26.1

