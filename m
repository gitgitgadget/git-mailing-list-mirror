Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E181F597
	for <e@80x24.org>; Tue, 17 Jul 2018 06:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbeGQH2t (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 03:28:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42979 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeGQH2t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 03:28:49 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so22987plb.9
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 23:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GpbpONbCm7CG3zy1xj2YEQhFD6Ng8HCIBBglvMT2/Nc=;
        b=ADXdliLd9hcGB+KF11m4I59rj8amNGpPvX99jBDjTSfktpck0SpybXOnqRNtqg+a1J
         1wNWovXZvUTrfvZiMhB6k402DqkzXaiRS1/69zPk4Iu/F/1l9jVzdeaRAqF+6axzM6Of
         fAFrPO2Zx+3VFxT2fzWULKqwYNPMARWD0BqpOEtEDeag3a0Uou7ytTFeejSZr2ICKHt2
         zxsIabgW1lhMuxZ/wCtx59re7i2sCdfFS9qh/wDud7dIaQUPwJG9owvyzjfw0CLoVCCH
         4NCKgF3lxfQ7A/aaH5O9eurD8QccozRP+Ze74bcpwncSass1eS+E1Brikj+z2xgnKUxa
         kEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GpbpONbCm7CG3zy1xj2YEQhFD6Ng8HCIBBglvMT2/Nc=;
        b=ujn6Q2urXGDyCvRNsB7816XPcm6+7Y/mWtYx/+IsTa2+pr754MGA/m80oCoW4gHkkv
         hqtnr7k4/Ws0fYvY/DAuU+/RCmrfnwgJODCZymwjGGEzRB3+8mhVD2NN9Cyjoq8B1dQJ
         rM57fG7bL24TMs4LIMn5brVpVHb00GpNpp03NeRT1JNZQ3xe/XNWozkWgr2yvgN+fZJ/
         8v+t4kuPzZ+e9AqvyKzo7Tf/94W5VWZMTh5wK2seF7poWBNfO3wjhPIyeEJnDj419O/f
         g9MUTdyOcD7g/2toZ4ngImVf0jR0eXz/vPgZHP+TXmMP91XIlLtF97Tb49fbF0n8mTya
         vxbQ==
X-Gm-Message-State: AOUpUlE/qikOm16K4BAC93YEKjH/MMQx/S/BzK/zA70p8myW3V2y3ARX
        VsHcHXReGtQNui4dXqWayJk=
X-Google-Smtp-Source: AAOMgpeJMKb1FdlGTCsudHapHKfG7kueIHkIILO5pnvfipdtCnfQ14au2CZUi32ZsphqiatGTI4Yng==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr399296pli.191.1531810662490;
        Mon, 16 Jul 2018 23:57:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n5-v6sm572742pgd.7.2018.07.16.23.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 23:57:41 -0700 (PDT)
Date:   Mon, 16 Jul 2018 23:57:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Andrii Dehtiarov <adehtiarov@google.com>
Subject: [PATCH 3/3] gc: do not return error for prior errors in daemonized
 mode
Message-ID: <20180717065740.GD177907@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717065151.GA177907@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some build machines started consistently failing to fetch updated
source using "repo sync", with error

  error: The last gc run reported the following. Please correct the root cause
  and remove /build/.repo/projects/tools/git.git/gc.log.
  Automatic cleanup will not be performed until the file is removed.

  warning: There are too many unreachable loose objects; run 'git prune' to remove them.

The cause takes some time to describe.

In v2.0.0-rc0~145^2 (gc: config option for running --auto in
background, 2014-02-08), "git gc --auto" learned to run in the
background instead of blocking the invoking command.  In this mode, it
closed stderr to avoid interleaving output with any subsequent
commands, causing warnings like the above to be swallowed; v2.6.3~24^2
(gc: save log from daemonized gc --auto and print it next time,
2015-09-19) addressed that by storing any diagnostic output in
.git/gc.log and allowing the next "git gc --auto" run to print it.

To avoid wasteful repeated fruitless gcs, when gc.log is present, the
subsequent "gc --auto" would die after printing its contents.  Most
git commands, such as "git fetch", ignore the exit status from "git gc
--auto" so all is well at this point: the user gets to see the error
message, and the fetch succeeds, without a wasteful additional attempt
at an automatic gc.

External tools like repo[1], though, do care about the exit status
from "git gc --auto".  In non-daemonized mode, the exit status is
straightforward: if there is an error, it is nonzero, but after a
warning like the above, the status is zero.  The daemonized mode, as a
side effect of the other properties provided, offers a very strange
exit code convention:

 - if no housekeeping was required, the exit status is 0

 - the first real run, after forking into the background, returns exit
   status 0 unconditionally.  The parent process has no way to know
   whether gc will succeed.

 - if there is any diagnostic output in gc.log, subsequent runs return
   a nonzero exit status to indicate that gc was not triggered.

There's nothing for the calling program to act on on the basis of that
error.  Use status 0 consistently instead, to indicate that we decided
not to run a gc (just like if no housekeeping was required).  This
way, repo and similar tools can get the benefit of the same behavior
as tools like "git fetch" that ignore the exit status from gc --auto.

Once the period of time described by gc.pruneExpire elapses, the
unreachable loose objects will be removed by "git gc --auto"
automatically.

[1] https://gerrit-review.googlesource.com/c/git-repo/+/10598/

Reported-by: Andrii Dehtiarov <adehtiarov@google.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes from v1:
- minor commit message tweaks
- using warning() instead of error()
- avoiding leaking gc_log_path in report_last_gc_error
- only changing the exit status when reporting a prior error, not a
  new one

Thoughts of all kinds welcome, as always.

Sincerely,
Jonathan

 Documentation/config.txt |  3 ++-
 builtin/gc.c             | 33 +++++++++++++++++++++++++++------
 t/t6500-gc.sh            |  6 +++---
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828c..5eaa4aaa7d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1649,7 +1649,8 @@ will be repacked. After this the number of packs should go below
 gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 
 gc.logExpiry::
-	If the file gc.log exists, then `git gc --auto` won't run
+	If the file gc.log exists, then `git gc --auto` will print
+	its content and exit with status zero instead of running
 	unless that file is more than 'gc.logExpiry' old.  Default is
 	"1.day".  See `gc.pruneExpire` for more ways to specify its
 	value.
diff --git a/builtin/gc.c b/builtin/gc.c
index 95c8afd07b..ce8a663a01 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -438,9 +438,15 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	return NULL;
 }
 
