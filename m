Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD92D201A0
	for <e@80x24.org>; Sun,  2 Jul 2017 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbdGBL3X (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jul 2017 07:29:23 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35991 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdGBL3W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2017 07:29:22 -0400
Received: by mail-pg0-f67.google.com with SMTP id u36so20165377pgn.3
        for <git@vger.kernel.org>; Sun, 02 Jul 2017 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WTV9ckazjIgTTntGcPYKQfGgTxCz+p9OTbEliFav5dg=;
        b=BZsmmcVVtotNc9pZM+r5mUzoPowxZsDPnZdEX5+1nm+q3qc/usycmiiEjVvH9l/s4/
         5GdwO9zluVEvxkVB1Q1b6MgOc21aA3Nhx9RVmB3NQ2uTydJuI95JOVoznYFpL6F+jF3P
         1Bx2r0XMTAqXdQn6iqBCAos07uPswD3eYsTgQgYUKenerl6GGJzJURMROdbXqzDArrQ2
         oLY6b8RbGzaXGcEBhfIoUtnK6ANiZalwXX9VxSg+8ZPZFm5owwZhzXgNhilo27+4paZU
         ryhxNv/FZQL7+r98hJ4DoVGTWLCn5NNv9/mcJuN+tGqY0ZK6g+rcf76Sno3tb6eMubLk
         8A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WTV9ckazjIgTTntGcPYKQfGgTxCz+p9OTbEliFav5dg=;
        b=dpPC/QH9RXNJmFiBtvnUwNz7bxWI0nbKR+UpC3ygflBS+UxwvGIGdKkDGY4s+HseEl
         ENEOtRTnftxxSgm88dbepFK5/ChmdiTIoele/s23kicIvDkrraYhRdgnpITUW+zptrtE
         Gt8tIe8ssXi3gjQ5X/O02zhcdLlWdACRAQmGz8x1qN94o3sl037tDyspMIQrNpAsGQ3C
         kp9FGc2OG6NlCkTiX585PQldHZ0TR3Oj9EX0yctpw+KB9mupMjr8oVy+bgbwtYRoEobp
         HZFaIx1LswlHMG0+Vm5YR6bPRELk1LJWun2pbdIkzvZE213b0nOyNWsEn/lDOhm2Oz+F
         /ADw==
X-Gm-Message-State: AIVw1134hDvQg7Hz/G5lvdwd10dbHekbCCnf4+qKpdikOoVkXNqox/FG
        MG/loRUrFDvMFBEVZGb2bw==
X-Received: by 10.84.209.234 with SMTP id y97mr4930792plh.200.1498994961156;
        Sun, 02 Jul 2017 04:29:21 -0700 (PDT)
Received: from localhost.localdomain ([42.111.160.182])
        by smtp.gmail.com with ESMTPSA id m125sm28041450pfc.47.2017.07.02.04.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jul 2017 04:29:20 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] hooks: add script to HOOKS that allows adding notes from commit message
Date:   Sun,  2 Jul 2017 16:59:16 +0530
Message-Id: <20170702112916.15845-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1498994345.1667.5.camel@gmail.com>
References: <1498994345.1667.5.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script is a little different from others in that it uses THREE
hooks to acheive it's goal, which is to allow users to add notes for
a commit while writing the commit message. It's working isn't
guaranteed even if one of the hooks aren't executed.

It currently works in the following scenartios,

* commit
* commit --amend
* commit -t

From what I'm aware of it's not possible to make it work
with 'merge' as there isn't any hook that checks the message
of a merge commit. The notes are extracted from the commit message
using the hook that checks the commit message.

Use cases other than those specified here aren't tested. It might/
might not be possible to use this script in other cases (with/without
modifications).

The usage of various hooks are as follows,

prepare-commit-msg: Used to add the template in which the user
                    enters the notes for the commit. Leaving it
                    doesn't add any notes for the commit.

commit-msg: Used to extract the notes from the commit message if
            it exists and save it to a file. It removes the the
            content between the template to avoid it being added
            to the commit message.

post-commit: Used to check if the file with notes for the last commit
             exists and if it does, uses it to add notes for the commit.

             Note: It's often times an file with empty lines when notes
             aren't given for a commit. It would not be added as a note
             for the commit as 'git notes' doesn't accept files with
             empty lines.
---
 templates/hooks--commit-msg.sample         | 28 +++++++++++++++++++
 templates/hooks--post-commit.sample        | 18 +++++++++++++
 templates/hooks--prepare-commit-msg.sample | 43 +++++++++++++++++++++++-------
 3 files changed, 80 insertions(+), 9 deletions(-)
 create mode 100644 templates/hooks--post-commit.sample

