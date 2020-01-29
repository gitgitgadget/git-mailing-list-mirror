Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B33C3F68F
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C187120CC7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df8Okftp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgA2Ded (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:34:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46918 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgA2Deb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 22:34:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so18458886wrl.13
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 19:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QexdTKdKJuL+pTx5o5eRbAL7OmbTHwZGa4FyVyeaTWs=;
        b=Df8OkftpPJRYC7DX3S+kIOKFOwd91v0BVb40HVYq6XhOPecYURP8mZfT1w8qLLMr3T
         z3AiBrWvSX6PTjgEPszTs9mzmep41URUCMvINZdHwXtbWBqZneDowMrNc9hMgEg0tm2e
         A9IhAXhL/hSm/pscHKyL6dp1lQT7slSSj7scxMnmfkPiUaJFnyipDMcJ3rVPM5WLvbxD
         cXT4w0DkCZhCUkv/2lSAxjolkQOrU4wxEYD2vKvUcO4PeODUjNcCJDd5dyf0opn4zarV
         ZgmW7tcpJjvv253uwOJJQl9zoIY7xuWXjOpfaIlr4hg3OvT0aE1m+YlY6vLzj9++QIix
         NQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QexdTKdKJuL+pTx5o5eRbAL7OmbTHwZGa4FyVyeaTWs=;
        b=JVoGiFXdBncbWTiuXU5/QNqrV1pWA1I++8GdYP0IvBUVjgXFHakkwOxgt6J1O6GTpd
         3MNmDJa0CWk8/fhuj7E3AYBv83dTUE1XO4ymF5gtz3/izVHQfRmdg/8drRKEHJINNKlg
         MCS1D+/oBWhkhPygpYNdOgUKRRsVGfWm2na2RhkqRXpywy8cUks9Oz7SsTBiCIgy7O2j
         ArdD5hxvSL39tL4PSw2wcFVPuuO3r+sKaeAAbFUzQaWiEuz9cFjPrAADmtAWNfekdpfR
         LC7I18St6SiRkmVkMRF1rR7/6hl8Dy4RqVK5SzU5pMMaVjoC/yGSElCBUuVCRbBFLYfw
         fzqg==
X-Gm-Message-State: APjAAAW/2bLiJGcsIybZGObYmkkTrfZE/Ouat0LRVI+r6pXo7wXsgFyF
        a8/NxrdbkMhlSx/TrYXDTk6N+fSE
X-Google-Smtp-Source: APXvYqwJ8O+A9QI2bpVCgFovbVgfobsWX6eh0HU5fV7Wp3alaiPbIizVV6vF+W4reEc38RVx4cqx3A==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr32925254wre.156.1580268869366;
        Tue, 28 Jan 2020 19:34:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm597932wmi.30.2020.01.28.19.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 19:34:28 -0800 (PST)
Message-Id: <975e65236890eff3fdbf0af5664903bf3ea6962d.1580268865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 03:34:22 +0000
Subject: [PATCH v6 3/6] t1300: create custom config file without special
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

