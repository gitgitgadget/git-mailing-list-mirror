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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0C32035A
	for <e@80x24.org>; Thu, 13 Jul 2017 07:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdGMHBF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 03:01:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33912 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdGMHBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 03:01:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so8370866wrc.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/nHuzzrJrZNorgo3oNINJow3rRyqe0YuR8n6qvvI0pQ=;
        b=l08AVLECFex+uYtuBoDk5/+idet3kfDOG8rhicfBUl0AlqP3VRZ0cosJTDEyJPbtCd
         dHUUqX8NXrkTvUZKhgidL/oDckH52h269LAwqk3DQr4G2MzxUXqXE9MM/wZnJhSJa9Ds
         56fAyN8gOh/PB5fOnFwvVYI21zkeiBlnZvL7Oli7phgHndoAuz9d0G8/YsLEvPW9T4YU
         u6lygaw/d49Wjpo/JIxXWjIwQlpEOgOjEYacG2ZI858Aky0akyHkb80mlURLRM5Yzk7P
         0azr4VmXR+v8eEAy0iRi+FaBhNWEtbZV5xaKVTf3XvRSA4nsbE+cyRGloHbt5yDQt8N5
         3jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/nHuzzrJrZNorgo3oNINJow3rRyqe0YuR8n6qvvI0pQ=;
        b=JOD/BT6MaqjbxIW2zcmdhI0k+ixpIiwKQUGQDkslaQwaSxySzMKrgw8W+VZemYJpdU
         49ReSHqLqOV85+5MonDtidb4ysK58ddr2IYJcURr2BaLBx9jy3vdP6pP83RgmkxPLuHZ
         iTCUk+19oMX6U4zlrFOpo/XRfgzUyqA986LhHC+C/a+okf/UtnSy+mnt6EIm809une/W
         Y3pxfnnHiCJRVM11pEwL/NABKDtGgUuZtVhRJ7b46dgNki6fVYJ0D224hu7NxgZtX6NT
         hb+jikZ2vzKQNF6CMU8iUTwPVPVrkBwQLr/hT8nUHq1dv3rYtIT6SYfnDLulrgHOgim/
         Q1pw==
X-Gm-Message-State: AIVw113LqKd7kYL8aJmRzXUo7Y8DUy5StgyzTZDqgo2W0UucOarFQjVy
        qOcdCXFwnaThGA==
X-Received: by 10.223.171.3 with SMTP id q3mr591672wrc.12.1499929262683;
        Thu, 13 Jul 2017 00:01:02 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id r200sm4049927wmd.20.2017.07.13.00.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2017 00:01:01 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH 2/3] git-p4: parse marshal output "p4 -G" in p4 changes
Date:   Thu, 13 Jul 2017 09:00:34 +0200
Message-Id: <20170713070035.12731-2-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170713070035.12731-1-miguel.torroja@gmail.com>
References: <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
 <20170713070035.12731-1-miguel.torroja@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option -G of p4 (python marshal output) gives more context about the
data being output. That's useful when using the command "change -o" as
we can distinguish between warning/error line and real change description.

This fixes the case where a p4 trigger for  "p4 change" is set and the command git-p4 submit is run.

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 git-p4.py                  | 85 +++++++++++++++++++++++++++++++---------------
 t/t9831-git-p4-triggers.sh |  2 +-
 2 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8d151da91..e3a2791e0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -879,8 +879,12 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
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
@@ -1526,37 +1530,62 @@ class P4Submit(Command, P4UserMap):
 
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
+        for key in ['Change', 'Client', 'User', 'Status', 'Description', 'Jobs']:
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
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index 28cafe469..871544b1c 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -66,7 +66,7 @@ test_expect_failure 'import with extra info lines from verbose p4 trigger' '
 	)
 '
 
-test_expect_failure 'submit description with extra info lines from verbose p4 change trigger' '
+test_expect_success 'submit description with extra info lines from verbose p4 change trigger' '
 	test_when_finished cleanup_git &&
 	(
 		p4 triggers -i <<-EOF
-- 
2.11.0

