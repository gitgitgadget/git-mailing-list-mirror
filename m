From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] config: Add documentation for writing config files
Date: Mon,  2 Jun 2014 06:27:01 -0700
Message-ID: <1401715621-3681-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 15:28:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrSHy-0000v4-JV
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 15:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbaFBN2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 09:28:30 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:52402 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbaFBN2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 09:28:30 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so3396562pdi.25
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VGhBt2aWYDHwGPOHOz14byu4nr5K2UUYCifiTUCBGdA=;
        b=U7JJQqbItgH6NX86317xeKPxQhloWKfGbeI4kWKspvUTKg0UkyrIsiex1mEz9IOVSm
         ZmVmIStLkeboZl8mzuiaT0WVM89GtUsjfurwOpNqqmuoCzGTwNRZDt3soV9ltgZ+2ll0
         5/i8sh5VFBgGA2XXEHhMGvHwTQOMjZBAIkK0pIMBaFXE5t4jCDlhmyfVp2ffukgBXAoQ
         Gk/OyFj1aB/DXL63J3cinl75iedIXjXBfRL7laEjZevsu6DMrTVDKo4LRlcPcZT3rHqN
         DjMFCxkKI323g06vrzjVcga7mZqz64SPkRyo1PCLrgDCwTnzKj15wY5argm+PD01XQa5
         IqRw==
X-Received: by 10.68.134.101 with SMTP id pj5mr40991111pbb.62.1401715709678;
        Mon, 02 Jun 2014 06:28:29 -0700 (PDT)
Received: from localhost.localdomain ([117.254.216.65])
        by mx.google.com with ESMTPSA id ba5sm20564689pbc.61.2014.06.02.06.28.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 06:28:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250564>

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 Documentation/technical/api-config.txt | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 230b3a0..df08385 100644
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
+In the end they both all call `git_config_set_multivar_in_file` which takes
+four parameters:
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
