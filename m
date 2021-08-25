Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA3CC4320E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FF9610C8
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhHYXUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhHYXUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:20:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9A4C0613D9
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso5491648wmb.2
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKSDvkQ1z+tDX5hXu0R9jSM3Mf3+HmrtLuk2mJn7gCs=;
        b=lCuO6JGY9Hsvufe7u1Msu/7LOQjevcCD7coHuAe7s7qN7hhiP8JCjEy7E6NhfIt/iw
         hWiYmkKoJ03twozuE6DPern13bNC3+jtShDAVNTeLIwqCSLrk8efbt0Lwafk/fAj+IXL
         CbLbfpWm2SKsgAg+3CIMi8T1LDZqHUY3tDyfv+z03GArDhJUQH6cUY+SKc9UcdssoLgM
         rT02X/AHNVnfni8BgmmfJpYRo3njBorXI6FIv+yruCmS9CBvSLCczwcuM/jxPVjubJVW
         uTB8T+FzYWqJm+cOimc0/s2J5snVetOrZZEzzUd1fBzuOPfdZ2EJUqzTlLTLsByI+j9I
         9nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKSDvkQ1z+tDX5hXu0R9jSM3Mf3+HmrtLuk2mJn7gCs=;
        b=AbHu6D/Ung6YivrxTGERVEOXmml2OPp9cJLxh85vEzkdiJx6W20pZBFA623NUW8mVb
         BVa5TGnAzuYe6hEm5gHhk2okaN7a1ISr5lsSni5qCWrcgIsfg/1H/TKag08ha8JYa16I
         ticQJFPPSXa3APgBNX8HEZpaG8Fd0yS2LYiqk/3F0zPRuksEa3hRMkZDK4r/ui3J+Wch
         Ryu9tbbj7g0LTC5YcMJm4Slb5xQPwzxJNhcC2l1mi1arc6QIwyqHVtownhN4MCFijZcA
         Hgqjsmu3ZSaHHk2r+/j3D5rSl/HpWByWviNdkUJ4G0KccGKuNTcKJNI4S7oczJXdAu0v
         MO9w==
X-Gm-Message-State: AOAM533KUJIqb9fbALBUZjnEOQ/j0h9ZZ7zvCePHujZAWNWo4rdt5g1+
        4343QlNw9ITNJCt7Xsn4LitE11UL4GkFPw==
X-Google-Smtp-Source: ABdhPJyz70iFkcbXr1LQkO4shc2goTXEoIxXaFiQH+fv/i/1Im4ofZo2ViSergNwDeu1aF02YgLhZQ==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr734497wmh.161.1629933591383;
        Wed, 25 Aug 2021 16:19:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm6327166wmc.24.2021.08.25.16.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:19:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] tr2: stop leaking "thread_name" memory
Date:   Thu, 26 Aug 2021 01:19:21 +0200
Message-Id: <patch-3.6-1fa1bbb6743-20210825T231400Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
References: <87o8agp29o.fsf@evledraar.gmail.com> <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in ee4512ed481 (trace2: create new
combined trace facility, 2019-02-22), we were doing a free() of other
memory allocated in tr2tls_create_self(), but not the "thread_name"
"strbuf strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 trace2/tr2_tls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 067c23755fb..7da94aba522 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -95,6 +95,7 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
+	strbuf_release(&ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
-- 
2.33.0.733.ga72a4f1c2e1

