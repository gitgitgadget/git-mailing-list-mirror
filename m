From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 17/20] refs: allow ref backend to be set for clone
Date: Thu, 14 Jan 2016 11:26:14 -0500
Message-ID: <1452788777-24954-18-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjs-0002SK-22
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbcANQ0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:53 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34363 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbcANQ0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:51 -0500
Received: by mail-qg0-f42.google.com with SMTP id 6so407858201qgy.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q23pL0caggqeIi0QRSV+4mpZvCL+cBh7ovhuTj8mu/s=;
        b=E7fzXiwWu0XyU6qGU750JU9trmd8mz8n+KhHzgoDlZTroF3TOQeMJAkKUkPIaGDrGt
         ZtND2itxyLZ7Qtwyu34dFGxiS7W5wmzYT9YS+xPl4H71J3wundVnSola0bobnO6QNaJ8
         EfgI2OeUIwBhaTpL9svDtu2ND8RkTVzFFQl5Vlu5FivQs31pE4cgXg82vJ4kOz5Ptwlj
         QJfN4CGYbcgPNuEthnB61o1gZDppPlT/ajtFMEQQuSplqY/2Vlj6xKW3j9LkPR2fFGAG
         +cunmbrKl0JsOeZ4FCMKW4js0zJLBhpLMAVrhqu1LcskHcnJs5nlWzdUBj6+XZivPQUO
         se5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q23pL0caggqeIi0QRSV+4mpZvCL+cBh7ovhuTj8mu/s=;
        b=SveSuV1Uymy0/Rc6MKO2G/0MUKNvnv9HqEXMycvrlX712JyXwbQQD9cB+FgO7eQ0CP
         vglFDNTDuFSFMJIp5uCDECHLo5daH9yjEwMZJSRT5G8ZhQVX9d0+n9/wGT/cvu0jITNQ
         WavbWKfg8jx0WgxDslGZVCHMElW+6mLhHDsN8Wyk+PoJ+tndiwXqi+xGU8JGFQkn2gPL
         gxBsd2aui8mselg21LMBpVNW4s7Llx4X0PauPznUyRjGdL5wRWQjo+PRi6pAWEVFbCwx
         JHYI5beshePiCuLMLORsnsT+PACj61qHi+95FXVKIOBpKb7YQxijMf5nBh7q7Q19iOCH
         VLBQ==
X-Gm-Message-State: ALoCoQn3R0KJCrCHFGh+54K/Id2TPuTzgF3Sv4RznbXq+PYLnHR+5sFxGPA+unkbQJ5QVigQT3yJLCdQY2eJrwMQaDggxR150w==
X-Received: by 10.140.100.141 with SMTP id s13mr6322020qge.25.1452788810838;
        Thu, 14 Jan 2016 08:26:50 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:49 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284042>

Add a new option, --ref-storage, to allow the ref backend type to
be set on new clones.

Submodules must use the same ref backend as the parent repository, so
we also pass the --ref-storage option option when cloning
submodules.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             |  5 +++++
 builtin/submodule--helper.c |  2 +-
 git-submodule.sh            | 13 +++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index cb7966a..ffaf5b0 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
+	  [--ref-storage=<name>]
 	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
 	  [<directory>]
 
@@ -225,6 +226,10 @@ objects from the source repository into a pack in the cloned repository.
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
+--ref-storage=<name>::
+	Type of ref storage backend. Default is to use the original files
+	based ref storage.
+
 <repository>::
 	The (possibly remote) repository to clone from.  See the
 	<<URLS,URLS>> section below for more information on specifying
diff --git a/builtin/clone.c b/builtin/clone.c
index dd26f57..a4c6396 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -95,6 +95,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING(0, "ref-storage", &ref_storage_backend,
+		   N_("name"), N_("name of backend type to use")),
 	OPT_END()
 };
 
@@ -733,6 +735,9 @@ static int checkout(void)
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
+		argv_array_pushl(&args, "--ref-storage",
+				 ref_storage_backend, NULL);
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8002187..849da47 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -140,7 +140,7 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_pushl(&cp.args, "--reference", reference, NULL);
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
-
+	argv_array_pushl(&cp.args, "--ref-storage", ref_storage_backend, NULL);
 	argv_array_push(&cp.args, url);
 	argv_array_push(&cp.args, path);
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 10c5af9..022902b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -637,6 +637,14 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--ref-storage=*)
+			ref_storage="$1"
+			;;
+		--ref-storage)
+			case "$2" in '') usage ;; esac
+			ref_storage="$2"
+			shift
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -670,6 +678,11 @@ cmd_update()
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
+	else
+		if test -n "$ref_storage"
+		then
+			usage
+		fi
 	fi
 
 	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
-- 
2.4.2.749.g730654d-twtrsrc
