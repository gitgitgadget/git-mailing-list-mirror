Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F7CCA47C
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbiFCSkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347176AbiFCSjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B013F44
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k36-20020a05600c1ca400b0039c2a3394caso3108216wms.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxVxL0Ex2NaBT4cMayReerAGfZHkk+5kSL5DT13ZbVo=;
        b=jZYo9I6f8tE9mZJnqPKAOUPA5rd9ifqGXXzOt0jwZ02f3B7gHRdLGXH1QZg6J6BJvX
         3hNqspIP/AeOuKjYE2FMhKvC2xzfI+Ib8ESCgZMC/G8dKZvo2OO9bXsrvPQSNNQfPFQe
         NUj5HWUVKa2PV/X3kqN8N17SRMRY9/cec056JDOnRGKrq414oWwUBhjThi1Tu+9/SN6V
         grlM9P6R0fto09VYn72dGSB9g0mmM8zzZ++jdSzvk55fdWdd11MDRhBJOfYgDGwdJX3h
         1NwsCUUuwPKDB+i7KAOMHOoPHOjGy33I6/FqfKyh+RmnyeGQ8JcG/D2U8dcqTxuUCtKE
         Tr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxVxL0Ex2NaBT4cMayReerAGfZHkk+5kSL5DT13ZbVo=;
        b=Z69MsdtjuUfTHW2vftNd239WqJv2gyfA66F+3kVdvC5XAMfVoJ+UeGVnNcIrfu3wa1
         ule+3tS+a6voPlQKxYRWqjLiiKXSFv3EoYbHH3Ix/ffNrzURRbjB5xZg28sO+8fLuGQg
         ibn1tl8lPmve6Zd7/ZncP7TjZdY7lsFxwsoPRHKquFejRrrPYJ9py37G7JGbQXE04z3T
         0wAHkmKwcYx/TkV8l8qXD65DLlXy0Yeu8mH48b2n5R8O7UDm/0LvhJjnSFBdsLQlty8i
         jZ+D++OuKiCXly+/J0ocLGXtPe97MyXcyQ1I/JZPFJjRh+BV8ghWk6BPxLbnkhIvVpUz
         T4ng==
X-Gm-Message-State: AOAM531rjwdiNW1q6KWhMojuzSqPpNRW2Pt5Ezy1a+5hm2yuoSClx1ZF
        oYCv104rwb7Q+K7e0wcQWSL9aHHDgeBsoA==
X-Google-Smtp-Source: ABdhPJz0Lx3LParGDjw/UJ7z0y+lQaZDWnOfigvSktLW1xuDGvVcAbM4kMCXaOFpePppiMROZT5AAQ==
X-Received: by 2002:a05:600c:3513:b0:39c:2a32:37a6 with SMTP id h19-20020a05600c351300b0039c2a3237a6mr8855845wmq.161.1654281490954;
        Fri, 03 Jun 2022 11:38:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 11/15] blame.c: clarify the state of "final_commit" for -fanalyzer
Date:   Fri,  3 Jun 2022 20:37:48 +0200
Message-Id: <RFC-patch-11.15-66518467e1d-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in d0d0ef1f67c (blame: create scoreboard setup
function, 2017-05-24) so that GCC v12's -fanalyzer doesn't think that
we can have a "NULL" final_commit in the modified branch.

This happens because the analyzer gives up in the
prepare_revision_walk() function, and thinks that the "sb->reverse &&
sb->revs->first_parent_only" condition we already checked a few lines
above can have a different result at this point.

That isn't the case, but what we really mean here is "if we previously
set up the final commit [because that was true]", so let's do that
instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blame.c b/blame.c
index da1052ac94b..f6b1865ba65 100644
--- a/blame.c
+++ b/blame.c
@@ -2816,7 +2816,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 	if (prepare_revision_walk(sb->revs))
 		die(_("revision walk setup failed"));
 
-	if (sb->reverse && sb->revs->first_parent_only) {
+	if (final_commit) {
 		struct commit *c = final_commit;
 
 		sb->revs->children.name = "children";
-- 
2.36.1.1124.g577fa9c2ebd

