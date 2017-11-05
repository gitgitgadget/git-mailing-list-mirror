Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9AE20281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbdKEUZ2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:25:28 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54182 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdKEUZY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:25:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id r196so10453685wmf.2
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsGGFd4ZIOJefB255n0dIPg/kHHTq7F5pwW7vAGftfQ=;
        b=IPeXpLQRrYCT4LddLxOeddKKUfEXW5DvTkLnzF6VY1LYzihpfg1IbEisN1FNj5EyAi
         o7pg4SLGdCB9ShmGv2ljTPRtjibm8WtnlZUU1zB22wfvpyziblyx5qE1UxjsdttOP2H3
         Auhb5yCLl3dudfbnT3xVOyeHuAYFzL1nZVdyKno4IRBB/zVTuXMfzszoedJK8uvnVPBQ
         pKT6bFOBJiNdO2nBewnYrbcWiNPNnlaPKn/Pp8m35KdcrxLQbrUczxDTMcya8SSNZyE1
         1Y3W8oa1rs/c0timL11bnT3I+ZtJXnEn1CT2fBE8ClzpSex+x/E1mHqz6a0yZ62w7uoX
         JZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsGGFd4ZIOJefB255n0dIPg/kHHTq7F5pwW7vAGftfQ=;
        b=FciDWOF2cKeHyF45x0n5C90ltC2RPsZ1jiRx1Jk+uTtYjqfyFmhaTzix5fd6nNKo/q
         U+e3x4XF6UIPckprWFrdR+PtJA518zwK+pwi7R26NA1IsWivbidssyQFxEcxssYjFOZ0
         /IsATyH8OdRrO72Wlv2Xt0A0hf8hJY9HU3dKfNqtfLeYJjn+yb9iqBpGF428Kld4GXvK
         LCOzUKGpHxzVKvcxAgTALHX1U9XDY+BLkNRGb5FWAM7xb1uIiczA0jv2stdHQ9gohaWm
         QXQs0nEi5dvypNfUMox/QZAS+FX+VdY67k7FeIYTTnsoh4wQgAzgXSAMOWgjeNgRiuZk
         O0Cw==
X-Gm-Message-State: AJaThX5fNhRSM7vS0nmRfmnEYT7MbriAiefWS3d0xFskyVuB0yrI01Pn
        5K2uCQED0Ph8BZCa5iinb0h4JHyR
X-Google-Smtp-Source: ABhQp+QSUr1we9CyuXUuFGhnDpWPm1NyJsAocruritV60JhdET3eo7lYIqioGUgPzk+974iXZBMAMw==
X-Received: by 10.28.151.137 with SMTP id z131mr4093702wmd.153.1509913523305;
        Sun, 05 Nov 2017 12:25:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 71sm12917543wmg.0.2017.11.05.12.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:25:22 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 3/4] bisect: fix off-by-one error in `best_bisection_sorted()`
Date:   Sun,  5 Nov 2017 21:24:30 +0100
Message-Id: <9e49e4ada1d1ede05b74c63b6e09c8891eba55d5.1509906092.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509906092.git.martin.agren@gmail.com>
References: <CAN0heSoBeG_8zLwS-71_ZVBF-HsVGKY1W1QiTSQ_ybwWCPauog@mail.gmail.com> <cover.1509906092.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we have sorted the `cnt`-many commits that we have selected, we
place them into the commit list. We then set `p->next` to NULL, but as
we do so, `p` is already pointing one beyond item number `cnt`. Indeed,
we check whether `p` is NULL before dereferencing it.

This only matters if there are TREESAME-commits. Since they should be
skipped, they are not included in `cnt` and we will hit the situation
where we set `p->next` to NULL. As a result, the list will be one longer
than it should be. The last commit in the list will be one which occurs
earlier, or which shouldn't be included.

Do not update `p` the very last round in the loop. This ensures that
after the loop, `p->next` points to the remainder of the list, and we
can set it to NULL. While we're here, free that remainder to fix a
memory leak.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2f4321767..b1941505b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -226,10 +226,11 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		add_name_decoration(DECORATION_NONE, buf.buf, obj);
 
 		p->item = array[i].commit;
-		p = p->next;
+		if (i < cnt - 1)
+			p = p->next;
 	}
-	if (p)
-		p->next = NULL;
+	free_commit_list(p->next);
+	p->next = NULL;
 	strbuf_release(&buf);
 	free(array);
 	return list;
-- 
2.15.0.415.gac1375d7e

