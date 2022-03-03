Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1A4C433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiCCQFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiCCQFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE5197B73
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:04:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y5so3482870wmi.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uEXe0nov1gHh5dELbny/Vmi9PzrTf0qeYMuKSF4SBsM=;
        b=DFbZrZ1oa7I9TJ+1b+nwz9bCutMS2eVu/E4HTM3ZKdXi9UDs91Iy1jVGS+JyhgiIjE
         AxSCMuFX1Oe+p9Ntswykn4H7kvLQSZCIN0QWVDnEBroRjyuouwr7z8w1jK9rT3tGQa38
         loQlHTNp9aRq1tvfI9RCRJ0bUknKM0pO+aFaZ/Gtm8GCnEQXwaQSmB187wDnumKeJrNW
         9LoEgPyeNx9QiYw7RsUAYy+6Xsa2LIZswnhkZJvC1+My9KQW0nrekVNAzALIjSLzm/qH
         PqDNbBY7G6Rk9JGYBOJYztJmmEevogUFLmHpqoHdbNgKG7ox4TljV1ZTdWskQtoDLjgA
         IQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEXe0nov1gHh5dELbny/Vmi9PzrTf0qeYMuKSF4SBsM=;
        b=57Qa2aW5nGWIDcAFOIVr8y7TXt+qkgeC6Vn9OlXH8gHFhQVyaes8nnWkgNxbaMWXoY
         TXJPFOhpLQWpXH30YMNf5z9q6jYl4mY5Lk4AjtQXy2jH4Uasj2Zc47ez1wuBnHJeRPeL
         5JywTTy6vOiW2Kk1MMwEoHcuY0MqqAX7Go/d5JE37AOalHEpSbkvBe99KGtNpObRDCCX
         5CJ8rql4x7Ejq7Y7zBRtG+50AY4JSBbQwc9Qhc981sRZWD1V/c3w916aJMXd5r96+98y
         GvQLz9NI9wAQMQtnAODl+2ChNvS1k/yk7d9Au6yXsRTZ9AiJ7j7jOc80Sqw7qSmqkiEz
         jugg==
X-Gm-Message-State: AOAM532IWyHeEJIDTZRi/AbO3/zvOvPE8fJk8pWJ+157yYgT1GTtF/A0
        ukH/GsObrMwAkOI9ppDU4WXov+dkX+g5fA==
X-Google-Smtp-Source: ABdhPJxWRPqyOn8Jizaxai3WLXkXAowDI/G5HyaG5kjhCRGr2HxAlSj4iG/NYwR3Tey+7u9L+1ETBw==
X-Received: by 2002:a05:600c:22c9:b0:381:3b27:89be with SMTP id 9-20020a05600c22c900b003813b2789bemr4298733wmg.83.1646323483159;
        Thu, 03 Mar 2022 08:04:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm4040667wmq.35.2022.03.03.08.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:04:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/8] Makefile: disable GNU make built-in wildcard rules
Date:   Thu,  3 Mar 2022 17:04:14 +0100
Message-Id: <patch-v5-3.8-9f42f40b518-20220303T160155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Override built-in rules of GNU make that use a wildcard target. This
can speeds things up significantly as we don't need to stat() so many
files. GNU make does that by default to see if it can retrieve their
contents from RCS or SCCS. See [1] for an old mailing list discussion
about how to disable these.

The speed-up may vary. I've seen 1-10% depending on the speed of the
local disk, caches, -jN etc. Running:

    strace -f -c -S calls make -j1 NO_TCLTK=Y

Shows that we reduce the number of syscalls we make, mostly in "stat"
calls.

We could also invoke make with "-r" by setting "MAKEFLAGS = -r"
early. Doing so might make us a bit faster still. But doing so is a
much bigger hammer, since it will disable all built-in rules,
some (all?) of which can be seen with:

    make -f/dev/null -p | grep -v -e ^# -e ^$

We may have something that relies on them, so let's go for the more
isolated optimization here that gives us most or all of the wins.

1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/shared.mak b/shared.mak
index 0170bb397ae..29f0e69ecb9 100644
--- a/shared.mak
+++ b/shared.mak
@@ -1,3 +1,14 @@
+### Remove GNU make implicit rules
+
+## This speeds things up since we don't need to look for and stat() a
+## "foo.c,v" every time a rule referring to "foo.c" is in play. See
+## "make -p -f/dev/null | grep ^%::'".
+%:: %,v
+%:: RCS/%,v
+%:: RCS/%
+%:: s.%
+%:: SCCS/s.%
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.35.1.1230.ga6e6579e98c

