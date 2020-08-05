Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D35C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F5222CAE
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHggdQiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHEXHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHEXHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:07:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A567C061756
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 16:07:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p14so33608875plq.19
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FZ3BxXcIPe/Jq3g6sXokArDVa7F4Jzb+l1RE2xm8xjk=;
        b=IHggdQiUAZ2l2RWlEF/Y9VJ7Iyi5wOeSAe/UDwDMtpmKNbB6jOStj6cDs+t7wTwsJ1
         3YMaWAelZ2kQAiDbssnjn2QgaYd4p7fcScOpvHt+/9JXGrzG7evH/3po6oq9kznpaRmP
         o4G6fr0DrwjAbxCb8zveE7WRHOlcDCiLwxKAzJgWKS8kUEaf98+pVjeMWpfbU5uq9MyH
         fcy+ylQgim+unEUrFoqobE3pBRIJmvsblJ51m3tdRq3jhksU6VWfqOptSYkcXtShayUI
         G/jQZjIxUF395weLWH/W2AKShzeXZLj3s6iUTyFZzhiaBhotbn4e0A9ZJqWotuDxo8Vo
         O48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FZ3BxXcIPe/Jq3g6sXokArDVa7F4Jzb+l1RE2xm8xjk=;
        b=VjwxLzSoiokrM0E0HLgOmfjleLcNDx6ZpSwgW8KsUE2zftHz9JbUJJOMl0xIiaeS6H
         AQSpSN056ZvOiYd9hwJjSM1NxOWq80KZToMckLJrL9+yO8mjv/MHWuhzoT/fY0Uif06Q
         zReKnWM0WseIV+F9XHCti9vOBtjxlIQfo6Ye969GJWdJ5br2FjdkXmi5+3eby7S6lvqQ
         HfYTBo7FQSfpFwuZ8/P10aU/IIlrJJFIdQPyGMFSEFf0g6JiolC2mZQHQRjCxODBcU8S
         ZAwoCtthzcfO76WUGjA0bmdjU68WzWXlbEo3e5eCDEwhaTtVNYLcW6uzw/d35jJkTKT2
         rIOQ==
X-Gm-Message-State: AOAM532BQL6MCkhwVfie6yZMrCCOYjVo588nminZhQyoSyQAYu7HdXmi
        chfPsPHKWU8b0hFh8rnRHdHyv6vWucCa1pdok5LdgnuNYX+8rvCaKKtutRTnjtyYyZGwdKsyUUQ
        tNXaGcvWoyPdCD8UqJLhzPGzowiTYT5wq/euueLNZrrDUwL7T9rwhzUkdwEcrdb7SFy9uy8UdaY
        al
X-Google-Smtp-Source: ABdhPJwiOfKVm47SunKe37c4fYzyW2/2Z3rV1EUw9wcCumRE5eBA+2vtE4wd3WGIyO4y2HVvML39CtuIVEaTRDJ8hEO4
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr1189563pjb.1.1596668824026;
 Wed, 05 Aug 2020 16:07:04 -0700 (PDT)
Date:   Wed,  5 Aug 2020 16:06:52 -0700
In-Reply-To: <cover.1596668156.git.jonathantanmy@google.com>
Message-Id: <efa3b0719d628bbbd3923725c2d8e0c0d0018876.1596668156.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200728010403.95142-1-jonathantanmy@google.com> <cover.1596668156.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 4/4] fsck: do not lazy fetch known non-promisor object
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a call to has_object_file(), which lazily fetches missing
objects in a partial clone, when the object is known to not be
a promisor object. Change that call to has_object(), which does not do
any lazy fetching.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 37aa07da78..fbf26cafcf 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -168,7 +168,7 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 		return 0;
 
 	if (!(obj->flags & HAS_OBJ)) {
-		if (parent && !has_object_file(&obj->oid)) {
+		if (parent && !has_object(the_repository, &obj->oid, 1)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
 				  printable_type(&parent->oid, parent->type),
-- 
2.28.0.236.gb10cc79966-goog

