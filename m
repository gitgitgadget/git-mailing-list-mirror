From: Stefan Beller <sbeller@google.com>
Subject: [PATCHV2 1/2] rebase -x: do not die without -i
Date: Thu, 17 Mar 2016 14:44:19 -0700
Message-ID: <1458251060-311-2-git-send-email-sbeller@google.com>
References: <1458251060-311-1-git-send-email-sbeller@google.com>
Cc: j6t@kdbg.org, johannes.schindelin@gmail.com, gitster@pobox.com,
	Matthieu.Moy@grenoble-inp.fr, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 22:44:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agfid-00017F-Us
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 22:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031072AbcCQVo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 17:44:28 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33116 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030636AbcCQVo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 17:44:26 -0400
Received: by mail-pf0-f177.google.com with SMTP id 4so6480737pfd.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5nsJcYCLPIf8QU8MD0VStABfKNd3frffDh4R2dJQ5I=;
        b=fv5bZd74rRLR1kx2kfWAi1XoUutMiLAOc1IOrMJBvG24H353s9Ujowl0wXRDfqrw0R
         UFqKhmpk9LRxibaqpgC24gAVB3a8BN2H3MNdFemZCpVPRZmDhqCbr8h85v9b4QFMsB5a
         +U6z1DmNCoEF84Qx2bxkDwM1qsQN29sYdmSgdXS1tKy2gvwge4DdgJ1ixZk9cAyu2Fl9
         VJ3CyxlzFnYhz9kXsh8pJpYV+OfApaLnlU1Oi/ktNoAoI9Lq0zmENugihAkyMOjYxlXh
         BhNqejq5+UoTOgiOxPwS/i27zWE+Q6xtNEeKr9DK2ah0EkHe1DVUxRJHjiwgi6xQXS3l
         QadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b5nsJcYCLPIf8QU8MD0VStABfKNd3frffDh4R2dJQ5I=;
        b=TGZVTIEG6J+0foVWvzOh1wSHu5R/YB6bWMg/UBJlWuNLCYKpBu4uM14a2XK0kWa3WK
         ApG0rQXZ+cUQwUWqgRn2yTG10abkpqK5Y00kF/NjWJIf8bO/+VCt7CkjMT+4//6spZUY
         cOLsJcmXlkS4uwfDUo2o2ebZElYeKv/o/BfABXtipAA5ysH0gv1FMS2lPMvizwTH7k9b
         icX+aj9ZNIGWnkBbQkIW+4wLQ7C4TFbQO5JVQ3hwwfQ7Tp8ZwFWLL9zRheMIdG9ZA6lH
         Vc50SIi4ahnk3kHEVSXHdhc5rnERwLuCh2MLJxZRohtdTbLXw105g8239Ayp6ezIgzYQ
         30BA==
X-Gm-Message-State: AD7BkJKuo/kpqIY9NK1kPGDAEoO3axgwNAZpw5y1vYfEC+2LvPpJ8OWREvyFIbvhNdBYANNa
X-Received: by 10.98.67.199 with SMTP id l68mr18216111pfi.18.1458251065926;
        Thu, 17 Mar 2016 14:44:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d62:319:527b:e183])
        by smtp.gmail.com with ESMTPSA id ql1sm15621579pac.24.2016.03.17.14.44.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 14:44:25 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.2.ga804a9e
In-Reply-To: <1458251060-311-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289160>

In the later steps of preparing a patch series I do not want to edit the
patches any more, but just make sure the test suite passes after each
patch. Currently I would run

  EDITOR=true git rebase -i <anchor> -x "make test"

In an ideal world the command would be simpler and just be

  git rebase <anchor> -x "make test"

to run the test for each commit I am about to send out for review.
This patch enables the short line. As things can still break, I'd want
to be able to fix those failures directly at the commit, so it is not
sufficient to just use:

        git rev-list old...new |
        while read rev
        do
                $command || break
        done

as it only tests and does not stop at a breakage to fix it up.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-rebase.txt  |  6 +++---
 git-rebase.sh                 |  7 +------
 t/t3404-rebase-interactive.sh | 12 +++++-------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6ed610a..0387b40 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -391,9 +391,6 @@ idea unless you know what you are doing (see BUGS below).
 	final history. <cmd> will be interpreted as one or more shell
 	commands.
 +
-This option can only be used with the `--interactive` option
-(see INTERACTIVE MODE below).
-+
 You may execute several commands by either using one instance of `--exec`
 with several commands:
 +
@@ -406,6 +403,9 @@ or by giving more than one `--exec`:
 If `--autosquash` is used, "exec" lines will not be appended for
 the intermediate commits, and will only appear at the end of each
 squash/fixup series.
++
+This uses the `--interactive` machinery internally, but it can be run
+without an explicit `--interactive`.
 
 --root::
 	Rebase all commits reachable from <branch>, instead of
diff --git a/git-rebase.sh b/git-rebase.sh
index cf60c43..0bf41ee 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -248,6 +248,7 @@ do
 		;;
 	--exec=*)
 		cmd="${cmd}exec ${1#--exec=}${LF}"
+		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
 	--interactive)
 		interactive_rebase=explicit
@@ -348,12 +349,6 @@ do
 done
 test $# -gt 2 && usage
 
-if test -n "$cmd" &&
-   test "$interactive_rebase" != explicit
-then
-	die "$(gettext "The --exec option must be used with the --interactive option")"
-fi
-
 if test -n "$action"
 then
 	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 544f9ad..c8cc03d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -876,16 +876,14 @@ test_expect_success 'rebase -ix with --autosquash' '
 	test_cmp expected actual
 '
 
-
-test_expect_success 'rebase --exec without -i shows error message' '
+test_expect_success 'rebase --exec works without -i ' '
 	git reset --hard execute &&
-	set_fake_editor &&
-	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
-	echo "The --exec option must be used with the --interactive option" >expected &&
-	test_i18ncmp expected actual
+	rm -rf exec_output &&
+	git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
+	test_i18ngrep  "Successfully rebased and updated" actual &&
+	test_line_count = 2 exec_output
 '
 
-
 test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
 	set_fake_editor &&
-- 
2.8.0.rc3.2.ga804a9e
