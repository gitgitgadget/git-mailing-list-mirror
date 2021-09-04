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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F15AC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 02:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F210761058
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 02:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbhIDCO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhIDCO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 22:14:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41EC061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 19:13:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s15so814740qta.10
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTYwqESaBgdGqLE6GVsW97LekovBaBbtdhOrpkxx4AI=;
        b=P8VYOxaVn5DnycGdiEQ7SxFhyiR8CKlzJ7tq08Kd1n+eVVKxf+PuxMzKPHhCFdGw9M
         luEp6+wOttuVyCUy008S9vtlB64L5Xxj7FovKKp/NGGimN0hOEbax6KGcOsISxbhIpQV
         6zxQ1hycUszARSV4vKDyOR5Uzu4O4BTshue3i84K9jBz0fMjZSPDx8W1A8LJQiQfWs69
         /bYSwd6e9c5fTg6O6o/EHsRr4PAHKJEYbhiclpF32JhyNJKKSb4hq+DZhhO87vt7izA6
         RXk/CeY5mUJb+Wu04XVCYylt0pA/BI7svM1xbZGhJ7pYm6mzzY37GSFUi77I29kUSymQ
         PuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTYwqESaBgdGqLE6GVsW97LekovBaBbtdhOrpkxx4AI=;
        b=NsMY4ol351e+gf+pgeN/wH5RFiXdaa1Cg1QQBKBuWQ+AOUWVsDaE1HDHw+HooYXEla
         nbTRQg07XB7tWH+XNKDqt1yPZ0jcupBj6hGpgdvwsTO/yCR+ODW0j/Fi6dad1xFuB+bD
         cjXzmg6qmJ4wYJgFUsvMzHJX/PnXWord6KIMjeGvBwd40wS+hxBeCRMFa2JCMwwFaBO0
         XQr3kFBPwZdwmcT1JpRRrF16HXhP+JMPtWQsk/JE6C7QWcvooHS7zwLrNFR+JHv3+MPd
         qgVx6BVjjo1ks0NOzIAmscj5IqpRge0Z4Qjmts4SjEg0okfekptwrgy0Cy6vf0vex2re
         VTFA==
X-Gm-Message-State: AOAM53110trZ8BdmP0Kw1BwxxUtxNItmJ7hT+bI90KCePseMAPr7DvI+
        Zab3Rr2uCceBXJsbXa8PiezSPUYFDrU=
X-Google-Smtp-Source: ABdhPJysRkKWVTtpP2WTQr3qewbxXYjkr6XXsPj3OLuqAZWOEY8Nn8b+N5bFxjt33eVNK0z1BU73FA==
X-Received: by 2002:ac8:4891:: with SMTP id i17mr1819366qtq.321.1630721636382;
        Fri, 03 Sep 2021 19:13:56 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 69sm846624qke.55.2021.09.03.19.13.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 19:13:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, emilyshaffer@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/2] bugreport: slightly better memory management
Date:   Fri,  3 Sep 2021 19:12:31 -0700
Message-Id: <20210904021231.88534-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210904021231.88534-1-carenas@gmail.com>
References: <20210903115933.622847-1-bagasdotme@gmail.com>
 <20210904021231.88534-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

238b439d69 (bugreport: add tool to generate debugging info, 2020-04-16)
introduces an UNLEAK for a strbuf that contains the buffer that gets
flushed to disk earlier, instead of simply cleaning the buffer.

do so, and while at it, move the free() call for another temporary string
closer to its creator, so it is easier to keep track of.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/bugreport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 17042381c3..a9bedde1e8 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -152,6 +152,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_addstr(&report_path, "git-bugreport-");
 	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
 	strbuf_addstr(&report_path, ".txt");
+	free(prefixed_filename);
 
 	switch (safe_create_leading_directories(report_path.buf)) {
 	case SCLD_OK:
@@ -181,6 +182,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		die_errno(_("unable to write to %s"), report_path.buf);
 
 	close(report);
+	strbuf_release(&buffer);
 
 	/*
 	 * We want to print the path relative to the user, but we still need the
@@ -191,8 +193,6 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	fprintf(stderr, _("Created new report at '%s'.\n"),
 		user_relative_path);
 
-	free(prefixed_filename);
-	UNLEAK(buffer);
 	UNLEAK(report_path);
 	return !!launch_editor(report_path.buf, NULL, NULL);
 }
-- 
2.33.0.481.g26d3bed244

