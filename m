From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 00/11] Expose
Date: Thu, 25 Feb 2016 15:08:17 -0800
Message-ID: <1456441708-13512-1-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ51s-000832-4c
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbcBYXI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:08:59 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35604 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbcBYXI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:08:57 -0500
Received: by mail-pa0-f51.google.com with SMTP id ho8so40882070pac.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xOgjDVcG20LHqT/uyw2fQt4RnLiSM073zq6s5b/Wg2Y=;
        b=UZyj6AbVYfWkbdH+kZqw9un/wlTDGwfZ0Sk1cRz+AhIuIyIl1Waf9ROBmRJO5B8FK4
         2E4qPgxPWDCET4HVo/Kb+vAqXeSeCfELyb5HhEy+heWjraxO06kkUO8qD4JY0ZyUF5+z
         ylyqR1EryR0H4jrslaZZuBsos0Xsu2FM8Q4IhNzHCxfTpxVlVWxPF8FjaVIbAd3QbkPl
         JxscDF/+ekbP4k3S6tprudbYL4Um5n54HaOYmKAqDgcCy1YTUmhM22lpVsOnbLMpoyGn
         wn1jYvi6Zp07RA6dNF+v+4vj+gmhCUw6i4o99B2Al6qxFWC4s66kMovpeXm0eS0hadpm
         04mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xOgjDVcG20LHqT/uyw2fQt4RnLiSM073zq6s5b/Wg2Y=;
        b=W9IdI05FnC086lFmzuVlBRiz2wNqT+mMZndGGzvlZLxWGbtQ1BWUuHBcmFtMXyaERm
         NYioAGHr5QAfZWC9QtQW9K7PDpMMgENhIQFwqtmMiWka17p1qSj+m7pWDxi70AnmCmVQ
         t5z7SBAV7XMbhfs+9ZIIHAee/jK8ctmoDLeY/TU/E3lsK3MqgJD3MeaaYv+75KNY6Vht
         O0dCTWNVxblEFLGX58Ebr2aL5eaWLYw8N1D0A6aUq2wS3xaZcfXUNXpZ69Bvg9/EfdSv
         q9OftOkzS2VOVn1mVo8wU1cwjsgX3SNEUV+TGNxtNNlrxQtcHwUYmZMJW9lrHXnpSKe1
         /xSg==
X-Gm-Message-State: AG10YOTFPuDUCof9KKdy3MXznEUhSbfWyDbD0Ix8f8dRIvUmVV+T2d76o6PEPjEWS0ydXtw8
X-Received: by 10.66.244.233 with SMTP id xj9mr46645362pac.19.1456441736994;
        Thu, 25 Feb 2016 15:08:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id l14sm14523151pfi.23.2016.02.25.15.08.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:08:56 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287474>

* fixes the test breakage (which was caused by a last minute fix :/ to the
  prefix variable handling)
* include the separately sent patch to not call fwrite in case of length 0

Thanks,
Stefan

Interdiff to v17:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d94406..882aeca 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -465,14 +465,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 
-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
+	argc = parse_options(argc, argv, suc.prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
 
 	if (update)
 		if (parse_submodule_update_strategy(update, &suc.update) < 0)
 			die(_("bad value for update parameter"));
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+	if (module_list_compute(argc, argv, suc.prefix, &pathspec, &suc.list) < 0)
 		return 1;
 
 	if (pathspec.nr)
diff --git a/strbuf.c b/strbuf.c
index 71345cd..5f6da82 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -397,7 +397,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 
 ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 {
-	return fwrite(sb->buf, 1, sb->len, f);
+	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
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
 builtin/submodule--helper.c     | 254 ++++++++++++++++++++++++++++++++++++++++
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
 18 files changed, 477 insertions(+), 71 deletions(-)

-- 
2.7.0.rc0.36.g75877e4.dirty
