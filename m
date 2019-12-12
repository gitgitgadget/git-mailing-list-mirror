Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB4C3F68F
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4442622B48
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqqTeyO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfLLTqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:46:33 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:32810 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbfLLTqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:46:32 -0500
Received: by mail-wm1-f46.google.com with SMTP id d139so4347751wmd.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E74JU8LkLWzYQuMU/Yj0F5w0G2k3dPMnipHP3jZk0Fk=;
        b=GqqTeyO61HGS1OkappnsEPh5kR1Qg+mZ40K/ShIPRHwT+K7bCSOBjX8yGd6/kMu4QU
         P6p54v9/8f0TW/ZUlLyK1cf/3g9te0Me7OKPpBPzvwtQpOF1BGpfPU7rU/4ZOYR8OWz2
         f0qeVlemMwfQNaHhl8J1wgNcQpzpie7sSXk13W4/0wNWwawca2TJZMXvcutaQqHk7oqm
         VKn9ohD+TH1seW9tL4dUMsqj9D4HhliIipQLgCN7L2ghqmoPjwNFU2iP4biZccBl3aZY
         QksQflx508gIpGHDBpkilHndNbu+VY8DJVB6Uj6mwcDLAsExEjf/8fT4Tw2XYrKDMKJz
         avwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E74JU8LkLWzYQuMU/Yj0F5w0G2k3dPMnipHP3jZk0Fk=;
        b=pwVokbJdzttIZ9mU5sDKbn/8+IsGomJT6zqnjXf9jvsHhkHGF0kTkt7c4nah3IguqR
         kg4sAhc3pYV+du1RE54xvfhMb4M+Oi585cJNrRDTJ4ENamE/6bWlbMPueVbM2xJxs8JN
         mVQ7DhmIFLkgShy5lkk3MyLkP8sFPQeCjevB1B5BiT1LlqHmvp5haRtYlHPOhOGBiMbf
         5PgOrmZHaxjFodNg9Nhkf+atG221rr0FMvi9eHlolKmlzRBY8Qyuw7UQJhRnJwzCLyS0
         hHYDp5Q8U9vNzT8nfBrGAQopVO+YM1mADprHxqT5kGHgdd2u9uzKCg/SrCeTVBBJ2xNt
         iPSw==
X-Gm-Message-State: APjAAAUyoZH/nUCZRtgEB2LXByq/kEltS5IIIsZuMPJh8IqdXLxXxLCK
        Yps+tabldhxGBda2AJKjubdYgas7
X-Google-Smtp-Source: APXvYqxrX2plUejIZFEfNwD/VPhiKOSdPaAGcHEXSW7wyUH0YP1Pr2T7xj/lOPeF0O2+4vL4JPEZZw==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr8273847wmk.37.1576179989737;
        Thu, 12 Dec 2019 11:46:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm7144370wrv.66.2019.12.12.11.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:46:29 -0800 (PST)
Message-Id: <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
        <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 19:46:24 +0000
Subject: [PATCH v3 1/4] git-p4: yes/no prompts should sanitize user text
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
  * promt_text is the text prompt for the user
  * choices are extracted from the prompt text [.]
      a single letter surrounded by square brackets
      is selected as a valid choice.

This new function must  prompt the user for input and sanitize it by
converting the response to a lower case string, trimming leading and
trailing spaces, and checking if the first character is in the list
of choices. If it is, return the first letter.

Change the current references to raw_input() to use this new function.

Since the method requires the returned text to be one of the available
choices, remove the loop from the calling code that handles response
verification.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 68 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..a05385ee2a 100755
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
@@ -4170,3 +4175,4 @@ def main():
 
 if __name__ == '__main__':
     main()
+
-- 
gitgitgadget

