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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F33C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA5A6196B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhC1NQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhC1NQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D647C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso7180877wmq.1
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pu1b9zR9Dj/kCCJZzffONapXZmdjhdqC/q4G1xIcz7Q=;
        b=PTHcw8yVQi5M0XxYM7FPYv2qFKaL3CoGT4Et12EJgWTlWfdF2V2xsalkAfSRUg0rt6
         M7PjSQjsbknlY4xvzlx6gyNwHaXdkk8QzEDAtXaFlUXJMA8Hzq29fSkJeS0FeLDsVJul
         IEFTDfApGQCpTQ5Dc2hhlp01/10HouZCKyaXe+3wZdUFl+lqoDAvNsrdQ7KKyNchtDll
         SXKBZN3VxRUSUhHiqL/MTUZp3ZcjnoFsuBU2NtyT7PwwiCfBCIi3gOtYg9W3Ex/W+Ct2
         Qoarh13dnb4CxVVJ9TZtzkGfYW3sgYN4Al4GmqbligMTbuEElSxuXHLM8NgJEJ+caGft
         H3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pu1b9zR9Dj/kCCJZzffONapXZmdjhdqC/q4G1xIcz7Q=;
        b=RAdapLVh1heqdSLbL75v2AC204wyYmGvd/vpQ/QdPbfynLUaRioVPU/aIb1OT8Tk5u
         0/Oh9mqfupvRzQds01AGwNT46Gfkwl2pF3MdcCpe6SEShRItlJetD0kJ6anhYCVPiVzq
         YHtplZLSXsYWbZmmKUcqEMdPbu49SW16oKpcpZK5RfowCR9ZrpycxKVORLMghQjaS1f1
         d/+Tae+KjUoJOJ3K/JfKh+PnAKB6dRVfrWpxm7BnQ15a6n6TEEUPtJPRY4Ytp4bfEC32
         8iR8m6ZkFxcGNuFHX6IPgFZlBbsAtDwiN7eQGkTuFoTbo8bbPtb43IrWrghGn4KX0m0N
         9ytQ==
X-Gm-Message-State: AOAM532YAf63qXzUUTJLOUoAMFgZ8r7VU0lFZ0AlwvF3aXMU2dDqr12O
        S3TEbXCmgdrULm4UJK3hwqz8gUsTum5OSg==
X-Google-Smtp-Source: ABdhPJyee6f2SImQQ0em9QPoCnF5u4vkZxPcMn3E3sz7YO+ZlHFbZ26y68mBV8re17bjIpX7HMHwkw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr21394002wmk.30.1616937358089;
        Sun, 28 Mar 2021 06:15:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 05/19] fsck.c: remove (mostly) redundant append_msg_id() function
Date:   Sun, 28 Mar 2021 15:15:37 +0200
Message-Id: <patch-05.20-b07e8e026ac-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the append_msg_id() function in favor of calling
prepare_msg_ids(). We already have code to compute the camel-cased
msg_id strings in msg_id_info, let's use it.

When the append_msg_id() function was added in 71ab8fa840f (fsck:
report the ID of the error/warning, 2015-06-22) the prepare_msg_ids()
function didn't exist. When prepare_msg_ids() was added in
a46baac61eb (fsck: factor out msg_id_info[] lazy initialization code,
2018-05-26) this code wasn't moved over to lazy initialization.

This changes the behavior of the code to initialize all the messages
instead of just camel-casing the one we need on the fly. Since the
common case is that we're printing just one message this is mostly
redundant work.

But that's OK in this case, reporting this fsck issue to the user
isn't performance-sensitive. If we were somehow doing so in a tight
loop (in a hopelessly broken repository?) this would help, since we'd
save ourselves from re-doing this work for identical messages, we
could just grab the prepared string from msg_id_info after the first
invocation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/fsck.c b/fsck.c
index 7cc722a25cd..25c697fa6a2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -264,24 +264,6 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
-static void append_msg_id(struct strbuf *sb, const char *msg_id)
-{
-	for (;;) {
-		char c = *(msg_id)++;
-
-		if (!c)
-			break;
-		if (c != '_')
-			strbuf_addch(sb, tolower(c));
-		else {
-			assert(*msg_id);
-			strbuf_addch(sb, *(msg_id)++);
-		}
-	}
-
-	strbuf_addstr(sb, ": ");
-}
-
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
@@ -308,7 +290,8 @@ static int report(struct fsck_options *options,
 	else if (msg_type == FSCK_INFO)
 		msg_type = FSCK_WARN;
 
-	append_msg_id(&sb, msg_id_info[id].id_string);
+	prepare_msg_ids();
+	strbuf_addf(&sb, "%s: ", msg_id_info[id].camelcased);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-- 
2.31.1.445.g087790d4945

