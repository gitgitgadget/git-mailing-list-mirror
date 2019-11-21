Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96CC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816C620855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvcUGDXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKUAqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37433 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKUAqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so701806pfn.4
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjfQ6ycQDyNyYAtKnfsUOUipajF2IsK+eNYd1+zSH9M=;
        b=IvcUGDXBPZrwfHr7n3AdcVR+7diM5HQ3N9yhUnMfW6c1soCALyRHxLW1Lb8FBIfM8x
         IvuKvediaPLhwiwY6DLsynA5HXH2HwPDbG1JXIQldl/nH7h7VHrN5+SKzlIqkG+BeDO7
         124/QQAmC84JaLe12RQ25Wt/stHYsjdC78z3c9nh1wz6OzLq8p30IeKJVZld0hRs15UH
         rxYigYZwtb31qH5SuEcvbR/O4GKziYMMO1lN4Y/u5jYcMdychGf8Ly/dXKeLd6c5dpTn
         ecUM34yegX844ibRNhN4OVykgu3qomyVvFdjzJD8pShwlBoSK/1IVXnx52uN453gcbAX
         E88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjfQ6ycQDyNyYAtKnfsUOUipajF2IsK+eNYd1+zSH9M=;
        b=O73WhOAaiWsOCtFOQI2XLunJaGa25nG/JBnJirAeWxp4eWwdElHLDryZqf7v+q8od5
         GEoaoVHgrxewQJ1eBM/34cIyF5GhDb+UY8KyNW0RuHULR8DQ/A5IqkIQSI9AVikjVbhY
         HU+G9lZn3fmUs4mS1kDi6oKW/xcN7PvS4ATVnmK14PZwZEZh79zPT8Mfu73yiWpSQKyI
         78FXG/M4g5labyh/fANtYcZE8TbuifTuW0FiCfZSOoRBAG4E92jENozcj7rWFjCmnw1p
         H/h0g/NmniJP7f+locUP26ma/rHpTg4ndVLwaNd5KxNaPsLLQNTt9JU7MS0Xl61dEhKq
         R4YA==
X-Gm-Message-State: APjAAAXKzTYCoC+qXHWcO30tUObQ/5W9UFMh834ImIhyaEwa/GA1N002
        HlWuXyp+/IAGXWmgjhNJION2BRuc
X-Google-Smtp-Source: APXvYqxDG7G6utO8BNcbs7o7EYsSK5MAFGS+VWM1UVKUFY4d6OdWOYXzx6+EJCSVKGwapfzCrJ4Mmg==
X-Received: by 2002:a62:b509:: with SMTP id y9mr7118232pfe.12.1574297170103;
        Wed, 20 Nov 2019 16:46:10 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 23sm414880pgw.8.2019.11.20.16.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:09 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 09/21] t4015: use test_write_lines()
Message-ID: <9fb33ea04eb291ea8de3968fef998435d2fd1cc9.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of rolling our own method to write out some lines into a file,
use the existing test_write_lines().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 7fb83c8eff..4c540b1d70 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -771,9 +771,9 @@ test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
-	{ echo a; echo b; echo; echo; } >x &&
+	test_write_lines a b "" "" >x &&
 	git add x &&
-	{ echo a; echo; echo; echo; echo; } >x &&
+	test_write_lines a "" "" "" "" >x &&
 	test_must_fail git diff --check >check &&
 	grep "new blank line" check
 '
-- 
2.24.0.450.g7a9a4598a9

