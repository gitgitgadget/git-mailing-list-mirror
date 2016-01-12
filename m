From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 18/21] refs: allow ref backend to be set for clone
Date: Mon, 11 Jan 2016 20:22:17 -0500
Message-ID: <1452561740-8668-19-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfp-0003OU-2x
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761913AbcALBWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:55 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34468 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761905AbcALBWx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:53 -0500
Received: by mail-qg0-f43.google.com with SMTP id 6so339428827qgy.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3VEk8EXnY0+o2Nc1ujKChnIN8+AAmgypDLwRTsUew8=;
        b=wuNoDPlyusgYBOVZqWx2QYTj9YfhSCqcXSvq+/swgnEe2X2+HE7LNnOR8qzgTeT5u/
         sOABcMqAOJH3yA13m1QO4tVJah5fkZrKIxl9Dt7jpdpSTilB8bJIJT4ApKd3ZVdCEDND
         +uhstEif14TTBEAT7B8U/K3GdawPM/Ijr+BPyYJ8yP9ppZau6HSiGcBMPE9Isi6zKMz7
         BaxDcun5vGcrEUWKD2FQ3kjRh55h0zHrNIA0viBdqsOxlTaNnOybM1m9IBWkiGr4hTLV
         c1X5+wS38m9Cxb+F5yc2jYZLycTe02pLB9jpOU1sb54JgnUJQBA2Xb9xI9ig2Gjjuaa8
         1FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3VEk8EXnY0+o2Nc1ujKChnIN8+AAmgypDLwRTsUew8=;
        b=CTj+U681096BwTgzBLpJ0QW9cqF3yHurJtU1Y2wosKRnBkCndv99Bj8Zx83XBE66GU
         zdM0TQJwGIh200BQ2wZEk4oqH1AqhVeWIKxLRDjFZfMpWRDXq8X3d4neIcvWTC0jNYgn
         goMX6KMVh1Bx+wHGSRvUOatcWFzVoFrQeVeKL6lWg6YKrpS2m1wFNBkHC8SJvywyASOE
         NV6puGZkMKXkXotds2FqyNRDxeSk492Qp10HnWbvPrRxoWNh6EPr4y8q7jUNZfuYGkUz
         oB5488l7x3bliO33fs210JNpA5f/0Xx5u8pgy2MVHuDyAIYiB45AB3pcK1Re25X28SNh
         hz2w==
X-Gm-Message-State: ALoCoQkEk/81jPDML7dX/s/Nmy133ccW4q8Qdqal3dJlPTTa5vQR8jxd0TqnsIlq+LVmvF3nYufuXfpgfFWUjNoLILV8jCvKUw==
X-Received: by 10.140.98.239 with SMTP id o102mr171921846qge.31.1452561772586;
        Mon, 11 Jan 2016 17:22:52 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:51 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283748>

Add a new option, --ref-storage, to allow the ref backend type to
be set on new clones.

Submodules must use the same ref backend as the parent repository, so
we also pass the --ref-storage option option when cloning
submodules.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-clone.txt |  4 ++++
 builtin/clone.c             |  5 +++++
 builtin/submodule--helper.c |  2 +-
 git-submodule.sh            | 13 +++++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6bf000d..dde2a77 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
+	  [--ref-storage=<name>]
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
 
@@ -221,6 +222,9 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+--ref-storage=<name>::
+	Type of ref storage backend. Default is to use the original files
+	based ref storage.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 53c2834..377e59a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -92,6 +92,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING(0, "ref-storage", &ref_storage_backend,
+		   N_("name"), N_("name of backend type to use")),
 	OPT_END()
 };
 
@@ -726,6 +728,9 @@ static int checkout(void)
 		cmd.git_cmd = 1;
 		argv_array_pushl(&cmd.args, "submodule", "update",
 				 "--init", "--recursive", NULL);
+		argv_array_pushl(&cmd.args, "--ref-storage",
+				 ref_storage_backend, NULL);
+
 		err = run_command(&cmd);
 	}
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..a411332 100644
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
index 9bc5c5f..d8a9192 100755
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
@@ -662,6 +670,11 @@ cmd_update()
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
+	else
+		if test -n "$ref_storage"
+		then
+			usage
+		fi
 	fi
 
 	cloned_modules=
-- 
2.4.2.749.g730654d-twtrsrc
