Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC04C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C9120637
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 15:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJZ/d2G+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLJPXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:23:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38594 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLJPXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 10:23:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so20568278wrh.5
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 07:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FBAOdDPXQT8RIvWETg0jbhbh0C+4swdyuA4nLPlM7pE=;
        b=MJZ/d2G+1paxdmVuava67jCkErEF3Psg80+HLTgk9dw0wwo7PyXFZWABUHGmxABTr/
         uYQ/DIzBniVLE5EJ9Ozw3qEr46EA4pysvDJmgdXpjpfzubYprk42OTl9sWe9GuiQ7PWN
         ZaA8BsoQJxqHgdQ0bxaagqhGlMmDNstxJ4sEkWLzU+8twj2TmXBkpwk+Yzb1MKjEvapm
         r2J0W5TMi/tmR03ejvNDwR9ObfXgzQ3VL5h8lEt8zGUNBFWIFPhG6KjPYB3NXOXhj3mR
         lHD+xCMc2NH6kGjAWiW4XtoPJwyb5m3v2lS5MTNAVkbwSWz3muDLEri4uZFkPhta+Id8
         EmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FBAOdDPXQT8RIvWETg0jbhbh0C+4swdyuA4nLPlM7pE=;
        b=ErXzW50WDCbUQGPXFQdHn3DuZFjfgKe+3uxxbLFVxRBGnVoHlCLk8xjemXb1wvM+oj
         WyvGiiI5Vg1ewU0nMqCYW9jA6AiIF/VO0TvQtTrqSOufYJskx0v+VvVNyAPP7h4jQKd3
         xZl1HdZC/4NbcvVwnBiGaMqjL3Wm4od+2aSI9rAVkhXMzb5kjIARWX3zt62jxjV48DIX
         oRPPPuz8xf1YpZBlTclfUy0WbErkIo8zFKaZWWa/qW+5tTAsOHexgduF1GYAg3Lsi4nk
         oW8Uo5JUsCUPbai/E5T5rdz5hycNeqH8ZogfoP0FB+FXwVW5s+jTMpane7JGcpJpwsMD
         m1Cg==
X-Gm-Message-State: APjAAAUmvDY+mfEAr+iuxOMCnBn/pkf4fnS2YiThw7KKcU+uPBux1Qn8
        /28EwgILmfesbJkSad3TRlWlVcqf
X-Google-Smtp-Source: APXvYqwSuV7pa9raVAhReLgTzNlt7jeKLxtKDwRkJ1pA7HkjrASHbgPDoXxtYZGwdUPLkUfrhhnSVg==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr3643989wrs.20.1575991378607;
        Tue, 10 Dec 2019 07:22:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm3693608wro.67.2019.12.10.07.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 07:22:58 -0800 (PST)
Message-Id: <20aa557193c14292a31f91a93a5a8f4ea3ff332b.1575991375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
        <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 15:22:53 +0000
Subject: [PATCH v2 3/4] git-p4: wrap patchRCSKeywords test to revert changes
 on failure
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

The patchRCSKeywords function has the potentional of throwing
an exception and this would leave files checked out in P4 and partially
modified.

Add a try-catch block around the patchRCSKeywords call and revert
the edited files in P4 before leaving the method.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index daa6e8a57a..174200bb6c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1950,8 +1950,15 @@ def applyCommit(self, id):
                     # disable the read-only bit on windows.
                     if self.isWindows and file not in editedFiles:
                         os.chmod(file, stat.S_IWRITE)
-                    self.patchRCSKeywords(file, kwfiles[file])
-                    fixed_rcs_keywords = True
+                    
+                    try:
+                        self.patchRCSKeywords(file, kwfiles[file])
+                        fixed_rcs_keywords = True
+                    except:
+                        # We are throwing an exception, undo all open edits
+                        for f in editedFiles:
+                            p4_revert(f)
+                        raise
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-- 
gitgitgadget

