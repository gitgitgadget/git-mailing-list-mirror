Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43339C4742C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6ABD20791
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMHQpxp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKLBc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgKKX3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:29:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF6C0617A7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h9so3949660ybj.10
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=yMa6nPQATK/YI7+9VIfxkNmcwemehrCcEEiiMSK6Tvw=;
        b=CMHQpxp/481Vp6sI9s4vI+cDxir0pWkSnGOs+kqZUw+GDFmB5UfrMsCiuRs35PNDdW
         bExpGKzIzn05aQBVUQj4kEmfEyNEN1OYINC2GEuINTazIAOk7D5+f9jcDtqOWtov5nhV
         b5rpGk8OBDz2ttNfypMuc/nnSWvCdcr8KSjBmr0/rcJ3YIDq93ox4xvFY/kRKSsJztPc
         iJolenNMsnEpzdTJ27/9wvdHRHxUiGLxZFYIgHtLIIHz5P+4OFmFSJ8EHCIUJehnCyTm
         Gm9IT9YHZXHPu7JBba+b1YUrRgNDAeQ4NtmJ+Ow135/xv48p9Mu22Jk/iDP50BpE0Q6z
         4Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=yMa6nPQATK/YI7+9VIfxkNmcwemehrCcEEiiMSK6Tvw=;
        b=m0loFrtofaPzC8p3auwFtzeU2Iita43uHryKEmdaW1PThOejLc8Z8ZPBPs6lkF7/4q
         8YBTjoK3MtjgZ3gROYvBS1gT8JBvCfn3t5Y15RgxnTogAF6rtvkHYcHyb9YVg2ApNjL/
         gWdQ53MtqaxOtxHgD5nSQnwBvokTIMdsDBkFY0ONerTCHP9Je2fOsDtuoxlYlukfT7oT
         NVdqjlFFf1VewWKkM61IkiUqvxAZlHWgZIxi63/5c6vsVInygkl7C2DCM0hN4D/RgH6s
         DpcTmvrja5X4wknbHhTYB6/fOYE8RqeTPO3IgcK+EX4YZ8Va71LzF49BMwGahq1atCj8
         uwQA==
X-Gm-Message-State: AOAM531OFqQ2H/1iMqVNT9YqhYcdAIBZPIHAlDr8MsLKNZrt4UGGxbo/
        FOi8LlWIskyQT+Gl9kgC56DyMcpEsU+bK7N0HilHTAychesU048lucBGq5u3Wo3WDpYEd5PAVaR
        32PURiQR4pjrcXXRpp9NG9frgQTfE2zSSSf10yZlNDE6gDbLzAsgju7rLsQAmHL8=
X-Google-Smtp-Source: ABdhPJzgsVHhd1VC08PSmN1szuTaRs1qUJypYaUf2ty5pRPjTv+NHG4uQ1S39tLWU4bNKEfgbxVCHYkDZlD3NA==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a25:384c:: with SMTP id
 f73mr35388026yba.135.1605137382450; Wed, 11 Nov 2020 15:29:42 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:26 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <227c709ba54ee457f05704e52310b39edeaae1ca.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 03/11] trace2: add a public function for getting the SID
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a public wrapper, trace2_session_id(), around tr2_sid_get(), which
is intended to be private trace2 implementation.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 trace2.c | 5 +++++
 trace2.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/trace2.c b/trace2.c
index 2c6b570077..256120c7fd 100644
--- a/trace2.c
+++ b/trace2.c
@@ -792,3 +792,8 @@ void trace2_printf(const char *fmt, ...)
 	va_end(ap);
 }
 #endif
+
+const char *trace2_session_id(void)
+{
+	return tr2_sid_get();
+}
diff --git a/trace2.h b/trace2.h
index b18bc5529c..ede18c2e06 100644
--- a/trace2.h
+++ b/trace2.h
@@ -500,4 +500,6 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason);
 	} while (0)
 #endif
 
+const char *trace2_session_id(void);
+
 #endif /* TRACE2_H */
-- 
2.29.2.222.g5d2a92d10f8-goog