diff --git a/templates/hooks--commit-msg.sample b/templates/hooks--commit-msg.sample
index b58d1184a..b15b72906 100755
--- a/templates/hooks--commit-msg.sample
+++ b/templates/hooks--commit-msg.sample
@@ -15,6 +15,34 @@
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
 
+# START : NOTES FOR A COMMIT FROM COMMIT MESSAGE
+# Script that allows you to enter notes for a commit while entering the
+# commit message in the editor.
+#
+# **NOTE** : It depends on the "prepare-commit-msg" and "post-commit"
+# hooks. They are to be enabled for it to function correctly.
+NOTES_HEADER='---------- NOTES : START ----------'
+NOTES_FOOTER='----------- NOTES : END -----------'
+GIT_DIR=`git rev-parse --git-dir`
+TEMP_NOTES_FILE="$GIT_DIR/.git/.NOTES_FOR_HEAD"
+
+save_notes_to_file() {
+  sed -n "/$NOTES_HEADER/,/$NOTES_FOOTER/ {
+    /$NOTES_HEADER/n
+    /$NOTES_FOOTER/ !{
+      p
+    }
+  }" "$1" >"$TEMP_NOTES_FILE"
+}
+
+delete_notes_from_message() {
+  sed -i "/$NOTES_HEADER/,/$NOTES_FOOTER/ d" "$1"
+}
+
+grep -q -e "^$NOTES_HEADER" "$1" && save_notes_to_file "$1" && delete_notes_from_message "$1"
+# END : NOTES FOR A COMMIT FROM COMMIT MESSAGE
+
+
 # This example catches duplicate Signed-off-by lines.
 
 test "" = "$(grep '^Signed-off-by: ' "$1" |
diff --git a/templates/hooks--post-commit.sample b/templates/hooks--post-commit.sample
new file mode 100644
index 000000000..ed99f114a
--- /dev/null
+++ b/templates/hooks--post-commit.sample
@@ -0,0 +1,18 @@
+#! /bin/sh
+# The following script allows you to enter notes for a commit
+# while entering the commit message in the editor.
+# 
+# **NOTE** : It depends on the "commit-msg" and "pre-commit-msg"
+# hooks. They are to be enabled for it to function correctly.
+
+
+# START : NOTES FOR A COMMIT FROM COMMIT MESSAGE
+GIT_DIR=`git rev-parse --git-dir`
+TEMP_NOTES_FILE="$GIT_DIR/.NOTES-FOR-HEAD"
+
+if [ -e "TEMP_NOTES_FILE" ]
+then
+  git notes add -F $TEMP_NOTES_FILE
+  rm $TEMP_NOTES_FILE
+fi
+# END : NOTES FOR A COMMIT FROM COMMIT MESSAGE
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 86b8f227e..364f66677 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -9,8 +9,13 @@
 #
 # To enable this hook, rename this file to "prepare-commit-msg".
 
-# This hook includes three examples.  The first comments out the
-# "Conflicts:" part of a merge commit.
+# This hook includes three examples.  The first one is a script
+# that allows you to enter notes for a commit while entering the
+# commit message in the editor.
+#
+# **NOTE** : The script described above depends on the "commit-msg"
+# and "post-commit" hooks. They are to be enabled for it to function
+# correctly.
 #
 # The second includes the output of "git diff --name-status -r"
 # into the message, just before the "git status" output.  It is
@@ -20,17 +25,37 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
-case "$2,$3" in
-  merge,)
-    @PERL_PATH@ -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
+# START : NOTES FOR A COMMIT FROM COMMIT MESSAGE
+REQUEST_NOTES_TEMPLATE='\
+# Add notes about this commit in the NOTES template below.\
+# DO NOT MODIFY the template to prevent surprises\
+# If you do not wish to add notes for this commit, leave it untouched\
+---------- NOTES : START ----------\
+\
+\
+----------- NOTES : END -----------\
+'
+COMMENT_IDENTIFIER='^# Please enter the .*'
+
+add_notes_template() {
+  sed -i "/$COMMENT_IDENTIFIER/ i\
+$REQUEST_NOTES_TEMPLATE" "$1"
+}
+
+case "$2," in
+  ,|commit,|template,) add_notes_template "$1"
+                       ;;
+esac
+# END : NOTES FOR A COMMIT FROM COMMIT MESSAGE
 
-# ,|template,)
+# case "$2,$3" in
+#  ,|template,)
 #   @PERL_PATH@ -i.bak -pe '
 #      print "\n" . `git diff --cached --name-status -r`
 #	 if /^#/ && $first++ == 0' "$1" ;;
-
-  *) ;;
-esac
+#
+#  *) ;;
+# esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
-- 
2.11.0

