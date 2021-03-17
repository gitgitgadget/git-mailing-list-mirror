Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D1C432C3
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD0A64F5E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhCQSVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhCQSVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4952DC061760
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1881060wmj.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hrhe2HTJZB5eFPococ6oZHMr2amKORBZgobAnkFyO/8=;
        b=Lm6GXR0uHf6oChGrgIZTz2IEFFtCRqh406FZBAsbwzLaWzjGMbi9jRiFiIpFfQmxf0
         SO5QdB/YiI+E7DXgentSl+ZTDuB5at6PHbr+E3po6beY0Xp080KOFlMTA92plmG15wdV
         xvAQpVgZjWsgJdC1SK0AX4N6TcLWPtoqKa5a6lSW3DBFsbDKEd+bQFlZrY2zET2Ag6SK
         ZbC7l6Qtzm+KmckU0ogHurEyd50ORaXSoP1DPi+DrYQHgKxp+VBOB6JHVDU3a/8aK8Yn
         oBqDa6Gbtzrk5rVTF3paCTrRa+zu7cbg3LRQ35hzf1/sUs/NHrVFsL4s8xOwA5xmvZo3
         S5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hrhe2HTJZB5eFPococ6oZHMr2amKORBZgobAnkFyO/8=;
        b=UD/iP2zn0mIbHZBWcCFPpwOAWCXCyYDa1pcrbDZZB7o9LMZY4JTkCxgo8gwOoSOJzn
         weRqrM/7w/qjPRZ/DsbwmhvhLte2PRQNLvcK7Mahx6M+LuLTKebFdtiL6KwUKhYA6+YY
         RGr7gM4kNn4/2pfg3VUCW9yQ4LUoNIyNj4tyqQE5WbpjhWR9UIdx0Rq4e73vmQh+8LFz
         8BH7Eiz06r97qiFZ3KNBwk2c7pmXsix02T3aNHXCiTw/xDD0OgJXUiJJUZW0APOLakpM
         W5gq9wbgiNGTAf6gR7wi2rYqLhmwLXc2nwHEgKhCRw0RThuY9RymL7hJ6WbqJBC8b3kB
         pfMg==
X-Gm-Message-State: AOAM532yWfew+Ifwv1JuIDwBvY/TbhEoY1uYz+saPZXOG7l7sEJ3bgZE
        70FKrtCZgv14myxGBSOhLOpb/9oORXlHjQ==
X-Google-Smtp-Source: ABdhPJxC02DRMhyzEwbBOsekDiC73SyyRuecceU1Y+33Yj25uCiveZaClWtydZZUdkV34uHZI6I3rQ==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr91030wmh.131.1616005277851;
        Wed, 17 Mar 2021 11:21:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/19] fsck.h: re-order and re-assign "enum fsck_msg_type"
Date:   Wed, 17 Mar 2021 19:20:44 +0100
Message-Id: <20210317182054.5986-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the values in the "enum fsck_msg_type" from being manually
assigned to using default C enum values.

This means we end up with a FSCK_IGNORE=0, which was previously
defined as "2".

I'm confident that nothing relies on these values, we always compare
them explicitly. Let's not omit "0" so it won't be assumed that we're
using these as a boolean somewhere.

This also allows us to re-structure the fields to mark which are
"private" v.s. "public". See the preceding commit for a rationale for
not simply splitting these into two enums, namely that this is used
for both the private and public fsck API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fsck.h b/fsck.h
index 0fff04373e..25c456bbd3 100644
--- a/fsck.h
+++ b/fsck.h
@@ -4,11 +4,13 @@
 #include "oidset.h"
 
 enum fsck_msg_type {
-	FSCK_INFO  = -2,
-	FSCK_FATAL = -1,
-	FSCK_ERROR = 1,
+	/* for internal use only */
+	FSCK_IGNORE,
+	FSCK_INFO,
+	FSCK_FATAL,
+	/* "public", fed to e.g. error_func callbacks */
+	FSCK_ERROR,
 	FSCK_WARN,
-	FSCK_IGNORE
 };
 
 struct fsck_options;
-- 
2.31.0.260.g719c683c1d

