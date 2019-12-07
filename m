Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01AAC2D0C3
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972DD24673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrHg9MaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLGRrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:55 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34714 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfLGRrw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:52 -0500
Received: by mail-wm1-f54.google.com with SMTP id f4so12115203wmj.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X9OallQF0hIpgkeVK60DD1vy4QlaqOZC2W/XfzNZN08=;
        b=VrHg9MaWzsCvCInBk5x6XsQWKhsR5M8Lo44DZp71dKxfYW4bAOdPvZ0l9KyXxUK+Mf
         IkHZ4kXKejOmdcCYPaHaHlY0n7YhTUmOeu+0Ej/l/2fRGK7bel43IqMGVPTTDi6H3CSA
         bK6AxQVdPB4LhKI5cyBR6ZHdLtr/JCDFtfg0q3M4bSl2ErtN1hFXDx4s0XJqCt9r/icy
         eKSW8xTz5Pe42uD/lKb/ismJq+MmLSq4UtrgKSc8UA4fbYBgMWVRKdOT0zLMgi1HuNVY
         HwSC99ryVNZGc8QEz0+YsGA8lgQ4Si9ca34fl0hkrIH2eyaDB17I6ZbmrqFQ4zyzQ7Vs
         Izsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X9OallQF0hIpgkeVK60DD1vy4QlaqOZC2W/XfzNZN08=;
        b=pjvOR/lXudNTtAwO6MpBb3Gu2cCwZSNTC6vWovDBxTHLoahU7Ra4VOi1aVvnO2v7z5
         iEr15WUCu8/FS0KRtvP7xcQoOQzTZVRsHJpO2VM9PpRnyk5eDoBzvVlMsz/9aQ/Nnrkt
         k85gE3epe8uEaldw02NhM74MS6r+3DUfvOX7kmaGEiIkMfqTkyMfhBkmceDFsRUaaUAG
         qnYGKRgt/dMSG9mobuTUcBXMV0WIKw4YNDbcrPL68Ma0ioAHymKkWSRAAgP0dpuBatyu
         do+rhMNi6ru7MrEdGwsjLVS6JVqtm6QCxdJllQfkDzNDb3ttBSThnazs9gAojwbKnla1
         lqyg==
X-Gm-Message-State: APjAAAV7Dn0thwg9UxncYLTU5dyyP4jCJvHBCGSfaeJXpogMIFQw2gcT
        tyecUlsSoSoXInuTepHbwjJEKdEU
X-Google-Smtp-Source: APXvYqw8SMO43YdtbSe+HXNoXVyl4h0dnVfKtTRP1LwaDwxdakcBzAeoynJz1MEmgiqOdJHXXgCVgw==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr16606850wml.107.1575740869639;
        Sat, 07 Dec 2019 09:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm7098876wmf.28.2019.12.07.09.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:49 -0800 (PST)
Message-Id: <e28fe095b41753ecf57c21984913bc2a26f7aa53.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:34 +0000
Subject: [PATCH v5 06/15] git-p4: remove p4_write_pipe() and write_pipe()
 return values
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

The git-p4 functions write_pipe() and p4_write_pipe() originally
return the number of bytes returned from the system call. However,
this is a misleading value when this function is run by Python 3.

Modify the functions write_pipe() and p4_write_pipe() to remove the
return value.  The return value for both functions is the number of
bytes, but the meaning is lost under python3 since the count does not
match the number of characters that may have been encoded.
Additionally, the return value was never used, so this is removed to
avoid future ambiguity.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index cc6c490e2c..e7c24817ad 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -171,6 +171,8 @@ def die(msg):
         sys.exit(1)
 
 def write_pipe(c, stdin):
+    """ Executes the command 'c', passing 'stdin' on the standard input
+    """
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
@@ -182,11 +184,12 @@ def write_pipe(c, stdin):
     if p.wait():
         die('Command failed: %s' % str(c))
 
-    return val
 
 def p4_write_pipe(c, stdin):
+    """ Runs a P4 command 'c', passing 'stdin' data to P4
+    """
     real_cmd = p4_build_cmd(c)
-    return write_pipe(real_cmd, stdin)
+    write_pipe(real_cmd, stdin)
 
 def read_pipe_full(c):
     """ Read output from  command. Returns a tuple
-- 
gitgitgadget

