Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4DE201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbdEPHgN (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:13 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32900 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdEPHgL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:11 -0400
Received: by mail-qk0-f193.google.com with SMTP id o85so21251465qkh.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bfCJk6X15b2Nf5Fq1g/F6d11yTdlwiknNdBi2UPan8Y=;
        b=gT8pU6OyibmN6OjxpudLjwDAUQcMLP/JIZzgZjlb0G2JsdQaOmQEAzpFcQf9Y7OGHL
         WIV6EyozB5BK3C8uOS8VfneR9l0Hvi2H6wqE+XVmEWYm8Cj0oW/AXRVMYm/LWN6+LU4A
         g9vtwdI0bMcB+IBOjdVNp2trl8v0tPlT0WMKJV7bk5N+4pAHWyXc/Z0Wnzy/Pm9WpaBd
         fdjkxBNmV7SUXS3PnHrJ+rUUbE0JZVb9xQcpnBh3hIINjv73wkArORhaoS47cv5EpMOX
         zvh+02VO0FVVSysPFmNVseSFa94uP2LaUpLEXkjrMPp21di50peigTy6F/khawVb5+Y0
         Jryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bfCJk6X15b2Nf5Fq1g/F6d11yTdlwiknNdBi2UPan8Y=;
        b=WFnGnLGUxatsA4ym3w+xqP2/RdxQHPYVEPnsyK7WS2SYQp26fIpD17s7hBxvsPhIIq
         BHSGBCKOjhNP/WdwjK3zNpisiOOiTBckwyN9UtjFqvZsE/CkheP8pZ9t2/v8iai4hqcV
         D44Py+JmBweYxt3KJBxp7JxkRtMCrJ//PNrd+VDb7KevU4wfCRxAxIEgHFKxgjv1QGtA
         5K03LEfAl37IaENgsYa6EfoCoQnDICv/SC9PmUUWIrppu7qbnkMljTtiy9d9fP9PzcsT
         yn4trkBKC5Jff7iX0lkcQzoaG4xAD4gmwPUt4k7IOT+Q1fCtpmYZBq/EW6yf0yxgI2+m
         hCsw==
X-Gm-Message-State: AODbwcArpyuUX4XrihpkIHnWVLd/d1o+/xKcoLTZT1Vsg5g6WC4cZ6Jw
        L/uV2PbZLyVQKQ==
X-Received: by 10.55.39.131 with SMTP id n125mr9654482qkn.215.1494920170909;
        Tue, 16 May 2017 00:36:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:10 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 1/8] t7300: clean -d should skip dirs with ignored files
Date:   Tue, 16 May 2017 03:34:16 -0400
Message-Id: <20170516073423.25762-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
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
 t/t7300-clean.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b89fd2a6a..c14c98e56 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,4 +653,15 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+	echo /foo/bar >.gitignore &&
+	rm -rf foo &&
+	mkdir foo &&
+	touch foo/bar foo/baz &&
+	git clean -df &&
+	test_path_is_dir foo &&
+	test_path_is_file foo/bar &&
+	test_path_is_missing foo/baz
+'
+
 test_done
-- 
2.12.2

