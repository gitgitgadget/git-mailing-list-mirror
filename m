Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A248C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 07:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4607D2071C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 07:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP/sKlOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEAHcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 03:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAHcq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 03:32:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B60C035494
        for <git@vger.kernel.org>; Fri,  1 May 2020 00:32:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d24so3397291pll.8
        for <git@vger.kernel.org>; Fri, 01 May 2020 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rmc5Xf830gVH1KEJBHzJHP41yFio8Nw0U1YGJM45Lxg=;
        b=CP/sKlOpJF/lDPyzO9856D8ghDBAR2wuMs+UxT55BC1X4DEG2onFEY+k5x1baERBT+
         kUeWVZrlncQWgxEH/eINQYOqrPTKI+oQujmH7hjugordSSPKDmZ/4MQ4ZQrPITzV94g7
         mMcO/6i0BRiaLD2ofz6EOf32XGBxpZIjpCzcpzxfTIfnnwHtZKo59GtZMIo7BP2cOHow
         e6w7shXnZ7Q/7zBMd1fhUiZZaFMAJcRuFhK3X/dTCBXTSadnlY9UlK53tqUWYeRDuJDU
         38WJt4ell/vYof/FzDvxeISDJp9kfLNlY1k38O4QZiYZSlHbxI/W09s/EsRSu1gpyN2R
         F5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rmc5Xf830gVH1KEJBHzJHP41yFio8Nw0U1YGJM45Lxg=;
        b=rzkAyGf5LYFRIR/HIvQgN+ei8q97V+fAgpsxCRo+Fg/t3gdYMHEasJpzAGG7Vqvf2E
         qqUFLk0BsnBgCYXSHOAEpPGfQtKYb7/OAq/R1v8aVCb93p6DI/RlP2YaHitlQ3Gqwmoi
         FQgczLyXTdGnIhMElP6My1OFFqihbrvLLpsdg2iYr3+UxlZC99y0sguBwHC9bXSJqg4a
         Jh7Hw8QNPyTvT5QAKLguovV6bueSMqwMEqXWaWh8scu6jFmiuLiHjSTYDo0QIp0HbX6i
         yICLOKLz1QL2BQFs7eMnM2Iso5MvaGxwydY3bgIuuYpdQNQjaHO55kAZjkm71HT6tvDr
         c6Uw==
X-Gm-Message-State: AGi0PuZ4eX2cqi6YECuXcDWVhSppb3gYv9ql5kwZTIwROetEUvHgNenA
        3s+S62el6i9lURXnZTuF6o8Bh6Uudr1RlfJ4
X-Google-Smtp-Source: APiQypKgNn62HJPs+aURzP7nXiUgbHez86HkS74tpd+y+AHkVNqleSi+VqaFs5iOrItgAuVRE1KSNw==
X-Received: by 2002:a17:902:261:: with SMTP id 88mr3292887plc.152.1588318364745;
        Fri, 01 May 2020 00:32:44 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id y13sm1550535pfc.78.2020.05.01.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:32:43 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, heba.waly@gmail.com,
        liu.denton@gmail.com, gitster@pobox.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2] submodule: port subcommand 'set-url' from shell to C
Date:   Fri,  1 May 2020 13:02:32 +0530
Message-Id: <20200501073232.18409-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to convert submodule subcommand 'set-url' to a builtin.
'set-url' is ported to 'submodule--helper.c' and the latter is called
via 'git-submodule.sh'.

'module_set_url()' accepts the the user input, which is parsed by
'parse_options()', followed by the setting of the appropriate entry
(i.e., the submodule URL here). Finally, the URL is synced, via
'sync_submodule()', with the upstream.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
I finally fixed the implementation, was making a silly mistake.
The test './t7420-submodule-set-url.sh' passes (both tests 1 and 2
are successful now). I have deleted the function,
'update_url_in_gitmodules()' because I was able to suffice that
functionality in the 'module_set_url()' function itself.

Thank you so much Christian and Denton for helping me :)

 builtin/submodule--helper.c | 55 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 25 ++---------------
 2 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c88..59334d4286 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2246,6 +2246,60 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
+struct set_url_cb {
+	const char *prefix;
+	unsigned int flags;
+};
+
+#define SET_URL_CB_INIT { NULL, 0 }
+
+static int module_set_url(int argc, const char **argv, const char *prefix)
+{
+	struct set_url_cb info = SET_URL_CB_INIT;
+	int quiet = 0;
+
+	const char *newurl = NULL;
+	const char *path = NULL;
+	
+	struct strbuf entry = STRBUF_INIT;
+
+	struct option module_set_url_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper set-url [--quiet] [<path>] [<newurl>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, module_set_url_options,
+			     git_submodule_helper_usage, 0);
+
+	info.prefix = prefix;
+	if (quiet)
+		info.flags |= OPT_QUIET;
+
+	path = argv[0];
+	newurl = argv[1];
+
+	if(!path || !newurl){
+		usage_with_options(git_submodule_helper_usage,module_set_url_options);
+		return 1;
+	}
+
+	strbuf_addstr(&entry, "submodule.");
+	strbuf_addstr(&entry, path);
+	strbuf_addstr(&entry, ".url");
+	
+	/* Setting the new URL in .gitmodules */
+	config_set_in_gitmodules_file_gently(entry.buf, newurl);  
+	/* Syncing the updated URL */
+	sync_submodule(path, prefix, info.flags);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2276,6 +2330,7 @@ static struct cmd_struct commands[] = {
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
+	{"set-url", module_set_url, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 89f915cae9..ea72d5a5f5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -783,11 +783,13 @@ cmd_set_branch() {
 # $@ = requested path, requested url
 #
 cmd_set_url() {
+
 	while test $# -ne 0
 	do
 		case "$1" in
 		-q|--quiet)
 			GIT_QUIET=1
+			shift
 			;;
 		--)
 			shift
@@ -800,30 +802,9 @@ cmd_set_url() {
 			break
 			;;
 		esac
-		shift
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
2.26.2

