Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573E81F404
	for <e@80x24.org>; Wed, 20 Dec 2017 22:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754428AbdLTWRf (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 17:17:35 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:41756 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932599AbdLTWRc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 17:17:32 -0500
Received: by mail-io0-f195.google.com with SMTP id o2so18917203ioe.8
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8HHPrWtZICockysHxwI+iC7dbwdIdGC3n/kT5okyEU=;
        b=iRuRkCYDvsivapYTnVTm++sKkoEvsZauziaE3HoW1vtYYFS3ZhgC5P85v7UxOYrAnG
         BT3nOhVnmIOF1xHwqproOCpr+uNb5aHQtlBh5+dfgQuziCwBXhR/46SJTuOd9oH8b2qX
         S0qOg38oGNzmRQ1rmDYrOLYLRjaKVnGcKHvr3vsiRTZY1iBuPnMB9fNaKeaq3TXuhdDz
         yz/ZNENB917vt/q0JQ5x6+H9Iko2UAlWBrbspmgk11oGAfA9NgTPNPb+4GFtT4qjB502
         pXzzui3+47Mnyh9bfcx4z8rQ8N2lvtjSlS0aFf+AoXtmAWSOo+8zr12M4PZh8eP3C19n
         LPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G8HHPrWtZICockysHxwI+iC7dbwdIdGC3n/kT5okyEU=;
        b=PeIRbJdvnfPlFUpFepLOsirQZj7T2dBJwSl3bpSQIp9dZngJ+uRYZQpBw5SzQcJJ+/
         uqbuk6PmoYS/IE7VoCj3YwOQNVLRuB4tM2YunK5P6DGRQCpTT5xWpZJttGQcD5EDDwiX
         CubJJN8EeLkeDO85ZCmPaZncXBODeEr5RyYLzUIBcMNlKABJqj62xz+4O6aA2qmp42AT
         RSDA5Tu7dlTHbFXiV/UU5KZYZUmAXBgjkO2DlT0ZfJqMwxfadpkPTARp4FSQgRWt4842
         8s0vqs6DMO8uKqOP/e85lk707tjCaL8DQcSAWWYaVhUS7EzzUQFNoCGudEZ7TcpGNZd9
         2EYA==
X-Gm-Message-State: AKGB3mJRjLLFdFofMyVpY2T3hujlvnWr2IFRP4JgNClUzd71PDIKL/Fp
        Gllmt3xf5kkbKVu+8kSrEmwd1Q==
X-Google-Smtp-Source: ACJfBotmvfpk7DjWn4cOLxjRkieuBAc2h0Is0nTzhNsWFylu90JlpfQ/DWoYpE1avhNYFJ7GHzDroQ==
X-Received: by 10.107.16.136 with SMTP id 8mr9890539ioq.228.1513808252098;
        Wed, 20 Dec 2017 14:17:32 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k9sm3138547ith.25.2017.12.20.14.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 14:17:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] t/lib-submodule-update.sh: Fix test ignoring ignored files in submodules
Date:   Wed, 20 Dec 2017 14:17:23 -0800
Message-Id: <20171220221725.129162-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171220221725.129162-1-sbeller@google.com>
References: <20171220221725.129162-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out that this buggy test passed due to the buggy implementation,
which will soon be corrected.  Let's fix the test first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index d7699046f6..fb0173ea87 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -885,6 +885,7 @@ test_submodule_switch_recursing_with_args () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file &&
-- 
2.15.1.620.gb9897f4670-goog

