Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E741F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbeADWxS (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:53:18 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37340 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753668AbeADWw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:52:57 -0500
Received: by mail-pg0-f65.google.com with SMTP id o13so1275276pgp.4
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=025ZItdkO7VhUgTnVxRwxyPD9nRW7wWvMIXfFKCs0Cw=;
        b=EjhzKHTjGwI+zNew3ljlf4Y1RoJzSA05JIV9i8mfRCrNZOoJPt1nE6jJ94WW1eBeQL
         fGN6YGhY7WBgR1OXco+eMb0ojnA4F+ArgBSGXLjXoyAcucUI8k+McnXXe1US3e/C3vM4
         vMeIUwV9xUNsjCYJFtE65LE0WoipGYN5ls6pVtlgUhDxfTxVO9h34lraDIwBaCn3/ZCi
         oEUUXg7y/sG/PIqT30w+wOj4fduDR/o5NGSjXimO+lk9m25QUQkzO3SoDwcxKQEuNXWV
         wNumb6OVFiy8YCcW4KkNJHZihpDCdqxgjSJnSPeaZFe0mN576c6WyLWQ+uWmkgIE/pe8
         gpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=025ZItdkO7VhUgTnVxRwxyPD9nRW7wWvMIXfFKCs0Cw=;
        b=Z96YExhHfg4F3CEvkhBRWwK7xeP3xnIDHrWfDnsKzFIIzE8Kw2Mg5e7S3lVsu62xlR
         fVGedwAAjSWAVVEyAZo14LJay577ocwvk2cXd9+YSJNGCFboPZLQhMkUa+bJ0Lk0ECWe
         SxAnYvWbjIsS6JI5CX/IYP99eXrYEuoWsIUvrcy/1EF2DR2qy5vPdmXdGcLxpzlDnbfD
         5t4mIDQxJYuwPG/2J0h/P7TcyPI8SxXVXGmkVxQuOBdxv48I/InKv1DDvY8r291TNMZ6
         UeTa4llc5cjhLXXUJOT4i/RXaI2Q5fK6IHvRzayX9Ho8K1ystZ+5Xy9hZ+7tNAfzVl0t
         PPtA==
X-Gm-Message-State: AKGB3mIDJXY1X8aRGSdCIHDD1SkMhMnZxH/YYlAqPjsHSzl6dpRGAa33
        v83jWbEpNOk59zB+WN1cfPNByQ==
X-Google-Smtp-Source: ACJfBovmJ0EASJlPtBFkvg3HzL3iSRSZZfHwwcgqyrz+bXiDPxl1qe6DMj9renDPboeFY4pfZra3RA==
X-Received: by 10.99.54.143 with SMTP id d137mr846863pga.160.1515106377035;
        Thu, 04 Jan 2018 14:52:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p24sm9105496pfh.170.2018.01.04.14.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:52:56 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: [PATCHv2 6/6] diff: use HAS_MULTI_BITS instead of counting bits manually
Date:   Thu,  4 Jan 2018 14:50:44 -0800
Message-Id: <20180104225044.191220-7-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104225044.191220-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
 <20180104225044.191220-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aligns the style to the previous patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 42858d4c7d..c2ee81a1fa 100644
--- a/diff.c
+++ b/diff.c
@@ -4107,20 +4107,15 @@ void diff_setup(struct diff_options *options)
 
 void diff_setup_done(struct diff_options *options)
 {
-	int count = 0;
+	unsigned check_mask = DIFF_FORMAT_NAME |
+			      DIFF_FORMAT_NAME_STATUS |
+			      DIFF_FORMAT_CHECKDIFF |
+			      DIFF_FORMAT_NO_OUTPUT;
 
 	if (options->set_default)
 		options->set_default(options);
 
-	if (options->output_format & DIFF_FORMAT_NAME)
-		count++;
-	if (options->output_format & DIFF_FORMAT_NAME_STATUS)
-		count++;
-	if (options->output_format & DIFF_FORMAT_CHECKDIFF)
-		count++;
-	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
-		count++;
-	if (count > 1)
+	if (HAS_MULTI_BITS(options->output_format & check_mask))
 		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
-- 
2.16.0.rc0.223.g4a4ac83678-goog

