Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340481F89C
	for <e@80x24.org>; Thu, 26 Jan 2017 18:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbdAZSax (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:30:53 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36157 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbdAZSav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:30:51 -0500
Received: by mail-qt0-f172.google.com with SMTP id k15so89815398qtg.3
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnt5w1rkAAqrW3uDbEqWX92xJ5O+uAKGiABmV4dFkUw=;
        b=oejfsE/tEtjjtgOhtvfB1FaF+z27ZXQ2hb/590Rx3UE4E3kyduwu/nY7Y5hZf31Z9/
         hP/MfqGeRbuHlQy9FkXeAVFrLqtTjiRjemXTxEK+P5IxaP5E9AiVWJ7JR3T6oe+OyRBu
         cA8cS/Gq2WEdFUjGK+t1dR0le0J6BMTJK6Qozq+YO0hISxzuqckD88sdtQyBoC2eQH3r
         Op4L9tirxSvjCi/oudLsmgxTp+ytOFSE6ykBEi1N4YnzarL7n55K3gqLpPGYFqCOLlRE
         /C5LOmrwZxW+OeKKkMyOekpIhAzWdagiXofaows7mB3KoE6pu8XdG82BTVmxjceC6hWo
         phAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jnt5w1rkAAqrW3uDbEqWX92xJ5O+uAKGiABmV4dFkUw=;
        b=EzpTzZPJl0ywkc8OEdfHP0T47IDrvImNq0HIFRIMOIOBpSen95sGoTpgJvdqnFxP5T
         zOZ1KCKMnTzSArG9vqbKJXfcCSbMseZfeg0p6MHAaQf0vwrn+u1bkRRzkkjrfSr/sUHD
         xVTCeKwaUi3acZ4269s5lM+tNjS6nVupU0AEe0XdJKq0XK8aT+6T3bnWMq3S4VqzRTLH
         M/0MMQimoDvacFGapyP6WC06afhmWWrQ8+h5bES2c7ZgGO9GqcWq7asvIc9SQs4wscRp
         9K6zcStzYm27sxOHd+I29VoZ9Gj/CyP8vBMZ+N6MmYwPN5v+tNMHyegAXkI1d/+S7uHT
         vOrg==
X-Gm-Message-State: AIkVDXL/z54Kc6prZpd5zk47fBBxMXDgE5a0CVGscQw2xFL/iAYKUlS7Qu9rikDm4lXdHg==
X-Received: by 10.200.47.100 with SMTP id k33mr3850977qta.241.1485455450825;
        Thu, 26 Jan 2017 10:30:50 -0800 (PST)
Received: from localhost (LReunion-656-1-21-243.w193-253.abo.wanadoo.fr. [193.253.106.243])
        by smtp.gmail.com with ESMTPSA id m12sm1857016qtm.45.2017.01.26.10.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jan 2017 10:30:50 -0800 (PST)
From:   marcandre.lureau@redhat.com
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] git-bisect: allow running in a working tree subdirectory
Date:   Thu, 26 Jan 2017 22:30:30 +0400
Message-Id: <20170126183030.28632-1-marcandre.lureau@redhat.com>
X-Mailer: git-send-email 2.11.0.295.gd7dffce1c.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It looks like it can do it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 git-bisect.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index ae3cb013e..b0bd604d4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+SUBDIRECTORY_OK=Yes
 USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
-- 
2.11.0.295.gd7dffce1c.dirty

