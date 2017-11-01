Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB80F202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 20:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755253AbdKAUfD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 16:35:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44604 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755173AbdKAUfC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 16:35:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id z55so3061171wrz.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8G+t8kx/pgVX1CmQMEwVCSNYzw5c+u0CQ80LGFXkHc=;
        b=d5qJVqce6kPkUCiGCDs0c+PwXYNjt5QxEQKDAgAPkO2GAC2GeabcI58AaDezsMRjgP
         fXklP9gx3ykkj5rWTz5XC7Y99Wr6GnPlkQtIFMds82AjnNJpOHv0sEsW4goIq61LMKzC
         svrZA9IDWbdHCT0/1iITJpoingtjxmIfEKDfVRcJ3SmkKhWUWLY7h8FS3LNOs+0uB3tg
         BfvY8YG+x9uG7ezoV4yIiXgCVtUFEuTzw+GlJIPeZRscJoLfDfxegAOaODlbxIN851OA
         pRz7GMxmmyQ6LO5E1px1FVOBDXhf811HFF8Z1y99gK5gXJAYw0sV+o4Uz0U31CL4jRgx
         TjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+8G+t8kx/pgVX1CmQMEwVCSNYzw5c+u0CQ80LGFXkHc=;
        b=joY+8pu2pJQaLfqxEUV45763204T2byISistGNUAVMGJGjbh8XAZ25ZtG2wMFHoME7
         hf05tLCBRHZ5ovAH9SUVUarROXrsin9RY5uXnBwt2xkshjH9SJWaAe629PeTAipWSExj
         bXr8QUcQEmGp2lVWZtoSChZ6rQoS+HqbG8bopG0iS5/HNtdctjeXhSZj+mIv9sQqtfhv
         exkGk/ZylnU6L++GKIMWu3sLkOeeXeWkd39tJ2kCAHK8zwbgbxkqB0kemx9v3Eh/4HWD
         m/G7U+EgPnbNtbYRcQUMQ9fhVLPBW720KC6h6Kzklw7DikszCHFQgk5RC9XPL+ClMer4
         q22A==
X-Gm-Message-State: AMCzsaWrMk4SDjOA/+z/ajhkONiTLeqa4cqJU1ROkW73+Py38yobPkOR
        0tVdjkIWFevDG2vtIU4s7Jie2Lx6syw=
X-Google-Smtp-Source: ABhQp+ROSuzbbGiGVro5g7filyWYWvabRbv5ieT3qWxGRFOaFuWgsDtA8KQjJ0YBab2jxLF335dWSA==
X-Received: by 10.223.159.81 with SMTP id f17mr810845wrg.4.1509568501191;
        Wed, 01 Nov 2017 13:35:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m8sm1312235wrg.55.2017.11.01.13.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 13:34:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/3] bisect: fix memory leak and document `find_bisection()`
Date:   Wed,  1 Nov 2017 21:34:37 +0100
Message-Id: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`find_bisection()` rebuilds the commit list it is given by reversing it
and skipping uninteresting commits. The uninteresting list entries are
leaked. Free them to fix the leak.

While we're here and understand what's going on, document the function.
In particular, make sure to document that the original list should not
be examined by the caller.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 bisect.c | 4 +++-
 bisect.h | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 96beeb5d1..f9de4f2e8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -380,8 +380,10 @@ struct commit_list *find_bisection(struct commit_list *list,
 		unsigned flags = p->item->object.flags;
 
 		next = p->next;
-		if (flags & UNINTERESTING)
+		if (flags & UNINTERESTING) {
+			free(p);
 			continue;
+		}
 		p->next = last;
 		last = p;
 		if (!(flags & TREESAME))
diff --git a/bisect.h b/bisect.h
index acd12ef80..cf135f16e 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,6 +1,13 @@
 #ifndef BISECT_H
 #define BISECT_H
 
+/*
+ * Find bisection. If something is found, `reaches` will be the number of
+ * commits that the best commit reaches. `all` will be the count of
+ * non-SAMETREE commits. If `find_all` is set, all non-SAMETREE commits are
+ * returned sorted, otherwise only a single best commit is returned. The
+ * original list will be left in an undefined state and should not be examined.
+ */
 extern struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all,
 					  int find_all);
-- 
2.15.0.415.gac1375d7e

