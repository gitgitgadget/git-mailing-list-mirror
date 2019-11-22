Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE911C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AE62071C
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm8bTHuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKVTAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37939 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVTAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id q18so3463591pls.5
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QZ5szS++jPGn+He2yAIgGt7U3Hfc4j5JqnCCTkat6rQ=;
        b=Tm8bTHuZtJUF/0DpsZvhbDnRT761q5b9dWxhfgEJ6BQKoZ3EjwCAn/BeCFU+1gcTAu
         QR95taIZS8oHhi7tbMaJD6e0IoxamDIWC+YAu8ax+FTBOhQvTPcLXhiIE37Qt0ylo/sE
         0TuEp9UQ2srBQPnNDBgbBnG802KAwcxcy3GhnXF2yqn0gauRQ4zYpBroEWdLITLCXu4G
         atgDfOr3KKOEsUJP0dy/jVs436CrGYBLQgfLTH0GOICXcMNoigpjjLQnOEbcQS4uIRYc
         h0B5ZXknsP1bUd+bQghCqxU1IuDhxbIYz+ah9bVokNIs1zmlwi2+MvnLzLy0ENmE1EwL
         gefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZ5szS++jPGn+He2yAIgGt7U3Hfc4j5JqnCCTkat6rQ=;
        b=pXLWPNmNCnRQWGKzIRHv9Gtvd4xZpIAWQQcDCG4gosZogeQ/mrH56XEwv3PQY5gZ6z
         sM6FrJzQaAxIoa/8/V+ok5JlCoJYq+T56KTGxavqU8CS4ecCCFYknxjlilsGm1sQ91lm
         BcQ4qsuNWT1EWoMZTqop1IvZ+TPvti3NvwaUyDGkMqViCLd43q+WrVC9ldlUvhBrBfzq
         m0EPjO3oZpwmZjLq1OGL7LIOGHHiurkcDKVYfG6d3+n9f63yR91zax4ANw4v5PDtNYtD
         SrldDJWTN1RetPOPq3EemXFaVn+mddDSoelaWpSfnnlLOElko5kzUS/iy82RsklP6iK/
         mSfw==
X-Gm-Message-State: APjAAAXEXTRcTEqMsv7B8roV2j/3pdQjqSOx1VoZvgGrawkEnzqMSozI
        MDMAegKllNOZJWUXZLeuzoSPl9C4
X-Google-Smtp-Source: APXvYqyUZFdO1TcJSkW7fRCfXc+8M519HT9opA3Lm0BOZOHsi9KLWqy0WABs5HU141mfZOwQZcDPSA==
X-Received: by 2002:a17:90a:7bcc:: with SMTP id d12mr20756602pjl.63.1574449201242;
        Fri, 22 Nov 2019 11:00:01 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id y4sm7977598pfn.97.2019.11.22.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:00 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:59:59 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 07/22] t3600: stop losing return codes of git commands
Message-ID: <a7d76f9cb912bfcd0eb2fa413c6a5d8e104d7668.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a command is in a non-assignment command substitution, the return
code will be lost in favour of the surrounding command's. As a result,
if a git command fails, we won't know about it. Rewrite instances of
this so that git commands are either run in an assignment-only command
substitution so that their return codes aren't lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f6e659b7e9..0c3bf10edd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -304,7 +304,8 @@ EOF
 
 test_expect_success 'rm removes empty submodules from work tree' '
 	mkdir submod &&
-	git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) submod &&
+	hash=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000 "$hash" submod &&
 	git config -f .gitmodules submodule.sub.url ./. &&
 	git config -f .gitmodules submodule.sub.path submod &&
 	git submodule init &&
@@ -623,7 +624,8 @@ test_expect_success 'setup subsubmodule' '
 	git submodule update &&
 	(
 		cd submod &&
-		git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) subsubmod &&
+		hash=$(git rev-parse HEAD) &&
+		git update-index --add --cacheinfo 160000 "$hash" subsubmod &&
 		git config -f .gitmodules submodule.sub.url ../. &&
 		git config -f .gitmodules submodule.sub.path subsubmod &&
 		git submodule init &&
-- 
2.24.0.497.g17aadd8971

