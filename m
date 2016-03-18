From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 1/2] rebase: decouple --exec from --interactive
Date: Fri, 18 Mar 2016 14:26:17 -0700
Message-ID: <1458336377-28296-1-git-send-email-sbeller@google.com>
References: <xmqqd1qszs03.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Mar 18 22:26:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah1un-0004Lq-K8
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874AbcCRV0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:26:24 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33321 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbcCRV0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:26:22 -0400
Received: by mail-pf0-f175.google.com with SMTP id 4so52242741pfd.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gKdstCOL2HHANfOZ0P4iUMd8hf14q1jNmqbojEODBr8=;
        b=AYa+/p3dZedNQY7P5recXZJ2xwkLrqiN/Fg538ArNWKXAd69XyglMn1WZB7Nt8VzYI
         wlUgOR0zoo0YLpvtquFPQg/0xG2nGNCApbuUFL3orSDTjgfpPeBEpm1Vf0TN9ixneSLs
         NoRh74mgt3hiVwngXCs3ww7zwAazcHdkVIZZo1PwZca3qDOo7lsVL54Ze2DvQQMZRyjC
         kVlYyJwTVbzyKG2gcOsOey0/QguzHAKt0r3T0SQe3M9PWPsAkE4CjZzE1hlgzb1OuNpL
         6KigOYPeandzgVBq6Y7VsTObsBOHiGVPX7EPL9fL4B9yiWRjMiJfrgAI8Ol90pMm4GVf
         hs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gKdstCOL2HHANfOZ0P4iUMd8hf14q1jNmqbojEODBr8=;
        b=fGTF/C7JdFC8x3F6oxKLmsD+X6NXdoo+M3U5RW1NJHPbhKrUYegybs50e3KSrUkHPK
         3/sMBc3XfLn/KcLkWdGGSw4+aRdfQLPunmrCnWyijAdPzYFFNH0l3FuspbyIhEzHTZ/7
         e83EdC/RJWJqBAxqYMff9FXt623UR4NiFRUb3+yNwy5ad5NaNRhe3GATFTDgfD9ZPv1g
         7DnDKAEhqoHLhLr/Hj9Qjw4oBP9+C5fElJnmXp8dOA5J85soROiT9w6L9JJYSXedkX6u
         duzqb8+7/S6sfPBPA9EU2Yb4cVKccsetVyMj1IINE7THL36YRPhouaIQ1Ja2+ayb33de
         lVzA==
X-Gm-Message-State: AD7BkJL/4Pszc8NqkuPfQSbS+N43JJDOTT3SvYPnFW+yBPYdQ6hz36EHRyLPVOVLZnF7qDSY
X-Received: by 10.66.147.164 with SMTP id tl4mr26272023pab.40.1458336381092;
        Fri, 18 Mar 2016 14:26:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3cc6:8cc6:6b99:f860])
        by smtp.gmail.com with ESMTPSA id n28sm23144976pfa.45.2016.03.18.14.26.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Mar 2016 14:26:20 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.10.gafa8710.dirty
In-Reply-To: <xmqqd1qszs03.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289252>

In the later steps of preparing a patch series I do not want to
edit or reorder the patches any more, but just make sure the
test suite passes after each patch and also to fix breakage
right there if some of the steps fail.  I could run

    EDITOR=true git rebase -i <anchor> -x "make test"

but it would be simpler if it can be spelled like so:

    git rebase <anchor> -x "make test"

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  Thanks Junio, Johannes for review!
 
 * Reworded the commit message (took your suggestion)
 
 * Diff to v2 in t3404:
        test_expect_success 'rebase --exec works without -i ' '
                git reset --hard execute &&
                rm -rf exec_output &&
        -	git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
        +	EDITOR="echo >invoked_editor" git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
                test_i18ngrep  "Successfully rebased and updated" actual &&
        -	test_line_count = 2 exec_output
        +	test_line_count = 2 exec_output &&
        +	test_path_is_missing invoked_editor
        '
  * I just resend this patch instead of the whole series, so do not expect a
    [PATCHv3 2/2] nor cover letter 0/2
        

 Documentation/git-rebase.txt  |  6 +++---
 git-rebase.sh                 |  7 +------
 t/t3404-rebase-interactive.sh | 13 ++++++-------
 3 files changed, 10 insertions(+), 16 deletions(-)

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
index 544f9ad..21b1f95 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -876,16 +876,15 @@ test_expect_success 'rebase -ix with --autosquash' '
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
+	EDITOR="echo >invoked_editor" git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
+	test_i18ngrep  "Successfully rebased and updated" actual &&
+	test_line_count = 2 exec_output &&
+	test_path_is_missing invoked_editor
 '
 
-
 test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
 	set_fake_editor &&
-- 
2.8.0.rc3.10.gafa8710.dirty