-static void report_last_gc_error(void)
+/*
+ * Returns 0 if there was no previous error and gc can proceed, 1 if
+ * gc should not proceed due to an error in the last run. Prints a
+ * message and returns -1 if an error occured while reading gc.log
+ */
+static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
 	ssize_t len;
 	struct stat st;
 	char *gc_log_path = git_pathdup("gc.log");
@@ -449,7 +455,8 @@ static void report_last_gc_error(void)
 		if (errno == ENOENT)
 			goto done;
 
-		die_errno(_("cannot stat '%s'"), gc_log_path);
+		ret = error_errno(_("cannot stat '%s'"), gc_log_path);
+		goto done;
 	}
 
 	if (st.st_mtime < gc_log_expire_time)
@@ -457,18 +464,26 @@ static void report_last_gc_error(void)
 
 	len = strbuf_read_file(&sb, gc_log_path, 0);
 	if (len < 0)
-		die_errno(_("cannot read '%s'"), gc_log_path);
-	else if (len > 0)
-		die(_("The last gc run reported the following. "
+		ret = error_errno(_("cannot read '%s'"), gc_log_path);
+	else if (len > 0) {
+		/*
+		 * A previous gc failed.  Report the error, and don't
+		 * bother with an automatic gc run since it is likely
+		 * to fail in the same way.
+		 */
+		warning(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
 			       "Automatic cleanup will not be performed "
 			       "until the file is removed.\n\n"
 			       "%s"),
 			    gc_log_path, sb.buf);
+		ret = 1;
+	}
 	strbuf_release(&sb);
 done:
 	free(gc_log_path);
+	return ret;
 }
 
 static void gc_before_repack(void)
@@ -561,7 +576,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
-			report_last_gc_error(); /* dies on error */
+			int ret = report_last_gc_error();
+			if (ret < 0)
+				/* an I/O error occured, already reported */
+				exit(128);
+			if (ret == 1)
+				/* Last gc --auto failed. Skip this one. */
+				return 0;
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c474a94a9f..a222efdbe1 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -116,11 +116,11 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_config gc.autopacklimit 1 &&
 	test_config gc.autodetach true &&
 	echo fleem >.git/gc.log &&
-	test_must_fail git gc --auto 2>err &&
-	test_i18ngrep "^fatal:" err &&
+	git gc --auto 2>err &&
+	test_i18ngrep "^warning:" err &&
 	test_config gc.logexpiry 5.days &&
 	test-tool chmtime =-345600 .git/gc.log &&
-	test_must_fail git gc --auto &&
+	git gc --auto &&
 	test_config gc.logexpiry 2.days &&
 	run_and_wait_for_auto_gc &&
 	ls .git/objects/pack/pack-*.pack >packs &&
-- 
2.18.0.233.g985f88cf7e

