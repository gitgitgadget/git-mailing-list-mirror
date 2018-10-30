Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B76C1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 08:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeJ3RC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 13:02:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33030 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeJ3RC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 13:02:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id i26so3801565lfc.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcdLYXqThVpch5g7xI3JGlhPaCJzwSXad+YJJcT+/PE=;
        b=TaSTMipiq5CL+zvzmU8eAFYUOYOiNATlJru9qjTJE2XTHdQY2NR+tcuvNFIpykb9rj
         kAfZ+I1sjxPQ+/M6yLlBkHKulvd2lnY9WH25NWslSZNguczwAYIJ4KOismdJTUQHhUUz
         j3o+AdXmkEkLa0Eaf8Zv/+EpdixaNUNCmbutjeTJTVNRtC9YGnl84xcxrQG8LwS8XEBj
         jt7pxL0aec+k6Znk0qHAEBmHjv7F7tA0T9sluHHUcwZrX6j9/QhHHTk0Zn0Nj8yQb8pE
         nVs+MLB9Ddybz5jyGoPjcihBAyTc2DNnpEHOxFaPvKafeJjn9MKty2wfzEAKloQgY6Sh
         Biqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcdLYXqThVpch5g7xI3JGlhPaCJzwSXad+YJJcT+/PE=;
        b=Lldca0+Sb3pjCnxfAtrlJ0V7PlN0LBrKbMiC3tV5G7j8VR/8wAE45H7J/CCzOgngBX
         MFORaLtZ1zIAXAUA610oVkYyEbTY30xUbPtr46eyc8qLNpCMsVAaSQuX948yX0Fs1vAj
         GSVHazN3d666SxY19qZ2P8FSxhlx1HbaemXLeZvqG8+v39HR5iXZWg6uJ92L9BT1XMdp
         mDWPAof44VyIvwPjx7bfJ3PkgfjCgdJ3pLCSQDRlfQRBJMd3PLFLesV+wnvIliC+6dX9
         THo29PJhla6mmDj8m42TpWoNp5/rs4T1BxJjYjrsl8pV9oUzpYOYCzFxgHXMzmb3WnVI
         3JPw==
X-Gm-Message-State: AGRZ1gICFoPWn5soPJumIHtEyEaTvatIeo4KP7eCjDSTL/GVrPxCvKRq
        +tLBpicSwlCdhkySAgOuDxr3s/rL
X-Google-Smtp-Source: AJdET5eVl/uLeEWsO54F5CMfKfG2FSxvWhGHScCH+74vjsR4MKcCV9IFISnLVNdwkxQkO0hiK5wQ/A==
X-Received: by 2002:a19:c396:: with SMTP id t144mr1152909lff.110.1540887000681;
        Tue, 30 Oct 2018 01:10:00 -0700 (PDT)
Received: from localhost.localdomain ([77.110.7.129])
        by smtp.gmail.com with ESMTPSA id d199-v6sm3822769lfd.20.2018.10.30.01.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 01:09:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] sequencer: break out of loop explicitly
Date:   Tue, 30 Oct 2018 09:09:37 +0100
Message-Id: <20181030080937.11118-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.1.593.gc670b1f876.dirty
In-Reply-To: <xmqqva5l76zs.fsf@gitster-ct.c.googlers.com>
References: <xmqqva5l76zs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It came up in review [1, 2] that this non-idiomatic loop is a bit tricky.
When we find a space, we set `len = i`, which gives us the answer we are
looking for, but which also breaks out of the loop.

It turns out that this loop can confuse compilers as well. My copy of
gcc 7.3.0 realizes that we are essentially evaluating `(len + 1) < len`
and warns that the behavior is undefined if `len` is `INT_MAX`. (Because
the assignment `len = i` is guaranteed to decrease `len`, such undefined
behavior is not actually possible.)

Rewrite the loop to a more idiomatic variant which doesn't muck with
`len` in the loop body. That should help compilers and human readers
figure out what is going on here. But do note that we need to update
`len` since it is not only used just after this loop (where we could
have used `i` directly), but also later in this function.

While at it, reduce the scope of `i`.

[1] https://public-inbox.org/git/CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com/

[2] https://public-inbox.org/git/CAPig+cRjU6niXpT2FrDWZ0x1HmGf1ojVZj3uk2qXEGe-S7i_HQ@mail.gmail.com/

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Thanks for the comments on v1. Based on them, I decided to go for
 Eric's option 2, and to make the log message less technical in favor of
 "compilers and humans alike can get this wrong".

 sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0c164d5f98..e7aa4d5020 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2829,7 +2829,7 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	struct tree_desc desc;
 	struct tree *tree;
 	struct unpack_trees_options unpack_tree_opts;
-	int ret = 0, i;
+	int ret = 0;
 
 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
@@ -2849,10 +2849,13 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 		}
 		oidcpy(&oid, &opts->squash_onto);
 	} else {
+		int i;
+
 		/* Determine the length of the label */
 		for (i = 0; i < len; i++)
 			if (isspace(name[i]))
-				len = i;
+				break;
+		len = i;
 
 		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 		if (get_oid(ref_name.buf, &oid) &&
-- 
2.19.1.593.gc670b1f876.dirty

