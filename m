Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643CDC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B5E24672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTU6T/tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLSWVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:38 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:42632 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfLSWVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:37 -0500
Received: by mail-pf1-f171.google.com with SMTP id 4so4068143pfz.9
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gqVg+mKGwzsg9uBBepfi+0oVdFuohGoCSh4opBe2r0=;
        b=nTU6T/tCzSDzBthI5jLnAppo7riyNFHaDFhUxJB3vyy4mSh951HEAZihPaQuC6pwgd
         zew78JfwkYlYNY0zP0YOK8NqtQPUWej6f2jHAMt13R1PJQfwc8dAX53laKo9Qrwcy6u+
         0G2yfC7nTf1wfjeWLfJ/YMq6XBBTHiEa/SqZPbAw2V2Kbs+TL05ECREPQiiSi+8BBp5L
         PjEhmeWhpJGnX4NQa8dZheVB86eRtGjKFn4C27KoJTdXt1JSbnmo9w1H0xvcizdjSiFq
         5HQ4dLS/8B6ro7nc+PnYfkEMyoXAlb4UY7V0nOzaEYybfMSQ08vQG9A23GYDBkWnI5uk
         svtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gqVg+mKGwzsg9uBBepfi+0oVdFuohGoCSh4opBe2r0=;
        b=tj9Y6nxdzLG46/ZWR4X/U3YpDC52rM3BhTk5IKbuDp5gTkkhgy6qhcXiueh6OiDTtM
         d1GxuPDUH+ic0imyCqV6JZDQIS0dnUq60NhKg7ln9I7J7kFisX831d/5vurrvZrt0hV1
         hJcHIR47ATe9n8MfFyum28xVMKnLourGAAvr16iX5QeQ9RoZElIJVDsXHQHw7uiweaL8
         mSUM4k8kRhuUQh5ANEYTNK4Q405Xrwxngh7K9T7BuzwoCQ2JyxmpWD/edevXf/aB1YhB
         X6eXDvfCVfuMIl1lM4SVFMdBXYeuH9hdjWXl0m8dy2ehc5jXr2F47kZjpq0AUSq6XtCg
         W1Cg==
X-Gm-Message-State: APjAAAX80ejtZWCSMT5YKzfE86BwfpPsSGJsaNI+uPOSAQc0SVKoYSQP
        lH/9AHA2ZFCVn6vkILLsKTjmMumH
X-Google-Smtp-Source: APXvYqwFSsyFGCA/wFRQZ9GM830rqNxjEVKIGp+PdeFiLYpseeACoNpuQmZ/yTPpd9e6slg/p+db9Q==
X-Received: by 2002:a63:554c:: with SMTP id f12mr11699922pgm.23.1576794096441;
        Thu, 19 Dec 2019 14:21:36 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:36 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/16] test-lib-functions: introduce test_non_git_might_fail()
Date:   Thu, 19 Dec 2019 14:22:36 -0800
Message-Id: <85cee927656cebed34bc93280d0b2d89e0caa570.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be preventing the use of the
test_must_fail()-family of functions (including test_might_fail()) on
non-git comands. To prep for this, introduce the
test_non_git_might_fail() function which is used to replace non-git
invocations of test_might_fail().

The test_non_git_might_fail() function is a lightweight replacement,
always masking the return status of the command and returning a
non-error exit code. Unlike test_might_fail(), it does not check for
abnormal exit conditions such as a segv. This is because we are not in
the business of checking the sanity of the external environment and we
can assume that it works properly.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/test-lib-functions.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 284c52d076..61d27f1ec6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -891,6 +891,15 @@ test_expect_code () {
 	return 1
 } 7>&2 2>&4
 
+# Similar to test_might_fail, but much simpler. This is intended for use
+# with non-git commands that we can assume will work sanely so we don't
+# need to check for conditions such as a segv.
+
+test_non_git_might_fail () {
+	"$@" 2>&7
+	return 0
+}
+
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
 #
-- 
2.24.1.703.g2f499f1283

