Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215801F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeHIAjs (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:39:48 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:34103 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:39:48 -0400
Received: by mail-ua0-f201.google.com with SMTP id n10-v6so3013200uao.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iJhhnV/0zptV3fSBH0d/Mt1X4QRZtN4DocuKs8E15QA=;
        b=LfD+wYlaTleqBTXQOqUab5Jj3OKxPH9hx1ePyV6SYb1nraMBUl+m4gHqmvqw1eP5PZ
         gXRi/y8GpitDUTlfJ81O3/BF7yIgx/CP6MysceYh/tNkae0fVOgfu7t64bOQKN2QXKUx
         XSi74LG3eUFAO2RRMz03VioeG5DiKvDhKnXfK5fBDSrxNdMEH/OBVVmXUPzsSyKfHB/o
         +J3IJN3eNpA50sy8n21yxrRat6qFjRr1zGA+C/oA6GpqDpO4R72r6gbLmhOjDxBPHRUQ
         zPEL3OVw1jC/Z4JbIvvPVuLHpV+n9ujBapB5K5G5HyQoh40lNgrQUjnx02AHIHSfOfSc
         NIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJhhnV/0zptV3fSBH0d/Mt1X4QRZtN4DocuKs8E15QA=;
        b=MX94iQ68RqnX49rmSAF3SPj9DfQeLx8OlrpXApcor5+TTtewjtnnEHYMy0LlDwG+PF
         M6t8TI0/OVyp1hL8vBMPPwdH6VSB4PTQ6dcw0sthl/dlkY21IbtDfOk3bKOmGLMHhQfC
         FMF372m8we7TnPqDTVwRQd0yhLi2rdvPezdz2pQSV8oC0Oew5KtLZFRTYuRv64wLhyrJ
         b9K5JhJ7O6rUn5eDs13XajaCd6kzyE/y5/kENgGnuAcITCfneRKfc4XH3m+Dd4pgslJm
         CnkCPiOU/um2Wv65VrRg7jG+PN54i6z/4ACFIcFaA6LVGtB346NQthBTxypH6yt2Lx+F
         mpqw==
X-Gm-Message-State: AOUpUlF+R0IhBHicxuUZ9kyUuDZNMDfhMJNLCqcUMNwek7BW5fGTkncO
        lYjLLkg0NduIymBe1rAEb3POSE+0HEa/AwkjJE9hJsokDKimSIbRgXGZ4mLAFGL5gZzDVZ05Kz5
        iXnKafX8LrrmB9AL6kXgX5LBV6aowvpbUYZLS0VlRZ1VOLgjDpjh/XcYC8K2a
X-Google-Smtp-Source: AA+uWPxU08FE4SNJkqu5ZDS/OR1xI7xdfB6iDkDEtijPWB0kR4/7dKeac1FM9r+iLmYF1d3V59O20tgFerhQ
X-Received: by 2002:a1f:ee87:: with SMTP id m129-v6mr2533447vkh.96.1533766686682;
 Wed, 08 Aug 2018 15:18:06 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:43 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 01/10] string_list: print_string_list to use trace_printf
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is a debugging aid, so it should print to the debugging channel.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 771c4550980..9f651bb4294 100644
--- a/string-list.c
+++ b/string-list.c
@@ -200,9 +200,9 @@ void print_string_list(const struct string_list *p, const char *text)
 {
 	int i;
 	if ( text )
-		printf("%s\n", text);
+		trace_printf("%s\n", text);
 	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].string, p->items[i].util);
+		trace_printf("%s:%p\n", p->items[i].string, p->items[i].util);
 }
 
 struct string_list_item *string_list_append_nodup(struct string_list *list,
-- 
2.18.0.597.ga71716f1ad-goog

