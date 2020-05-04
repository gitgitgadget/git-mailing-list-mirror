Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD37C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D339121582
	for <git@archiver.kernel.org>; Mon,  4 May 2020 07:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoUjrv/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEDH1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgEDH1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 03:27:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B4C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 00:27:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so6443413plk.10
        for <git@vger.kernel.org>; Mon, 04 May 2020 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MzB00g0Ql7c2huyECvboSkmzI6bQC/ZDgxkH1W84RIw=;
        b=VoUjrv/fsHjlYFxxSnU+Zv9g/vLOO9AeBBB6U3UFTSLOgZe6uViqna6rpEFu4/o1LY
         gTsn4wvPaZih0QT33ekjY/7JkqsaWAz1ZHOXdkyiJQ2MTWxtWHABSPhVzfWyE88zgHso
         YYCVujQEUI/36Ox64yvubOpYaIG0Wv6dfiYmK5FbA1HWBmYaDbwpTNab5JZ2CtLHww+2
         AwASjriGNxrf23W5j6RXPi5jUFGpwEjrEEokmA5GbiimvMrj9aBtfKSmcVnM+9gXDnM+
         0uOLqDJL5A/4s9OzafFbaqFvdLN038bWue7k9YNGrfMP5HYyccugkiXw23Y4A3jIrInb
         NgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MzB00g0Ql7c2huyECvboSkmzI6bQC/ZDgxkH1W84RIw=;
        b=DBLKLHMdv8kw/1kjV1jnGDO8Jroctk43JMShuPaNpa2I6BXtiqoa1bxxO84tinPWea
         pFCxwctSB5uaMsIUsJNiwpgRH/k6lrK3l+MBkg5T9Zkd8tPpL2U98SfGo5LH/7Pmdcu9
         qqLVvrtLtYhRfH/sQ79X+91hTTTfkIq69VMGyAonDNT2oE/h2Iy3+WygtN1qY/MYruC6
         LMTtwifsT3D3efz+XohQvBp+VaVGjcCzMsFHiZYKiMtfitegiXsF7jPniQQT+j0nmP25
         MkUVZfYxYUXTSFRSTLOEOXlG2o7wG6tCK1GI+qPExvcOKGTxx4637k32T4xAAJyr2fmB
         bQAg==
X-Gm-Message-State: AGi0PuYkIcJBZwaO6GIGQZBEQkatRLR1/pCjue08aA+mYW302vuW3CZQ
        mB4vMOv2h5bOPW8WFrl14MMNOuL2nU3Orw==
X-Google-Smtp-Source: APiQypJihmKMqjEeMSwBKsyJ3ohXr3zNPPQId6Hz4O9b293yosjiW2o3QdOE4JuABK5Ie+uD7WK6rw==
X-Received: by 2002:a17:90a:6f22:: with SMTP id d31mr15872545pjk.14.1588577257843;
        Mon, 04 May 2020 00:27:37 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id a12sm7961292pfr.28.2020.05.04.00.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 00:27:37 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        liu.denton@gmail.com, peff@peff.net, heba.waly@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3] submodule: port subcommand 'set-url' from shell to C
Date:   Mon,  4 May 2020 12:57:05 +0530
Message-Id: <20200504072705.15261-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert submodule subcommand 'set-url' to a builtin. Port 'set-url'to
'submodule--helper.c' and call the latter via 'git-submodule.sh'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Thank you Junio and Denton for the review :)
Eliminated the whitespace errors and removed the callback structures
as well. I have made the commit message more abstract for now as pointed
out by Denton that the message seems to go into too much detail.

Also, the variable name for `&entry` has been changed to `config_entry` so
as to avoid confusion with `cache_entry`. The shell file has also been
amended.

 builtin/submodule--helper.c | 46 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 22 +-----------------
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c88..6fd459988e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2246,6 +2246,51 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
+static int module_set_url(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+
+	const char *newurl = NULL;
+	const char *path = NULL;
+
+	struct strbuf config_entry = STRBUF_INIT;
+
+	struct option set_url_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for setting url of a submodule")),
+		OPT_END()
+	};
+
+	const char *const usage[] = {
+		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, set_url_options,
+			     usage, 0);
+
+	if (quiet)
+		quiet |= OPT_QUIET;
+
+	if (argc!=2){
+		usage_with_options(usage, set_url_options);
+		return 1;
+	}
+
+	path = argv[0];
+	newurl = argv[1];
+
+	strbuf_addstr(&config_entry, "submodule.");
+	strbuf_addstr(&config_entry, path);
+	strbuf_addstr(&config_entry, ".url");
+
+	config_set_in_gitmodules_file_gently(config_entry.buf, newurl);
+	sync_submodule(path, prefix, quiet);
+
+	strbuf_release(&config_entry);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2276,6 +2321,7 @@ static struct cmd_struct commands[] = {
 	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
+	{"set-url", module_set_url, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 08e0439df0..39ebdf25b5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -805,27 +805,7 @@ cmd_set_url() {
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
2.26.2

