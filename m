Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E375207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041560AbdDURlc (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 13:41:32 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36555 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041565AbdDURlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 13:41:12 -0400
Received: by mail-io0-f176.google.com with SMTP id p80so9419859iop.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u60SZkERupozcX0oZXrcBHm3SGNC7B9XKy8VQfEDszo=;
        b=AK8mxgu+2t5Ea8A5qlYtPvkW/j8nombWC4ILly+GzcSjVRSHUhKykDh1pJ5qDi6Buw
         gPMfaw/+2ESVkD4UWXzzY20p38O8qQ0Czoj6fneA2q/Oa4lBokp0RVwFWvIGnXXfEnfJ
         83E8FhL9R7hHVoX919u3WyMBUBQwzUcUkaSWdDHJqXNTaKHOOFes7z8DjUHMwQuSPuwg
         FEwLCksP60jdGLEuhlYRhai1nI1EQ1jNLcm40XAWOlPx4iHjowupBmf4ZqA6PewCoF5f
         4ugYYBRF/34aXn+HfNTL3nRcdHtw7zQM5CA9TugGFsKbKRgqnQbeUM+glWdRwW7HVubK
         t5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u60SZkERupozcX0oZXrcBHm3SGNC7B9XKy8VQfEDszo=;
        b=mvuc37CW5v/5NqYDaCq1hg7Lx24GcoTO+7AeJ9uh1IM9ldXo7LFU65aUlJt4u+i123
         mugYMkF4959zIZums5K46Vz2rMeQk4/Xcbk8fA5sD9jE2zv7VRqBGmEjqVeI9YJpTifS
         auM5IRdv9o8nsXI48grGOrccQgq6HDbimoQEXmuWgxHJB8RGx7O21YjQNzhM8xVRgXop
         +hOsyWqBu7DmNm+dksQEvb5Hde6FYGGPjcRYD9VHZyg/AGP2C66BriH9/S5aVgeQje7P
         cAPhwk3yfoT3lVfXpNvLUf3sdGiWuDx3aIH/p1mZrnk2BSs5k1PR+g4K4WhctSbTP4RJ
         b1cg==
X-Gm-Message-State: AN3rC/7hynInZvf7jW4XbEbZOyBxZ6kYzXoqSToXgWWfoEZDG77IXp7H
        ytqY1bNe55KHam1h
X-Received: by 10.99.107.198 with SMTP id g189mr13273502pgc.162.1492796397693;
        Fri, 21 Apr 2017 10:39:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:20c0:fec:9e95:adb1])
        by smtp.gmail.com with ESMTPSA id x1sm7356500pfx.133.2017.04.21.10.39.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 10:39:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, philipoakley@iee.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/4] builtin/reset: add --recurse-submodules switch
Date:   Fri, 21 Apr 2017 10:39:53 -0700
Message-Id: <20170421173953.16433-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc0.2.g0d1ae48b0e
In-Reply-To: <CAGZ79kZ4oJcCD5QttcSzkfTVotust8vnBmSbp0sh5PrpqMQgJw@mail.gmail.com>
References: <CAGZ79kZ4oJcCD5QttcSzkfTVotust8vnBmSbp0sh5PrpqMQgJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-reset is yet another working tree manipulator, which should
be taught about submodules.

When a user uses git-reset and requests to recurse into submodules,
this will reset the submodules to the object name as recorded in the
superproject, detaching the HEADs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  This replaces the topmost patch in sb/reset-recurse-submodules.
  The only difference is the rewording of the commit message.
  
  Thanks,
  Stefan

 builtin/reset.c            | 30 ++++++++++++++++++++++++++++++
 t/t7112-reset-submodule.sh |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c47..5ce27fcaed 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -21,6 +21,27 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "submodule.h"
+#include "submodule-config.h"
+
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
+static int option_parse_recurse_submodules(const struct option *opt,
+					   const char *arg, int unset)
+{
+	if (unset) {
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+	if (arg)
+		recurse_submodules =
+			parse_update_recurse_submodules_arg(opt->long_name,
+							    arg);
+	else
+		recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -283,6 +304,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "reset", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
@@ -295,6 +319,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
+	}
+
 	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", oid.hash);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index 2eda6adeb1..f86ccdf215 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -5,6 +5,14 @@ test_description='reset can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
+KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+
+test_submodule_switch_recursing "git reset --recurse-submodules --keep"
+
+test_submodule_forced_switch_recursing "git reset --hard --recurse-submodules"
+
 test_submodule_switch "git reset --keep"
 
 test_submodule_switch "git reset --merge"
-- 
2.13.0.rc0.2.g0d1ae48b0e

