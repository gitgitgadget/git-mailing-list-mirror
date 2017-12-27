Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18C91F404
	for <e@80x24.org>; Wed, 27 Dec 2017 22:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbdL0W50 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:57:26 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35803 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbdL0W5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:57:18 -0500
Received: by mail-io0-f196.google.com with SMTP id 14so30178990iou.2
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kwhxQji5SRKiULgn86G+CJgT8SLPEXNvhOiBXq6Hc0o=;
        b=se87BXukjIG2qL4l7gSiEeizxGXqek2i3J76MGpIdNWRYIJIDHM9uqZBU00Mf67aPk
         zrfQNBgdvT9XYqUELtG5T2Bm3K1N21xpz8LjKE0gpXbqsStj79clCNhxffvB0wDo1nfZ
         0N+WKO2/fH40bLF6QMFL7YdgupLEFAqeXFqMCoa2DfIjJNWJIwHT2/TB5u6VnqvGROTJ
         mT8yHES+XU8n0p8qu0X37ZfME3ov0grQFf1WkPqgVX35RhZPK36cexfHZuPBwDvwhMY2
         xiUoCz2oxKk1d9q2SRQnQnAJ98CjETmDun7U8G1ohZK8cQrmEEMBdwzpWtH5tHSXAssw
         x3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kwhxQji5SRKiULgn86G+CJgT8SLPEXNvhOiBXq6Hc0o=;
        b=fJK9XVApzfzmRexXMJk9LIQXRWsyEp3gWEFfLPSOY/RfvWdTmmm7KvXRhi4ij8JOLS
         cY83wk0xlHFgScJ3PyXBdXY0qdvekxcrRANFfLdV9fygfqL8lrwbSaHPHQqXxlXdu11l
         kRoraqKYJedhSQlT/fqb6R5SYUd/ZnQQx1Yzby1DlxRyEQCf9ydLGfdyY+wcFcoylhhH
         kFq59L8gvj28X98BsUxFaeSyLSTif3hMQaUbgtVfbkuUUudq6k/J5ReMeWF369Pnrqbl
         FPIbKuT94sHh/Gswel1FZzUKVstgFBGwOS6a42B1zHcJxXAtRUuwPdD9pILXrOU5bg7W
         JHXQ==
X-Gm-Message-State: AKGB3mK1pN0xBufqw8DoVvdtxe5zL38Yd5fugcx/EMKGLCrRigkOT9Y0
        0aQOyLVpwHObjRLY1vezkWc4NQ==
X-Google-Smtp-Source: ACJfBosObLSP2u2kUFKDnuT2jba35yUlhcvCsX3sE5GaOuGvaH5evzk6olLf7MGSXyGN2/dM/5QeLg==
X-Received: by 10.107.53.67 with SMTP id c64mr29011618ioa.113.1514415437129;
        Wed, 27 Dec 2017 14:57:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l126sm18127272ioe.65.2017.12.27.14.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 14:57:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: [PATCHv2 4/5] unpack-trees: oneway_merge to update submodules
Date:   Wed, 27 Dec 2017 14:57:04 -0800
Message-Id: <20171227225705.73235-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171227225705.73235-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171227225705.73235-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is a one way merge, each submodule needs to be one way merged
as well, if we're asked to recurse into submodules.

In case of a submodule, check if it is up-to-date, otherwise set the
flag CE_UPDATE, which will trigger an update of it in the phase updating
the tree later.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index bf8b602901..ac59524a7f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2139,6 +2139,9 @@ int oneway_merge(const struct cache_entry * const *src,
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
 				update |= CE_UPDATE;
 		}
+		if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
+		    !verify_uptodate(old, o))
+			update |= CE_UPDATE;
 		add_entry(o, old, update, 0);
 		return 0;
 	}
-- 
2.15.1.620.gb9897f4670-goog

