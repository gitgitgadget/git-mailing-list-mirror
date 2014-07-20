From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2] add documentation for writing config files
Date: Sun, 20 Jul 2014 12:48:13 +0530
Message-ID: <53CB6D35.80805@gmail.com>
References: <1405782354-13929-1-git-send-email-tanayabh@gmail.com> <7DFDF6A1361542EE9BA73AB52B1234AF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 09:18:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8lO4-0007Hx-V5
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 09:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbaGTHST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2014 03:18:19 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44078 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbaGTHST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 03:18:19 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5860728pdj.40
        for <git@vger.kernel.org>; Sun, 20 Jul 2014 00:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cTg9aQrZzAaDzHqGgNsW06eKloomr0PKH1AP9ZhUHuU=;
        b=V57r+BmP3sxSdjscDqwKGxqHbdB4bwsqVw9WISvL1wKJ6FBRBNmRkcZgQaqx2IxrHM
         0AFyxpJIAQQjsGuBmL11eikkb1ckLdJ1fG4fk44R9PJyZ5cO7M8heZH4crkEuvM97D4O
         eK5ofQA++SdhbqmPbaQu9QVDkXNXaqL63gBQjXTvCTl8vQVSk4ajbsKvi6YyYuJl7bSf
         LGZyOoIhmdmreDygmi/Z6ggGKN6LAfz2eMMWEh2lbDSyCypookJrAjj4b8h1rb95hwYg
         ZSLeUhphwYy5Lidww601Kp9Kj98VEfMlbZIAGPpHbixB3He3+0qs/QAa9XqhakKJjNqq
         2BEw==
X-Received: by 10.68.194.229 with SMTP id hz5mr5842220pbc.91.1405840698614;
        Sun, 20 Jul 2014 00:18:18 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.242.60])
        by mx.google.com with ESMTPSA id or10sm9288433pdb.26.2014.07.20.00.18.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jul 2014 00:18:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <7DFDF6A1361542EE9BA73AB52B1234AF@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253912>

Replace TODO introduced in commit 9c3c22 with documentation
explaining Git config API functions for writing configuration
files.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
Minor nit corrected. Thanks for the review.

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
