From: David Turner <dturner@twopensource.com>
Subject: [PATCH 14/16] refs: allow ref backend to be set for clone
Date: Wed,  2 Dec 2015 19:35:19 -0500
Message-ID: <1449102921-7707-15-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Ht5-0007bA-1v
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbbLCAgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:24 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:35314 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757683AbbLCAf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:57 -0500
Received: by ioc74 with SMTP id 74so64532255ioc.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a0VRj0ouX6bE0UZB940U5bt83mEQp3u5bxV3zKavpQc=;
        b=bgLMEHwtMighwBn36YzsgNFDG07Jzj1jdvLP8ZPvA+9SmVjzFbRTJoElx01HyfhV+V
         w+dcYFJRHf4v+IYiA+e+KPRWGAr9gJi/ThmnE/CsE/p3BmXmuJifEb1IBlxxEfgEgQhS
         quEjDT9JCCFLLCT45+cuyEaGLUjw1MPCtEV4ea+TaWvM0fpg9srfHPIIlYq7bRcr9bIG
         F6SG/UNNeYF+mhlG7pAnSlRi7qzdTeesYBJ8YJ2ACIj7hwEj20cgqsNMBnR7ejfEUmsx
         eckv5qJQJiVyGIR3Rg3LNgn4L/9lZaKE2G1w1iJSJpznR4Yjxm8hMUn0DUogmGgwXwgA
         mRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a0VRj0ouX6bE0UZB940U5bt83mEQp3u5bxV3zKavpQc=;
        b=aYc8qRaWaC4Sqy+Uf30ge+lfjb3YoFB+eeUtqOwlF5hzjtkWULUEemM8+khHjGyJ3i
         Lem5p5IRnzoVOQJfLu9uH9Q4as9LRcUU1IjKSMwksmbXYE42yxCdjSaNV/Va4AJOkrzw
         4KB8yT26M6N4N4N+9SnF0Qb0rN33qcmUVSbVL8S8Cel4o+JtjoN6aWra9iJIY5dZzLCh
         qvI1k84HmVGEuIFDPWkDC7lEmPZoF/xa1K4jkT15NGCR63/41JDNOKVatMmvKmqvA98+
         /kpx/dBFg2obkGV/XUMxSnz1Vd+V4xmqEs1nIS0x689b2KysNjwPFC9K5upYK9ufbQ/u
         n+jQ==
X-Gm-Message-State: ALoCoQkiaYX1L143HxBCdMl2QkVstQZN0TjhLKBghIiHC6V8B1zDbRKUzu8q7tTjtaANVn7+t9/d
X-Received: by 10.107.152.3 with SMTP id a3mr6451743ioe.177.1449102957286;
        Wed, 02 Dec 2015 16:35:57 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:56 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281935>

Add a new option, --refs-backend-type, to allow the ref backend type to
be set on new clones.

Submodules must use the same ref backend as the parent repository, so
we also pass the --refs-backend-type option option when cloning
submodules.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-clone.txt |  4 ++++
 builtin/clone.c             | 27 +++++++++++++++++++++++++--
 builtin/submodule--helper.c |  5 ++++-
 cache.h                     |  1 +
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6bf000d..431575b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
+	  [--refs-backend-type=<name>]
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
 
@@ -221,6 +222,9 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+--refs-backend-type=<name>::
+	Type of refs backend. Default is to use the original files based
+	backend.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index caae43e..a53f341 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -92,11 +92,13 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING(0, "refs-backend-type", &refs_backend_type,
+		   N_("name"), N_("name of backend type to use")),
 	OPT_END()
 };
 
 static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
+	"submodule", "update", "--init", "--recursive", NULL, NULL
 };
 
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
@@ -724,8 +726,24 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
+	if (!err && option_recursive) {
+		const char **backend_arg = argv_submodule;
+		char *new_backend_arg = NULL;
+		if (refs_backend_type) {
+			while (*backend_arg)
+				++backend_arg;
+
+			new_backend_arg = xmalloc(21 + strlen(refs_backend_type));
+			sprintf(new_backend_arg, "--refs-backend-type=%s",
+				refs_backend_type);
+			*backend_arg = new_backend_arg;
+		}
 		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+		if (refs_backend_type) {
+			free(new_backend_arg);
+			*backend_arg = NULL;
+		}
+	}
 
 	return err;
 }
@@ -744,6 +762,11 @@ static void write_config(struct string_list *config)
 					       write_one_config, NULL) < 0)
 			die("unable to write parameters to config file");
 	}
+
+	if (refs_backend_type &&
+	    write_one_config("core.refsBackendType",
+			     refs_backend_type, NULL) < 0)
+		die("unable to write backend parameter to config file");
 }
 
 static void write_refspec_config(const char *src_ref_prefix,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..5c9ca4e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -140,7 +140,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_pushl(&cp.args, "--reference", reference, NULL);
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
-
+	if (refs_backend_type && *refs_backend_type) {
+		argv_array_push(&cp.args, "--refs-backend-type");
+		argv_array_push(&cp.args, refs_backend_type);
+	}
 	argv_array_push(&cp.args, url);
 	argv_array_push(&cp.args, path);
 
diff --git a/cache.h b/cache.h
index d1534db..8f2ca55 100644
--- a/cache.h
+++ b/cache.h
@@ -695,6 +695,7 @@ enum object_creation_mode {
 extern enum object_creation_mode object_creation_mode;
 
 extern char *notes_ref_name;
+extern const char *refs_backend_type;
 
 extern const char *refs_backend_type;
 
-- 
2.4.2.749.g0ed01d8-twtrsrc
