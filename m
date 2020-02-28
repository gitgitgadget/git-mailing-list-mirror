Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ABDC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C91246A0
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMSVRPm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgB1Pob (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:44:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50688 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgB1Poa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 10:44:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so3680535wmb.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMO6rdC5tUA14IzlpT+h75Ka0Ip5FtdBDMkJ4oD5RuM=;
        b=ZMSVRPm9/Bv0h/qEWe8rdybp/3/F5qt+1sDL8oiPm5kmCPNrCEoG8iYUagqz56rF/G
         pvGK2+S6/NNA+NBtm9efu3qXZts+bHgA4unmrD/j59RmDNXEyRK70N7VUekTgcMIro30
         6/28ZFsbeQyKkq67KWxZkX2iG81KR1dxaIP0eK7H2c1sZ+8mQhHv5wlGX0UAej9oaiJL
         waBlAESVHoy1aWorkzbKpxAXR4agJrvGF+WhQHLuEos4L1kyM8Lb/Q1v7td7co60uAQI
         hL+72nbGep4DX/AH1FXUedOpewtZWUOuXAvl697P1U2X6R5B9cz4rIznJGuZ2qNIAqLi
         Oo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMO6rdC5tUA14IzlpT+h75Ka0Ip5FtdBDMkJ4oD5RuM=;
        b=BnXFP5Y7eyd8rrukECQ+SnH2wqmGL95jK8HpFODd4Dnf4/pO7fRS9nVyo6SURxPa9w
         nYjuZGPiDsFSIi6IZc8JknRwOcu9xNafMn6DY7esHL4d3ZSiW0oXJRMOs5sltMkd/aAf
         124nK8j2VlSOb+RTCSYIlrZMXKgi1syYLA4e4rUKh3KUFOAUJNiexZNelAWXee4O88iZ
         jf9c5DZbiQv+0hu4K6HBbV0DfcSgyZhXTtdlXuloa5V6FQ7y80M2bwBqLKn0FACl79+n
         3BARLv/JOMO3MDLTxcCuzLG6lf+OIK8LLWZ5G0s9iSgZUbexjpzq2dkLHoO2M9F4JKF6
         ZaSg==
X-Gm-Message-State: APjAAAUVousnxSo7c8xZqoj+X7Wwf4LqyzPTpPL5nICtbffutZ6u+yGe
        sYUPhedo1m4PmN+6w1804pK+F0Emjow=
X-Google-Smtp-Source: APXvYqytYA3ABRHBbJKxU4C5Iqs8iPmZtAkQMTAfDxByk4CW4/1ufBW7t1LSLI6MBITeriP6jaFUgQ==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr5274468wmj.26.1582904668172;
        Fri, 28 Feb 2020 07:44:28 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id z6sm12815549wrw.36.2020.02.28.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:44:27 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 2/2] pack-objects: change the name of add_objects_in_unpacked_packs
Date:   Fri, 28 Feb 2020 16:43:57 +0100
Message-Id: <20200228154357.1710521-3-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
References: <20200228154357.1710521-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`add_objects_in_unpacked_packs` was added in commit
08cdfb13374f31b0c1c47444f55042e7b72c3190 (Sep 2007) to handle the
`--keep-unreachable` option.

Back then this function would iterate through packs associated to a list
of revs, and add all objects that was not already in the object list,
hence the name.

Now the function simply iterate through all packs (more precisely all
local packs not marked as .keep), and add all objects not already in the
object list.

So rename the function to add_unreachable_packed_objects, to mimic the
naming of add_unreachable_loose_objects.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 940fbcb7b3..16c2efdbec 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3031,7 +3031,7 @@ static int ofscmp(const void *a_, const void *b_)
 		return oidcmp(&a->object->oid, &b->object->oid);
 }
 
-static void add_objects_in_unpacked_packs(void)
+static void add_unreachable_packed_objects(void)
 {
 	struct packed_git *p;
 	struct in_pack in_pack;
@@ -3290,7 +3290,7 @@ static void get_object_list(int ac, const char **av)
 	}
 
 	if (keep_unreachable)
-		add_objects_in_unpacked_packs();
+		add_unreachable_packed_objects();
 	if (pack_loose_unreachable)
 		add_unreachable_loose_objects();
 	if (unpack_unreachable)
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

