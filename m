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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F952202A7
	for <e@80x24.org>; Thu, 29 Jun 2017 22:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbdF2Wro (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:47:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36493 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdF2Wrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:47:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so37827832wrb.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SjDRnsRdqq+6DUnu0by1y69zzJPTCMT+FJGVWqUBimQ=;
        b=jrkdRtSnx/MPohJvSZQ3QuFqkOoDZvfMhi6INeHOPaa8PPXj/ZNpzdRunBfgu56xUh
         5vkQqWlj+TonH0hUHrl7O+7DP/GASllrdFtzvxloJ8QduVNgb4G3uncsxGFNbcnh3qCS
         QcE/2Cx8IOSk1d5g7EVO5a+oqBTz0sUH8gnbRXwwIxYFB9p8aIcPbsNSaLnYJtR/m/5/
         kAqAbqCaCYpRUBVEJy4EJlTsClyhYa5lGwNTKScAkMcd3/+IKuOoC1AQSiGc/VuJ6ccU
         VjTzCx5XRnKVT8o2R5VXb45wSmZe3uRIqNTlowz8uOufe/1C2bMjFJ84kYO2hvUSU4Ls
         XOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SjDRnsRdqq+6DUnu0by1y69zzJPTCMT+FJGVWqUBimQ=;
        b=iH+S7NU7tSGHbbkXbOgl+LAQrAgjs+H0Drd+MLYc793+MFNa1q+yGvG71bzl5ZLyo2
         dYI4EgzlVCY8PwCbBHB3Bydr4HTNTk6kFZJwP8+RLuLTn2oqXAeJb3PTm0JRSG+Mt/Bl
         8vKxGcSH+oVlGc3aDyBJDSFX0bbE/HSx64vqHWS2h+zD7LPUsoRZLsKSDW0dPwCSWEjr
         LtIoB6mODj5qLEF/k6hnqfjkdlzMztPMOskeFobmf430A0vlgREMF3GQfCmVFJ+do4Tc
         FVOoA2T2zYFmlomT0hUIcipw9F1OpmnBFfOh3+XDo/EtHyNXGIevtCzEpQ2m7RtIEJ0d
         3kCw==
X-Gm-Message-State: AKS2vOw/QGXfPIBaPzUHRnGWS3A5zp8iAFh4rfwhXWmi86sHP6hIgmi2
        VaIE+yzp3wDldA==
X-Received: by 10.223.161.138 with SMTP id u10mr23658642wru.191.1498776461604;
        Thu, 29 Jun 2017 15:47:41 -0700 (PDT)
Received: from berenguela.telefonica.net (152.red-95-120-155.dynamicip.rima-tde.net. [95.120.155.152])
        by smtp.gmail.com with ESMTPSA id f21sm8134876wra.5.2017.06.29.15.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:47:40 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     Luke Diamand <luke@diamand.org>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
Date:   Fri, 30 Jun 2017 00:46:59 +0200
Message-Id: <20170629224659.25677-1-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com>
References: <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py                | 85 ++++++++++++++++++++++++++++++++----------------
 t/t9807-git-p4-submit.sh | 27 +++++++++++++++
 2 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8d151da91..61dc045f3 100755
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
index 3457d5db6..4962b6862 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -409,6 +409,33 @@ test_expect_success 'description with Jobs section and bogus following text' '
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

