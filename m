From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Thu, 25 Feb 2016 15:48:28 -0800
Message-ID: <1456444119-6934-1-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:48:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5eO-00083m-MY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbcBYXss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:48:48 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34488 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcBYXsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:47 -0500
Received: by mail-pa0-f46.google.com with SMTP id fy10so40217443pac.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1dRqp/pE7NzQtcIIpa4ZS+nLYzoKmvTGoH9EceCfA5U=;
        b=D3t9cjMOo0JfW4ZmoqpEsuLVjJFhkN5MKHxuPR64tMaLgH/TE5tzBhD3Zqo5fScDU+
         oPY+5keg5YcpNze1mt5b3tb5MV0LMILYYzbFK1hpWdM2nK8DkP13qQnNGFhEGm9YT5se
         Q/we6z8nINeRD+CeLsJWyL+ijBS+pS5NC/JJGPh1ghHEflPcs7iS1Gz7n7Hk1QIaP5iB
         c49jbLjaAa6KECL3EMGZHi1uU24BUZRnvKMK57OCFDH6M3OmKsH93LQ5e8VSit+PSRCi
         WwqPbsgbHKfZFzahnT+weNBK9nxdgvOAc8+93wFUjYCieXm/zQejOq0zDK9NJVb+SVLm
         gLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1dRqp/pE7NzQtcIIpa4ZS+nLYzoKmvTGoH9EceCfA5U=;
        b=OTQVKli2I9is+5XCUSSWqsz0SwLmBALAe+p4nZ8unvCAgU4YAcyI7Ax9NLSoWJQg3m
         dRyCJRLZ/TbEsIKhqapYja7H5TltOmF7rP8LuAoYTvVSUv4uzMFcPK5v+Q/tBdxzVAvj
         P/U8MQ+UuRysQUiYlOPQoqXyk4ZMIKF1BuXSYcWVZJkcGe7YPa42s9lJvDlwe6581bnQ
         5I3NXadIUm0XW1wcENVItO0amVctmPLxZD2muSP+HZKcGR203eudnsCkGM7q52bPnMNB
         xdKANUV86mXLCVGq5zo6U+qEA1vqKIKvUaf23ac+c3zLQIhuARnG2gCgXlHdLpuIwH1Q
         lltQ==
X-Gm-Message-State: AG10YORgdGvMNFrIm0xiJkWdxVg8B2Aew3ujJ+he2F+4yLLMqJEcY8GtmvVE1/6hBw+r9vzR
X-Received: by 10.66.63.104 with SMTP id f8mr67031282pas.109.1456444127061;
        Thu, 25 Feb 2016 15:48:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id e20sm14614948pfd.4.2016.02.25.15.48.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:45 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287500>

Thanks Jonathan (and all the other cc'd reviewers) for bearing
yet another revision!

I changed the prefix handling back again as it is more consistent.

Once this series is landed, I plan to refactor the prefix handling for 
all the submodule--helper commands.

Thanks,
Stefan

Interdiff to v18:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 882aeca..0272c98 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -439,7 +439,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
 	struct option module_update_clone_options[] = {
-		OPT_STRING(0, "prefix", &suc.prefix,
+		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
 		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
@@ -464,15 +464,16 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		N_("git submodule--helper update_clone [--prefix=<path>] [<path>...]"),
 		NULL
 	};
+	suc.prefix = prefix;
 
-	argc = parse_options(argc, argv, suc.prefix, module_update_clone_options,
+	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
 
 	if (update)
 		if (parse_submodule_update_strategy(update, &suc.update) < 0)
 			die(_("bad value for update parameter"));
 
-	if (module_list_compute(argc, argv, suc.prefix, &pathspec, &suc.list) < 0)
+	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
 		return 1;
 
 	if (pathspec.nr)


Stefan Beller (11):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  submodule update: direct error message to stderr
  run_processes_parallel: treat output of children as byte array
  run-command: expose default_{start_failure, task_finished}
  run_processes_parallel: rename parameters for the callbacks
  run_processes_parallel: correctly terminate callbacks with an LF
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 ++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 255 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  56 ++++-----
 run-command.c                   |  36 +++---
 run-command.h                   |  29 ++++-
 strbuf.c                        |   6 +
 strbuf.h                        |   6 +
 submodule-config.c              |  19 ++-
 submodule-config.h              |   2 +
 submodule.c                     |  37 +++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 18 files changed, 478 insertions(+), 71 deletions(-)

-- 
2.7.0.rc0.36.g75877e4.dirty
