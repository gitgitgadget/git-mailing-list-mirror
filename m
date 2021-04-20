Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31572C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8409613D0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhDTMva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhDTMvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53176C06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so4766243edb.2
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WW9CkW1F5CH4iV/1N8KPXaF/4PaGAUr3EpgsRklThg=;
        b=JK+0xJyIlPCkd7e15vMKbUC8n/Tk4oCjXzUcJgp/L9yoX60yYFW2NoYktkxM710piN
         k1o7NNJj1S1p1yqjCYdWg9L5N+uK3Xl3l2jgUClNXB1GbW7JKSUvXXbIAXmXSSML9lJT
         LcRbMPdY22445hK2oJKsyvkY8iExpthXhE5ADJAHJyBgmBvJeIB30MQUX50FT4yDo3Bk
         8B51NNSDZL6JQSyfnfTXn1yWqyvsg/nzNull6UdGO5b3lNF5XdUuoprrRKoaZmJDLYG5
         ITJQ3BU4SHifdd7v8BD+8fVsj4yLP5CgrTCKLdxLhKJbdhJ30Dwyf1WJh0NsHsMRO/AM
         xbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WW9CkW1F5CH4iV/1N8KPXaF/4PaGAUr3EpgsRklThg=;
        b=ddsKnwqP1s3L4lODWI061/akYkdx3eWIHuWDeDdm/SylvrY9v3H3DNzIbkLrhfiHJX
         I6jC56uz3j4s7Ckahg2ZfdYmLxSHvnnb9S386d7Lb0fZLqt55MR9q/74M6/1eP0DXV3e
         JxkEtiFLFxCARVr0NRFKLfFtZiP2AERAIPdekl6YE+PyPBdl0mV/c8j4UWHrOv3JG69t
         bDAZO5xVfg25vPc2fR25Ff0ATgdFqKGQBg4APbaAEmx9XgNQ/k0LRueN38/4T7cj9hvi
         mgxQtuq3JP3MUaJ4kUVFPiyCeBIJc0gUZH4+08gfYWgCrHTyZrb4y2V/Ff7z1WbhF2/P
         k5Ew==
X-Gm-Message-State: AOAM532hzBeAge+fLh+Ba+UumRah9fvJMsKIDN7/8sw7x353HWB57bDj
        ZMxTWPs2bHh6v72rIDdEp1neRHIq5GtEAA==
X-Google-Smtp-Source: ABdhPJy17F9mWP4g5oi1qf5QDMCldyMJtWZ7zojQxXaMKu1KeXGDJinegmWKKcR/jbvVd1rc8sdyMw==
X-Received: by 2002:aa7:d54c:: with SMTP id u12mr33450745edr.234.1618923051934;
        Tue, 20 Apr 2021 05:50:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] object.c: don't go past "len" under die() in type_from_string_gently()
Date:   Tue, 20 Apr 2021 14:50:41 +0200
Message-Id: <patch-08.10-f652d0fb5c-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug that's been with us ever since type_from_string_gently() was
split off from type_from_string() in fe8e3b71805 (Refactor
type_from_string() to allow continuing after detecting an error,
2014-09-10).

When the type was invalid and we were in the non-gently mode we'd die,
and then proceed to run off past the "len" of the buffer we were
provided with.

Luckily, I think that nothing ever used this function in that way. Any
non-gentle invocation came via type_from_string(), which was passing a
buffer with a NIL at the same place as the "len" would take us (we got
it via strlen()).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 70af833ca1..bad9e17f25 100644
--- a/object.c
+++ b/object.c
@@ -50,7 +50,7 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	if (gentle)
 		return -1;
 
-	die(_("invalid object type \"%s\""), str);
+	die(_("invalid object type \"%.*s\""), (int)len, str);
 }
 
 /*
-- 
2.31.1.723.ga5d7868e4a

