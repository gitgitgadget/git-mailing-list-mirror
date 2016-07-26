Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D01203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbcGZTkz (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:40:55 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37925 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbcGZTky (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:40:54 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so31474219wme.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 12:40:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=ohSJY64l2zok+eKa++67OKkpgu1cS2NrBbC6BaEfB+E=;
        b=fjr20wm/F5cIVD+MAVwckjLEQbVGV/OHpLH4luo23KcBtqvBPkEnQ8I9rnWUpgP7iL
         6zhzH/DdhwxsXOodn7HptcEIcRKCLV2usjKWLJGTjfAplvtIQNGNdfLf9CtaWXclTOKm
         R3dzzpnfSqGvrwZINzkhcika3khWkmwPAkyWHyvRSXgXGVMj5LqGVtw/rm6sB6Z0RQqf
         KbGNQk7iX2SsoLy8x/6h+JI4bevaQoczCFfepAep2hqAUBGZ6q0LEZXzFmmDaXZGllUl
         VVhgOt4lvSc1/tHny51qVISm2vVPtwVbCsKPsTXrJgUIt93kKPdCEBLeSYl5Vhg0sSd0
         WSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ohSJY64l2zok+eKa++67OKkpgu1cS2NrBbC6BaEfB+E=;
        b=QD7Ign8flSFFAXl29nVTiM9v7NyxcoV/cv00zrYQt6dRg9Zs2Axo+YfB7mEAI46RNv
         3tjvZJ/0y3DtnnPYGoRkfr4kGQB4wdmu8tZ3oGovUusiMs4J/3hU1o3hfU3duuKxwpHv
         Z+UYAipouT1o/TQW83VQBAZzarDPiGSudZcW8NtEnd9PF7/Q7rkN3JmaaqdzdWQz4vLu
         ffEXFtp3Re/cG1U/ius3es4YdYbs8HmYlYv08ALHyV3bJlIkLDmM+B9yqC+Ji5VZOuzr
         SgsbHHFHcLCSTI54TqVHRh1lmpoerzQP2BG0PMLVsviJ9WvaVuyIgbJxvG2mLvwT13Np
         KUig==
X-Gm-Message-State: ALyK8tIhkunMgwkGmYtIa8W6wjZqUyYNJQ+vkBqN0W7ElNF+UpHHkfYOU7Wd7vF27j6bpZ32g+Es/75guwgHtw==
X-Received: by 10.28.30.1 with SMTP id e1mr49598639wme.77.1469562052416; Tue,
 26 Jul 2016 12:40:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.154.134 with HTTP; Tue, 26 Jul 2016 12:40:51 -0700 (PDT)
From:	Stephen Morton <stephen.c.morton@gmail.com>
Date:	Tue, 26 Jul 2016 15:40:51 -0400
Message-ID: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
Subject: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When I cherry-pick n commits and one of the first (n-1), fails, what I
should do is resolve the conflict, 'git add' it, and then run 'git
cherry-pick --continue'. However git advises me to

error: could not apply d0fb756... Commit message for test commit
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

I suspect this is not just a little bit deceptive but actually a bit
destructive, as doing a 'git commit' removes some of the sequencing
information. If I do a 'git commit', while there is .git/sequencer
information and 'git cherry-pick --continue' will work, there is no
indication in 'git status' that a cherry-pick is in progress.

It would be extremely easy for somebody to follow cherry-pick's hints
by running 'git commit' and think that they were done, not realizing
that there were m more commits remaining to be cherry-picked.

Would it be possible to expand the hint message to tell users to run
'git cherry-pick --continue'

This patch is *not* meant as a serious patch for submission --I'm sure
it's all wrong-- it's just a proof of concept and showing some
goodwill on my part that I'm trying to help and I'm willing to put in
some work if I can be pointed more in the right direction.

Regards,
Stephen




diff --git a/sequencer.c b/sequencer.c
index cdfac82..b8fa534 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -171,14 +171,21 @@ static void print_advice(int show_hint, struct
replay_opts *opts)

        if (show_hint) {
                if (opts->no_commit)
                        advise(_("after resolving the conflicts, mark
the corrected paths\n"
                                 "with 'git add <paths>' or 'git rm <paths>'"));
-               else
-                       advise(_("after resolving the conflicts, mark
the corrected paths\n"
-                                "with 'git add <paths>' or 'git rm <paths>'\n"
-                                "and commit the result with 'git commit'"));
+               else if  (! file_exists(git_path_seq_dir())) {
+                       advise(_("SCM: after resolving the conflicts,
mark the corrected paths\n"
+                     "with 'git add <paths>' or 'git rm <paths>'\n"
+                     "and commit the result with 'git commit'"));
+        }
+        else
+        {
+            advise(_("SCM: after resolving the conflicts, mark the
corrected paths\n"
+                     "with 'git add <paths>' or 'git rm <paths>'\n"
+                     "and continue the %s with 'git %s --continue'"),
action_name(opts), action_name(opts));
+        }
        }
 }
