Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A0C433E1
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA92D20870
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 22:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlvqkRFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGDWSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgGDWSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 18:18:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BFC061794
        for <git@vger.kernel.org>; Sat,  4 Jul 2020 15:18:54 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so25160236ljj.10
        for <git@vger.kernel.org>; Sat, 04 Jul 2020 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RabM6YLQrpH1ucDybYRDdvVnHb1LE+U58F3s3N2Jec=;
        b=WlvqkRFqHopCa3UI8v+RB7q4u7KsoyZWvTa/p9w42z340pasKAJc1tvRuSgFkFOyPa
         9cZ9SAjNhfOuH0dZ6DEr7Mvbr1CBnS50rSX1nazZ46/wQmBUXAIL3pvNjl/CnHFw4eCP
         SCfRegsCS/s+D4JFhet1X4muIJp0dcIUihildwu6Ch1iw7SeG40fW3a7JYLq7Kpa7CcG
         wHBmEdsovgWWjKVhdasvCsA0zchmfTGillfXh8SteqWjBFNzSrYBrhezg4+9o1LQ3RpS
         awMZj12KDoi4KlbgKdS7W/cLoFKo2Nf3qzshSs5Q9f//slmaPzJf6DAvg6a3HKRVuH3Y
         xWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RabM6YLQrpH1ucDybYRDdvVnHb1LE+U58F3s3N2Jec=;
        b=oQ3wdijaCCxS3sjc6lTYmu/Cgo8xSFFvilK/6fcvBy9dCoiIB2HbGIlmhjJzmAyKwH
         CLsE4IOkGV8Md1IHHP9pH+0DtMI3dWZVfAXYF6InuuxoiTDc/h1EA+s7k//F/kIdu1NB
         lgNGBvDEnCwYf0+k9KFSMlncUhQwtRc0WhscRyDwG2cskhbP1aNH5WX/3WSGjFTiYUs3
         5bCDa3H07ShrgS7qjfz6z6CNu7+YMBh8/zcAl2B63ONDsdVdy+CELCy8XH2dRJqP93Od
         9vgUyC+TUPP3l+TZq9UCwVxFRgCKjHx/zvI2SghsBGfB3fice5ughBCSuynIm9Gt88ok
         T78g==
X-Gm-Message-State: AOAM5306lGp7aclb9C554Uv/jeMMEUQDsFFOqQzy7c2UQ08mVnygWzaa
        qt5aLF6lO0yUYxBjp9BY0DQeM/z53uU=
X-Google-Smtp-Source: ABdhPJwW3nGvHAYeaqqwbz920aPm5qncCnT9BqgafgKzX8MLcUXL9YAShJCqkmR3FMBdTt9zXTilnA==
X-Received: by 2002:a2e:9b0a:: with SMTP id u10mr23225822lji.243.1593901133116;
        Sat, 04 Jul 2020 15:18:53 -0700 (PDT)
Received: from elaine.localdomain ([46.46.195.162])
        by smtp.gmail.com with ESMTPSA id n25sm5588776lji.28.2020.07.04.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 15:18:52 -0700 (PDT)
From:   trygveaa@gmail.com
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Trygve Aaberge <trygveaa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 2/2] Wait for child on signal death for aliases to externals
Date:   Sun,  5 Jul 2020 00:18:38 +0200
Message-Id: <20200704221839.421997-2-trygveaa@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704221839.421997-1-trygveaa@gmail.com>
References: <20200704221839.421997-1-trygveaa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Trygve Aaberge <trygveaa@gmail.com>

The previous commit fixed this only for aliases to builtins, this commit
does the same for aliases to external commands. While the previous
commit fixed a regression, I don't think this has ever worked properly.

Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>
---

I can't say for sure if this will have any unintended side effects, so
if someone with more knowledge about it can check/verify it, that would
be great.

 git.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git.c b/git.c
index c8336773e3..0797ac6a80 100644
--- a/git.c
+++ b/git.c
@@ -346,6 +346,8 @@ static int handle_alias(int *argcp, const char ***argv)
 			commit_pager_choice();
 
 			child.use_shell = 1;
+			child.clean_on_exit = 1;
+			child.wait_after_clean = 1;
 			child.trace2_child_class = "shell_alias";
 			argv_array_push(&child.args, alias_string + 1);
 			argv_array_pushv(&child.args, (*argv) + 1);
-- 
2.27.0

