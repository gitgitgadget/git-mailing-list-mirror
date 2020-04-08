Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC884C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9176B20730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVnNtL+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgDHTdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:33:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33804 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgDHTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:33:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id x62so829728ede.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=hkxcwkfov41oIK99xM9ufFvKKqGrO1o+PAGoa0ilKOU=;
        b=DVnNtL+RiqdIDM1BL9+bI0/tNlAAYIzDQLie+e3i+BrUEmz9p0CJtIIpnFfEHP9v9l
         qX9MLmiAP9B/eYbtP/rLn4W8mWYmRwn2V1+Krmtqm8lOUYQMjwSYPus70aUS3ESdKPRd
         zoqrdvFUpbx6lhPxugDUSFQvgkL9YpgUJWKGskLv+MDTwgxu5delDbCDqLmT/wjMczzL
         03DdxDpYXhH2EgIItl3WtcdJnFRu85iKv+7qdEgmjy7kctMSyn1flFBAv8YCuNOE67Hp
         yRAjsOyXkcBcsNAyRYUQMDeyBZxJcom6OrOoPazbH3YlSLMTeVnlXxYeFQNS/ZWO/ld8
         5bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=hkxcwkfov41oIK99xM9ufFvKKqGrO1o+PAGoa0ilKOU=;
        b=E2c8be18LE0JMsDuAjhUGs61KGwxS7d6drOOiIpcrCQ/U9izXBXp0ymzZRu/k4jaJ9
         xNIq2/HMBCKs/bleECkm77FsCifitRWd5o2tHRWIitfKeNjACJuXeq2znhLBg29cEBUb
         jsFxoB5EyYKAZJhauAVQTfEdb2/XB3Kp01EnH2VL/+qr30aCxvWW0FjDy9oKAcaeT4i8
         tPuEzAWy02U2cW+E8tYwmnDMblCg9zLwdk/2KPoEZXta3f49cjm6vJot0tf4aPJazzpj
         RKtPCMnjuxz7e7O+URPmNenv/RaA24x5nsS27ljcqyWOl1/PuVIC0nCT7q9AAGKHwyPe
         aUzg==
X-Gm-Message-State: AGi0PuZHbbcuNbuSb7dFPV9X2pS3mqmOq1eFs8XedlUwXUGQrDl5oWsB
        EuynES/vgdC2MiLlthFa+3GFf295
X-Google-Smtp-Source: APiQypKSF19Rtt1KSAa2pjv1Jv/OknX2zPWMwcWHf23Ouzr5vZmuMUOPXUw6m7D0tJcIAnVs6sMUtA==
X-Received: by 2002:a05:6402:160e:: with SMTP id f14mr8040063edv.301.1586374381889;
        Wed, 08 Apr 2020 12:33:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm3659717ejj.63.2020.04.08.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 12:33:01 -0700 (PDT)
Message-Id: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 19:33:00 +0000
Subject: [PATCH] clean: explicitly `fflush` stdout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>

For performance reasons `stdout` is buffered by default. That leads to
problems if after printing to `stdout` a read on `stdin` is performed.

For that reason interactive commands like `git clean -i` do not function
properly anymore if the `stdout` is not flushed by `fflush(stdout)` before
trying to read from `stdin`.

So let's precede all reads on `stdin` in `git clean -i` by flushing
`stdout`.

Signed-off-by: 마누엘 <nalla@hamal.uberspace.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Explicitly fflush stdout in git clean
    
    This is yet another patch that was funneled through a Git for Windows
    PR. It has served us well for almost five years now, and it is beyond
    time that it find its final home in core Git.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-755%2Fdscho%2Ffflush-in-git-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-755/dscho/fflush-in-git-clean-v1
Pull-Request: https://github.com/git/git/pull/755

 builtin/clean.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/clean.c b/builtin/clean.c
index 5abf087e7c4..2bd06d13395 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -580,6 +580,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 			       clean_get_color(CLEAN_COLOR_RESET));
 		}
 
+		fflush(stdout);
 		if (strbuf_getline_lf(&choice, stdin) != EOF) {
 			strbuf_trim(&choice);
 		} else {
@@ -662,6 +663,7 @@ static int filter_by_patterns_cmd(void)
 		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
 		clean_print_color(CLEAN_COLOR_RESET);
+		fflush(stdout);
 		if (strbuf_getline_lf(&confirm, stdin) != EOF)
 			strbuf_trim(&confirm);
 		else
@@ -760,6 +762,7 @@ static int ask_each_cmd(void)
 			qname = quote_path_relative(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
+			fflush(stdout);
 			if (strbuf_getline_lf(&confirm, stdin) != EOF) {
 				strbuf_trim(&confirm);
 			} else {

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
