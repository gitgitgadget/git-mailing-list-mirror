Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254131FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbdAITrB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:47:01 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33240 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763995AbdAITqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:46:34 -0500
Received: by mail-pg0-f43.google.com with SMTP id 204so24010008pge.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3PKbIYJtKs3YzfqYipSLOEr+Rk8CbTGU6gbK6r1oBac=;
        b=I7xSRhhlDaHMh3V+Nz4szGDxRhqJZi0ZRwp7VsW0sIshlIMqn4UBkRrCHp51vlGX1v
         R9KKjTEVMJWq5v2RXMWnXc8DslJtlzsRecUaL2BBcV4WfZN+/yYY3c10j6yViXxGZuyT
         BkPV7hxD39sjzat27VOLqOfHumv6bsUtUvTPsWEiOD0zBqRu8lBSczxlK8oiC6kFE3kU
         TXhFdS6NaFoeAJOvLNkkCIv6j8b7PCpL7gm+Uph23KkuWta+A0QBHZOdIcjFuC5uC3T2
         1aRlrF0aFNu89K9ioDjujotcsxRikwElnSJKLiukvyhwnpZyh8mj8rcBcpv2LzmtMd07
         u+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3PKbIYJtKs3YzfqYipSLOEr+Rk8CbTGU6gbK6r1oBac=;
        b=cqH1PdeYaG65RTxc3s6GLDB9TVxR6UiKB8O/7eZk5IC851xN7H9DA/TPMpKsk9TQnc
         Dcn2e6X/OVbswENvEasWVWRJXFdi9hVoC5f5Z48Es+ZRfLYQbp+thEvifPrnpa8EDAYi
         U3OvIDWsWgD72RLUhoNBW0YFLi6MNDy68DAGcYrC2voVY3xEIGyp+IaCy2LvXKkbw9uH
         P7Qu6AmBAkcMQJL+xmyDzZgK5SxObc/Efa8El3knYU0w07I/SDr1EQsvcwV2lJ3t0wbV
         yQqgesVpXbsqCXO7UsHKLO73rPXXE+VK6bxm++UxEpsm1mXvZiPMNCrNLLzhlZLmzZX1
         j9fA==
X-Gm-Message-State: AIkVDXIX3F41wTzLS1UIzFpKSjVcyXx9Jz+e6YIYlPmfdTorv4OcG8EhTnxAEzJB3t+nArjV
X-Received: by 10.84.204.8 with SMTP id a8mr199561508ple.172.1483991194004;
        Mon, 09 Jan 2017 11:46:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:45b6:2235:29e9:acb7])
        by smtp.gmail.com with ESMTPSA id 134sm20296940pgh.13.2017.01.09.11.46.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 11:46:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/5] unpack-trees: remove unneeded continue
Date:   Mon,  9 Jan 2017 11:46:18 -0800
Message-Id: <20170109194621.17013-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170109194621.17013-1-sbeller@google.com>
References: <20170109194621.17013-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The continue is the last statement in the loop, so not needed.
This situation arose in 700e66d66 (2010-07-30, unpack-trees: let
read-tree -u remove index entries outside sparse area) when statements
after the continue were removed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8e6768f283..d443decb23 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -253,7 +253,6 @@ static int check_updates(struct unpack_trees_options *o)
 			display_progress(progress, ++cnt);
 			if (o->update && !o->dry_run)
 				unlink_entry(ce);
-			continue;
 		}
 	}
 	remove_marked_cache_entries(index);
-- 
2.11.0.rc2.30.g7c4be45.dirty

