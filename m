Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7945F1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeDFXWO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41717 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDFXWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:12 -0400
Received: by mail-pl0-f67.google.com with SMTP id bj1-v6so1522542plb.8
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1ZkzZCvkcPgX4ux1LTfITZpqPTvE7vlal3GcZqAdlAw=;
        b=BRmoz746Tf301TlSdBBMQ5eiVkY5PQSkPJe9grCm+uYMc6zaCk8yL5TkVVPYD7EfWF
         UuqZNZpyEGyqR6kIWi2D5eDOI3M+78RiROpxkkpV1KBkuW7Ro6rt7u0eCNZ+QAaLJSH9
         XfLcoV95YMmN0WfmJytHBLcJj3BdhVBHLjd7SU2ePRyPWytxbk7EnL0jYtheJWoGE06s
         P9ynontOELSRkyL72RMDkhmnXSP8b2z7/luBdO6pmpm56+pAFN0Gp2gGEq/u71HBqRst
         p3o1rr9Eeio2oSQY0THW3jNnrG0jCpibiPT5QFXjvyIyvmwu0a9Xm4VG2f9TfUfA6iEY
         T3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ZkzZCvkcPgX4ux1LTfITZpqPTvE7vlal3GcZqAdlAw=;
        b=kPva6m1oouuJPlDBviwBGTiQ4kyeLHDm79Qg96XBC3OYuwdbtSjzrOf0ieyt7wNF/I
         IRc7YYyQoP/Ms34FjNVS66/IVVdx3QNavRAIOLV6+ROPsV9oW7SCi7A1dxejLxy2i8Ju
         jMXedjK7hS26ISaIG6Qk2eg3toffhxbFNq5XbP07+giGkEkorUupe22+rLVRLerwUwjb
         hSCmQbNnW5j2+Pbp+J/TMgBNWBDKgv3ZgU1lq9fpshkgCIBuBlARiUMDGZVRfHUiQtaa
         Iu8erY6dXnZGHBivImcVNddwQulntGC1WbbiL7xUxHCjcNZqwTxkGEuhW4iW8fPPtNgx
         XGCQ==
X-Gm-Message-State: AElRT7HXQkH8/YW2gdvQJap7A7eeckQ1dRto0R51wGNFxuDkZxJraazc
        wbp+SYiMlnv6c5jCT4foIQVimw==
X-Google-Smtp-Source: AIpwx49AwhTqA6fLULghll6RtQFqOHnX5QnzKT+xiYtwrOlU8U0/B67l+0Hc+eJtuy7+H1TTi/ZCyQ==
X-Received: by 2002:a17:902:52a4:: with SMTP id a33-v6mr22208031pli.371.1523056931375;
        Fri, 06 Apr 2018 16:22:11 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id o123sm19594787pga.76.2018.04.06.16.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/19] replace-object: allow replace_object_pos to handle arbitrary repositories
Date:   Fri,  6 Apr 2018 16:21:32 -0700
Message-Id: <20180406232136.253950-16-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 944bcaf242..9272c7acbf 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -12,12 +12,10 @@ static const unsigned char *replace_sha1_access(size_t index, void *table)
 	return replace[index]->original;
 }
 
-#define replace_object_pos(r, s) \
-	replace_object_pos_##r(s)
-static int replace_object_pos_the_repository(const unsigned char *sha1)
+static int replace_object_pos(struct repository *r, const unsigned char *sha1)
 {
-	return sha1_pos(sha1,  the_repository->objects->replacements.items,
-			 the_repository->objects->replacements.nr,
+	return sha1_pos(sha1, r->objects->replacements.items,
+			r->objects->replacements.nr,
 			replace_sha1_access);
 }
 
-- 
2.17.0.484.g0c8726318c-goog

