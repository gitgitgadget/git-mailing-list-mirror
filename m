Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEF41F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeJaHEh (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:37 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47812 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbeJaHEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:36 -0400
Received: by mail-qk1-f202.google.com with SMTP id f81-v6so14905835qkb.14
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vuV8ZxSueg+saTYiqp0ei1lG+d06gAWfJrnhI+UF3o8=;
        b=v51WHpWAd+xfUoT1HYULuHd3U4z0QdzkMU/S2nlk6BIw3b1/YUTIJHmFs9G7+oLy8O
         lzZ6WZXZ2Lh5/jwCBYEUj/+jiEA6qAZ3BFXhuf1XiOYsXHgWXs3AfhRdrgrPictReqqe
         8ch8m9GQ7W4mKhNmADuqmINerhvjKgpLF+KE+Bwuom1wViOW2L1jsNI5Mt8GSjbIrR73
         gF3LH5HJ3ieRD0vX7XYYBXXMpKh1UIBaHeO6tDWXVGoSqxlyXpU4nFdT/0buZTK3jQUT
         cfqH8I+91LoOo/a0eubsGdAR4dZQOj72I91+Hb3WY/X4jBrTOdgQXEKsWXx1Zm3Tm+cC
         lylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vuV8ZxSueg+saTYiqp0ei1lG+d06gAWfJrnhI+UF3o8=;
        b=lUIirt4icNeZ6ytKVHC+6J8OTSgzRZpvfAvBByqep1hdyUEn0yL90DpX5Sec/IBzlD
         SdUc1qVfjGf27d8PWtJYBVT+7ETcm55MAwownE3x4OcDAE2A08sAPplymFPVZv+40kB7
         l67Iizwe4xgr+sZqg1tcMrRmEq3eHvjkWorQ9OGf3lfoGxnst4KgNaWbuFkuB/vOkPVL
         MdsF5F/XiRKRQbmGZMMgnWd6clNZ0jrUnnMlYf1GX2r27n/8nwbM2w8jTsbYgf3+gSXd
         Gp9nUqVAPK6MxVPe7OqHIKYZDkYWXfmP1xMJVKOi4y6LPt0aldzkp0Ua/VMKLNUkwbi+
         4v6g==
X-Gm-Message-State: AGRZ1gLe7nd/QgWAW9pn58tBBGeZ6kqlhiTtTnN1tyMmhWMfjFQMulhB
        SnWemuU3DoJ7EJRYZFjEZJUzs6AusE+VtzNYAjuZs71Z+8D9OwOcWOnBeEa+hAyEGLJt/5cWX7x
        jg3178gwGGYGLiCBiAw1+rmvO78mtsUf43rAqu7bi3ivg55q/PdaXKleOcI93
X-Google-Smtp-Source: AJdET5fP+YWT6agB2TDEAu0laJhNL+7bVnU1VS/0MQUFhLeA3AwgybjOd/Nbh9Ltor5IXHMIHNzVdYMLU9C4
X-Received: by 2002:ac8:5488:: with SMTP id h8-v6mr427277qtq.51.1540937361488;
 Tue, 30 Oct 2018 15:09:21 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:13 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-21-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 20/24] submodule: don't add submodule as odb for push
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In push_submodule(), because we do not actually need access to objects
in the submodule, do not invoke add_submodule_odb().
(for_each_remote_ref_submodule() does not require access to those
objects, and the actual push is done by spawning another process,
which handles object access by itself.)

This code of push_submodule() is exercised in t5531 and continues
to work, showing that the submodule odbc is not needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0fdda45252..da1ac1e6f8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1024,9 +1024,6 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (add_submodule_odb(path))
-		return 1;
-
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		argv_array_push(&cp.args, "push");
-- 
2.19.1.930.g4563a0d9d0-goog

