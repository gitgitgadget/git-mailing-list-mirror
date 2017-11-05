Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A5820450
	for <e@80x24.org>; Sun,  5 Nov 2017 11:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdKEL6m (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 06:58:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:55558 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdKEL6l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 06:58:41 -0500
Received: by mail-wr0-f195.google.com with SMTP id l8so6082168wre.12
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 03:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAkeNyZdfD9lU76y7meurOoTUkGFK0f3PTE37YyISY0=;
        b=HIpxNFyPgj0R0DMP+cg2bh76aZUCCekZPx0GFtteU/JO9hfXMGpZmWoYNsHU60JlXR
         KZ6a7KV1tYK2zntj7bmV47FpQiBuWMtB5KY9bGY9Uf2a94h9wwsB7x0nF+BnTP7xP1uY
         RuPFOBw3qdCMRz6BJrt18E2fuMYhNegh6d4tuO5glmrtqo2tQ4PyTmQRfuPyIfU/WfjS
         UJ96TlDWO1AibwCmu/4DJ5Z6uBs3PNdebEZr1OOnq/dt+j8JoMNmNcMtfU+n/LcUoHB1
         TiTMQBNrMr7zKYUVnIvjpXsMAATWcg8PygLND6smgrcivu/Fy2Nhebp7dZ2bywEo6ddO
         va8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAkeNyZdfD9lU76y7meurOoTUkGFK0f3PTE37YyISY0=;
        b=YfVPXnLC8Xch+wrHWvZ9Mr6L45a7wFW7G8pUdR/W2Ga0uJ1sDddo+a5T/wvP5kXeqV
         Blb1V4hqDE+O4xHKOMDwfyq9JI3aqsWtunSTozSlndEKrUQYD6FUZST2tb9NTRRJ/Gdf
         A9QT3YzFd2dWWHQU5x3rX4Vh2u5Tigi4MEH17C4Xthp3i7RGQyLvNgap8C9P9VQWC/Jt
         gkWEtYT2QeKADTxJp3/g886N/XQdHqrr7ZvrFRX6nJbLIiBfkXFPvltXR5Ka2S4DUUTC
         qtr45rQNoKxsl2nG/Da3mBV6q9fYYH7sXMPZdOOcJMoHBC8FLVQRlRkHruzg0u3KP6Xb
         f82Q==
X-Gm-Message-State: AMCzsaWYIQGSwbjQhGy3IlRj3OW4Xk+Ruj7rvBrs879/Nmp+Z+oY1ePc
        qoij8lVLd64gMkSHmjlKR8k=
X-Google-Smtp-Source: ABhQp+Ro+lYVrb64YKbgvT2UHL3zDLL/sPx0Inq198JKSuurm5ZTgW1eLCNeNoz3EQoKq2v0S9JZng==
X-Received: by 10.223.199.137 with SMTP id l9mr10765845wrg.113.1509883119755;
        Sun, 05 Nov 2017 03:58:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u18sm14391450wrg.94.2017.11.05.03.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 03:58:39 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, hkleynhans@bloomberg.net,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/4] pager: refactor `pager_command_config()`
Date:   Sun,  5 Nov 2017 12:58:20 +0100
Message-Id: <2b0f8f5c1f42f7a85d8017ca378de8acde2688a3.1509879269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509879269.git.martin.agren@gmail.com>
References: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net> <cover.1509879269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`pager_command_config()` checks for the config `pager.<cmd>`. In the
next commit, we will want to also look for some strings on the form
`pager.<cmd>.foo`.

Refactor the code to verify upfront that the string starts with
"pager.<cmd>" and then check that the remainder is the empty string.
This makes it easy to look for other remainders in the next patch.

While at it, before assigning to `value`, free any old value we might
already have picked up.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pager.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index 92b23e6cd..8968f26f1 100644
--- a/pager.c
+++ b/pager.c
@@ -191,14 +191,19 @@ struct pager_command_config_data {
 static int pager_command_config(const char *var, const char *value, void *vdata)
 {
 	struct pager_command_config_data *data = vdata;
-	const char *cmd;
+	const char *cmd, *remainder;
+
+	if (!skip_prefix(var, "pager.", &cmd) ||
+	    !skip_prefix(cmd, data->cmd, &remainder))
+		return 0;
 
-	if (skip_prefix(var, "pager.", &cmd) && !strcmp(cmd, data->cmd)) {
+	if (!*remainder) {
 		int b = git_parse_maybe_bool(value);
 		if (b >= 0)
 			data->want = b;
 		else {
 			data->want = 1;
+			free(data->value);
 			data->value = xstrdup(value);
 		}
 	}
-- 
2.15.0.415.gac1375d7e

