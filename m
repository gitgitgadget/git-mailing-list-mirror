Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BD220282
	for <e@80x24.org>; Tue, 20 Jun 2017 12:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbdFTMTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 08:19:51 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34071 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdFTMTs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 08:19:48 -0400
Received: by mail-qk0-f193.google.com with SMTP id d14so10524094qkb.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HUaqvYfthwlyejOPYJUfbFAew4Bt0YigF+rvNN6hjxg=;
        b=J5o5U+up9ANuLu8F7c+8CF7MoiGzVtHj8eLnPtmcSATrzOPmB0v/N8SJ8bkZCrjXE7
         rvRsRWPYIjfyIEDthp5ur0C0B4XQn7FKu+iQGGCq/Wi8qaoPjhro9rHrAu1iYz5cILRq
         d0Tg6FQKaO9xujuisUEFaICNQDOrkTOtaxfRWNbICVhida961r+HoRkaRd7FQDPqOHL/
         hE6kIsUXAHfxvr9IhUZ+QC+9o8ZHhjxqdJjHGaVyE+ktCR2FprIcaP7JtnquogJ0c/5b
         XfYfXNenCqznajON4Phs1mc2Lpbi3PentwpokqWPizYAn8OELrcrkPDvaUt8qr2IP5Dj
         nETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=HUaqvYfthwlyejOPYJUfbFAew4Bt0YigF+rvNN6hjxg=;
        b=MoqAjRW118DCjlghMQLJkrSwdV1tKjBB5b+Ibyncjmjtjn5V1UOQUnj/XQjFGek6qa
         b11jnNE6KiLcb05x7JjPcfyrsacTKqmvBgDbdYF2BlA8Gt5kfqz+YyZXMEujVAhXTIWj
         /pKQsP5d3rnf+TanF+qLEaIZcK7NQKtfmBLHsHhkmmHFZQFtefRAeC4NAU8dxhNhToVE
         hvcKUi774jz9iL/k5+yJddDUx0nPxxqMy0dVf4bSLU74YBvgDwhew9BbEpS2kLOvsv3i
         BFj64cvYGMbvdHWIGLQOV5dMLNTX2LoMSqM2KuQIJTApvWkza7CEhk7I0p7NwH7lSXtZ
         hlOQ==
X-Gm-Message-State: AKS2vOyP/eVrGCA751b0ifSk3mooDujdCsROFpPdDjhBCeS+Ya6E4QNF
        ZiCfUBnyb6OudXc5
X-Received: by 10.55.170.212 with SMTP id t203mr31181196qke.200.1497961182748;
        Tue, 20 Jun 2017 05:19:42 -0700 (PDT)
Received: from phobos.cam.broadcom.com ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id p24sm8245306qki.49.2017.06.20.05.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 05:19:41 -0700 (PDT)
From:   Miguel Torroja <miguel.torroja@gmail.com>
To:     git@vger.kernel.org
Cc:     Miguel Torroja <miguel.torroja@gmail.com>
Subject: [PATCH] git-p4: changelist template with p4 -G change -o
Date:   Tue, 20 Jun 2017 14:19:01 +0200
Message-Id: <1497961141-3144-1-git-send-email-miguel.torroja@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option -G of p4 (python marshal output) gives more context about the
data being output. That's useful when using the command "change -o" as
we can distinguish between warning/error line and real change description.

Some p4 plugin/hooks in the server side generates some warnings when
executed. Unfortunately those messages are mixed with the output of
"p4 change -o". Those extra warning lines are reported as {'code':'info'}
in python marshal output (-G). The real change output is reported as
{'code':'stat'}

Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
---
 git-p4.py | 77 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8d151da..a300474 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1526,37 +1526,62 @@ class P4Submit(Command, P4UserMap):
 
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
-- 
2.1.4

