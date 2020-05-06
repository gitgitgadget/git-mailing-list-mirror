Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1010CC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 07:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E082B20747
	for <git@archiver.kernel.org>; Wed,  6 May 2020 07:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOra0a9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgEFHh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727872AbgEFHh1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 03:37:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC30C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 00:37:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so473216pjw.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4yWeANlq6Z/WDDOkjM3hT2he/H1UaqVvWC+msnERvw=;
        b=dOra0a9SNmtnseKvB2SqAdb/eOg2R0l4wth8LiEuXxmukJiN6yJ62OomXfCue7l7un
         vHCSrE9xeN1a5YpOZByk5xFs9JUM2JEH9b9g3DuQfBy/vwnbqjMUwSHBd075QzrIQmFi
         RkrSVdJoqwQjH2X6MQA+VXOESW0hcEsPToXgQrJws2exfLGS/RNi8NuGip3WRo8iD5GY
         z1t/gZXzixQYSnUd6cj4DnvkrC1mXCDNhft3cDxVX1sp/oWNbFTtoh7rzIIIVerOa6hT
         o92KIKf8oUj1tsEWO2dOwbO1nLePzDA+cGw8ner146HQ5bFQnX2rfh6Efi+cLHmreLcx
         mbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4yWeANlq6Z/WDDOkjM3hT2he/H1UaqVvWC+msnERvw=;
        b=T/04rLdPiJQaZQ2b1//74m9FcjwTUzEH9/BHdCs10yrSwy/E09g1/8e7U+oUS7EjJE
         nm52TynTY6GAjgdH/op0EMlh1dFLIPmk0lvOKJUod+jAWZejCoFJAixS/gWPmkCm2+Ic
         gnuwC75eHg3xmmJWsPdduPX32l1/KZ5Zj+4r97v1UQHFpYDbNTyAqJM7Pe5yqCxBqrRQ
         ZKinEH1CjRF6lGF/1dd1NK6LGT/TL861d5UV4n/lkT79H/mz7yJ03APXQ0+KyTCB/srT
         BUwXMq1I3O1ASLu1b5qURoaHb+dtpQLuKuv6vVGQzkWKway/22+nrJ4Wza40pqWUP68i
         /Kjw==
X-Gm-Message-State: AGi0PuZP20KYzXAT1OSSeA+eIxwwqtFrjTBvhwIlALAT9CjH/pPGyrU/
        9nMN2+NZoCtYJLun3XDcjk/ZNO3f2iLbrg==
X-Google-Smtp-Source: APiQypJ1uXLKIcfKf06bINbtaXwzm9uFVeluAE2MUpBANbZP5VjVDrTTqg93vwRg/P9pKguCVCpwUw==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr8075773pjb.49.1588750645106;
        Wed, 06 May 2020 00:37:25 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id 131sm1039343pgg.65.2020.05.06.00.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 00:37:24 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
Date:   Wed,  6 May 2020 13:07:17 +0530
Message-Id: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
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
Thank you Junio for the review! :)
BTW, how detailed should the commit message be about the
patch?

 builtin/submodule--helper.c | 39 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 22 +--------------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c88..f50745a03f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2246,6 +2246,44 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	usage_with_options(git_submodule_helper_usage, module_config_options);
 }
 
+static int module_set_url(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	const char *newurl;
+	const char *path;
+	struct strbuf config_name = STRBUF_INIT;
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
+	if (argc!=2) {
+		usage_with_options(usage, set_url_options);
+		return 1;
+	}
+
+	path = argv[0];
+	newurl = argv[1];
+
+	strbuf_addf(&config_name, "submodule.%s.url", path);
+
+	config_set_in_gitmodules_file_gently(config_name.buf, newurl);
+	sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
+
+	strbuf_release(&config_name);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2276,6 +2314,7 @@ static struct cmd_struct commands[] = {
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

