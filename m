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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E2CC388F9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8AD20791
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFa72zDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgKLBc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgKKX3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:29:41 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B7C0617A6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:41 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q5so2252407pgt.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=q5sEuC3n8RveOdl6xjqIRa92pbUf7agPILK2zH4JUbk=;
        b=UFa72zDplsg1XcwjdhIWQGK0yMdFKImWRVw0Nk2jb+QsKoN3he2ynycOdgDAt85sDn
         f3emy0iEV8z0fbyxK2Pu1i2nuzNjqGB66V61TQgV6vLPFQwI320CQGZXeHcizO63/JOF
         735zT0NlqpEEOyOaQnrZC6M57hOR4jqXRd+Hd5CWZQPXAAx2ZZ+tNLkjw3v03x4XES67
         +738ObHJvK7Y44bE75vbb4pXbeevsRtvKW3huO0mePpO8z0VayaWPS3GnqoM8onuQxqs
         T1QT+rOXO7fy1kLL3kHDZ0kGkXvXTHXtsl1ZJ2zOrTdTHxDzYGTfjW70TzPTrhkZwMDm
         ddMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=q5sEuC3n8RveOdl6xjqIRa92pbUf7agPILK2zH4JUbk=;
        b=F9QCAXaiiGxo3eS4DDuRiR0y57Q5yuBWwZEOrYmcgkW8pkY7lWVmGESzkEexWSGpBy
         FmDMsL75O+StRwNWO0QO9IrAvDESRj1WKQt83hverAZl3Secpna/E6w0X4XmDfBPOcDQ
         QN5foUMYP7b+B+9dCfpsgZKYknKFBp79khcofL+PHtbjuDu1dKebKxFxZDCWnYbJMQar
         p8z11KubinVLY/OW65xVE/NTUUq6QFNFOLKrlZkOziXsgR2L8OIdSvGB/Gt1n+xIBrin
         1ZfuLrL863z5fttc7WOFOU/oZTpZjze2JlLrDDi8OZeCeSb8IAaxtrjmhkmOEalX3vc+
         ftVg==
X-Gm-Message-State: AOAM533D5YZU5cBryPmJEcec/UGUZKC3Eb5U3dtylfG/3nRMCNlljY3Q
        ihPP8RsoifH7bFZeDO5Xd2czL1XPTyKrGrlI5AaYhIM7nTlRAuQyqQ3+3/wzzIby5wyXJgfrii6
        ef/BNFlLrL8XByui+e/FrNUHk+GLODSNYKYzwf1iH+R5hOYPas1sOc5tHpHoV1OY=
X-Google-Smtp-Source: ABdhPJxWcC+QdnJM4jIPo7evqzNsHjuzm1NxQW8092gXA/oaVnwfq+jgXPC9apliaVXr+oXxJI8PihTbBsIROQ==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a17:90b:293:: with SMTP id
 az19mr625042pjb.1.1605137380468; Wed, 11 Nov 2020 15:29:40 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:25 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <937534065a9d5609f61fdcf7a8309418a07cb755.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 02/11] docs: new transfer.advertiseSID option
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document a new config option that allows users to determine whether or
not to advertise their session IDs to remote Git clients and servers.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/config/transfer.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index f5b6245270..505126a780 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -69,3 +69,7 @@ transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
 	The default value is 100.
+
+transfer.advertiseSID::
+	Boolean. When true, client and server processes will advertise their
+	unique session IDs to their remote counterpart. Defaults to false.
-- 
2.29.2.222.g5d2a92d10f8-goog

