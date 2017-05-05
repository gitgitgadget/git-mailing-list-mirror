Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC12207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdEFStc (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:32 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35986 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdEFSt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:29 -0400
Received: by mail-qt0-f196.google.com with SMTP id j13so4884771qta.3
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yJnR9gfXB5QDTXLVukOfgO4lkytgPA3M3u0m0+P3Q+Q=;
        b=ccLnuiaqf491L92o+dWcycviHM67dB3VH8TXv4BXhbBVYFvQ9tyBeDdWqbgeUpehQA
         SQ/leys2iepruc5rVgaev0x1SK97TG/gc9rDCXyh3HZ0jwX1GmCGZbt+3I3GHy5UVK+U
         bijXuSYDYIXPwB4lMSOzIHaSk5D1QsGio4OindquBIU3NCrQj611rnx4AW3nAOm29efa
         W8p5Q7ulAM8UuWNbbdvs3HwGVyULLJ7q+5X92llfJLDMmoP38gI2JB7N+NheWtSQBlWP
         DWyKsYRcN8e6cpmcFDvJ78UScfSqURdJRiXSh1maOhagjPKGz8mTUF82dSVE7zQ6ndtL
         e42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yJnR9gfXB5QDTXLVukOfgO4lkytgPA3M3u0m0+P3Q+Q=;
        b=j9CzcKLy5J2jegRHEifkpZ8ZtzmAbx1LIz1gg0qILSowiGsbYRSNrT5q7XqWV/B+xP
         +yC9408ABUukXENK6FM/zTDzXc5mAh1m8NiZJQcIP14O80Ehf2YL56mn4qyps1XU0IQu
         WyzX+8HKTC+EJbLt2Nrncu8O6/wTh4/PCSQltLjVLY0RK6sU4d2qy321Uv0kd0rP+P4t
         5hZZL3Ee0DK3SQMwOnuFnZWZFFy6FahC0vq87Z2MEwsO34SJJ5acYdRYFlJ5KxdQfw65
         DX5vdEU677rsJ1cNyH1zQD0UYWg07odFRfsxoMBUgCxYLsDTZamyhOIxBd9iufm6sFtM
         tJTQ==
X-Gm-Message-State: AN3rC/4XkwMzuH4wBj96vzFy3mIdE4xVYpK2Elc4MgNhcFZLMBW+W3HO
        RigSeWzZ7aTnGhMJYWU=
X-Received: by 10.200.50.216 with SMTP id a24mr18049149qtb.91.1494096568561;
        Sat, 06 May 2017 11:49:28 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:27 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 1/9] t7300: skip untracked dirs containing ignored files
Date:   Fri,  5 May 2017 05:46:03 -0500
Message-Id: <20170505104611.17845-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If git sees a directory which contains only untracked and ignored
files, clean -d should not remove that directory. It was recently
discovered that this is *not* true of git clean -d, and it's possible
that this has never worked correctly; this test and its accompanying
patch series aims to fix that.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7300-clean.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b89fd2a6a..252c75b40 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,4 +653,14 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+	echo /foo/bar >.gitignore &&
+	rm -rf foo &&
+	mkdir -p foo &&
+	touch foo/bar &&
+	git clean -df &&
+	test_path_is_file foo/bar &&
+	test_path_is_dir foo
+'
+
 test_done
-- 
2.12.2

