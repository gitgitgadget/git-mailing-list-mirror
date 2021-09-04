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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE16C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 02:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B33660FC0
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 02:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhIDCOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhIDCOg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 22:14:36 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20BCC061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 19:13:35 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id y144so1009266qkb.6
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDMVDrVEcfXBVT/D5jMqQZI7w2JwHQ3IsT4osw8Bpcs=;
        b=ROlapWvMnSttREnHJDkIYq5IUFY9Ynb1j9ZeANzbOwU8N0EksWSJea7im9NSveJCOL
         R+G00hfFKW//FfOU8yaI2pAE5PZpH6Ik+DsvLV4tv9zDob/+7w040zuEObvxNi4lHD6S
         pbI+4F04Zy+lUUlRo9uBi8HiZJxm49digrF1LZx1VV31nS+XLq39vlGO/KkBeaFM/nhc
         hZMZZScOLLxVHjNU6ZZt60wWwJCmdYmh19o5XIvIS42QSOaZ/xY/1yl76A6VWk2xHWRZ
         qgi8Xt9doFfBFq23zrnMxdBXx+V2zH5iiiIWxLzweehLgbTpofdivNLC/yYuRk2I1SC5
         jPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDMVDrVEcfXBVT/D5jMqQZI7w2JwHQ3IsT4osw8Bpcs=;
        b=UPtRBWI6Wl8Az7pIIusFZ1O98mqLnOx+0a8o+esIHeMoSI8/7YAVQ65corC7TUKn1+
         Zg3pPFJlu77ap//rKS2w+el3mdOOB3kWS4iyMOafwz4nAUHUDpR5mtm7Td8scMi6ZO6c
         saYJG8YjLyPv9lyM1wbwf6MNKmVf3fz1097zsA1zfvWQMEFywHiK8Z9LPDxQOkMVDpD0
         dVoLQu/OaDwj874Z6se+49O4qnDWU7QdWxQc7nG7jx38hExUtRX9963dvAbEvxD4JeY1
         mpcsJqIRI2yp9Jy9SwoNQmIISzGcMoX2pNMjpNamN3cgnMzNMM6Gx73VUprhCxC8APZ9
         1aoQ==
X-Gm-Message-State: AOAM533xIRDKf2nA4szK4uA8jvox0p+oYCjJA8qcf8MRkzhEXbKEQjfx
        zF79WWZ6641wwIy3HaERLqYQk3JHbAo=
X-Google-Smtp-Source: ABdhPJzEmS49McK/I9tsEdpnBQvOGSRCafJ1mPiHTxm459adDDSBsd87ecfiihfnnYxgsb9L4mRE0Q==
X-Received: by 2002:a37:6447:: with SMTP id y68mr1631591qkb.296.1630721614206;
        Fri, 03 Sep 2021 19:13:34 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 69sm846624qke.55.2021.09.03.19.13.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 19:13:33 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, emilyshaffer@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/2] bugreport: avoid duplicating options in usage()
Date:   Fri,  3 Sep 2021 19:12:30 -0700
Message-Id: <20210904021231.88534-2-carenas@gmail.com>
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
includes the options with the commandline, which then means they will
be duplicated in the output of `git bugreport -h`.

remove them and while at it, make sure usage() is called if the wrong
number of parameters is provided (ex: `git bugreport help`)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/bugreport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9915a5841d..17042381c3 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -5,7 +5,6 @@
 #include "compat/compiler.h"
 #include "run-command.h"
 
-
 static void get_system_info(struct strbuf *sys_info)
 {
 	struct utsname uname_info;
@@ -87,7 +86,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
+	N_("git bugreport"),
 	NULL
 };
 
@@ -141,6 +140,8 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
+	if (argc)
+		usage_with_options(bugreport_usage, bugreport_options);
 
 	/* Prepare the path to put the result */
 	prefixed_filename = prefix_filename(prefix,
-- 
2.33.0.481.g26d3bed244

