Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBFAC00454
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D295420637
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfm0/FJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfLJPXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:23:04 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42704 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 10:22:59 -0500
Received: by mail-wr1-f45.google.com with SMTP id a15so20520394wrf.9
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I8b8jus+gL9qTMtX2MUVL0s1hihf58yRSrMe9WY6y50=;
        b=kfm0/FJxiCgZhRw9z8OmdD6RRdCiUpryuRwNFS08bKejJS/ASV1DaMRB8ojHXlCts/
         q3tm+w0tDiOg38dv+lwuQLDgNjR9bJsLfo7EKL2JuaFY/fFd4iip0Ik7G4RUfQdR2mOV
         pBOpMLEpyaM+R8dICC30leBng2wRsf9b9SfrUhZq841CD6kPpgSbsGKeFb2P97olbI76
         1xz+ShIlo4/kko11xNfLRcJIl5nxYsyWBRuOF1uNLnehIjDf8Y6wgFssbI+MoMzAr6KJ
         zXh4oJoETPGlCxNnToZoW7eb4afA5t3J8BuNym+liGln3O+PPW70klKf23yHrR4iArDG
         gnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I8b8jus+gL9qTMtX2MUVL0s1hihf58yRSrMe9WY6y50=;
        b=qELMAQxQfH5Vs+D9gj0NcUOc7ov/86E1dY9RnDAlQkZ22G7ctJFyseuvQ/J1OCnM67
         7LY4lagiMOLo6buOY/7+xlaTZWvLZqG2Yt3mWg1LLre07Q+rrMF+ZXVWpjtjuy2jX6B9
         36VodhXOjdxl1L8IaXrIx8Stf9NclBECmncQdkUQb8KwzdQCQjdMkbzohFMqbscqcBaT
         V5fxaQ8xAmWtcG3ub98QOnBNWhAtPqd9Q++H8gwdeEQ/sFRGFtXNYI5ft6vi3u9xnXMB
         N/c/tFGjaJ75Ia5a7izw+eOuf1wKeuPtMBkVBBsRxVNRh4f7Ph+1fr7xa9FKS59NX8dq
         HkLw==
X-Gm-Message-State: APjAAAXKqCJAeMPp6IxswgKAlzQSoDmmE27cS++G9Fh+NV4cwXIR8cw3
        uerLa8iDEGv6TRP7Q0rWkrJY+9UR
X-Google-Smtp-Source: APXvYqwXo+4WgN98C0lJKbVzdAWR+5JxpfITw2F9WFTRPuU7D8w8FCqj+HnoHG1GbpWZRWE2/Sk3TQ==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr3840202wrn.140.1575991377282;
        Tue, 10 Dec 2019 07:22:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b67sm3548972wmc.38.2019.12.10.07.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:22:56 -0800 (PST)
Message-Id: <527b7b8f8a25a9f8abc326004792507f7fe5e373.1575991374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
        <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 15:22:51 +0000
Subject: [PATCH v2 1/4] git-p4: yes/no prompts should sanitize user text
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

Create a new function, prompt(prompt_text, choices) where
  * promt_text is the text prompt for the user
  * is a list of lower-case, single letter choices.
This new function must  prompt the user for input and sanitize it by
converting the response to a lower case string, trimming leading and
trailing spaces, and checking if the first character is in the list
of choices. If it is, return the first letter.

Change the current references to raw_input() to use this new function.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..0fa562fac9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -167,6 +167,17 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+def prompt(prompt_text, choices = []):
+    """ Prompt the user to choose one of the choices
+    """
+    while True:
+        response = raw_input(prompt_text).strip().lower()
+        if len(response) == 0:
+            continue
+        response = response[0]
+        if response in choices:
+            return response
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -1779,7 +1790,7 @@ def edit_template(self, template_file):
             return True
 
         while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+            response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ", ["y", "n"])
             if response == 'y':
                 return True
             if response == 'n':
@@ -2350,8 +2361,8 @@ def run(self, args):
                         # prompt for what to do, or use the option/variable
                         if self.conflict_behavior == "ask":
                             print("What do you want to do?")
-                            response = raw_input("[s]kip this commit but apply"
-                                                 " the rest, or [q]uit? ")
+                            response = prompt("[s]kip this commit but apply"
+                                                 " the rest, or [q]uit? ", ["s", "q"])
                             if not response:
                                 continue
                         elif self.conflict_behavior == "skip":
-- 
gitgitgadget

