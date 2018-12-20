Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E5D1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbeLTNsp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44340 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733197AbeLTNsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so1819043wrt.11
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7ghYcTl64zh+BK0z2HqfNjZhsYGBo7TUn+7jd+yPvU=;
        b=HVQRhH/dwks5+/ru6XKMC2J11bVKO+ioMeEAoZX05n1oRZtDkAobhW8xkEWk0SYMXh
         hQI7ChEpAJyypd3TV0ARFBYfqkojOMQOxfNnytncN/J0dMKiUd0YR40RMc9S44mLuioa
         PS9mL+TR7TBhOw5kX7NhrRnvKRijWpVyByqt0fe6hTvILRu4Pn8W3dIt6uVbz8vf4xyF
         wvvLPkmB+dlVoirLWzuCGc+wy2EG+cymbqBFdDx3K85a0duL0qDXweZ62WSQRpx4lbED
         gFYXnYYv1bhPIEHXrp/vOTHq+XzxIo/bf7sT9zUd0vsU9bwhl/6/K4rffkUwmX2Mxx6t
         y8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7ghYcTl64zh+BK0z2HqfNjZhsYGBo7TUn+7jd+yPvU=;
        b=sRW3y0bIchOAqKLzuSSh7hpQRYanXhFp10YvIFGaMlGnRkiitSSQSB66uokHF3FkeD
         fJ2oXBb8rlZMpS3dzt0JTXKojGc/WF5psbIktkDtjhJfoG5X6xb98356QOMkZ2YNxI1C
         SmHllp8TxQi95iHPXEHtWOyo4GvYUt8nJH7qYGo6eWqSGc7LHloAY66F/jEU94MCWj96
         /cLgbbi54cqjPX0xVHlI00iQhLZ8IGk3UOPR+8X87QkW9Vs+JXTsI+24peOUzUyUwiN5
         jTePbdsoAkPLXPMe7TmgnDKtkiXCFSkjXekwvX7oBe4bj60wNl1ml8OErn7yL9e0d/4D
         BGfg==
X-Gm-Message-State: AA+aEWZF9jXP3xzBLVmcrfHV6mUfsZS9fuPbie/rNx9lOouUqd5gHU94
        lJqIAdignYsU+C3rddoQSOtgy+aJrGM=
X-Google-Smtp-Source: AFSGD/XXl9E/rBzDZlXvHnuqdRVTCJqWERRokh6/b8rgrfBZH2/HV5QAlH/9ZWM/Y9UecGyK5A+u+Q==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr21397191wrq.108.1545313719858;
        Thu, 20 Dec 2018 05:48:39 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id i192sm8211572wmg.7.2018.12.20.05.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:39 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
Date:   Thu, 20 Dec 2018 13:48:15 +0000
Message-Id: <20181220134820.21810-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
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
2.20.1.415.g653613c723

