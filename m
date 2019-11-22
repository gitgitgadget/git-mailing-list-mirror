Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE1C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4A520715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTfpaQkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKVOlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:41:14 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44689 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKVOlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 09:41:12 -0500
Received: by mail-wr1-f51.google.com with SMTP id i12so8852832wrn.11
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/MnVEB2vVWXY7yuhnRkFNN58n/fRZWdgF5EQrDV7bk=;
        b=QTfpaQkgTzAkI0/A1U6FuabB9PnVyssMQEcLsXGYuu3wcEbWX/OYrtMAs0tEmO3ie6
         l9TGwITb1MDVB0OIIvYkwW3nRDMr/CPUGyrWiRjrrWvrU7XBi7sOUh4UGdPy7Bj8Yd/+
         i4Pew0WQMlNoiFcrpVY8UbXXpjZYEMN3p1wdB8+JaLQm4ElW9FuemZaXBELXt5Ntdgw1
         RrHBRfpqWR4IWXPySG+SGU3j9P6HQAQqy2U0jsXu/mbp3HBo3dnKgs2APQICINiN6V6M
         XMAsxfPOofIMbs5N9k3nLqeI4hCPgASLbER1cbNPFQLjn1EdM4xjNB8Rp6yFp0ieJyQy
         0TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/MnVEB2vVWXY7yuhnRkFNN58n/fRZWdgF5EQrDV7bk=;
        b=UmJLl/4kxuhAuKXBX1smAhFzMqdPhCRhosufNA49wg1Tl3LlB6CTQK1CYM9VPynxZs
         D+4Oq7HMQkJsRnJHfE+QqF4EVMSUtuZCPR8gjERVHLTzVioA66nzRSAeHkZfOSrW2J06
         LbRNFZNWjxhSc1ut4yl+XKS7zdrCUlkyhcmiRP4cx6Ht361rP8wI3qBenttayRtKC55Q
         kQFK+6FayJ7xBV/XyHmve7I4Wi4PFeC7CC5MwxCZdT1dFxn5ypA5O2g1CdYK/s49DvKU
         5wt4Fn9SQa+m39f/WGvQvwa7CuAMejuZ0rERtCDm8AWMrYP/wd9UeCDY8pC1gVmTVJA1
         +iEg==
X-Gm-Message-State: APjAAAWed2/sJslcWxkJ0ssVLEmolwE9Twt7tlGsEquCJs1Z2QXvWVlU
        hFrflBIoQRiAqQotzdAJMu74G2o9
X-Google-Smtp-Source: APXvYqyPwv4c/rd+D3mNTb/eVoVQ+gNsGkW623NNAhQCbnAw1CB6sCZH6GwafWGc9ebEa3JUrWXcIQ==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr17467179wru.242.1574433670123;
        Fri, 22 Nov 2019 06:41:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm6430902wrs.24.2019.11.22.06.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:41:09 -0800 (PST)
Message-Id: <85adb04e3d9a7a79e9b24ea50be71ac55dff6f65.1574433665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 14:41:05 +0000
Subject: [PATCH 4/4] mingw: restrict file handle inheritance only on Windows 7
 and later
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Turns out that it don't work so well on Vista, see
https://github.com/git-for-windows/git/issues/1742 for details.

According to https://devblogs.microsoft.com/oldnewthing/?p=8873, it
*should* work on Windows Vista and later.

But apparently there are issues on Windows Vista when pipes are
involved. Given that Windows Vista is past its end of life (official
support ended on April 11th, 2017), let's not spend *too* much time on
this issue and just disable the file handle inheritance restriction on
any Windows version earlier than Windows 7.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/core.txt |  6 ++++++
 compat/mingw.c                | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 852d2ba37a..ad4fa4dccd 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -559,6 +559,12 @@ core.unsetenvvars::
 	Defaults to `PERL5LIB` to account for the fact that Git for
 	Windows insists on using its own Perl interpreter.
 
+core.restrictinheritedhandles::
+	Windows-only: override whether spawned processes inherit only standard
+	file handles (`stdin`, `stdout` and `stderr`) or all handles. Can be
+	`auto`, `true` or `false`. Defaults to `auto`, which means `true` on
+	Windows 7 and later, and `false` on older Windows versions.
+
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
 	a delete of the source are used to make sure that object creation
diff --git a/compat/mingw.c b/compat/mingw.c
index cac18cc3da..2b6eca2f56 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -212,6 +212,7 @@ enum hide_dotfiles_type {
 	HIDE_DOTFILES_DOTGITONLY
 };
 
+static int core_restrict_inherited_handles = -1;
 static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 static char *unset_environment_variables;
 
@@ -231,6 +232,15 @@ int mingw_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.restrictinheritedhandles")) {
+		if (value && !strcasecmp(value, "auto"))
+			core_restrict_inherited_handles = -1;
+		else
+			core_restrict_inherited_handles =
+				git_config_bool(var, value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -1398,7 +1408,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
-	static int restrict_handle_inheritance = 1;
+	static int restrict_handle_inheritance = -1;
 	STARTUPINFOEXW si;
 	PROCESS_INFORMATION pi;
 	LPPROC_THREAD_ATTRIBUTE_LIST attr_list = NULL;
@@ -1413,6 +1423,16 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	const char *(*quote_arg)(const char *arg) =
 		is_msys2_sh(*argv) ? quote_arg_msys2 : quote_arg_msvc;
 
+	if (restrict_handle_inheritance < 0)
+		restrict_handle_inheritance = core_restrict_inherited_handles;
+	/*
+	 * The following code to restrict which handles are inherited seems
+	 * to work properly only on Windows 7 and later, so let's disable it
+	 * on Windows Vista and 2008.
+	 */
+	if (restrict_handle_inheritance < 0)
+		restrict_handle_inheritance = GetVersion() >> 16 >= 7601;
+
 	do_unset_environment_variables();
 
 	/* Determine whether or not we are associated to a console */
-- 
gitgitgadget
