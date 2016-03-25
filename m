From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 11:39:16 -0700
Message-ID: <1458931156-29125-6-git-send-email-sbeller@google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	sunshine@sunshineco.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 19:39:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWe2-0005Mt-AN
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbcCYSj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:39:29 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34338 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbcCYSj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:39:28 -0400
Received: by mail-pf0-f169.google.com with SMTP id x3so87784231pfb.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8JJB8aElZZcgDlHvvb2fSDKTjSh5m2BR1JbCr/rOfc=;
        b=Hyjiw8kcQu5wLEGd5U0yrbLOqWa27kLVgqR3FawSMCiZtbwzYnhsIEOjUW+hK5FYpk
         Lu8wg50SBXb8seceLKw6oakgPTxaSEE6zs6K2GCDliB+zw7rn8S3fze2068uewgjHjR2
         JfVcASlP9DWq1ucbi1dDxywTHErU1pnlEDMvuiNv+O6e2lUIvFiMitCkgn/8NEKrepDK
         pRSTuJNHGgz1OBqb4l8WJsfwoqqL7b+/hR7tQ3KTUW6r1Aup2m05Dv8IK5zK0uXqcxIH
         ALEH7m155VY13s0thRXCv04+/TMpnTADt9AICtynj0jeu0UnSTt8xsYuIGPI0znYICFv
         EsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8JJB8aElZZcgDlHvvb2fSDKTjSh5m2BR1JbCr/rOfc=;
        b=BJOCTqZ7H66ZiA+/RScvUBVwXxfUckPzfAG+ffkG47al9Dc/xM7EGbiY0A0sioGUD3
         YZ0nsI7AMQ3b0WLgz4QVAr8T3ERQ7aVOd6G6A3BjS7ai1TJP58g6roZBJQSVxHzJMR8A
         +yDRAjfT66udXb5b6ZacALjEWMm3dw7P+IxVJn8L5FMP0akxeLJp25aQiNQdnDhx6Xn5
         gA8hTHfba3tcgtTzlhGKWxgLvQ2hJhxW5qZsYnJGUpnhTVM/lUT47zNE0MFwCiMi5vfr
         Fn4PWLM4N7eaz7AZLpXVqFUc/zhEMwealrXitAZbagOZdFNOAVs3uINpGXisDfhOgnHA
         9LJg==
X-Gm-Message-State: AD7BkJI6zTDgiDcpg5E3Shtw2UvK6B2MCZJNOcwjhqHMisj0Q/RJdE+kz1eTm5b5ns0L6Xvw
X-Received: by 10.98.13.88 with SMTP id v85mr22938142pfi.150.1458931165703;
        Fri, 25 Mar 2016 11:39:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e4a5:c9cf:82bb:5195])
        by smtp.gmail.com with ESMTPSA id 82sm17942612pfi.78.2016.03.25.11.39.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 11:39:25 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33.dirty
In-Reply-To: <1458931156-29125-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289942>

In the rewrite from shell to C (ee8838d157761, 2015-09-08, submodule:
rewrite `module_clone` shell function in C), we never made use of the
prefix. Probably it sneaked in as module_list which was converted in the
same series had the prefix as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 5 +----
 git-submodule.sh            | 4 ++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6c3ff91..73b5874 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -153,9 +153,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct strbuf sb = STRBUF_INIT;
 
 	struct option module_clone_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("alternative anchor for relative paths")),
 		OPT_STRING(0, "path", &path,
 			   N_("path"),
 			   N_("where the new submodule will be cloned to")),
@@ -176,7 +173,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
+		N_("git submodule--helper clone [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--url <url>]"
 		   "[--depth <depth>] [--] [<path>...]"),
 		NULL
diff --git a/git-submodule.sh b/git-submodule.sh
index 2dd1b18..93beada 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -347,7 +347,7 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -727,7 +727,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
+			git submodule--helper clone ${GIT_QUIET:+--quiet} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
2.8.0.rc4.10.g52f3f33.dirty
