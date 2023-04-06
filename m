Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E461C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbjDFRJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbjDFRI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 13:08:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6F977F
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 10:08:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k37so51758240lfv.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680800932; x=1683392932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXnYY3V5beE1qo6NN2p/1xRlkH+oKvSiqNLN9UkKn8s=;
        b=JmVHce1TyPgaZ7P/6N5GwgO50n+hQx+Dnqj0xsqhktFy2JMVpLiQdr7YkJlkn2MY3v
         ub8ORJdy2oeBoFxWkJPcbghrVgOHgC4MqjuglC+FK1yrAkCmkL1egklluQlZiQykIkZP
         90/2wM2kjs1xY+E7FazKw3o17GOOKs25ZY0wnPXkZ5YxddUOyYTPbmNuAvb1MkVD0Mbh
         A+B+qEICQEhcSVqKsP0ogAa2Gu3OcvztU6sPE47kjyKHxpemo0TqFZHtaBEZcUOLJlqL
         W5d8aU0oUZCURAH9VeZ5iGsYe/9jrE9plPRK29lVCAoE1dcTppA3Ph5xjObGokPbHSsm
         dN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800932; x=1683392932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXnYY3V5beE1qo6NN2p/1xRlkH+oKvSiqNLN9UkKn8s=;
        b=0VN27UzwecfjjH3Y47V9VFN3dgKKBnDVyuIZWZEj+x4+FYEFhrI0wPpGdwgCW6QtW1
         YFgff12jFhxOrxpZDbSRv0U/FLiCIlTu4efGrXkb3k7aXkI0XvVc89FcunMl3ldRVgDM
         zTWyMXzzdgFV7GSohGJZ4fJBLVi3YT7ZCBbzFtXRnj1C6KFETLdB09pCUg++kNWJK8k6
         TZy4VQgDtkRYPVmO8XkZT+TuKzvImEdtOFEmxhveBROvb4ZStRucz9MUTyvQbMP8blId
         lXCBrBaLPsjmYtKZn3/+MMA82fgJdXaR6PlrLtDRd500Dxt/m5lyt25Ms/lWwveLc2zn
         pncQ==
X-Gm-Message-State: AAQBX9dxJ8yOrTJQ7J0JUTQtzB/34X49kOV5JO0utpTlGFYLXAYU1DuP
        QB0SnhNcg42LMdu5bfYaSnNUYtZQ+iV3Kw==
X-Google-Smtp-Source: AKy350ZeOt3r6ocWto36SXv04UEqsidqTOpCihAeIgopG5Kvanjl2CVv+0/D03RbPg8F2BTuvYFVSw==
X-Received: by 2002:ac2:428c:0:b0:4ea:e262:b94e with SMTP id m12-20020ac2428c000000b004eae262b94emr2488742lfh.21.1680800932682;
        Thu, 06 Apr 2023 10:08:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9c74:f016:4c88:53bb])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24850000000b004e817c666eesm338412lfy.193.2023.04.06.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 10:08:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com, peff@peff.net,
        oystwa@gmail.com
Subject: [PATCH v2 1/2] ref-filter: remove unused ref_format member
Date:   Thu,  6 Apr 2023 19:08:36 +0200
Message-Id: <20230406170837.10060-2-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230406170837.10060-1-oystwa@gmail.com>
References: <xmqq4jq0hp1i.fsf@gitster.g>
 <20230406170837.10060-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

use_rest was added in b9dee075eb (ref-filter: add %(rest) atom,
2021-07-26) but was never used. A follow-up patch series[1] that used
this member was submitted, but ultimately the development was abandonded
due to performance problems.

[1]: https://lore.kernel.org/git/9c5fddf6885875ccd3ce3f047bb938c77d9bbca2.1628842990.git.gitgitgadget@gmail.com/

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 ref-filter.h | 1 -
 ref-filter.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/ref-filter.h b/ref-filter.h
index daa6d02017..e3eea5e3ad 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -75,7 +75,6 @@ struct ref_format {
 	const char *format;
 	const char *rest;
 	int quote_style;
-	int use_rest;
 	int use_color;
 
 	/* Internal state to ref-filter */
diff --git a/ref-filter.c b/ref-filter.c
index ed802778da..20e0a72f24 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -596,7 +596,6 @@ static int rest_atom_parser(struct ref_format *format,
 {
 	if (arg)
 		return err_no_arg(err, "rest");
-	format->use_rest = 1;
 	return 0;
 }
 
-- 
2.20.1

