From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] clone: Allow an explicit argument for parallel submodule clones
Date: Fri, 23 Oct 2015 11:44:39 -0700
Message-ID: <1445625879-30330-4-git-send-email-sbeller@google.com>
References: <1445625879-30330-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 23 20:45:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZphKj-0005hb-NI
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 20:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbbJWSov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 14:44:51 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36224 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbbJWSoq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 14:44:46 -0400
Received: by pacfv9 with SMTP id fv9so130801042pac.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2015 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4wFbgq6uXx7qHSs3a6tL03BDX+vOeHv6YQPh/oTaXvY=;
        b=jh4OPmLIHx690tFBi8qL+QJ9d0BJ0S+xdG0zjKVvkpgzgX5Jh6WSwQC+U9WTmF0rl/
         hKxs1bGp/wGDM2BxCc8BCdIfAcOVZp64uuUS+yzJB0XU+5Tv/lkpGCob9Jx0XDjqqtvy
         q93V0nuJ6O3vsncGOSqqSKqpppcAgoZoTF1ZhfgJRjlD8ugRl7fQSOuMjPlrdBLEY34A
         DMA8RtQ9taJOJYGfd2amFbq7JlYZDOF+ZMGTW1siF1M5uc/+c7LgB6ikNIElWxtwRE7/
         Ffmv2U4PvKhEBktPAYEbs2llnJdUkdKpGCrPgQT8j41jGYa0ulAmPICWLgl20y7yTVTd
         JQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4wFbgq6uXx7qHSs3a6tL03BDX+vOeHv6YQPh/oTaXvY=;
        b=K8i+HpOAw+/Y59Jr69+ylehTEve57ISvuTvGBpjyqOeF1XybVCUx6V4+a5khCrKAdm
         64R5lyliFyzWqHm19catnyd7lL1jKPUrkbxRSk84MLLQWi6ZspltmOqXuERL8YthoGqU
         DH5FjUgPW+xLYTHVFM5zTGlV645aTGpVnm3VkbnFM5cQCFsMp/4lydCY+HO7R/hFwOnI
         fSgQS+DUtbPGJbSzpeyKOHWT05PXk5wONDnX4ieazDP5/JJW5HXKmHXLzYTBOTeHR9bv
         Vuw1RoFI6Tp0in4Ye+CdsvD2wcvaofF512hxFOzT6dadHrRh4YX1Hfus9Kubz0XT6gfG
         7A6A==
X-Gm-Message-State: ALoCoQmjbibrEB0/oukhyI6OmaimeXxB89XMqIH8fuspqQd9dpMUamEfCHO9YhuBs+3VZrGPSNnC
X-Received: by 10.68.185.67 with SMTP id fa3mr6448099pbc.113.1445625885890;
        Fri, 23 Oct 2015 11:44:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7d77:bdba:3237:8a09])
        by smtp.gmail.com with ESMTPSA id qd5sm20214942pbc.73.2015.10.23.11.44.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Oct 2015 11:44:45 -0700 (PDT)
X-Mailer: git-send-email 2.6.2.280.g74301d6
In-Reply-To: <1445625879-30330-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280103>

Just pass it along to "git submodule update", which may pick reasonable
defaults if you don't specify an explicit number.

TODO: Add a test for this.
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  5 ++++-
 builtin/clone.c             | 23 +++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..affa52e 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--] <repository>
+	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -216,6 +216,9 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+-j::
+--jobs::
+	The number of submodules fetched at the same time.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 5864ad1..59ec984 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,7 @@ static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
+static int max_children;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -72,6 +73,8 @@ static struct option builtin_clone_options[] = {
 		    N_("initialize submodules in the clone")),
 	OPT_BOOL(0, "recurse-submodules", &option_recursive,
 		    N_("initialize submodules in the clone")),
+	OPT_INTEGER('j', "jobs", &max_children,
+		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
@@ -95,10 +98,6 @@ static struct option builtin_clone_options[] = {
 	OPT_END()
 };
 
-static const char *argv_submodule[] = {
-	"submodule", "update", "--init", "--recursive", NULL
-};
-
 static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
@@ -674,8 +673,20 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive)
-		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
+	if (!err && option_recursive) {
+		struct argv_array args = ARGV_ARRAY_INIT;
+		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+
+		if (max_children) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "--jobs=%d", max_children);
+			argv_array_push(&args, sb.buf);
+			strbuf_release(&sb);
+		}
+
+		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
+		argv_array_clear(&args);
+	}
 
 	return err;
 }
-- 
2.6.2.280.g74301d6
