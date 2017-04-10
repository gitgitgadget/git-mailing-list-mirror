Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B09320960
	for <e@80x24.org>; Mon, 10 Apr 2017 21:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbdDJVFR (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 17:05:17 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36738 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdDJVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 17:05:16 -0400
Received: by mail-pg0-f44.google.com with SMTP id g2so110207184pge.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QDAHrQml1czOnAt3zxH+wMsBGR0/mE4jaC8trkX0tu0=;
        b=uhLV2ZbIQWeTOPsbHZ1ZgoOSOulm01a78BqntQe9mXLYj9xVLIuiUjSFhE7eidqIgo
         JDczrICRQdxx2EXzRrYPexUV+Vo1/G1ODhun7equoaZ2WBBGj/GT+1BQI5pVYw08QUEc
         XxW7Jl0WqRL05Tjk69r4o4dMqr2rcYHTJhnF7avRJ75iYdBlR3HEwg4+ROcb8lzMtjz1
         /Jonv2isY33Qu47uJui88hODNFkYvpenyF5r2WrkO4w/+m0SGS2NNWuzYNLvsgaBx3ay
         J8/F4awYodORPj0YpVT7B3Z4Zsq+M3ivXZf/wzkn4DcBC2UWveBYsuOsna6yg6V9P7C/
         AyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QDAHrQml1czOnAt3zxH+wMsBGR0/mE4jaC8trkX0tu0=;
        b=XcmQo0I4OZ2ub/VyAskk8HFXpcw2bGKPuUgswxZTGiHgRluzScl8tJMSEWpcq5aAtZ
         59nifbTqAwXAo6MNA48IxyhVP5IYIyOXYgW1HFKB1ecYMdXku8Hqy3d4VqI9bG2UPyPI
         uzFkTmqwWuBzf4Fh3JSEbi9BxLv4Aq7K6oNjnWsMBOZghcrrOzqtbxYJjJC3NcudXm5K
         4r5tMUzNxiu7d2ooBbuFbPxFw1Kp7ohCebBKV2oqBdY1GVosb/gEsvEiXoGU0NoF/gOp
         uN5oARM0rAeoLEXkzqySdf1Wn374D8J2FTkRA6CWpPq/OMG063D0QD3isFJUUTpvZN3Q
         +fQw==
X-Gm-Message-State: AFeK/H1q60ntF6tBUqSOwqnYF5NMaKOw9P+drOJuOpr8xhG55gj4PcDhO2+O/vgVLhz7YZF8
X-Received: by 10.99.109.137 with SMTP id i131mr57562096pgc.103.1491858315386;
        Mon, 10 Apr 2017 14:05:15 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id k2sm26386016pga.47.2017.04.10.14.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 14:05:14 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fetch-pack: show clearer error message upon ERR
Date:   Mon, 10 Apr 2017 14:05:11 -0700
Message-Id: <20170410210511.8505-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, fetch-pack prints a confusing error message ("expected
ACK/NAK") when the server it's communicating with sends a pkt-line
starting with "ERR".  Replace it with a less confusing error message.

(Git will send "ERR" lines when a "want" line references an object that
it does not have. This is uncommon, but can happen if a repository is
garbage-collected during a negotiation.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

This situation has been noticed occasionally in my company - this is a
small change that would make the situation slightly easier to
understand.

 fetch-pack.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce3..688523bfd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -276,6 +276,8 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 			return ACK;
 		}
 	}
+	if (skip_prefix(line, "ERR ", &arg))
+		die(_("git fetch-pack: got remote error '%s'"), arg);
 	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
 }
 
-- 
2.12.2.715.g7642488e1d-goog

