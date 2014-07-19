From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] add documentation for writing config files
Date: Sat, 19 Jul 2014 08:05:54 -0700
Message-ID: <1405782354-13929-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 19 17:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8WEZ-00084s-8S
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbaGSPHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:07:20 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62209 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbaGSPHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:07:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so7072070pad.13
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H0nnG6kanN3MbSaxbLof6B8N3y5jKza6oA7HQv8IBZY=;
        b=QnBqb5n3v1ev2ePgQjAQlyyGLhy3nqY2xZkM9X3K9DcZce8wQFm+VP2cCOM5DUWvaK
         0ruxSYKr+lLWvq3nO7/G+KaT8O86mla73VQGebYn1xb0WIka8xLo6tkzLw8bi1vj61Xh
         e7CytbGr83LaSMl9/W7Mpt7+ZoO+mL819wG1H9AF2hOZjd2wZda9+S4hE2/mxoUk+T/p
         VAhJbOIhXtrDIVNkjjfOYFg+4BgeB5Bye+evL+BXeYbZGVstkMm6552LIC1h4ekigySd
         GAi8taJALiuw/bYl6Xd7ri3HLGNbw1nWCz9qZlRYc9Dm0y0WTcfEfeS+1lU7NwGAbRVt
         R4+w==
X-Received: by 10.68.191.34 with SMTP id gv2mr2012476pbc.13.1405782438639;
        Sat, 19 Jul 2014 08:07:18 -0700 (PDT)
Received: from localhost.localdomain ([223.176.232.60])
        by mx.google.com with ESMTPSA id ec2sm8837124pbc.63.2014.07.19.08.07.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 08:07:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253881>

Replace TODO introduced in commit 9c3c22 with documentation
explaining Git config API functions for writing configuration
files.

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
