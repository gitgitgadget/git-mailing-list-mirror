From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Wed, 28 Oct 2015 16:21:36 -0700
Message-ID: <1446074504-6014-1-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra2h-0002sU-52
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbbJ1XWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:01 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34893 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbJ1XV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:21:59 -0400
Received: by pasz6 with SMTP id z6so20294344pas.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XV2Bfg7VVU2gimmd0f2kMrKVAVVV14bZWYTqoMf1728=;
        b=WeYmPSrAhQ+1CgZJImjEVvas+EfsfIiq/ESTlKF1cfUAVaW3O3UxDHyHKuU3gatyTk
         4dCM7wurV1k6SImfkFmFp23ORwQknqTVBSao+WqgPVT4zNugdhKe03vf6M3t1fwabgUe
         /Km5m8dM5c823sqeUF5twS1iH+ij47Clx/2+H4rc+T/kPTcXUWPPyH7ttI687a0qxhqu
         v3SLIAo/QUTLMq+kLBsGWnU2K7rGUtf293yD158GBzZDXyS5v6mwy6ax98Q/mdxxp6yI
         HL0XjRGbRxa0DBNnkh2UA/6voPaMz9pfCj75GpVkE81l30GBnDnb6inDtM6CD4LYQ1RU
         A+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XV2Bfg7VVU2gimmd0f2kMrKVAVVV14bZWYTqoMf1728=;
        b=AIamRI7vt8gH1IhpOshks9Tmc7TmR9+pPyyKGlcBCu/BGaFFqBTuFQnQDCii+3AyBp
         3uKcyH/39KP3LcZOwg7WfNaxNlC7CVuB+47SK/DbtDHvXzY7iEXovvPVTP8iqkVVzfPD
         t+1EwPReFYbEgRF1LVmuWYxN1CyvzOsC0atKv8FMTLG9jNYdqpqry4y2WPVG2R0eRaL7
         7pxetJPAZSBZjO/Lyo5h9CAA1BtL2VfbY/ceBBCE+9TcE78q8UcLym/qvssgSz04E2XM
         kxHs/d/EcIKlLRia5OS7Hhmm+R4ZEeCyL2QUjoNEBxWVSqtHKBcBfcVe722yPF6G2PMg
         i5GA==
X-Gm-Message-State: ALoCoQnS965xi/bXZe4b9v7o4m0WVLI89XY/xv8Iioaaoe9dbNLJC4UL6vK5DK6XdOgoMvpaJYic
X-Received: by 10.66.185.129 with SMTP id fc1mr36978560pac.137.1446074519296;
        Wed, 28 Oct 2015 16:21:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id w9sm47422110pbt.29.2015.10.28.16.21.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:21:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280423>

This replaces origin/sb/submodule-parallel-update
(anchoring at 74367d8938, Merge branch 'sb/submodule-parallel-fetch'
into sb/submodule-parallel-update)

What does it do?
---
This series should finish the on going efforts of parallelizing
submodule network traffic. The patches contain tests for clone,
fetch and submodule update to use the actual parallelism both via
command line as well as a configured option. I decided to go with
"submodule.jobs" for all three for now.

What is new in v2?
---
* The patches got reordered slightly
* Documentation was adapted

Interdiff below

Stefan Beller (8):
  run_processes_parallel: Add output to tracing messages
  submodule config: keep update strategy around
  submodule config: remove name_and_item_from_var
  submodule-config: parse_config
  fetching submodules: Respect `submodule.jobs` config option
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   7 ++
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  23 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 244 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 run-command.c                   |   4 +
 submodule-config.c              |  98 ++++++++++------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 418 insertions(+), 80 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0de0138..785721a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2643,12 +2643,12 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
-submodule::jobs
+submodule.jobs::
 	This is used to determine how many submodules can be operated on in
 	parallel. Specifying a positive integer allows up to that number
-	of submodules being fetched in parallel. Specifying 0 the number
-	of cpus will be taken as the maximum number. Currently this is
-	used in fetch and clone operations only.
+	of submodules being fetched in parallel. This is used in fetch
+	and clone operations only. A value of 0 will give some reasonable
+	default. The defaults may change with different versions of Git.
 
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index affa52e..01bd6b7 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -216,9 +216,10 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
--j::
---jobs::
+-j <n>::
+--jobs <n>::
 	The number of submodules fetched at the same time.
+	Defaults to the `submodule.jobs` option.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f5429fa..c70fafd 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -374,10 +374,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
--j::
---jobs::
+-j <n>::
+--jobs <n>::
 	This option is only valid for the update command.
 	Clone new submodules in parallel with as many jobs.
+	Defaults to the `submodule.jobs` option.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/builtin/clone.c b/builtin/clone.c
index 5ac2d89..22b9924 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -727,10 +727,7 @@ static int checkout(void)
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
-		if (max_jobs == -1)
-			if (git_config_get_int("submodule.jobs", &max_jobs))
-				max_jobs = 1;
-		if (max_jobs != 1) {
+		if (max_jobs != -1) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addf(&sb, "--jobs=%d", max_jobs);
 			argv_array_push(&args, sb.buf);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c3d438a..67dba1c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -476,9 +476,10 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	/* Overlay the parsed .gitmodules file with .git/config */
 	git_config(git_submodule_config, NULL);
 
-	if (max_jobs == -1)
-		if (git_config_get_int("submodule.jobs", &max_jobs))
-			max_jobs = 1;
+	if (max_jobs < 0)
+		max_jobs = config_parallel_submodules();
+	if (max_jobs < 0)
+		max_jobs = 1;
 
 	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,

-- 
2.5.0.281.g4ed9cdb
