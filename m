From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule--helper, module_clone: always operate on absolute paths
Date: Thu, 31 Mar 2016 17:17:28 -0700
Message-ID: <1459469849-9643-2-git-send-email-sbeller@google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 02:17:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1almmQ-00089C-DV
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbcDAARf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:17:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34506 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457AbcDAARd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:17:33 -0400
Received: by mail-pa0-f43.google.com with SMTP id fe3so77222522pab.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OKF3Fb+kPzX3FOM2H8v8NMr3o/N4TmJg1bHITVdgSkQ=;
        b=VUyXF92TcRjZgQLSt4IGwP7N4cEuFGh1BOr4C+ORyqbaVW33+nE0Jl7MvD+ZbNktCM
         MXvszrUehDHA8dwqSFUfdIBNiakv90904YPrjQXxUincB2WNuV+z388FTafdvbO5x+Gs
         MCKVqWti5+rj9u7GzAtcVyd4OYjjHK++BybCSp5RE8OXGRo4+aAliWCiAprCVbwnibqe
         imc4DwkQT5DujMxVyTWyHwh1FFzATa7GdbYjjTh7R4wfZg6nBcwdY0AK+PQNHMEOu80k
         D4LxTiLJc2odHs5ThSKnzhHr8G0VuIlue2zgf2oSiPKgw4hECZOuRB9tYj/6oQLQa6Al
         Wevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OKF3Fb+kPzX3FOM2H8v8NMr3o/N4TmJg1bHITVdgSkQ=;
        b=YGvg0dZvOSK5yzYR2RFth20uHypclLi3dHTYKBigO6I6lxTCkCU3VN5L/SiSBo7nFv
         e9mvZpczb4letV9wdyLHiEPS2QPxgIKi2EODQxuz8hMjiwt5Yv1qg56idaD8XRqZY2an
         z4PRTdzOgQ3WDjC3AfcIpHjICell+BQv82x6Z3SyoJ1tFAjuEIHG/xpJYVW6oYpHOjz9
         /fxQWI2I436eIK5Ku2uIFzuDE9LeZAsYqzh3Ax9Cb/gbSaM3v1XRsnmKkxXthzZse/De
         Rgw3QaB5SPE3Ydry4cz+eGSUFmj0Z7vSioYV3ZNRSeezPo8qOzRe0yJM2CLSMLq+R3SU
         45gQ==
X-Gm-Message-State: AD7BkJJqgICXcqpCZFWllkej0bTi3H0wQ6vAWH50bagF9mRUXb4BTP0v8oMDMw4oq/lR3lSi
X-Received: by 10.66.167.145 with SMTP id zo17mr25887209pab.73.1459469852913;
        Thu, 31 Mar 2016 17:17:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:a519:64be:5369:a180])
        by smtp.gmail.com with ESMTPSA id 16sm15950939pfk.28.2016.03.31.17.17.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 17:17:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1459469849-9643-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290492>

When giving relative paths to `relative_path` to compute a relative path
from one directory to another, this may fail in `relative_path`.
Make sure both arguments to `relative_path` are always absolute.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 28 ++++++++++++++--------------
 t/t7400-submodule-basic.sh  |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b9f546..b099817 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -153,11 +153,12 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 
 static int module_clone(int argc, const char **argv, const char *prefix)
 {
-	const char *path = NULL, *name = NULL, *url = NULL;
+	const char *name = NULL, *url = NULL;
 	const char *reference = NULL, *depth = NULL;
 	int quiet = 0;
 	FILE *submodule_dot_git;
-	char *sm_gitdir, *cwd, *p;
+	char *sm_gitdir_rel, *p, *path = NULL;
+	const char *sm_gitdir;
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -198,7 +199,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		die(_("submodule--helper: unspecified or empty --path"));
 
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
-	sm_gitdir = strbuf_detach(&sb, NULL);
+	sm_gitdir_rel = strbuf_detach(&sb, NULL);
+	sm_gitdir = absolute_path(sm_gitdir_rel);
+
+	if (!is_absolute_path(path)) {
+		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
+		path = strbuf_detach(&sb, 0);
+	} else
+		path = xstrdup(path);
 
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
@@ -229,24 +237,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&sb);
 	strbuf_reset(&rel_path);
 
-	cwd = xgetcwd();
 	/* Redirect the worktree of the submodule in the superproject's config */
-	if (!is_absolute_path(sm_gitdir)) {
-		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
-		free(sm_gitdir);
-		sm_gitdir = strbuf_detach(&sb, NULL);
-	}
-
-	strbuf_addf(&sb, "%s/%s", cwd, path);
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
 	git_config_set_in_file(p, "core.worktree",
-			       relative_path(sb.buf, sm_gitdir, &rel_path));
+			       relative_path(path, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
-	free(sm_gitdir);
-	free(cwd);
+	free(sm_gitdir_rel);
+	free(path);
 	free(p);
 	return 0;
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fc11809..ea3fabb 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -818,7 +818,7 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 	)
 '
 
-test_expect_failure 'recursive relative submodules stay relative' '
+test_expect_success 'recursive relative submodules stay relative' '
 	test_when_finished "rm -rf super clone2 subsub sub3" &&
 	mkdir subsub &&
 	(
-- 
2.5.0.264.gc776916.dirty
