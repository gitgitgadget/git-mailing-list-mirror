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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C83C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D320E61102
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbhIGKvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhIGKvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:51:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB5C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:49:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v123so7827585pfb.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVjzC6dkoLtqMeqZZ2F5dBxcbBXcGbK4XeQwplbNiOU=;
        b=kyasLTDTyDc6ver6qLDphQZKIADMRuyDvt7pq7Z9P7D7WiHj0FD9sNTRZGxPmOG7Vo
         E/QsYgc3Z5CULRu4/Rj3C079xn7Brqqrsc4LPFvHQcgL/yXX02DrrViTRVQhcbNP/R/V
         1tkKQ4qousf11T9HicRnknwudhKvE/Gh9TNaNVWveXpWLewNRTxjx+mzbUzfbxezqosi
         z6URxrPPTxJeBpuveo+i6ubMB47iFEXtnPO341Jc5Z+6oLvy/092TDN5495jtgXMBk2C
         s3aQ0fWRVUY5UujgWfc3Z7odSmmaeHlzZdvhz55Q4hTS3byofoMXWA4eS6GbVSQbfggg
         PfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UVjzC6dkoLtqMeqZZ2F5dBxcbBXcGbK4XeQwplbNiOU=;
        b=gGG3G/MkqROq77Oebcb0Mez7hDwdYtps0Hbi7bkyyMxLCmluE6nH2IhbF0XsfUjJ4S
         tXLj8czIyYeOmObKJpzgEdrLjWd+5BIA1r7qrbZqV9kznuR80KLcXKBRplrwezpAlpjo
         LXq3/q1lOD9fF5bER4WdNPD2Q8AAeY/JPN9bzR7j1iJLpt4Vvlapy9ktAq3fFZzesxzz
         YZBOGx/XhfCbZuWZwbeVelB4dl9KhViKVVte2Ui5k7Km0wErFriad3pWUPoeaWNfFLdD
         RHALXiMcUvak6tZHmNAb0Lv3O5+U5BX08EY92ZI2dAvfEM4mE4FYngwRHcV78P3N1iNY
         LStw==
X-Gm-Message-State: AOAM532tH+8WTbfMJhUYVIg8ndlxRaPQODO6udKsGUEEh8Lja5bFgWaB
        KiWAJFQAWQCqNTOCJt26wW8EK3M7a02KMg==
X-Google-Smtp-Source: ABdhPJwweXMMh8ytgv1ZLS6ke42brnA7VPHNXYSj0yw2YApxLkhoIj4AH0GDhkvQ3X04Q/5PhkIxUQ==
X-Received: by 2002:a63:cf44:: with SMTP id b4mr16598552pgj.215.1631011796417;
        Tue, 07 Sep 2021 03:49:56 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id c68sm10595544pfc.150.2021.09.07.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:49:56 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND] bugreport: Add hint to answer questionnaire in English
Date:   Tue,  7 Sep 2021 17:49:29 +0700
Message-Id: <20210907104928.16099-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on system locale, git bugreport may launch the localized
bug report questionnaire (and thus users respond it in their native
language). However, many Git support forums (including
git@vger.kernel.org) expects bug reports written in English.

Add a hint that answering the questionnaire in English will increase
chances for bug reports to be responded.

Fixes: 238b439d69 (bugreport: add tool to generate debugging info,
2020-04-16)

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 In [1], Junio suggests to add hint for filling in bug report answers
 in English. That stems from my responses to Krzysztof Żelechowski's bug
 report [2], which advise him to re-submit the report in English.

 [1]: https://lore.kernel.org/git/xmqqeeaiodxc.fsf@gitster.g/
 [2]:
https://lore.kernel.org/git/22496693-cf63-a278-c85e-d9e4376e2a59@gmail.com/

 builtin/bugreport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9915a5841d..56ccd0fc41 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -96,6 +96,7 @@ static int get_bug_template(struct strbuf *template)
 	const char template_text[] = N_(
 "Thank you for filling out a Git bug report!\n"
 "Please answer the following questions to help us understand your issue.\n"
+"Answering in English will give a better chance for your issue to be responded.\n"
 "\n"
 "What did you do before the bug happened? (Steps to reproduce your issue)\n"
 "\n"

base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
-- 
2.25.1

