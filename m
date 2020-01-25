Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E5CC35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336DD2075D
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOpjNELE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbgAYAjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:39:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33558 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbgAYAja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:39:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so4214153wrq.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 16:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vzbm2jbZgmjXl+MHBE3DtIUgRyeqxuVjjO8cWWLto1M=;
        b=LOpjNELEv6hc6m63kTWnulj41S3evdpBy0+Yqj429U8wKJkhqWNBMECz9MckQEnZnW
         XqxVxw9kkLdzt+c37u6GRophzcOeG2qXiUUxZzVmyNHYcV6u6Xes7/L5aSRmlEt5e/6F
         nYytj526Xpw1VZgLVhg+cc/UUIJSaP4mveSKotPiiaKxHaOzPu73788gxAl0+QUldvGC
         WkRmp0RFLJkTjq2YG5t2h0vll6ZUoiqgUohIU00tLZcvxGrJ/fRfYbkuuzZ7F6d3zrsW
         wEBTG6zFATerG2WwMkoIER3cmKKpJptkW9ij1CZ4n2v2M8//wmfmPnhfMPbwKdXN0XMy
         0KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vzbm2jbZgmjXl+MHBE3DtIUgRyeqxuVjjO8cWWLto1M=;
        b=oeNCl2RE70zSEm9YX0s29lH3BmrYqDEdL+MNgT3Y+guUnPmHyP8y+emltc/Ovgu5Ty
         ILKtFPvd8W9CB7vQ4N4VDnfrWhmtjiA/dlc//yMuxYesCXWWQDiH52VQfxERJJo4MHXa
         NDUdXHKm0vt1NpPOdR+FNre0doJxP7Q1Tk4lk7sFe/wAsvREkqRVd9jB/kCFYX/f86x5
         LXy3G0Cccx0ApJ0Rm2UgTHhH2vNafnaYhJfa9ZduxQwzVCDXQtQAc7lOy/G5MRLxFsIY
         dkbErYc+9NsPIyVkBIiMSSJyUS0XQhC4DTG+7k2xnXb2xw7ab/3JOZG+T45MzbbcBJDR
         ZQiQ==
X-Gm-Message-State: APjAAAUQpoS8vA31Ton7GWWKIRs8MDQMYgv1t/iMSdOPMGbq5SYKh9+L
        t1pPZUpoIevBVD1dZektWX2YLjkA
X-Google-Smtp-Source: APXvYqx+2zJ7N8y+NbkGzzQCocaMVrigFT4btrHwiv8eA/aDsWqpK5m7HY7fgPMBK8WGrnqxwjZMBw==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr7447240wrp.2.1579912768659;
        Fri, 24 Jan 2020 16:39:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm9772379wrn.78.2020.01.24.16.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 16:39:28 -0800 (PST)
Message-Id: <9d19794dfd667b3f9752f0e8118dc9eb0c8f59f1.1579912764.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
References: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Jan 2020 00:39:21 +0000
Subject: [PATCH v5 3/6] t1300: create custom config file without special
 characters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Tests that required a custom configuration file to be created previously
used a file with non-alphanumeric characters including escaped double
quotes.  This is not really necessary for the majority of tests
involving custom config files, and decreases test coverage on systems
that dissallow such filenames (Windows, etc.).

Create two files, one appropriate for testing quoting and one
appropriate for general use.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 t/t1300-config.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e8b4575758..e5fb9114f6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1710,18 +1710,23 @@ test_expect_success '--show-origin getting a single key' '
 '
 
 test_expect_success 'set up custom config file' '
-	CUSTOM_CONFIG_FILE="file\" (dq) and spaces.conf" &&
+	CUSTOM_CONFIG_FILE="custom.conf" &&
 	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
 	[user]
 		custom = true
 	EOF
 '
 
+test_expect_success !MINGW 'set up custom config file with special name characters' '
+	WEIRDLY_NAMED_FILE="file\" (dq) and spaces.conf" &&
+	cp "$CUSTOM_CONFIG_FILE" "$WEIRDLY_NAMED_FILE"
+'
+
 test_expect_success !MINGW '--show-origin escape special file name characters' '
 	cat >expect <<-\EOF &&
 	file:"file\" (dq) and spaces.conf"	user.custom=true
 	EOF
-	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
+	git config --file "$WEIRDLY_NAMED_FILE" --show-origin --list >output &&
 	test_cmp expect output
 '
 
@@ -1747,7 +1752,7 @@ test_expect_success '--show-origin stdin with file include' '
 	test_cmp expect output
 '
 
-test_expect_success !MINGW '--show-origin blob' '
+test_expect_success '--show-origin blob' '
 	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
 	cat >expect <<-EOF &&
 	blob:$blob	user.custom=true
@@ -1756,9 +1761,9 @@ test_expect_success !MINGW '--show-origin blob' '
 	test_cmp expect output
 '
 
-test_expect_success !MINGW '--show-origin blob ref' '
+test_expect_success '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
-	blob:"master:file\" (dq) and spaces.conf"	user.custom=true
+	blob:master:custom.conf	user.custom=true
 	EOF
 	git add "$CUSTOM_CONFIG_FILE" &&
 	git commit -m "new config file" &&
-- 
gitgitgadget

