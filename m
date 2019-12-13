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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B515C50726
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD4D24779
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds2quPmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfLMN6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:58:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37512 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfLMN6G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:58:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so6667010wmf.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CrcFgAOSLMt24NNawc3MVnI7liTnEq9Ggfv8QAET1f8=;
        b=ds2quPmBft6WDqhDsVKr1NNezV4NwHMRECAjCyCy2kE5vrnBmViUAaNbCjI0up/vmA
         EEZg0vyiI1Q9fHwMYMxRhQnW+SDCJ3NtAxC9s4Ml92a3yEmWgON61lV5/C/8D84PQshq
         W64z7IyXEttqL+9Pmz+eEsTcF7NZsSuJuqGE8QctgZZI0BjULSgd6vbR6mVud/2/+Ybg
         Oe6wxrDzXysrhRvsl3OqnkIS2JLwCBBRaff2Ngh4sXDuSTam1ai6vY0Tinb+KDeqBfA9
         MEB9fAjXq5Ki3X1QTU2QQW3Qs+/3JsQ2A1zaC26YO22/7n8KYIosd4hq1r2HBJjnq5/h
         6+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CrcFgAOSLMt24NNawc3MVnI7liTnEq9Ggfv8QAET1f8=;
        b=HJ6N5gfCUaMFUEAix588GM4yWHm+FowKGbXLdt/DRqlhpIWuBJXAeH4T/DNVP4lmGw
         VG73NLO21Dl42vBUMF4169VRvzr4gcTpjo6pGB+Nq7v/PI1EBu0AP3gaAZdn2lVSPhiv
         +HnKvVbKuMjX7UHDeqqP3K+Duay7BwZJvJgpApIYUmHcA+DYocUXjsOxHuMLYP4FHoFK
         Z2wSz4KwipXKiGPDrqHEosfsa7CvBbep5oxN1IgDeTt3tYH4SBvf473GQtUJcfVDjOxY
         0X+NvZ4zOLJEF9HwDTWj3Q3h7EJ+Oow498Fzte7XhNUoDPzx+0YPtwjKhkAOwDuj31KW
         Z1hA==
X-Gm-Message-State: APjAAAXsbChCdZJC2tB50UQR3Hy2yRVQFNGujpGLbHWwx3wn147iUJ2a
        nkl54ERbPMeWLiY52tuzI3ticTbw
X-Google-Smtp-Source: APXvYqzDL2LEonMdAGl5bL8dfXSYaHlZKW2QTjK7DB2ysqih9ginNNHDYNNtczCMbJd1Gl4RqBRI3g==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr14176102wmc.54.1576245484438;
        Fri, 13 Dec 2019 05:58:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm9944084wrt.37.2019.12.13.05.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:58:03 -0800 (PST)
Message-Id: <bfdd3dc517c01e1e27be017b87de5e22b2525920.1576245481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
References: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
        <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 13:57:59 +0000
Subject: [PATCH v4 2/4] git-p4: show detailed help when parsing options fail
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

