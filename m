From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Thu, 24 Mar 2016 16:34:27 -0700
Message-ID: <1458862468-12460-4-git-send-email-sbeller@google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 00:34:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEmD-0005nC-Br
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbcCXXes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:34:48 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33996 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbcCXXep (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:34:45 -0400
Received: by mail-pa0-f52.google.com with SMTP id fe3so33545902pab.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oOP9xHi2xu8L092u1kQI9Iy/yTi5wwxoKVDS9eZhG5I=;
        b=gSJkYKvL9Ez12S3O/ZKwn7KP44ULB9AsK6p2KRVUhvMW8GXmH0I3rTOMiM1w11dR2/
         SrsXTrRDMju4HTXSkKT/b/VDLLaQ0td9DjNNeFpVnEK6GNP099l+DWkk8GLsCFvN9wiH
         3hhKSWgiKW3/9notj2U627P3eMa5BsW69/tldVHbpwTlTM4pwoN0bXOrK5Y74Ft0LIng
         tY4sf6pZVu/C4LrrEBkv3ALsVpLDt3zZ0CB1df7u7WpeMWXbiM7rkJOFd+mYUioHCs62
         bwOEniQL6V+AAl90yxEUZPZLqBleAtf4vJI0ZRXDAB/oXO0zacnGDGn4ykqXHIqqhsap
         px6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oOP9xHi2xu8L092u1kQI9Iy/yTi5wwxoKVDS9eZhG5I=;
        b=IN/y+MflHco2uxILpZm+2llGpTaB1YhxT8ehJLNZdQTrB5vSrq73pOulSKU9hC0geD
         JTrQwQtbvP0eJ49dEfJDG1Z2W9Hq6Ncxw0bt0yf/sZd/5EBZmSLjvoQ+sQqypFPH/UAW
         sm9vPTc2CBQB95o+yJU3WGWtVEYI1y1dm54zERabiHUOezmYSaNmHRZaiEx3ZHdWDyc8
         lKAHM115Cdy/2lUEnUVQMTnnt13FsyRctOMBFoiwBdCusBNLCrL3FtG1vq8RBgOx18gP
         3yoQ2PQN5F2nLuBlM04uW3h3D9FzTjgXwAur4Atb/9CBMV2dROkPLuHMwBMGOmWC6LX/
         YXTA==
X-Gm-Message-State: AD7BkJIPQy7jI+BwhFY0wvJZjs1dff/GjcUU6rH1tp5xX7pz2hhipC6oOuwR2mMTFkwld9GG
X-Received: by 10.66.155.232 with SMTP id vz8mr16483895pab.53.1458862483720;
        Thu, 24 Mar 2016 16:34:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a88b:7b22:8e5b:edac])
        by smtp.gmail.com with ESMTPSA id vy6sm12410234pac.38.2016.03.24.16.34.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 16:34:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33
In-Reply-To: <1458862468-12460-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289826>

The usual early machinery of Git is to change the directory to
the top level of the working tree and pass the actual path inside
the working tree as `prefix` to the command being run.
This is the case both for commands written in C (where the
prefix is passed into the command in a function parameter) as
well as in git-submodule.sh where the setup code runs

  wt_prefix=$(git rev-parse show-prefix)
  cd_to_top_level

So the prefix passed into the `submodule--helper list` is actually
the relative path inside the working tree, but we were not using
the standard way of passing it through.

Adhere to Gits standard of passing the relative path inside the
working tree by passing it via -C.

We do not need to pass it for `submodule foreach` as that command
doesn't take further arguments ('$@') to operate on a subset of
submodules, such that it is irrelevant for listing the submodules.
The computation of the displaypath ('Entering <path>') is done
separately there.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c |  5 +----
 git-submodule.sh            | 12 ++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed764c9..2983783 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -68,14 +68,11 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_list_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("alternative anchor for relative paths")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		N_("git submodule--helper list [<path>...]"),
 		NULL
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 6b18a03..1f7ad6e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -407,7 +407,7 @@ cmd_foreach()
 	# command in the subshell (and a recursive call to this function)
 	exec 3<&0
 
-	git submodule--helper list --prefix "$wt_prefix"|
+	git submodule--helper list |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -467,7 +467,7 @@ cmd_init()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -549,7 +549,7 @@ cmd_deinit()
 		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
 	fi
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -683,7 +683,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	git submodule--helper list --prefix "$wt_prefix" "$@" | {
+	git -C "$wt_prefix" submodule--helper list "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
@@ -1121,7 +1121,7 @@ cmd_status()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -1199,7 +1199,7 @@ cmd_sync()
 		esac
 	done
 	cd_to_toplevel
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
+	git -C "$wt_prefix" submodule--helper list "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-- 
2.8.0.rc4.10.g52f3f33
