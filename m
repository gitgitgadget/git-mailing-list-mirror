Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A21201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 22:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdGCW6P (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 18:58:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36492 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdGCW6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 18:58:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id y5so22977813wmh.3
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPWwoSjbWwnfOIgUU1S+mM1cFcgLJrogza6QYU9ngCc=;
        b=epG17hlV/fv7TsTZ6EBITIy1+nDkFz8YI1QqUW0k9/QPU+7iw8lKzEgDET8/0LDu3V
         LETuDiHo629beF9+rFFPRuOIFqhSDCgeX7yey7AtkDZpfMkMInE3fz44LGhwbiV7f8qE
         JZrgeeqgilAk1cQnGzYXvYKCVJt3w4MCxX2o+Fmqlul/2lmD4FZ0Za7XJ3VH6aQ0M1wb
         E5iz9bfOQ+rK3exsSG7kaBKHcnhkTCTF+v4blzzXr2gT69CQflasvBkPOhiDKg3TQSZ3
         oR0G+MRs7xIMpJl9pHa9IaRfNx5pxylvwWikB7kYkqkp2Sh8U3dEp0SeLLH96GvqLUmT
         A9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dPWwoSjbWwnfOIgUU1S+mM1cFcgLJrogza6QYU9ngCc=;
        b=mxzA9LIWyG1HWaOfo3J29wADgw7M0dUjLz5VnwmdLjqp3JYz/kqLerTytCCnhWRXXJ
         G48ENLmM9HhPYLL6Ru9qzIonyvGMA8yR5uKMHYU54pXm6ItgYG28rqn3inLlXSwidFes
         +evy5z0XIkgNzIZ8CEsTNLJ6KID1QD2E+QXJk1j8OEoISFlS9PKjxfSb26m+H6D14f+0
         EC2mYgHo8hvce56i+NjdIv7ugxVsodZFhekjLGaJsB25QGgjYDTMkfYFV1veic68q1b8
         MvGxo9eck2snF9EqSNb1fF4JT+LmuEurgaO2ahljLerOTyOHWQ/FkP9R2L05cFudzZfu
         kM6w==
X-Gm-Message-State: AIVw112DFTrkzq5it+JKWytcSC9OWOAHjpC49s0syaiKxkec++9KH48O
        8Chrouk/WgiBFg==
X-Received: by 10.28.55.201 with SMTP id e192mr15619729wma.75.1499122692991;
        Mon, 03 Jul 2017 15:58:12 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id l14sm12499761wrb.19.2017.07.03.15.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 15:58:12 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Cc:     Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
Date:   Tue,  4 Jul 2017 00:57:31 +0200
Message-Id: <20170703225731.21212-1-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <94F87EDC-4F34-455E-88D5-F99C606EF628@gmail.com>
References: <94F87EDC-4F34-455E-88D5-F99C606EF628@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option -G of p4 (python marshal output) gives more context about the
data being output. That's useful when using the command "change -o" as
we can distinguish between warning/error line and real change description.

Some p4 triggers in the server side generate some warnings when
executed. Unfortunately those messages are mixed with the output of
"p4 change -o". Those extra warning lines are reported as {'code':'info'}
in python marshal output (-G). The real change output is reported as
{'code':'stat'}

the function p4CmdList accepts a new argument: skip_info. When set to
True it ignores any 'code':'info' entry (skip_info=True by default).

A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
that outputs extra lines with "p4 change -o" and "p4 changes"

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 git-p4.py                | 90 ++++++++++++++++++++++++++++++++----------------
 t/t9807-git-p4-submit.sh | 30 ++++++++++++++++
 2 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8d151da91..a262e3253 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -509,7 +509,7 @@ def isModeExec(mode):
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
-def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
+def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=True):
 
     if isinstance(cmd,basestring):
         cmd = "-G " + cmd
@@ -545,6 +545,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
     try:
         while True:
             entry = marshal.load(p4.stdout)
+            if skip_info:
+                if 'code' in entry and entry['code'] == 'info':
+                    continue
             if cb is not None:
                 cb(entry)
             else:
@@ -879,8 +882,12 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             cmd += ["%s...@%s" % (p, revisionRange)]
 
         # Insert changes in chronological order
