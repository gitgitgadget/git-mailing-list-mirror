From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2] add documentation for writing config files
Date: Mon, 28 Jul 2014 03:42:26 -0700
Message-ID: <1406544146-19404-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:43:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiP0-0002yg-R9
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbaG1Kna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:43:30 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39527 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbaG1Kna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:43:30 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so10358589pab.29
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gUemk9kj2VzFvYAcIU9PzQ/Gtbi2jZdmAEWw9uMUsMQ=;
        b=QvWILiV7p1jUdbJz6+8vPZiCvcpZkUHgoe6IXQAQ2HdlmZCQZxYGNObhe217o7vuU/
         zMbrVYDGrlhtGix7M4Yn4mYon8OpYO9ZcTb88soOdnKk7QXTIZ+uj669BmkGWVIcQ5s1
         aklFn0+SVHn/SyMBU1yBsS59G0ch16cHu7Gl9kyRS0alrhF2jYQH9OhmM/oSWN+xZD4F
         /kgLpEIe5ONBkeBwOpveLVD2dtRiL/zw4nbXENPFVDEYg62t8UhAM/87jGhFRuSl8TXv
         mdRL9dPWgNSdCPfIAIj8pFnSd6yQiTXB/VV2069gU1Y1aSyvda0BXHMia/5VxaBJYqmo
         Ot4A==
X-Received: by 10.70.40.131 with SMTP id x3mr38235647pdk.22.1406544209582;
        Mon, 28 Jul 2014 03:43:29 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id cm7sm23663499pdb.74.2014.07.28.03.43.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:43:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254299>

Replace TODO introduced in commit 9c3c22 with documentation
explaining Git config API functions for writing configuration
files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..edd5018 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -137,4 +137,33 @@ int read_file_with_include(const char *file, config_fn_t fn, void *data)
 Writing Config Files
 --------------------
 
-TODO
+Git gives multiple entry points in the Config API to write config values to
+files namely `git_config_set_in_file` and `git_config_set`, which write to
+a specific config file or to `.git/config` respectively. They both take a
+key/value pair as parameter.
+In the end they both call `git_config_set_multivar_in_file` which takes four
+parameters:
+
+- the name of the file, as a string, to which key/value pairs will be written.
+
+- the name of key, as a string. This is in canonical "flat" form: the section,
+  subsection, and variable segments will be separated by dots, and the section
+  and variable segments will be all lowercase.
+  E.g., `core.ignorecase`, `diff.SomeType.textconv`.
+
+- the value of the variable, as a string. If value is equal to NULL, it will
+  remove the matching key from the config file.
+
+- the value regex, as a string. It will disregard key/value pairs where value
+  does not match.
+
+- a multi_replace value, as an int. If value is equal to zero, nothing or only
+  one matching key/value is replaced, else all matching key/values (regardless
+  how many) are removed, before the new pair is written.
+
+It returns 0 on success.
+
+Also, there are functions `git_config_rename_section` and
+`git_config_rename_section_in_file` with parameters `old_name` and `new_name`
+for renaming or removing sections in the config files. If NULL is passed
+through `new_name` parameter, the section will be removed from the config file.
-- 
1.9.0.GIT
