Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B1C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21739206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9H7HvGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLZTzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:55:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41370 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZTzM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 14:55:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so10817011plb.8
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9zRq52tAgDliOgSLhbSUY1zxqjZl8SpHaniqbSArlK8=;
        b=H9H7HvGlZ0bOdjI0tztNpE0PWcpboaNob4ds4eawdCsTX1OQCKSDpu5J93MfMXbjxF
         brHhoY0qepmBOh7d3+qfmNYaW9vQ3wRoOOG99mvLlitRf1u+TGVPumHLdDzN9USsPa2S
         lyINm0agkCLQMgAc/NjQMA7kIFM6dkyufJxC88EI4lw9RZ+FhFZpYgt/1swcTxNXqbTF
         nDfW6w1uDdEWypdn/J/g1ZLPUQsXyi7fP+WZoiBGbj0fUPhwMGNjKcbUYhZsUZCfjp6F
         /TMspF7LLXG/XZLZiUkzyq57Te/Kr0Ob+2P4Obr5yQFZ3IA7QaN0mqRoffjhlmVonV24
         r/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9zRq52tAgDliOgSLhbSUY1zxqjZl8SpHaniqbSArlK8=;
        b=try7dtsbNe0vGqxIJxLKhNuHxg7ofuLRZQgGKW3cCDpyfdPg6WBLswfMf7iJ/QQxc9
         VLrjAc2aew6plT/N+l0Jaq5iHzDhY+vK8fxJtT/zyXCOjxaFwkkQQhLFSq5W8Y3i5fLw
         uYujx+cBgo+nWdOQLDyZo41+ThipUL2voMBXptZQccmMU/B1pvnDrPkWxnhUigmM7qoA
         QwCB5z28WenJoO4JD5k+Z0IHRG9Ym8I7I/Tyrb6JfjhX6xo7i8L8VNl7IDVOgwFPK8q3
         wtKLvdYwwVyjmsD5gjCz0x+ET/LnJookHsdC+BLc8exhN8QkmojlZJOtEmLLT8MvSOjz
         42cw==
X-Gm-Message-State: APjAAAX3AprVYgc2ascpJ8WouCoQF86xM7MPpDILkk3YBHsVvfMIs1/9
        iua4SFcbZSmjN6RCIX8qEaQ=
X-Google-Smtp-Source: APXvYqyP04ijg4BgGm2c2qDzTzWwxyweiXXG39eqDFQIJc4bxS2MbJj1DVVodRuYpDfeSi5B1icoFA==
X-Received: by 2002:a17:90a:3487:: with SMTP id p7mr22072068pjb.115.1577390112204;
        Thu, 26 Dec 2019 11:55:12 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id l21sm18780809pff.100.2019.12.26.11.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:55:11 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:55:10 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/2] fetch test: avoid use of "VAR= cmd" with a shell function
Message-ID: <20191226195510.GB170890@google.com>
References: <20191224005816.GC38316@google.com>
 <20191224010110.GF38316@google.com>
 <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
 <20191226195357.GA170890@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226195357.GA170890@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like assigning a nonempty value, assigning an empty value to a
shell variable when calling a function produces non-portable behavior:
in some shells, the assignment lasts for the duration of the function
invocation, and in others, it persists after the function returns.

Use an explicit subshell with the envvar exported to make the behavior
consistent across shells and crystal clear.

All previous instances of this pattern used "VAR=value" (with nonempty
`value`), which is already diagnosed automatically by "make test-lint"
since a0a630192d (t/check-non-portable-shell: detect "FOO=bar
shell_func", 2018-07-13).

Noticed using an improved "make test-lint".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5552-skipping-fetch-negotiator.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index f70cbcc9ca..a452fe32fa 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -107,7 +107,11 @@ test_expect_success 'use ref advertisement to filter out commits' '
 
 	# The ref advertisement itself is filtered when protocol v2 is used, so
 	# use v0.
-	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
+	(
+		GIT_TEST_PROTOCOL_VERSION= &&
+		export GIT_TEST_PROTOCOL_VERSION &&
+		trace_fetch client origin to_fetch
+	) &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
-- 
2.24.1.735.g03f4e72817

