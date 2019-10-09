Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056611F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 23:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfJIXoc (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 19:44:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40669 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732454AbfJIXob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:31 -0400
Received: by mail-pg1-f202.google.com with SMTP id w5so2874630pgp.7
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EadqpmqEO1sbalt3G0ZIdBP16QD9Yn0wEtGvxrBvS9I=;
        b=qXJ/qD+PL5O9hLclIKG6t1+u7hhn/cmCZs+RHwW2lCJyFSmDtMAx50K/JKCxqK7wJ2
         wqdqHfhswZpqn+xjR59CiB5EvhKHmRLeZWMT9RGaG3e6Pe9sZWcCzTyEMqGw0cI1xrHi
         f1EkQysYGlD2QPubPB+6N+Mi8qX3BmxsHhD6gYNiTEx8A241d0hZj6J/8TPIXbov0/A7
         mxGOSDnCDK7MwIbfCuajbdWQ0goAdwC1iN+LzIGIUGyVssDcr+KBAuJK6MwsMRxWy+1H
         CbYnVHVPU4cxlBQvWl7g/MGS4001FpXaRciXMonbo9c3wzbHtALx9EWPIR2OnS4q6dqc
         nd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EadqpmqEO1sbalt3G0ZIdBP16QD9Yn0wEtGvxrBvS9I=;
        b=VV51Wd9QBnwso5lCXfDgofVdW7X3uQ4Q8hlU4fGmhDFkW+phRGY4q0r/q+DXcIXJYj
         LmkJ7f8T6zbw7BMOqiPgUNwFtDDsaUaOjD/tYgkTGPn/RSzDHv4oaAzz0bUigQ1WjUCE
         DXLoJpVkgOLdgcn39c1aSl1tU/2RVk9u0VJHOhQnOifKi05SU+enib2UG4M4qDst5lbx
         qgtC7uFkW9VV5eeNH/fB5dfU8jJTETT9JUkXGBuiATsgQu4KZ8Bn3bLgHfrlwQJ18jld
         vYg5JPaFAmP9khVaBqXUy2yEwfgVyhBdd2rEp/F+sjCZ1u7m4rMng9VMAXefJZHMyNgT
         J8kQ==
X-Gm-Message-State: APjAAAW+/ZwxaV3qm+UyB36LzgYMonWgav05l9qAZTSqA841KaAIPeoR
        sDD2fBnbD5JGaUvK3PxElcGcmzeImXYjeC9NjV7FM2swSPTPF2YvsGVwwim9KjZx7ozTtl4x33Z
        s5ijE9Xv4JKMpj9SHcRWNCudSWkqi73qB9lYw+R3fXY5l380Pap70imR7YFbIDESrFadGYB/iQh
        id
X-Google-Smtp-Source: APXvYqxyxXd1Kx1W9Jaem3+nVUW2cRPloAjIU8KFEBBttKp6Xf2vOR8RGo5B+57jBSRrAk+/qhy+zaQ9JQzZf8J17lD3
X-Received: by 2002:a63:1b4a:: with SMTP id b10mr7266966pgm.450.1570664670464;
 Wed, 09 Oct 2019 16:44:30 -0700 (PDT)
Date:   Wed,  9 Oct 2019 16:44:17 -0700
In-Reply-To: <cover.1570663470.git.jonathantanmy@google.com>
Message-Id: <32ef0122a55bfbdbde0595b2aad930d83b27dd6d.1570663470.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 1/6] index-pack: unify threaded and unthreaded code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a23454da6e..1a2600d4b3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1210,15 +1210,7 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *obj = &objects[i];
-
-		if (is_delta_type(obj->type))
-			continue;
-		resolve_base(obj);
-		display_progress(progress, nr_resolved_deltas);
-	}
+	threaded_second_pass(&nothread_data);
 }
 
 /*
-- 
2.23.0.581.g78d2f28ef7-goog

