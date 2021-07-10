Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD9DC11F67
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0123613B9
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhGJNki (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhGJNk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A58C0613E5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t5so2645994wrw.12
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWlM3thwZepB5bHIEVDk0JIgE9Qo4Yn1JyVgH9wmaDI=;
        b=amlGe9IpT4YGLt0QhIQQVcE5yoVXZvNeQqXP5sVVhtcK1Wn5P4zrfVtnI0Br9K3owg
         gId4KANhgvgU9R91AeExX4/hIoiEU5DLTuuqG9Y1/djXug8+BR1TrNEJe3DVYBbGxCM8
         gDZua8XGeUQal41kmvM+c0wa7qo33NYfb4IUmkxQf/gFLxIPemHwTdNSYcEsIEwI1WIT
         gxitCbtnj2Oxr2Zsk5as3Szi8oZdpX1rzTpkNL/SeAvKeoYRbpyVZySmh8LGq6QjI0MZ
         DOWkLheoaC/anbV8RbnXtV/lUKNSC/2BKr5q7nzr/SSY5AH6X+X+HlgcsYcApgvo/xM0
         Bu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWlM3thwZepB5bHIEVDk0JIgE9Qo4Yn1JyVgH9wmaDI=;
        b=fEpLoeDYBZKVEXUNp+vi4jCRwqy9D48DL/Qsc01MWwN8cNUFV8h4BhTJrtEjJekNNv
         VTrgI1RrKN1tJEb35Nll+dEgq0ddmZ+mTwGrIhRCg+LrABtz/qijXL4NqbZwDwijf+xG
         y4eIr0ADBHBgj2tNJ4bpAj6BJNwjZAk/DVA/PUl5IlEbKfMIiZG0oanm8zYGpcXYpIWo
         l7cEvHwh4yIf53VVsz5zlELzJyZJdnTO1P1sJbieHwQUsthsLkB2fuTWRB8bvabbG6I9
         8RHTdNdS8x9iZ6H8vE/YWHLgAlQU3nJYRzfXSV1H3ZneKUijB+BU+UOkzlmT1+6KSNZI
         EwAg==
X-Gm-Message-State: AOAM532XXdFW7rM6avnj3ngvU7+ADffgkjkQ8OayYRniC6oQTdUkDPpB
        H45nHVxSzxBlZgYYloWmi59wYwbyeUpucw==
X-Google-Smtp-Source: ABdhPJxVf9NTM+/ux2atXJ4V+JHT1dYoHqNkEMtPxgvUay4hRt+prIPDmWFtqAbkncwUbX33CS73+Q==
X-Received: by 2002:a5d:524e:: with SMTP id k14mr12299255wrc.264.1625924262556;
        Sat, 10 Jul 2021 06:37:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 16/21] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Sat, 10 Jul 2021 15:37:19 +0200
Message-Id: <patch-16.21-912c9edf362-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return a -1 when git_inflate() fails instead of whatever Z_* status
we'd get from zlib.c. This makes no difference to any error we report,
but makes it more obvious that we don't care about the specific zlib
error codes here.

See d21f8426907 (unpack_sha1_header(): detect malformed object header,
2016-09-25) for the commit that added the "return status" code. As far
as I can tell there was never a real reason (e.g. different reporting)
for carrying down the "status" as opposed to "-1".

At the time that d21f8426907 was written there was a corresponding
"ret < Z_OK" check right after the unpack_sha1_header() call (the
"unpack_sha1_header()" function was later rename to our current
"unpack_loose_header()").

However, that check was removed in c84a1f3ed4d (sha1_file: refactor
read_object, 2017-06-21) without changing the corresponding return
code.

So let's do the minor cleanup of also changing this function to return
a -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index d41f444e6cc..956ca260518 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1229,7 +1229,7 @@ int unpack_loose_header(git_zstream *stream,
 	status = git_inflate(stream, 0);
 	obj_read_lock();
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/*
 	 * Check if entire header is unpacked in the first iteration.
-- 
2.32.0.636.g43e71d69cff

