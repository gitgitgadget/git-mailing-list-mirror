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
	by dcvr.yhbt.net (Postfix) with ESMTP id 092242082F
	for <e@80x24.org>; Tue, 27 Jun 2017 19:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbdF0TRg (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 15:17:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34253 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbdF0TRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:17:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so2722938wmg.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t+52ATZCPUOrFj20rWlSacfESy1wI69PtQO8cf/+gyY=;
        b=uL4LAvR/nMH5R3QVP8lfPq4mjStV1YUmcwIJTdOBHn10tBPgIFPsSDyXAcflc/AZUn
         Uunf5nFF9k8Anwcfi4G3J2VrJPrTb/vJY3g6LOpTqE+tRXU2K8K2EEe0ghq0r//tVHpd
         wTv1eqxNzsKwbc9ztWefEw10b9JiVda1F0tGA2VPZ6eAfZ/U19Kv0nhGPJGi1WOyKRVK
         CBFHItx5BlVkIdl2Dz2CbrO4Ogyc2Aq9ljQ60jcDN3310Q2vs2hRNR9Hpnhe0zmG24Fh
         C2PB8nrP1IicD8f8POIdN5K7xSEZ6GkE2/ZGr1O2WOX7fijDhCo6G3u+TRjj4IBjPhcn
         6USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=t+52ATZCPUOrFj20rWlSacfESy1wI69PtQO8cf/+gyY=;
        b=f43MpeV0wjtEQU1KhNtgGor4d6V0873xw2y/EOasPqX69kgL6UIUjq7l9WK8bxC/rC
         vYsgoZHVv+hwd9QRPIGlJGusD3CgdR8Fhy4A3yoNkCnLuSvSyz2okFIK2Z0S0s6Bwl6k
         TNh0197QAKtBbp/z+rs+KRpfA0r/G6kEBv7deVR09Mi5glMU1L9Hrke/49S9goWIJ2Gy
         CZGMITE1NORrMIUe3tO54f3Crewm/uA/px8zIl/8IcuO4wxJ5MFjjkUPv9l9PizZAZ72
         GZt2GobhcVMQaQ8ePbhDozWOPmN3kC+DcpL9FERWe2u+y/lyyGgQ9+6dtLnkIyVAfJBN
         Za2A==
X-Gm-Message-State: AKS2vOwQkak8NZqYyXmAVXWKxKMlSVsoiN3rTWvAmSPLeo7mi9bWY0my
        Ln6qlBRREIaWqg==
X-Received: by 10.28.178.198 with SMTP id b189mr4443589wmf.8.1498591053203;
        Tue, 27 Jun 2017 12:17:33 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id t75sm648948wmd.10.2017.06.27.12.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 12:17:32 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     larsxschneider@gmail.com, luke@diamand.org, git@vger.kernel.org
Cc:     gitster@pobox.com, Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
Date:   Tue, 27 Jun 2017 21:17:04 +0200
Message-Id: <20170627191704.4446-1-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
References: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
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

A new test has been created to t9807-git-p4-submit.sh adding a p4 trigger
that outputs extra lines with "p4 change -o" and "p4 changes"

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 git-p4.py                | 83 ++++++++++++++++++++++++++++++++----------------
 t/t9807-git-p4-submit.sh | 28 ++++++++++++++++
 2 files changed, 83 insertions(+), 28 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8d151da91..239a8f144 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -879,8 +879,10 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             cmd += ["%s...@%s" % (p, revisionRange)]
 
         # Insert changes in chronological order
-        for line in reversed(p4_read_pipe_lines(cmd)):
-            changes.add(int(line.split(" ")[1]))
+        for entry in reversed(p4CmdList(cmd)):
+            if not entry.has_key('change'):
+                continue
+            changes.add(int(entry['change']))
 
         if not block_size:
             break
@@ -1526,37 +1528,62 @@ class P4Submit(Command, P4UserMap):
 
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
index 3457d5db6..05d7fc3f7 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -409,6 +409,34 @@ test_expect_success 'description with Jobs section and bogus following text' '
 	)
 '
 
+test_expect_success 'description with extra lines from verbose p4 trigger' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		p4 triggers -i <<-EOF
+		Triggers:
+		        p4triggertest-command command pre-user-change "echo verbose trigger"
+		EOF
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

