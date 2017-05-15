Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620921FAA8
	for <e@80x24.org>; Mon, 15 May 2017 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933960AbdEOLGt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 07:06:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34765 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933297AbdEOLGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 07:06:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so27471718wmf.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saBFN5/SvkIpuk+dW0GZgYbJBUx8zytFBADAoOWRML0=;
        b=HZ1X+uslUTYXVqd07TkNhwLYzEyBsyxIdp5SjzcqIfV2XhZtLGPvXWIbV5P/qDxSBV
         0SPcO8jJfX/GnaRpLdhBWjeA4kdZs+peuARXSDU88/xOb5ERCWW6JgoEwXCysLdK9bxO
         kbNCXD01aRgHj6iXaW7hEAKZo4tlNaveB9jUsRJKYa/pycQoGgCxogAUvSwUTlJgL0CT
         GjXrAJTTZicRCSPzKHxlFu/HLbNitvK3bKooAZTk/p7V09a5umrfM7H/w3O6D1j0IWOQ
         ddO7ITwazRPOhj8LFsNgy+HNdZvxfYdab+W+dlLnLlqzyCaQr5xRLf0KB/tB2j/+qHj9
         fnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saBFN5/SvkIpuk+dW0GZgYbJBUx8zytFBADAoOWRML0=;
        b=qR7UeAuJCgyHoxL7aR3nXrMJCYVveVjSolmxvBT2OcfMzy5xrjkIaNSnaiKoICu5dh
         jimb0htApxWcXSoW4W1gwrm1Lmq+ZzKOcaqjEdTp4EDfx85fpqambY/qRujT7yMpaSEt
         7IGtc2AJqvR7pn1VxxXMSavVpVgLfJlUOC/WTWNWqylkSKKmRSWszexHyZw+X4eEYcmy
         hOWWshfTrtN045B3MmxX/f3+LEJWrRfe/owcAQ8ojYkXv7wJIDnB1HvIo57LUnmdJYm9
         olyOW3o3Zf9+N9HMy1aOEi/E4AzZKkP6osjbU9uIt8E/raUtm4nDv8YT2oktzaml4Gls
         WhWQ==
X-Gm-Message-State: AODbwcDaB0wk7baFOYVKw27nX3D7vabdLIffsixXPr8/WMJEW9dzJqaF
        P4ODbwpQcUrRJw==
X-Received: by 10.223.169.78 with SMTP id u72mr3485236wrc.193.1494846406901;
        Mon, 15 May 2017 04:06:46 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-151.pool.digikabel.hu. [62.165.238.151])
        by smtp.gmail.com with ESMTPSA id 20sm10363191wmk.17.2017.05.15.04.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 04:06:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv3 4/4] clone: use free_refspec() to free refspec list
Date:   Mon, 15 May 2017 13:05:57 +0200
Message-Id: <20170515110557.11913-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
In-Reply-To: <20170515110557.11913-1-szeder.dev@gmail.com>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Using free() on a refspec was always leaky, as its string
fields also need freed. But it became more so when ad00f128d
(clone: respect configured fetch respecs during initial
fetch, 2016-03-30) taught clone to create a list of
refspecs, each of which need to be freed.

[sg: adjusted the function parameters.]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4144190da..4bf28d7f5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1120,6 +1120,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(refspec);
+	free_refspec(remote->fetch_refspec_nr + 1, remote->fetch);
 	return err;
 }
-- 
2.13.0.35.g14b6294b1

