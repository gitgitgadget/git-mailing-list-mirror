Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B7C206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbcLMPcD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:49378 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933759AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LymHf-1cey8Y0pbr-016A1B; Tue, 13
 Dec 2016 16:29:57 +0100
Date:   Tue, 13 Dec 2016 16:29:56 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 06/34] sequencer (rebase -i): write the 'done' file
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <4a1229e9f2d3715607935519f359b5d7986c2290.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mcmgicYqp6mepChoqCd79awUkDMXlUQsEitLMmXqm0Ona7zYboD
 2VHhepmnzvkJ3YaGEf8GkLbWBUnUpPMgcCR9KQ8qjyvvO7wbR3I8oFDtVo4c2MTdaebPr71
 +njsq1AbXOP0sJTtwbmjBfvEYnWjY8GGy6WtjBZ520MXHrs5a6V0T+lexo/vXsglopfZhkF
 DPVeWlnwIzPsWrutU9LKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q2Q1wyoWbyc=:GgE0TIOmqrKLIJyFz2zuh/
 FCuVrl+saGwbcOnP/Ie+97mI8NGz2C1SojeZUK89L+BwYVggjOfPhI9dW/gZMIWun2AumzidP
 DaMKfhK9JPWAKaGVDOMspRZyyT2nWKI2MktY7bHUEvwmcwKPUdE1h5fCb2e44IajYAnW7kdnM
 yvQmwTj9wv8a19eFkWPTmY05Lla0rq4qXVOXEsf9ccg1VGyk6z6vlE7U82bZAZdVsr1cx4X0s
 sAgeTL90u1UBTXzaXZNT+Yd8+KZyY8zb1F7JEwG8+8PkS1o88/nlmNpNeJ2aK9jjvtfGX7agt
 95X8y5cKlN1V0qb2EtU4DmFZ4pCxHUjEhTVklqUWICSuaKLW5xeIu2sSaEoT8F3qH64MiRADf
 el2IR7MNxhsRzOvDtHvEoBz16DOOmeEvbr1mwiutLrVP3cJJCXLCZMmPVl18Hecx0dVDBq+Xo
 r2cHQAWKgUjPEHuGk5QP7Y0fJYrtN6Z5AbJXD+ZelIKq0L0xyFbMhA2J6yc9C2EvZ632nGW/i
 Tk6MV3/wXrS9YmMNElOgRz8yfoSZdvkSqmHhuf/vI+gz1Nv9D0EpysMW+/X10bYcyA5Ss1v14
 r7OIJl7iI3/QOJpn64D4Xbc4PYbpNFIPD568bcm5/LUOxlIHgx4NYKSBlgF1s1zmz2yiaXUwe
 UhqRFUNky9E9xUqEnO1s+WF9MfJmFZ07zrHhHpobPiSNlv6+6fR1Q3rwx/G1VeHDkmndX7iEW
 Avu5wPBrdfwaX+Y/9B3AXmkIhK0yobo5JCiBRrTHltx/a+k3DB8wWBXjdvyxh/KH1LaUEHyqs
 Bf6wGsE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the interactive rebase, commands that were successfully processed are
not simply discarded, but appended to the 'done' file instead. This is
used e.g. to display the current state to the user in the output of
`git status` or the progress.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 1ab50884bd..f6e20b142a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -39,6 +39,12 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  */
 static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
 /*
+ * The rebase command lines that have already been processed. A line
+ * is moved here when it is first handled, before any associated user
+ * actions.
+ */
+static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
+/*
  * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
  * GIT_AUTHOR_DATE that will be used for the commit that is currently
  * being rebased.
@@ -1295,6 +1301,23 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 		return error_errno(_("could not write to '%s'"), todo_path);
 	if (commit_lock_file(&todo_lock) < 0)
 		return error(_("failed to finalize '%s'."), todo_path);
+
+	if (is_rebase_i(opts)) {
+		const char *done_path = rebase_path_done();
+		int fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
+		int prev_offset = !next ? 0 :
+			todo_list->items[next - 1].offset_in_buf;
+
+		if (fd >= 0 && offset > prev_offset &&
+		    write_in_full(fd, todo_list->buf.buf + prev_offset,
+				  offset - prev_offset) < 0) {
+			close(fd);
+			return error_errno(_("could not write to '%s'"),
+					   done_path);
+		}
+		if (fd >= 0)
+			close(fd);
+	}
 	return 0;
 }
 
-- 
2.11.0.rc3.windows.1


