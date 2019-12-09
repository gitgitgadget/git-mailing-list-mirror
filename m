Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA62C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933F220726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPIA0iV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfLIOQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:16:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38219 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfLIOQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:16:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so16392011wrh.5
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z6cfkpy0XYOK6kEsOlgEccbPfpxqqKqR4uKSe3tKNCw=;
        b=ZPIA0iV5aNKth6DglbKX0S8yDUQFCLu4MtCIQ/9uyENZr2tiLxsmKBlRG94EIuhNFN
         hn04BTxYLg8hKhmcNlMqhKeUynp/BY4b6gyqHzYSn1uO1MHr6l+3xUVNKN7uAd1HOZTY
         ksDcm+NifTUHY6UqoV+wROpv9bfhvhS+DzaGixgCIfBoTm2uPITcMxfYgoH0Q7nVp+kW
         8vAVlIqwfFhMh1qHpdVXNGgExntzn9A7V8bOl+S2WnsNgBC2zURDCWaDgStH3Ubzbv2v
         wFDwTy7LPvMcklq4hpCZ3YwZ9YPPmFJue3CVoCxqRUl882QlrtCBAFwUJ0VlkZistejx
         4L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z6cfkpy0XYOK6kEsOlgEccbPfpxqqKqR4uKSe3tKNCw=;
        b=Zb7rB5/WSIt/OuIuEj+ydA4ZfNlr58r5N5HRy82g8TioTCO96cHYH2fwgZSuoZbYMy
         zmpBGmlJDOCKOK6IhBZ1naFjtt6pGzlRIA+1qZ5NdqJD3mD5aLIatLFJnPFQvCavTM3k
         zoz7v2GxsT3lgnNnxQIyxIJnl1ZFkIogYOLIqyB8xqemTwc6rO+FYVXZHJ2wsKKCI9FR
         ionR2JHNVAXSk6OnuMy4JfgNUUsYff68K4QaOYIM0tb1x9E85kHx0N3/ILla9bzynZqH
         Pmhhnz0x3gmN7KYMgc95bMBaQuIu93+ypjyVpVqCFFwU668WSn6b2YZIf+DRgfY18DAP
         dBYg==
X-Gm-Message-State: APjAAAVG/zEfSVx/jLZN2M34IKY+tM9XyytKiIuKksPLyapQ9Owcg06K
        rEvJoGzJRMOm9YvG2Iz2CsCfRlIO
X-Google-Smtp-Source: APXvYqxOhHx+PiPzrTWXTXzsEVuRxhG9xQS9f3pmuxW5sAkqVkUF7AMiL7CYfY3fzLmJe4Aoutf6eg==
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr2259979wrx.253.1575901013319;
        Mon, 09 Dec 2019 06:16:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i81sm9025373wma.10.2019.12.09.06.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:16:52 -0800 (PST)
Message-Id: <2a10890ef76697dbdd67b4c416077726100f88be.1575901009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:16:49 +0000
Subject: [PATCH 3/3] git-p4: [usability] Show detailed help when parsing
 options fail
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
index 856fe82079..cb594baeef 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4166,7 +4166,12 @@ def main():
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
