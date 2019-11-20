Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0010C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7203208A3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMe8Moc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfKTVSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33354 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so379922pgn.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJXJmnDX+/pFKtuG+4GW4W7xq7LilAaK4zOcCJ0XC9g=;
        b=tMe8Moc15Mq0V4F2E3nmD9Gvlf/qYptysKKX18cPs9uyhBnK7sRFhDOIiPHnPYA25Y
         TKo5+RREfK+P3uSpaVkNc5oN4WxlEpmKRF3uQU/Fj+YqsWJsbxzszbHvIdNML1dcNsIV
         GJM//FIAE/FCWUg82IrQYs5SYO6mac4sGKmE1N1Jb6wX+B/ie2IgUHzqFM3GW63faDOT
         W93p8uNWj12bMG8YXB6u54h5eVr5ZClk8F2iocX1DSZTigkgmK0zIZVKOCk/DoS9Uc3a
         9CQH7ELGPRQZtFxLe3sMVEDGIczCMuJr+vQgdSt4QyQFylcuWsJ9r9AxXJq7DrXa20A2
         Xxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJXJmnDX+/pFKtuG+4GW4W7xq7LilAaK4zOcCJ0XC9g=;
        b=OAV/7hBKG3d7B/X3Gaov5P6HjQHPM2+v7rpNFREwk7vTJVowq8bE84D3E4KryxTCkK
         PMvB1HUsBXqTcf78i5uSNbdDBqa7nwIA7VjNx3m/yXUDsk2L7C0U+o7RQE49+nO4UEJp
         gcn3PZ88EN41Qp5IUQ3D+gYR7l2RVwKTM63fJ/0r/pqYToWDmT3G/buBp09KO+u518SR
         X0DrOaMXiFBO4UE+LLTiTrvbEBMPLz2V9oMF2nuyaSHV2UluSSs5XkozYiXqzLEj2f1E
         jgvwqjMui59V9O8qJUiRWdKN7tlDV+cILAGnk/kYKTVQDA6dHcnvdxr8fWUJvE09Krd4
         1TtA==
X-Gm-Message-State: APjAAAXAjJHG3efyQl3xjatFN6ah0L0gE0VMr/Iv52vYpq/5N9Gpjw+/
        XIC9gRF8WDrHUUZI2ALz8RA3TgyP
X-Google-Smtp-Source: APXvYqwXbvDLt7Va7sisZV5S7bDFM/j3793jZBvnlVym4F0MHfrF2b2sXnJb3PZauHFVT0C4jdAh3A==
X-Received: by 2002:a62:8705:: with SMTP id i5mr5600897pfe.238.1574284711130;
        Wed, 20 Nov 2019 13:18:31 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 21sm299179pfa.170.2019.11.20.13.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:30 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/10] rev-list-options.txt: remove reference to
 --show-notes
Message-ID: <e1b023a6fc2818f871e3033bd21f72a2de7b7a21.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ab18b2c0df ("log/pretty-options: Document --[no-]notes and deprecate
old notes options", 2011-03-30), the `--show-notes` option was
deprecated. However, this reference to it still remains. Change it to
reference the replacement option: `--notes`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 90ff9e2bea..311bc06a9b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -58,7 +58,7 @@ endif::git-rev-list[]
 	`--all-match`).
 ifndef::git-rev-list[]
 +
-When `--show-notes` is in effect, the message from the notes is
+When `--notes` is in effect, the message from the notes is
 matched as if it were part of the log message.
 endif::git-rev-list[]
 
-- 
2.24.0.450.g7a9a4598a9

