Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2842C1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfAHVwm (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51685 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfAHVwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so5615912wmj.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7vB/8N84zjcTyOfxb32tpK/FXLrGAsQoaAtcNb5OkCI=;
        b=Y36YDfe4X02zcP1mTvBXwDjcc76isH08FwgCB9c2UGnv49rIrT4oHFgzJWf4DL7l7a
         r3gHWZJKHBGASdT4cNmfjeiUPW4HSGk6sZpequLE/VXwxyqSjTG2HKUQfM+XW+RcDO44
         ImMPTMQ7JIjzH4Xv5YEJL9WwyBBkLF+0Hzd1Q2Eqyk+bWX3VzAlSbT1hBLvg0tXhs8OU
         AHhPw1s2m6VGV3TUytOykquGYsu0uyVlYxAD+7TqquoD/xujs+yQ2mIs3UQ2quAPKxdd
         w6s6uCpWkcMIxZ+gNem93NnUEfz9NpiQC1mSqHvBBSVjG8zF5q9hpH3bk4Mih5uM86q9
         BO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vB/8N84zjcTyOfxb32tpK/FXLrGAsQoaAtcNb5OkCI=;
        b=k9rs1Mepw7+DHN4NEKxy90U/rhyZcbSUrqXAGqXcntTwh6NaN2HFtaFTKYOxBQjGMS
         req/7LNZwm7mFULCJhCmYlkt2D4ebSqBXjSQHOvSTcOpmnMsRWvVC0yHfPG45bDsjF0z
         xBKN4C5uxgT0ofMxqrr8uNJzmB6sTZXrPXPCWXgQT3VOWTnhi2zHbEGV+MUg9HO5g0Oe
         2g6M2G+o5jqhgfTbbrS3qWqnCxxQ7mWS7bqOJsXa8VeGnDEKipgBFpaovRYw70mno0G2
         Qb7rIG2Xu5dgfJcXkkm/iJ9fI7eOXBriiFBGDg4fxbEECTryjSJpe6pZhZdcjNr+ez20
         8Lzg==
X-Gm-Message-State: AJcUukfqlVM8leOUg0BsCzqHRQNnaD4JrsEONlNkDefXpFZScmP7FMyW
        rTPcKGnMTXxWJmslUsa1rlcX1dQ2
X-Google-Smtp-Source: ALg8bN7W0X1v7Gj2AgxsuraqulR525bx9QTIaLZhZHukULYgEAqueRn2Qi+KTag17bNOwIzLFirUSg==
X-Received: by 2002:a1c:ae15:: with SMTP id x21mr3025051wme.146.1546984356835;
        Tue, 08 Jan 2019 13:52:36 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id k19sm68408326wre.5.2019.01.08.13.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:36 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
Date:   Tue,  8 Jan 2019 21:52:20 +0000
Message-Id: <20190108215225.3077-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190108215225.3077-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'checkout_entry()' currently only supports creating new entries in the
working tree, but not deleting them.  Add the ability to remove
entries at the same time if the entry is marked with the CE_WT_REMOVE
flag.

Currently this doesn't have any effect, as the CE_WT_REMOVE flag is
only used in unpack-tree, however we will make use of this in a
subsequent step in the series.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 entry.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/entry.c b/entry.c
index b9eef57117..3d3701e7ae 100644
--- a/entry.c
+++ b/entry.c
@@ -441,6 +441,17 @@ int checkout_entry(struct cache_entry *ce,
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
 
+	if (ce->ce_flags & CE_WT_REMOVE) {
+		if (topath)
+			/*
+			 * No content and thus no path to create, so we have
+			 * no pathname to return.
+			 */
+			BUG("Can't remove entry to a path");
+		unlink_entry(ce);
+		return 0;
+	}
+
 	if (topath)
 		return write_entry(ce, topath, state, 1);
 
-- 
2.20.1.153.gd81d796ee0

