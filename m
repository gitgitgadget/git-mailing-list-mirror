Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 558181F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeEPW7E (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:04 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:38486 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeEPW7A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:00 -0400
Received: by mail-ua0-f201.google.com with SMTP id c8-v6so2259691uae.5
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PJ4vElEbhu8iwzbaPdG5iDoXC+S2fX4XA7SMpGPzhyg=;
        b=qXEH0aGTGeS7J/0+TwJNxEB7VJrD0t5KWkJB11hOLA4fBa+e0qqlgjEzzDbOCVJnAF
         jcrq22GbYX1GDYDv4AEemNqyy8XERX7FaJZmZbc66TazyKZROWiVWP7yd61UDFfkVlSE
         XVi4l/HlRtqFc6mIQOXvK85Ef+RVdNZZYcuV0Kjr5UPP4CdM4TexTMRlWAVgwKx9OYKW
         XqsupG+E2Q2brDczlwqDnCQYEEBzt2nOyeGToYgfw4IqaOlAGZ482L/mmAUP7POy9pfd
         apBjoQYdPEMBtLn6NiFnzWqbh8U+HA6LgvzFfvNloYSe6w/qYISV997aGHkrNi+/wA+F
         AXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PJ4vElEbhu8iwzbaPdG5iDoXC+S2fX4XA7SMpGPzhyg=;
        b=RuNKRry6WUN2CZVNSOz+3rCu5K8oReoo3m4PLjLoOMYaEnj/QgSvv2lxwym66UX6HH
         xGSZtvwGG+SqOjswgBcer21rbAGLLrsrL3LVD1Ive61n/o69w2XCrDQHotdbKSQ3KwZO
         ujeD39ZCCZq1I5kizMuLNekDyR/y6OoH8IfCF00fLgnDBKuekwWyfSfGcrp1uBz2anUK
         m8IHBcugPIiwl312UBzgRv5T5KAd7hnRQzRKyLs/44kYo2eNsufBLzjSw25tvJmvDo1Z
         Q3AUv1cgCSn7G7TajerjlDMX3IAqkCOkygyBnbqC4s6xZx1RqpnfttADHPhd23O5Yj0o
         cjnw==
X-Gm-Message-State: ALKqPwdgPFiMDw3I1YGZz2j/2dprQ7O1+biGQc+SKLhYG6UeI8QYlzYd
        I/qY2XdF+tbVGNjSHV818Q2omgX5WzywD1ShDv/rQcs8SzzSyfBuLARRcpefGU7JtIgIAXrrYlL
        Vk4uf/fPfJ/CXcUWiKUp3i98bC3mZTyG/OVbX1cNacwH6i8OFDEyHz/4gDg==
X-Google-Smtp-Source: AB8JxZqtnbv69MipofLAMIreiGyny5X1Se9yJRLfvXzA7KvX64B/3XuNcbNAeS3Y+Q5xm0VB5ozGCB3sKlM=
MIME-Version: 1.0
X-Received: by 2002:a9f:2b0a:: with SMTP id p10-v6mr2409285uaj.22.1526511539748;
 Wed, 16 May 2018 15:58:59 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:56 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-10-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 09/36] remote: convert check_push_refs to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'check_push_refs()' to use 'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 89820c476..191855118 100644
--- a/remote.c
+++ b/remote.c
@@ -1282,12 +1282,14 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
  */
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 {
-	struct refspec_item *refspec = parse_push_refspec(nr_refspec, refspec_names);
+	struct refspec refspec = REFSPEC_INIT_PUSH;
 	int ret = 0;
 	int i;
 
-	for (i = 0; i < nr_refspec; i++) {
-		struct refspec_item *rs = refspec + i;
+	refspec_appendn(&refspec, refspec_names, nr_refspec);
+
+	for (i = 0; i < refspec.nr; i++) {
+		struct refspec_item *rs = &refspec.items[i];
 
 		if (rs->pattern || rs->matching)
 			continue;
@@ -1295,7 +1297,7 @@ int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 		ret |= match_explicit_lhs(src, rs, NULL, NULL);
 	}
 
-	free_refspec(nr_refspec, refspec);
+	refspec_clear(&refspec);
 	return ret;
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

