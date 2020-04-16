Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C943CC2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A548C20786
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyPl6b1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDPVFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgDPVFd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:05:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74EFC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:05:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so77333plp.9
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1PKcAATPtozVsIh8owWyylu5HzuX9sLenn0ttdTSgk=;
        b=TyPl6b1dxNY5xSDmK6ktMJnvyHpzZv0p50uAyiTFEpCLEHNzcuUO7HOBunXe0OPyy3
         K2elvYHlyDpbQ/MM3RVGPkxBCF1H+5F6Zb11DsAaydE8NJi6xpGxevk0WDHFsd1Wcw8b
         7VHRfrYqmiVzL3ttx6FJb/capZ4BNwNbmL+MwTjhtzwsvK8EB5HfoCDHzwnQ9d+UdmgM
         EYVPdwT00ddROZxowQn8ZphMw5K/JRP4F7ihsFTC35eccUHF353mGmWO92/2cN+a+ft6
         F4qmId+pQy62Fwa4V09cBDU7UDWxFr0+IRcvmU+HYEGs6F7CZ00p1XnQBkQU+Zkmm67M
         nw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1PKcAATPtozVsIh8owWyylu5HzuX9sLenn0ttdTSgk=;
        b=c17e6AhqPrNKbFA/1ENyDBNy20f9EARjM6JIePM7vUwG7fEBRW4IqmuBajg4iS/v4O
         fhhnoNr4HsEEp40eTZzYoKc9RCUntia6tGl0mFKwaulx1sfF08Gh/3/MNgwQYFBlSG+A
         2lSaB6DGCO5myyDP/A0+aCptOHJqvsHuoB0iviLq+ULj7AHoLqWOfcGBObxVelhhyiNc
         SAq/CynDTFEatWT6DKBlsUi8CeirKTBx7ZiIaJF8yAsJOoSwtX8/D5CFfQrb5TG1gGZr
         xikeoKMoCkKiQUoXUJZxwPwKx9Ad2WAOfMp1qD3VPdSTxaiZUDQe0jpUag7o4ipX3PNN
         U2IQ==
X-Gm-Message-State: AGi0PuZ5JLLQU2Ixkyj55vxrTFu6n5K6XV3vM1zw05l/oyo1+fLimwzy
        AlDPNfPso31Ybe1qw52pLKEfs6lRjPrluQ==
X-Google-Smtp-Source: APiQypJk0SdxcVOKoMnH/m7fbiWkgjg5pWntNl0twRq6e0+OiJf2qNlRFZ2UCq0UqCXuKxrJjPMOAw==
X-Received: by 2002:a17:90b:3443:: with SMTP id lj3mr310896pjb.38.1587071132942;
        Thu, 16 Apr 2020 14:05:32 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id x18sm10524090pfi.22.2020.04.16.14.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:05:32 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, heba.waly@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 2/2] submodule: port subcommand 'set-url' from shell to C
Date:   Fri, 17 Apr 2020 02:34:56 +0530
Message-Id: <20200416210456.19122-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
References: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to convert submodule subcommand 'set-url' to a builtin.
'set-url' is ported to 'submodule--helper.c' and the latter is called
via 'git-submodule.sh'

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 38 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 23 ++--------------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c88..10e774a5c9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2246,6 +2246,43 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
+static int module_set_url(int argc, const char **argv, const char *prefix)
+{
+	const char *newurl = NULL;
+	const char *path = NULL;
+
+	struct pathspec pathspec;
+	struct module_list list;
+
+	int quiet = 0;
+
+	struct option module_set_url_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule [--quiet] set-url [--] <path> <newurl>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, module_set_url_options,
+			     git_submodule_helper_usage, 0);
+
+	path = argv[1];
+	newurl = argv[2];
+
+	if(!path || !newurl){
+		usage_with_options(git_submodule_helper_usage,module_set_url_options);
+		return 1;
+	}
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	return update_url_in_gitmodules(path, newurl);
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2276,6 +2313,7 @@ static struct cmd_struct commands[] = {
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
+	{"set-url", module_set_url, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 89f915cae9..f0304c3e19 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -783,6 +783,7 @@ cmd_set_branch() {
 # $@ = requested path, requested url
 #
 cmd_set_url() {
+
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -803,27 +804,7 @@ cmd_set_url() {
 		shift
 	done
 
-	if test $# -ne 2
-	then
-		usage
-	fi
-
-	# we can't use `git submodule--helper name` here because internally, it
-	# hashes the path so a trailing slash could lead to an unintentional no match
-	name="$(git submodule--helper list "$1" | cut -f2)"
-	if test -z "$name"
-	then
-		exit 1
-	fi
-
-	url="$2"
-	if test -z "$url"
-	then
-		exit 1
-	fi
-
-	git submodule--helper config submodule."$name".url "$url"
-	git submodule--helper sync ${GIT_QUIET:+--quiet} "$name"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
-- 
2.20.1

