Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F271F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfBGUGC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:06:02 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47024 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGUGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:06:02 -0500
Received: by mail-qk1-f202.google.com with SMTP id c84so1048061qkb.13
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=nORwMn+u+drxP+kMqOU+K61mCfZGlsZxJSInkrQRJIc=;
        b=c26xEt81OScXGtB3FXRpsOUkV/F7pqbTBSnhlmdJqDrdMF0y7pELR9y7He1DEhr4Je
         W7b91n6CWrqJ6kmrX33J93uyz8ICfkKF6wUAQCMP6yrx+7iXY/HSMwz3mOyCwm322ksq
         Pbm7H/YwFTL5Tq/JYiIS5pT6Z8EdgXyMMuN3z0Jq5rKWVczJpecl4Esp/P1FaYAxVRjm
         s3XFi9omVShIqw+RE7+rBOydHpLlg7TjmOXp3BLOq6mSxkRwDfRHL+c9vAuGRoOlUCgR
         R8pc9cSZ0jRFmqZXCtx3lU4GYsZj7GwJwBaydMxZJTW6IcO0/R4lgCgvdQ4Rox/v02E8
         4bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=nORwMn+u+drxP+kMqOU+K61mCfZGlsZxJSInkrQRJIc=;
        b=RFEUM7IzBEEQk8BYYrJxp+3YxovTAWzic9qyuJrv3iKFCQDPs1m4KzvudeDi3G6TWX
         9y/miOu/5bXvGD1LwsU3wyFthdEnnnN1TGeU4L8IiGYT1EoUTLcyisHMTtF/p9T9dtBS
         xgCJ9Yx5EZer0NhA7aKNn86QXqi5VdD/c1JhLKaat0spYi/lyEwWGgc9sr04fjFpllGo
         2VYYe1kZUVs7EzH1zJpMzHiXfypSdxUtKQerHOgE2gJlOCVskaNE4fr6OT3nmmv1WQK+
         ZPUaPAYAduU56yfUYtF7QI2Ji1VIaenGUYvJvRmGGsqFytl/7mbjv9Ythq3Z+3OvqxfQ
         PzpQ==
X-Gm-Message-State: AHQUAuYI++k+I1oVoXLqZcLUzVldKLUvvMrVQ3p1DBlgIjum/fBrPmlK
        /CqGLCNcQKRagPqvWOwDpZSQQUvE9NE4uUXbp966B8wEhIgnfnaIrCbHPcBQks0ZFcTvTEagi1F
        BOmgEBdKx5DgWfPkdaqV2BaVQCQoA0cjiWd1nuRzi+KuqunNXIV8fO5UPbUOvihg=
X-Google-Smtp-Source: AHgI3Ib/t2cN/TmedBqeO5y77QfOD8AZNcy5LIL4QlW53dpa8fuo6Lxnan+5RAOZLK7tPATjG5ZWjBC9kJWdMQ==
X-Received: by 2002:a0c:ef0c:: with SMTP id t12mr3074620qvr.19.1549569960997;
 Thu, 07 Feb 2019 12:06:00 -0800 (PST)
Date:   Thu,  7 Feb 2019 12:05:54 -0800
In-Reply-To: <cover.1549569479.git.steadmon@google.com>
Message-Id: <9a0495694dc2344ae5fdf2a95b301cfca3ed4a79.1549569479.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1549569479.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH 2/2] object: fix leak of shallow_stat
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In eee4502baaf ("shallow: migrate shallow information into the object
parser", 2018-05-17), we added a stat_validity pointer into the
parsed_object_pool struct, but did not add code to free this in
parsed_object_pool_clear(). This leak was found by fuzz-commit-graph.

Clear the struct and then free it in parsed_object_pool_clear() to
prevent the leak.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/object.c b/object.c
index 5dc5eec367..ca0b093c37 100644
--- a/object.c
+++ b/object.c
@@ -557,9 +557,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	clear_alloc_state(o->commit_state);
 	clear_alloc_state(o->tag_state);
 	clear_alloc_state(o->object_state);
+	stat_validity_clear(o->shallow_stat);
 	FREE_AND_NULL(o->blob_state);
 	FREE_AND_NULL(o->tree_state);
 	FREE_AND_NULL(o->commit_state);
 	FREE_AND_NULL(o->tag_state);
 	FREE_AND_NULL(o->object_state);
+	FREE_AND_NULL(o->shallow_stat);
 }
-- 
2.20.1.611.gfbb209baf1-goog

