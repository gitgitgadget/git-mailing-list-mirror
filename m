Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5D8C432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35992240C
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUasPBpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKSXzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:55:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40253 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKSXzn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:55:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so4996169pgd.7
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nYWFdTPer+CqHXVb9a58OxkeMilcMhYxjFB7JCX/8jc=;
        b=pUasPBpq9ztaI9iZ5Hzwq7j5biDFnWH0mY9LcY/NSV5o7kbI16gASMqR01J05MPMV9
         sO+/D4NjE7/6OYpqAicx+jx2vbAvjGUjC91Hd18990sY8O8gxsKnJop9317BVv5Xwe16
         0Bnp3ZAOFyCagk2VfA77tHgt38rxrnlzdBjNWt3QRNq4vuCkwx160PgMo0Z9x6NzGaOf
         dFsd7CF5Vc/aF0QKUjZBlMph1MKg4xIHpcvJTIpyIs9GQ2r3sbuEMbG1mURLFVlq/LNV
         RCvf8/63xfQgg7PXNu7F9oBBl5wKPfvSA6HboRBXCdfOQRS1owHzE07tklqnp/LNXQqj
         fi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nYWFdTPer+CqHXVb9a58OxkeMilcMhYxjFB7JCX/8jc=;
        b=PsyZD9A/+3ldK3j3dhziES+ymf3KtZiJDFnlz8Zdfcw1O6Pj7xW3RKePI7ad0cBK3l
         xqW2TxmQDcbF8viBYG5cnNIdRI6NY58vhALWd5c+ayxGnO0CEjOYQxPRqlm87uYyobbK
         WhaZ6NK0JZ8Dw0PzJFWEhxJLXzgzmlYSZR5OrulyhJ4Ygd5afNbIW7WYU6j2R5nQy1fz
         3LYlD5mH+zxCIy5iTSfBJqeDyMjxBgDheZmE3tc7aDXl4dP5rg219AH+i5jNX40ni2dM
         mXCHWsbwceSY/eALMDHLkrgU9Gko5e/ObQBsq5yR6GlSbH8mrDuD4v9gJzGyVdzdpx5m
         pO5w==
X-Gm-Message-State: APjAAAWLWvgaqm0a5Ck9jdXSrIi41lWQCpPJ+lDWYElB7zMv94iNePDb
        uZVGyoljcHOm7VtzJT5yXXGdHKw7
X-Google-Smtp-Source: APXvYqyIn31gkb+rjZpnGh49xGqHxSbTI3MDLjiMOGsSxE4zJ0kR5cqOr3RTUhj4f96EAyUj/jYUFg==
X-Received: by 2002:a62:1dc6:: with SMTP id d189mr386170pfd.100.1574207741950;
        Tue, 19 Nov 2019 15:55:41 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a13sm10366451pfi.187.2019.11.19.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:55:41 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:55:39 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] t3206: demonstrate current notes behavior
Message-ID: <4cf7d39fe342a1f140598f09369afaf785358aa5.1574207673.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574207673.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite had a blindspot where it did not check the behavior of
range-diff and format-patch when notes were present. Cover this
blindspot.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e14b4951bb..69babdcf03 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -505,4 +505,56 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
 
+test_expect_success 'range-diff compares notes by default' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git range-diff --no-color master..topic master..unmodified \
+		>actual &&
+	sed s/Z/\ /g >expect <<-EOF &&
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid u4) s/12/B/
+	    @@ Metadata
+	    Z
+	    Z ## Commit message ##
+	    Z    s/12/B/
+	    -    topic note
+	    +    unmodified note
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'format-patch --range-diff compares notes by default' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git format-patch --cover-letter --range-diff=$prev \
+		master..unmodified >actual &&
+	test_when_finished "rm 000?-*" &&
+	test_line_count = 5 actual &&
+	test_i18ngrep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
+	grep "! 4: .* s/12/B" 0000-* &&
+	sed s/Z/\ /g >expect <<-EOF &&
+	    @@ Metadata
+	    Z
+	    Z ## Commit message ##
+	    Z    s/12/B/
+	    -    topic note
+	    +    unmodified note
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	EOF
+	sed "/@@ Metadata/,/@@ file: A/!d" 0000-* >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.420.g9ac4901264

