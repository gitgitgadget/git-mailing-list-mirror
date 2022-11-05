Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C757DC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiKERIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKERIX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE54FC9
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so7568868plb.2
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VQpaKMcn6bHAChQ9L+fuITIsR8U2S9eznDl7WQGlMI=;
        b=CkhRsEwRPAq0I478mmgq6QsJSPSWRfVGh2Ofuo0rh0VGLTEueVWbAR246bA5s4Ylru
         KrSSJPnvpZ/+vaxUdGpJNGnB+dOYSqoKK04PWzBdn7XRpDgj7V/GEQ/tabxvA4Ngmxd5
         uufmA07gDtMGCg2iVmNYHXYC+xUydXnd3l9XvZCAAOMZxzcDxcMgmJw17U2QUCCTJ9nf
         02Wpxj3MuxpW9kLjUS5YPKLxt2P+jmlTUjcFEtmhwbHA6m3JIp+JMkFIUpOumO0zxO4N
         2c6Ao747VuW0jNwLu/M8Ny/TR1QYcvelUY5Yl3P+44a80/ae+GY1hgOYdcuSubb8UwI2
         qOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VQpaKMcn6bHAChQ9L+fuITIsR8U2S9eznDl7WQGlMI=;
        b=NyNN2zfzl/rERpeNr27g7EfF+xDsNFqoAy4SRAypVHW/WAyu5TYG9VpJ0Vxeflrhip
         RAsUJ7SP4U4xyTnMXFItKsFjjlAln6O3U7YgMoIDZOvs2GVIJQxUf3k3Ha3Fp36dY0LJ
         cwJ8nE9KbesdHSyQ3eze7yRrcl9HF8SYA570ripIgwhrOlesP61zVWIUcY+thec9yMNp
         JwkRbJC6yT1J53C9Z0dFymzgwcJZhjjHPjnphg+6dqC0odG6uGh3Uz+7UY3hStcYi0h5
         HGXhZrauFh9LOxCqkUtz0TzvfVQwAdDOWlXxAJAFoDkoBSq/h4a6i4l6wymoudqxTt0P
         +Q4A==
X-Gm-Message-State: ACrzQf1xTmaFm/XjS89h3UaoVLV5m9EF9xNMQxhmtQD+CCtsO1gvMx2h
        vOVJK0JFIHrBW1z8Zw9S1a0Bkzr3u/U=
X-Google-Smtp-Source: AMsMyM7PaJbxbzRlGGwxuz0G+kkExRzXKkjvTrirRxNMlLWq4hTqyKoVniU4NUP6B+K9IQi/PxSwKQ==
X-Received: by 2002:a17:90b:2651:b0:20a:daaf:75f0 with SMTP id pa17-20020a17090b265100b0020adaaf75f0mr41110360pjb.142.1667668102062;
        Sat, 05 Nov 2022 10:08:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:21 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 10/13] bisect--helper: make `state` optional
Date:   Sun,  6 Nov 2022 00:07:41 +0700
Message-Id: <a53e0c61cac3252bc9119fbde05b6c4bd0a1a295.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for making `git bisect` a real built-in, let's prepare
the `bisect--helper` built-in to handle `git bisect--helper good` and
`git bisect--helper bad`, i.e. do not require the `state` subcommand to
be passed explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 29 +++++++++++++++++++++--------
 git-bisect.sh            |  2 --
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index bfa160dbf2..3c7a16355a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1435,14 +1435,27 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("run", &fn, cmd_bisect__run),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, prefix, options, git_bisect_usage, 0);
-
-	if (!fn)
-		usage_with_options(git_bisect_usage, options);
-	argc--;
-	argv++;
-
-	res = fn(argc, argv, prefix);
+	argc = parse_options(argc, argv, prefix, options, git_bisect_usage,
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
+
+	if (!fn) {
+		struct bisect_terms terms = { 0 };
+
+		if (!argc)
+			usage_msg_opt(_("need a command"), git_bisect_usage, options);
+
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		if (check_and_set_terms(&terms, argv[0]))
+			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
+				       options, argv[0]);
+		res = bisect_state(&terms, argv, argc);
+		free_terms(&terms);
+	} else {
+		argc--;
+		argv++;
+		res = fn(argc, argv, prefix);
+	}
 
 	/*
 	 * Handle early success
diff --git a/git-bisect.sh b/git-bisect.sh
index dfce4b4f44..9f6c8cc093 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -57,8 +57,6 @@ case "$#" in
 	case "$cmd" in
 	help)
 		git bisect -h ;;
-	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper state "$cmd" "$@" ;;
 	log)
 		git bisect--helper log || exit ;;
 	*)
-- 
2.38.1.157.gedabe22e0a