-        for line in reversed(p4_read_pipe_lines(cmd)):
-            changes.add(int(line.split(" ")[1]))
+        for entry in reversed(p4CmdList(cmd)):
+            if entry.has_key('p4ExitCode'):
+                die('Error retrieving changes descriptions ({})'.format(entry['p4ExitCode']))
+            if not entry.has_key('change'):
+                continue
+            changes.add(int(entry['change']))
 
         if not block_size:
             break
@@ -1526,37 +1533,62 @@ class P4Submit(Command, P4UserMap):
 
         [upstream, settings] = findUpstreamBranchPoint()
 
-        template = ""
+        template = """\
+# A Perforce Change Specification.
+#
+#  Change:      The change number. 'new' on a new changelist.
+#  Date:        The date this specification was last modified.
+#  Client:      The client on which the changelist was created.  Read-only.
+#  User:        The user who created the changelist.
+#  Status:      Either 'pending' or 'submitted'. Read-only.
+#  Type:        Either 'public' or 'restricted'. Default is 'public'.
+#  Description: Comments about the changelist.  Required.
+#  Jobs:        What opened jobs are to be closed by this changelist.
+#               You may delete jobs from this list.  (New changelists only.)
+#  Files:       What opened files from the default changelist are to be added
+#               to this changelist.  You may delete files from this list.
+#               (New changelists only.)
+"""
+        files_list = []
         inFilesSection = False
+        change_entry = None
         args = ['change', '-o']
         if changelist:
             args.append(str(changelist))
-
-        for line in p4_read_pipe_lines(args):
-            if line.endswith("\r\n"):
-                line = line[:-2] + "\n"
-            if inFilesSection:
-                if line.startswith("\t"):
-                    # path starts and ends with a tab
-                    path = line[1:]
-                    lastTab = path.rfind("\t")
-                    if lastTab != -1:
-                        path = path[:lastTab]
-                        if settings.has_key('depot-paths'):
-                            if not [p for p in settings['depot-paths']
-                                    if p4PathStartsWith(path, p)]:
-                                continue
-                        else:
-                            if not p4PathStartsWith(path, self.depotPath):
-                                continue
+        for entry in p4CmdList(args):
+            if not entry.has_key('code'):
+                continue
+            if entry['code'] == 'stat':
+                change_entry = entry
+                break
+        if not change_entry:
+            die('Failed to decode output of p4 change -o')
+        for key, value in change_entry.iteritems():
+            if key.startswith('File'):
+                if settings.has_key('depot-paths'):
+                    if not [p for p in settings['depot-paths']
+                            if p4PathStartsWith(value, p)]:
+                        continue
                 else:
-                    inFilesSection = False
-            else:
-                if line.startswith("Files:"):
-                    inFilesSection = True
-
-            template += line
-
+                    if not p4PathStartsWith(value, self.depotPath):
+                        continue
+                files_list.append(value)
+                continue
+        # Output in the order expected by prepareLogMessage
+        for key in ['Change','Client','User','Status','Description','Jobs']:
+            if not change_entry.has_key(key):
+                continue
+            template += '\n'
+            template += key + ':'
+            if key == 'Description':
+                template += '\n'
+            for field_line in change_entry[key].splitlines():
+                template += '\t'+field_line+'\n'
+        if len(files_list) > 0:
+            template += '\n'
+            template += 'Files:\n'
+        for path in files_list:
+            template += '\t'+path+'\n'
         return template
 
     def edit_template(self, template_file):
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 3457d5db6..b630895a7 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -409,6 +409,36 @@ test_expect_success 'description with Jobs section and bogus following text' '
 	)
 '
 
+test_expect_success 'description with extra lines from verbose p4 trigger' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers: p4triggertest-command command pre-user-change "echo verbose trigger"
+		EOF
+	) &&
+	(
+		p4 change -o |  grep -s "verbose trigger"
+	) &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		echo file20 >file20 &&
+		git add file20 &&
+		git commit -m file20 &&
+		git p4 submit
+	) &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers:
+		EOF
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file file20
+	)
+'
+
 test_expect_success 'submit --prepare-p4-only' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
-- 
2.11.0

