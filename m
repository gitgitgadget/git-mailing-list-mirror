Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1244C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9579420684
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egEl1xeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfLPOCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:02:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43789 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfLPOC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 09:02:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so7374651wre.10
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CrcFgAOSLMt24NNawc3MVnI7liTnEq9Ggfv8QAET1f8=;
        b=egEl1xeAz3f1R0GOtMEXi3LoS7OVyAHzHxA5mwqM4ZJr6wOg5gQ/PirDrz1eQYFRKo
         SjrCzmRX8ZLG3Nxt3hbKguz/xSsLKyfN70oBLn/oN0ZTjBquf+CqwuzFQ8OC3Zm6x3TH
         VwYB+Kyl8c/OuoLbf0hM5swR8V3dnRIbmKq81umx4UIntIYqWhfzofwL2QrZnjuM+0Kb
         4F+OiIIgsC1Zv3+YAFJTZSB17aod/A6BunUgvC6IsTWzITH1QkeoLb/l0o7YaBr5GG9U
         fz9+IFh9pbEA1YGLVMso60saDbnUEaaA7NzaqugNoEMH++7roND+Nb2qk98qB/jB0E+6
         lD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CrcFgAOSLMt24NNawc3MVnI7liTnEq9Ggfv8QAET1f8=;
        b=YT2KvhgZ2Kk+l6MtVqCg7VT7l1Lv4j+bI7+ITDQxq+bIIVQlebu/5g5Ka9FZdAHEoF
         QRhOkGoKteW25bkSa1zVYDv+s70YY1yBrmEBkDfsLBovFz0hkr1ct10u5u4T5BBR92Sf
         MDb5A2tbxWk9dkwUdUsTGuUt6OuYkSlc6XjT6QxlmIkpb4FFpCwiEl5Trqjpx+QapGJQ
         Gz20YwhGKOOmbytv9gvu08HNJMTEERoJachcfrtoip9P3BWhCEl/t1kbja420o9oh2EK
         gIryxZpJqvYhDX19i2BXGqR5zPp/cFDYIE0LvhM/VDRgCVlejuMtuAYf1NWfTKPAd+D9
         z31A==
X-Gm-Message-State: APjAAAVuZscZktnhD1V8SdoZ3Xj+j3UUIUe55hoQ2QxT3RnjvvIg9zPE
        1+BRMbpCBZynykFr7BSqb/Yb4ELe
X-Google-Smtp-Source: APXvYqzuAhL8IyLuLjZvSciPj3SL5I5DoEPiNn3LsC7Q7ZyPHj5g8UKB+8SrNPY4e9e2n7UNDC2w5w==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr29218709wrs.363.1576504945198;
        Mon, 16 Dec 2019 06:02:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm21968380wro.77.2019.12.16.06.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:02:24 -0800 (PST)
Message-Id: <4960d1fa223fc00def148cdcade46855e0772a20.1576504942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
        <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 14:02:20 +0000
Subject: [PATCH v5 2/4] git-p4: show detailed help when parsing options fail
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

When a user provides invalid parameters to git-p4, the program
reports the failure but does not provide the correct command syntax.

Add an exception handler to the command-line argument parser to display
the command's specific command line parameter syntax when an exception
is thrown. Rethrow the exception so the current behavior is retained.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 3b3f1469a6..9165ada2fd 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4145,7 +4145,12 @@ def main():
                                    description = cmd.description,
                                    formatter = HelpFormatter())
 
-    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    try:
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    except:
+        parser.print_help()
+        raise
+
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-- 
gitgitgadget

