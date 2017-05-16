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
	by dcvr.yhbt.net (Postfix) with ESMTP id 39938201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbdEPHg2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34640 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbdEPHgS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id l39so19358652qtb.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=H+uaLwWyZfUhpX6aBpoTJsrBAdGJmg43lztA5T0rk4s=;
        b=XQ00wZL/VlpMZYNpeeqpU1z1S5+6wmQs4kFwm5qAQo7niLLIP6NBtbHkAlDbeoOk1Z
         UMY0oNBjnLXyzqdyamLVLehUt4rli5s2LZL80FpFGiR7yt7m2ktyqj7AMPOWKfdZA0WX
         ecdWPgCTttIHEWZinS6rbd2ZyCUwN1UMNKSGKhkHoCTYMw3jtS0Coki8IAW6rW0/Q05Q
         p7a48T9m7vxQjDjEJETsSXOVTO/dgsnQnsohp8jQqhrzXCnfSWY+7w8FLfWLUxdyr4n7
         noElzSDwe0+l2rQ3AVIz1bwIAZebCqqQ3vEOh6zGM9Axg0DWi17RP0P0vnXE6WbpWyaO
         gHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=H+uaLwWyZfUhpX6aBpoTJsrBAdGJmg43lztA5T0rk4s=;
        b=m9R6Z0X7bfGmeE2CzSpWAbuUnVNXryqSkG3K0eGisdYQYYoi8esGimUqypfphgNf4J
         cs9BqWDVXzfnT+wKg8k0K1btXJRE8RESdS5cfzV0BNbqTOWZB/3/3huFIQBZhqBFA1dU
         4wIojdH8rds2r7wnLR5eiEY5/1QPMipSzdE7+fS5re1oV4/uhdfPA9mQ4OLp9fujlidE
         cX0brTfz2pgfwBOSvFmnxJ/NkoDBtGYu4O1KW1/L8+HvfpYAbQIMPMEHX1Xa1++oV5Uw
         h0Ofjnr22AoATsW2NpLxUJZwjsH9oNuXcgh8qcW/EA6gHppEEjZsb61Im7tADIhBb/Uy
         XYtg==
X-Gm-Message-State: AODbwcCqx7nberqrIINYftjvsnEHt1YIlJ85L83qLv8bpBmMnVzRUxEK
        unqXgDa033hcxg==
X-Received: by 10.200.3.195 with SMTP id z3mr9751358qtg.185.1494920177535;
        Tue, 16 May 2017 00:36:17 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:16 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 7/8] t7300: clean -d now skips untracked dirs containing ignored files
Date:   Tue, 16 May 2017 03:34:22 -0400
Message-Id: <20170516073423.25762-8-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index c14c98e56..b65d4719c 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,7 +653,7 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
-test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
 	echo /foo/bar >.gitignore &&
 	rm -rf foo &&
 	mkdir foo &&
-- 
2.12.2

