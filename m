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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C3C4320E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A03610CB
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhHYXUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhHYXUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:20:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFDC0613C1
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso5482509wmc.5
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykrDvlTosMAM0/o9ae8k+S+F6gOG7Zpz4IBbaGqbQ30=;
        b=G/HFUZWDHOYfz7nFI6wARS2qv8YOANIteJ3Wd/FdtYcVRt6VtNq/oO1d7xnkdMTuD7
         FfAAIh7UF2C1qPafQynZqVp50uZegduYFTf/EbwG4QMn+1COyL8QPs6N/H7hhGTYZkN+
         B9nRE9J3pOZMWzsiHxOqY3LQdNNUNeg5+q/IBuR5xY9/mldwOIhhWEk73GsHA+p9qH+k
         pH9k06MrfdGWzq3oW7qswqBWQvMjSdxrjZ+mdxHtQpNcJl3ddSpU6ATBHDLUlh3aEiV6
         1LimwBIhg2ImydYeOifOrldKlvW4o102Ws9lXoESZuTptKi2BTJkMS8G6/iO6vuabJlT
         n9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykrDvlTosMAM0/o9ae8k+S+F6gOG7Zpz4IBbaGqbQ30=;
        b=P7HFzHzUPQsT1lcAgvejsz2F9J/83HQY3l+JNiRIGZcT9GhzqeG1lM0JvtCCLHTmYS
         GQNyftD+CLTJgJRpRqcHYyeaxkyxcfZz0KMH9mxph6rsyqfcbRFR8YPmrYDUkFsU8+OF
         dUNuIefsJAEujG4lQrp7hExxuEiRgBH7Lp0Dii1QZSL1qWUs7ZYNYcnMHR4Qo7XFG925
         kGV6HM/WRfOOZSRww97+y/XiZooOeSg6ascWiZKImBlIE+2R6k/qoFDu6kyRTKdr6WKA
         r3uccM5CfTwyc6a+Gt6tzxvZZUsOz9Kf7W8yPtmlDUllJ5KzbQ/MmbPBzjLOQRXm77aM
         J//g==
X-Gm-Message-State: AOAM530DQwFcZymYFqUkSaKOf/gGGEtlFhmaHAQKbF2z3pv7Hh6r3Ka6
        +wKU6edoJlEoqRi6SNJPj/eEY37mNZ0=
X-Google-Smtp-Source: ABdhPJzfwep0SX0iiWmG/9nh9j0pYzjanufonl50l88vsFwM2GyDwcpm/QbqpYqYpoTgaxeYBMVzsA==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr743246wmi.69.1629933590071;
        Wed, 25 Aug 2021 16:19:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm6327166wmc.24.2021.08.25.16.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:19:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] tr2: remove NEEDSWORK comment for "non-procfs" implementations
Date:   Thu, 26 Aug 2021 01:19:19 +0200
Message-Id: <patch-1.6-8c649ce3b49-20210825T231400Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
References: <87o8agp29o.fsf@evledraar.gmail.com> <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm fairly sure that there is no way on Linux to inspect the process
tree without using procfs, any tool such as ps(1), top(1) etc. that
shows this sort of information ultimately looks the information up in
procfs.

So let's remove this comment added in 2f732bf15e6 (tr2: log parent
process name, 2021-07-21), it's setting us up for an impossible task.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 578fed4cd31..15a89676c7a 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -25,7 +25,6 @@ static void get_ancestry_names(struct strvec *names)
 	}
 
 	return;
-	/* NEEDSWORK: add non-procfs-linux implementations here */
 }
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
-- 
2.33.0.733.ga72a4f1c2e1

