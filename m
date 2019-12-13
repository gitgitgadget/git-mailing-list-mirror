Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6AC5072A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F6B24704
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrlfyFhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfLMN6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:58:08 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34481 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfLMN6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:58:07 -0500
Received: by mail-wr1-f52.google.com with SMTP id t2so6776846wrr.1
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K4nTQ0kCXi1h71P7LCfnyO4NxOvrAcJyf5H1qyP/pVI=;
        b=KrlfyFhrrhT1H7WuiXIPmNfkcGnxJZP/bvU2Me+a7Ar0crSLEZslfztCmFcg4CKzPU
         M3oHwhsHY1vEqsSVzLUazu9/A1EcXlWbDAIMkvNR6xAl4nUjbf+R73/FfLm3cxdJafJB
         lz6OHmrXcgfWH3dXNYT6N6uYii4sCwvKU25YMYo7Woc4FVYtFLSq2dTo0sNYJALVBm+5
         bnaDyZ4qZLF56w5FS7o5bAwZUQrxjtLes5ArLbcOFvLUgtQ9mvb6X+AyiSgUKbSKn+0E
         zkpOt5hCGJInO1Zsoq8kmyMisb4slr96pOdFYO0fGat4fi8/V9XLQA/jDloI3YKORZBS
         8L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K4nTQ0kCXi1h71P7LCfnyO4NxOvrAcJyf5H1qyP/pVI=;
        b=MIL17ZSbXwrfNvk3zPBo0nh+pC9lKCzWcSQ6pxNr530WE5RyLdj/hsDzGbgxQr0DRV
         2oVId7BhTkDsz6d1NV8H7cY2x2hCTiPvS8OsN9/gLKhCPcrz6X3ElWezrTImuHBgg43J
         qIV371rkh85FVjSWZJbUZmDnnnwIHnnPMS98Ltm9LK30qKDXfmZcu+Hlg1LcoTGSv6Ih
         bp7B09fVUbi5MHXVj8t00Yl/0M8RDHgtnE3GkSmdkWoHKdkp+5lAkVS6NErk9zOP5yfk
         0tq/dZ8Cyh5r0icD89Qv37VLPjD2FyzT6a5riYwpBMQe/J3K0DwcIm0A8hP79faXe1Gi
         6tlg==
X-Gm-Message-State: APjAAAV1o2vEX6wQQ20/V5QpTLMXUEYOsJT0IBrc1YPQEJKJEk0R2Be6
        aigmG9RQ2Fkwcjm33J7ekfeom6U0
X-Google-Smtp-Source: APXvYqzZ/0Nv66hHXK2OQYH1h7nRuyn8wMUqv8pc08bXoqOg/TaDkfZcVrA+LPZGrPXpBPMflU6DYg==
X-Received: by 2002:adf:e887:: with SMTP id d7mr12589506wrm.162.1576245483612;
        Fri, 13 Dec 2019 05:58:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o194sm303105wme.45.2019.12.13.05.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:58:03 -0800 (PST)
Message-Id: <6c23cd56842e76e5c11f32ba59fd7729769ab4b7.1576245481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
References: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
        <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 13:57:58 +0000
Subject: [PATCH v4 1/4] git-p4: yes/no prompts should sanitize user text
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When prompting the user interactively for direction, the tests are
not forgiving of user input format.

For example, the first query asks for a yes/no response. If the user
enters the full word "yes" or "no" or enters a capital "Y" the test
will fail.

Create a new function, prompt(prompt_text) where
  * prompt_text is the text prompt for the user
  * returns a single character where valid return values are
      found by inspecting prompt_text for single characters
      surrounded by square brackets

This new function must  prompt the user for input and sanitize it by
converting the response to a lower case string, trimming leading and
trailing spaces, and checking if the first character is in the list
of choices. If it is, return the first letter.

Change the current references to raw_input() to use this new function.

Since the method requires the returned text to be one of the available
choices, remove the loop from the calling code that handles response
verification.

Thanks-to: Denton Liu <Denton Liu>
Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 67 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..3b3f1469a6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -167,6 +167,21 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+def prompt(prompt_text):
+    """ Prompt the user to choose one of the choices
+
+    Choices are identified in the prompt_text by square brackets around
+    a single letter option.
+    """
+    choices = set(m.group(1) for m in re.finditer(r"\[(.)\]", prompt_text))
+    while True:
+        response = raw_input(prompt_text).strip().lower()
+        if not response:
+            continue
+        response = response[0]
+        if response in choices:
+            return response
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -1778,12 +1793,11 @@ def edit_template(self, template_file):
         if os.stat(template_file).st_mtime > mtime:
             return True
 
-        while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
-            if response == 'y':
-                return True
-            if response == 'n':
-                return False
+        response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+        if response == 'y':
+            return True
+        if response == 'n':
+            return False
 
     def get_diff_description(self, editedFiles, filesToAdd, symlinks):
         # diff
@@ -2345,31 +2359,22 @@ def run(self, args):
                           " --prepare-p4-only")
                     break
                 if i < last:
-                    quit = False
-                    while True:
-                        # prompt for what to do, or use the option/variable
-                        if self.conflict_behavior == "ask":
-                            print("What do you want to do?")
-                            response = raw_input("[s]kip this commit but apply"
-                                                 " the rest, or [q]uit? ")
-                            if not response:
-                                continue
-                        elif self.conflict_behavior == "skip":
-                            response = "s"
-                        elif self.conflict_behavior == "quit":
-                            response = "q"
-                        else:
-                            die("Unknown conflict_behavior '%s'" %
-                                self.conflict_behavior)
-
-                        if response[0] == "s":
-                            print("Skipping this commit, but applying the rest")
-                            break
-                        if response[0] == "q":
-                            print("Quitting")
-                            quit = True
-                            break
-                    if quit:
+                    # prompt for what to do, or use the option/variable
+                    if self.conflict_behavior == "ask":
+                        print("What do you want to do?")
+                        response = prompt("[s]kip this commit but apply the rest, or [q]uit? ")
+                    elif self.conflict_behavior == "skip":
+                        response = "s"
+                    elif self.conflict_behavior == "quit":
+                        response = "q"
+                    else:
+                        die("Unknown conflict_behavior '%s'" %
+                            self.conflict_behavior)
+
+                    if response == "s":
+                        print("Skipping this commit, but applying the rest")
+                    if response == "q":
+                        print("Quitting")
                         break
 
         chdir(self.oldWorkingDirectory)
-- 
gitgitgadget

