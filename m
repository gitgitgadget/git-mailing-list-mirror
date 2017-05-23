Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007E62023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935973AbdEWClH (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:07 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35158 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758262AbdEWClE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:04 -0400
Received: by mail-pf0-f175.google.com with SMTP id n23so99562708pfb.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MJXr91NFt8GH0E6kLhW7m5KtfvDV26zLt4zSaGoVCyM=;
        b=Vqp7kZkeJoaeTvkacwiZIR2fS8m5LulyHrE9sVCY3pUP/Olhq8s961mI5q+39H8UFs
         D7WlBbqYO02RJolvz1PDtWCW+vUq4Lmx1wwOkKZif5R4ZjRw9HHfq3I5rb3dzfHX8rpF
         9PqJNBHA7KJpa/p1D6YDPZsYgXPyNLBKdgMt3yWMZ7red/hm2/rL1yuTVxHaZ9Sno+He
         IcOZu22EDgZK3+vjShFqoLuP4rTX7tEGzFJyEx77wFE7X3o2cRsFFuhVOaxg+DwL1SRi
         zPwFctUUP8HaFCcsnVyqeZpKmSqXRQW0GhazDKldFPeOYKhtSwaacPB9IDy6EBE9wrjT
         3dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MJXr91NFt8GH0E6kLhW7m5KtfvDV26zLt4zSaGoVCyM=;
        b=hWubvDs1AZXfA/zHTUU2MYQvsrqUpzLlk7Sw1v0WhBZfue8IyribUOE6z/BIRbB6Wb
         2LeYAIPBL9WmK+rIVeSF5Jx7T7iEBnQxdSFfPt8aYBY1sZjAdIaF5jKXiZ4nq2bFxVOw
         9a9gzoGeATt+naLjCjnT3a98+Sq0e0IM9JDEgBHEgSRVQN2RkmJmYHVrvZ03Wquh8cAb
         k0Mu2JZGKPU9LpOHgvbPzg01j597Qx6th8rFRY1NOiaQ522sXaZgTjHI4wTjvUeTpFE2
         HfTi8z7L4c7tH7pSvnvjgPTMW/Ubeb+BYkCZ7aHNxP2kvgYTipC6n9tyXjtgRLsOkKDN
         7h9g==
X-Gm-Message-State: AODbwcCbveLN/9GXEcrJl29J+kdomrtSjQhjTybNT8TOwMYoZGk8ISEm
        66SzNhqrz17PxBVq
X-Received: by 10.98.14.13 with SMTP id w13mr29185907pfi.59.1495507263444;
        Mon, 22 May 2017 19:41:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id o10sm31325141pge.67.2017.05.22.19.41.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 01/17] diff: readability fix
Date:   Mon, 22 May 2017 19:40:32 -0700
Message-Id: <20170523024048.16879-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'. Use
that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9001..3f5bf8b5a4 100644
--- a/diff.c
+++ b/diff.c
@@ -3283,8 +3283,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.13.0.18.g7d86cc8ba0

