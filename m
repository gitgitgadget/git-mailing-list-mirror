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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50DAC433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E82961A06
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 12:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhCXMbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCXMay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 08:30:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9AC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:30:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so1116651pjb.2
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJK3jIQ1ELZfn8vekPFuUlXYx0CPXSfpa4cGSxfpWDs=;
        b=oXiCcPciB7aWImRo1C59C+b73c3H2cBOamBC4Nx9dspco77cMXLSbkbe2Y9kZT9WgW
         5JX7v41AylcaqUJdhmmzxFdLyIBS/IMouacAFIeCPiyWoBYBieAssdXQJ19eWVNHHvy0
         wG+/l5tmLjxcms91tzktaEPiwU9DdXAd2r3Ut/UFsTKq3Ib5RzqzPsU62UF4bOE/jvE/
         Xthq415JHmptpu8i2M/g8n3tlVUaJmp449rKtO7+xEpWmOFaMFFX9LPhLud5ylj1Z5Ow
         LBHP33dCf1ni4gf5KeEUfJ1EI7pn4GOjk4sRpeV1JfsayfP6v3980D484MO3Sr1OywC1
         KVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJK3jIQ1ELZfn8vekPFuUlXYx0CPXSfpa4cGSxfpWDs=;
        b=CSIGjgTf3Lrcq3GgMMWesmkRoj9jbXjdyPW2+efYDlz8bX+pm/7VyyTDHUqnTeG+BZ
         xlZQKW4RhgE/O67B5RLn+LFIpEDqYXcH71O96m+yVdEb5/aHgJIrP73YlVOQndbx0S4q
         u6kCs182ZDgspJ0/mBQURStfHlgnvNUgs2sZksOftrDWL0DGDNv4vrpS75+NVNt5POlI
         P6i8mLebiAuHXgxIYL7pCGnlwUwu2Q41zcyfUbmxQWSiDDr7sVa9gaF5950O0UddlbMq
         ANJ2mM8xz5gT4eyY0dF7JMJw969LHVqvDF+tsnl5BKy/GQmx+/eMwjYrqoZ/ddIIUc2U
         gKpw==
X-Gm-Message-State: AOAM531oqCcIy3cT9yTLl0zHl5tL6BJwaJOSpjNHnP6i//YCdsW2ybRR
        1qsMPLICGNT0k3QBkDIg8dDjHitDPUGZVw==
X-Google-Smtp-Source: ABdhPJweyruBVJ/Y3/zzgQ02Fqt5r6PNF6Nq5/MhDgdkK5O66lhTAP6GktS4CZBaD97Bt8xKhCtUaw==
X-Received: by 2002:a17:90a:400f:: with SMTP id u15mr3230309pjc.80.1616589053579;
        Wed, 24 Mar 2021 05:30:53 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id c24sm2443299pjv.18.2021.03.24.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:30:53 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] git-format-patch: Document format for binary patch
Date:   Wed, 24 Mar 2021 19:30:27 +0700
Message-Id: <20210324123027.29460-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210324123027.29460-1-bagasdotme@gmail.com>
References: <20210324123027.29460-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document binary file patch formats that are different from text file
patch.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-format-patch.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 247033f8fc..8de172b1f4 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -725,6 +725,28 @@ diff format is described as below:
 
 include::diff-generate-patch.txt[]
 
+Binary Files
+~~~~~~~~~~~~
+For binary files, the diff format have some differences compared to text
+files:
+
+1. Object hashes in index header line (`index <hash>..<hash> <mode>`)
+   are always given in full form, as binary patch is designed to be
+   applied only to an exact copy of original file. This is to ensure
+   that such patch don't apply to file with similar name but different
+   hash.
+
+2. There are additional extended header lines specific to binary files:
+
+        GIT binary patch
+        delta <bytes>
+        literal <bytes>
+
+3. The diff body can be either delta or full (literal) content,
+   whichever is the smallest size. It is encoded with base85 algorithm,
+   and emitted in 64 characters each line. All but the last line in
+   the body are prefixed with `z`.
+
 SEE ALSO
 --------
 linkgit:git-am[1], linkgit:git-send-email[1]
-- 
2.25.1

