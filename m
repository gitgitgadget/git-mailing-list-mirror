Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59108C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039C622275
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpRv4xXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgKBWbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBWbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:16 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D6C061A47
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:16 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 22so5462940qtp.9
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=Y6MHdBdPxqowdqb96wr1JWEY0Xk0KmoTvIXiei+qIyg=;
        b=IpRv4xXbalnbNfzJymaX0bDglImMgd27UBTYpB91YJ3Smfa1CLV0CJlgTEHPLr/JK+
         5EUcGI3PNZNFi6vzNTkB1rf317ZYDCc63V2dJ+B1Xa1O/p833kGcTQ4BU7RV6Kn8fbk7
         gA0uKeKdTALM2vroahbeY+xkKTc6mOUWasca4OwnPlVfyuvmERgcNFGbbjwxMm3UvYKV
         aDjW2OWpaEIvTiaRW8VY+LAWhma6IkO1VDwgM2l3Hnli/PRTAyIaLvyy9GMPhdDuNBIk
         1+7oR9Swpe/xIJpjywJ7+H1PAuecxQVgRtsXWJhDETbx/Rogr+SMYLDE31qcDHdSXpqF
         /KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=Y6MHdBdPxqowdqb96wr1JWEY0Xk0KmoTvIXiei+qIyg=;
        b=GGurL2uhwb3ulMaLXOCgp6FYDxLFFA36oFsHRYUYUCc14UQdt5HQwX/yu8Dux1ExtH
         4CIrx53znLBvQ0lornv95K0edq8K7OOPvarncVj5aUhmyJJtB6UdCZ9sxVCFhgx/t5Zl
         Q3WMXqPjOKetPc/WIO9088NaLIy5OmERcyFqDdPUBKYMcQBVAEnK6H5S4j0V08HIS1l+
         3RFdmQ6xGlRt+RN3d4+0eBEsm7h7t7pLQaVYeVH/fjicgtiHk/SnP7pv3XOv++Go/dhx
         G3yb6s7wCGzxR/a7zYd/+90JamxIdmV/hdE+kCkdXS7YvoHIz9bNu2fMPq+t0uVTda+2
         YZeA==
X-Gm-Message-State: AOAM533Bf3vlUeKPrE2uAmFMq0yZGoMLZoN1LT4IVLWejM2fjPGgHiwW
        /hOLnE7r+O6Ki/rwZLW53Um/H4ltl/XQvjuqYKIP5LRUDGQEb3iMCqz4AwwEd4haLGpxdP7zuoG
        2DzzFa/HuFoC6WRxXdGjcR8SUuWZp1ZjIZKbXbF0IyQl7ebNTfUz7kOBFaUrmY9A=
X-Google-Smtp-Source: ABdhPJwbJTp9UkPXTj1J8fdvTAicC9imkanRDJ//EMj76wpBcidgmJElp/n0IKM8lj9PHkiYv1ASwE0IqKllyg==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:ad4:5004:: with SMTP id
 s4mr16752928qvo.49.1604356275642; Mon, 02 Nov 2020 14:31:15 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:00 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <5d5097b67109554e0763724633810ea616b5e2b2.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 02/11] docs: new trace2.advertiseSID option
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document a new config option that allows users to determine whether or
not to advertise their trace2 session IDs to remote Git clients and
servers.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/config/trace2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index 01d3afd8a8..3f2e3b4425 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -69,3 +69,7 @@ trace2.maxFiles::
 	write additional traces if we would exceed this many files. Instead,
 	write a sentinel file that will block further tracing to this
 	directory. Defaults to 0, which disables this check.
+
+trace2.advertiseSID::
+	Boolean. When true, client and server processes will advertise their
+	trace2 session IDs to their remote counterpart. Defaults to false.
-- 
2.29.1.341.ge80a0c044ae-goog

