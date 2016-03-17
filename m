From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] rebase -x: do not die without -i
Date: Wed, 16 Mar 2016 18:19:44 -0700
Message-ID: <1458177584-11378-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr, j6t@kdbg.org,
	johannes.schindelin@gmail.com, Lucien.Kong@ensimag.imag.fr,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 17 02:20:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agMbd-0000Se-NU
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 02:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbcCQBT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 21:19:59 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35935 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbcCQBT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 21:19:58 -0400
Received: by mail-pf0-f174.google.com with SMTP id u190so96970200pfb.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 18:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uu/3i8Z19es/O9aXRvV62VX0N8eeDx37UvGZvQsWu+U=;
        b=c7Yj5iCFT9Tl7/aBPpiYksGCh0g4Yk7ROdPkbr2wYypBmMucAh9h1/+SqXQGTFGfTK
         YXC0qw9zfiaJqYkNl7q5mj80gVnjIwTzbPdWqdDsSu5etwbf4DvFXTTVBiw+S7ECW3NI
         rRsHtylU2xiK7aT0oxW1qDFsCvKXlogjba4rsfDAtZK6qwOocnzRbVsThkIAsnFeCpdR
         09aQEOrypduy6hyohqK9ahD+R0p9VEiOPXlinJetIlcPUkbUmlzKzlgymUxU+99P9U3y
         TS+wN4xmJvIw8mt6ztL2XKwXaw6/UpZIwDimvxU5zC3wkt+Sz5Dcyy4FRMrcHqb4dVYQ
         +VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uu/3i8Z19es/O9aXRvV62VX0N8eeDx37UvGZvQsWu+U=;
        b=iIBXb3Tmrug8c0aPs+J5dwzL1TKj5jbTVwVWw9ZtJ3rQx+jkJoHrNANAuwK1+oH+Ob
         NhnCcgnW89rxbxwE6RIc+sKHd0tYkBqTKbuvOGCkdW5QjHUmV+T2SV6Ps6bNtD1qK2tZ
         JtlG7H+jqCPaiWOBRDko7QudXBjso1rjPUwhxUhAOJdLrZSBsV9+yA1WanR+xlOn5kbE
         kTW08y2+nvfwWTDqyEb381HZ245/n9GQloocxE6tEOQWDmdoF/JC6rkn0OU8K+6mprLM
         nvfUaRo1054W8sjs8biJWgrzP7+7j8miKPk0FAmGcRuWYLTpgESXGshNugoW2G8q+DyI
         FGOg==
X-Gm-Message-State: AD7BkJLYS4kprfyvFJC/JzXXomZflVL8FS+Mq+1X3TcJriEpDJD8Qj0NzuNKKC3YNQFvLHTo
X-Received: by 10.66.55.70 with SMTP id q6mr10499255pap.126.1458177597746;
        Wed, 16 Mar 2016 18:19:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:35c8:8c27:4243:7f7b])
        by smtp.gmail.com with ESMTPSA id g28sm8500834pfd.25.2016.03.16.18.19.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 18:19:57 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.1.g4c756e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289067>

In the later steps of preparing a patch series I do not want to edit the
patches any more, but just make sure the test suite passes after each
patch. Currently I would run

  EDITOR=true git rebase -i <anchor> -x "make test"

In an ideal world the command would be simpler and just be

  git rebase <anchor> -x "make test"

to run the test for each commit I am about to send out for review.
This patch enables the short line.

While at it, remove the double empty lines in t3404.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Junio,
 
 This is a slightly different approach.
 
 -x doesn't imply -i any more, but just the internal code does that. The user
 will see --exec working just fine without the -i option given.

 Thanks,
 Stefan

 git-rebase.sh                 |  4 +++-
 t/t3404-rebase-interactive.sh | 18 +++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index cf60c43..232484a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -351,7 +351,9 @@ test $# -gt 2 && usage
 if test -n "$cmd" &&
    test "$interactive_rebase" != explicit
 then
-	die "$(gettext "The --exec option must be used with the --interactive option")"
+	interactive_rebase=implicit
+	GIT_EDITOR=true
+	export GIT_EDITOR
 fi
 
 if test -n "$action"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 544f9ad..2064d88 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -771,7 +771,6 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
-
 test_expect_success 'prepare for rebase -i --exec' '
 	git checkout master &&
 	git checkout -b execute &&
@@ -780,7 +779,6 @@ test_expect_success 'prepare for rebase -i --exec' '
 	test_commit three_exec main.txt three_exec
 '
 
-
 test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 	set_fake_editor &&
 	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
@@ -793,7 +791,6 @@ test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	git reset --hard execute &&
 	set_fake_editor &&
@@ -807,7 +804,6 @@ test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'running "git rebase -ix git show HEAD"' '
 	git reset --hard execute &&
 	set_fake_editor &&
@@ -835,7 +831,6 @@ test_expect_success 'rebase -ix with several <CMD>' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'rebase -ix with several instances of --exec' '
 	git reset --hard execute &&
 	set_fake_editor &&
@@ -850,7 +845,6 @@ test_expect_success 'rebase -ix with several instances of --exec' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'rebase -ix with --autosquash' '
 	git reset --hard execute &&
 	git checkout -b autosquash &&
@@ -876,16 +870,14 @@ test_expect_success 'rebase -ix with --autosquash' '
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
+	git rebase --exec true HEAD~2 2>actual2 >actual1 &&
+	echo "Successfully rebased and updated refs/heads/autosquash_expected." >expected &&
+	test_i18ncmp expected actual2 &&
+	test_line_count = 2 actual1
 '
 
-
 test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
 	set_fake_editor &&
-- 
2.8.0.rc3.1.ge1ac87c.dirty
