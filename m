Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39FDC433E7
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A3E2083E
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0gsMXVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgH3WBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgH3WBb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 18:01:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB3C061236
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x9so3641836wmi.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eIlaYX3lT7GN4nnWu+Fg9tJR3gwdveb7QzVhDnDD6t0=;
        b=L0gsMXVhsxYuqZ098vct2T3Oqb/m9x4H3nIUomz2GcBPcmUbkgVAlsXZf/k1Be2lko
         yVJGVS6+P1siVvT6Fpcejc+dQUwLeprpUz6c+E8vaRTTxZu7S03mLekDW0RP6zH/mxFG
         +9fdTn2yAMBPjti/qFlP34MNuC7k9HiTtQXxG8rQlhDCsNH22/Lbf4nUWPrxq/qfJON6
         cI/wRRpUhvmPZHfk0Y4dVtLi2dxFfjC1NLPtBcqka/A8U9uX2g5411hRLZmv0eexoPis
         JRdNzCaIzpsdLyBcJ1RXOyEDp/gAcN51WLvYV1iwAqJIzfWfOnGkLS8CCFDBsRNTB84v
         yt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eIlaYX3lT7GN4nnWu+Fg9tJR3gwdveb7QzVhDnDD6t0=;
        b=T1kpu0bD6UUuuHIS2L4gdXf/jFNL+ZWRJHQqpg0mGOjxjoLbKuuJ2VDyfQ9957rZIl
         gd6L7xQ/GkL8015S9SSOODy81NbZHLMs25JbbhrnUnmF88q2CJdAj2jt92mBGHo9nymK
         UheK9par7JRiaFbDBLy8QcGf24mXqkGuIgJ/XLvcKlUigl6qr1mzIGl1TIrue0Tipp4P
         bZziMZUL7oi2mghZUVl/jRT/DBMtdzM7/+Bt0EoazWXbmrcbRdyA39bYPj6e+ZIhZSS6
         qdb7uW3LnMeZMjvxb+C4zm3guFx5Mk9EVJ81F+gx1Spp7IxEIAg43U5vl36JUvSAkfWI
         Zjcw==
X-Gm-Message-State: AOAM532JDXLV2TL3DtN6ktMf/OpxHZ2f6BLg5tQF4ZV8k612bQqY/hMj
        ToRJLUz7YMbL++TI9sCXOCcvbKBqVTM=
X-Google-Smtp-Source: ABdhPJz/2P6c3KoqMRNW2tMg7ZX+uxTZwb5r/U2+t/6IKMfoxbibdUQ4tZU/G1172F6G7/XYl/ImAA==
X-Received: by 2002:a1c:2903:: with SMTP id p3mr943296wmp.170.1598824882885;
        Sun, 30 Aug 2020 15:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8sm8990017wrx.79.2020.08.30.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 15:01:22 -0700 (PDT)
Message-Id: <3a9b82839e47d974a1a37e77dd10a19daeed5d94.1598824880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.715.git.1598824880.gitgitgadget@gmail.com>
References: <pull.715.git.1598824880.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 Aug 2020 22:01:18 +0000
Subject: [PATCH 1/3] git-imap-send.txt: don't duplicate 'Examples' sections
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Remove the 'Examples' subsection in the 'Configuration' section and move
these examples to the 'Examples' section. Also remove the 'Variables'
title since it is now useless.

Also, use appropriate Asciidoc syntax for configuration values, and
capitalize 'Gmail' properly.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-imap-send.txt | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 65b53fcc47..0a00a1236b 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -51,17 +51,13 @@ OPTIONS
 CONFIGURATION
 -------------
 
-To use the tool, imap.folder and either imap.tunnel or imap.host must be set
+To use the tool, `imap.folder` and either `imap.tunnel` or `imap.host` must be set
 to appropriate values.
 
-Variables
-~~~~~~~~~
-
 include::config/imap.txt[]
 
-Examples
-~~~~~~~~
-
+EXAMPLES
+--------
 Using tunnel mode:
 
 ..........................
@@ -93,10 +89,7 @@ Using direct mode with SSL:
 .........................
 
 
-EXAMPLES
---------
-To submit patches using GMail's IMAP interface, first, edit your ~/.gitconfig
-to specify your account settings:
+Using Gmail's IMAP interface:
 
 ---------
 [imap]
@@ -107,14 +100,14 @@ to specify your account settings:
 	sslverify = false
 ---------
 
-You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
+You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
 
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
 
-Just make sure to disable line wrapping in the email client (GMail's web
+Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
 
-- 
gitgitgadget

