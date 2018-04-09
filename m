Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0551F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbeDIUm1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:27 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46145 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754130AbeDIUmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:19 -0400
Received: by mail-io0-f195.google.com with SMTP id q80so11209280ioi.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YQoqIdwPEpBS3hYUpgmXOQDDyW0VJl2lp6yHDMmEIUw=;
        b=h1xhvMszQw9cZlbyYc+iEmeBH0z7VhHYJ9/kEgTHmbseasHPSDksg7EuaIzAJ0N84T
         sX2JvwKay8amLTYULV5jJM9oBa96m/eepeK7ADLXT6p8Wseii9n/EBVYGG6qZRTOX9qO
         wiO5FW+ycktT7+4jQDlJXvRLwrnjKlLOBfzxwl8SncoTB9cr7rCLei9XAtKjX7FBNSH4
         hE9puqBFa8BQjoqfkMlYmQCMqaqpR6zEZWXWYmfHcG5I/n3GF/j9jsQ+PoAhTsuoLYu8
         KtobJ+WEExKEqFu+Uw7PaHzAodFofyjGE1i9cDQRwjPjmJSTe9yVopCEBDBtQ2ZBfDoe
         7ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YQoqIdwPEpBS3hYUpgmXOQDDyW0VJl2lp6yHDMmEIUw=;
        b=PWo4nzzJnKM5xc4+gFN1ulmOZXm1dEKarSoWtmZSyY7BzAj7P+uXVcIeDMciVhi0/m
         p7Na4pPy+kMydaydHEzohx5Bda6AXizeSFRciJJvwIEFTSvqbgfLnjacJjeo8fSaqZHX
         W9LZ5ue/LAdbwC3zl34Hh3G3AJIgAltCYXG2wpDEmuFxe0cJTyQ/CF7AWBnSgshEGHZ3
         TyTDlIErTIfqrTZiLNdqM0Lo+OCsLowJG3ioedToyO3El6kYXN4qPza67FDD3zechl3C
         ehognoig3lNECtiGRgCIrhj+16MC4LEYIFuuchrQSmctQ4zT1sB/SZHl9FuwauWtAH6V
         VlYw==
X-Gm-Message-State: ALQs6tA4zaJckINLVd/TE4ktnSM6k07vlQnSIlgLjTlFS/GJkGuUJ+cB
        yKmUiaM57uXjb1R5FgPh76ouerF5
X-Google-Smtp-Source: AIpwx4+3M12cUnFOMj2Cw5tRw/TRL71qO9tE/4XPKrV3OXfwQERQWXJjhxdqaegFMHKGPG1fHQ18fQ==
X-Received: by 10.107.2.7 with SMTP id 7mr503549ioc.187.1523306538759;
        Mon, 09 Apr 2018 13:42:18 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:18 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 5/8] gpg-interface: extract gpg line matching helper
Date:   Mon,  9 Apr 2018 14:41:26 -0600
Message-Id: <20180409204129.43537-6-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's separate the actual line-by-line parsing of signatures
from the notion of "is this a gpg signature line". That will
make it easier to do more refactoring of this loop in future
patches.
---
 gpg-interface.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 3414af38b9..79333c1ee8 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -101,11 +101,16 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
+static int is_gpg_start(const char *line)
+{
+	return starts_with(line, PGP_SIGNATURE) ||
+		starts_with(line, PGP_MESSAGE);
+}
+
 size_t parse_signature(const char *buf, size_t size)
 {
 	size_t len = 0;
-	while (len < size && !starts_with(buf + len, PGP_SIGNATURE) &&
-			!starts_with(buf + len, PGP_MESSAGE)) {
+	while (len < size && !is_gpg_start(buf + len)) {
 		const char *eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
-- 
2.15.1 (Apple Git-101)

