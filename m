Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE051FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932090AbcLCAbG (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:06 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36341 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so55136586pfz.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k3oSnnSPDS8aSpcgSX5pUmeikl4h5SoIDwUWsCX58Dg=;
        b=cTTWoDxhRt3pocT0uNvAFgfprGNaOhME/iIuInVZeFBlVQjGJ6B+B0N3FvoMhJqWcT
         tZABCcA4yyXAgcRnYX4lhDaLepbrR7JEZ9X2PmJeNLsNpl7N+rPAQSzsTgUDzluYf+ZK
         yCE5dudVdleQ1hBe5/D5lipzFqroaOM4zfGQ6OzyqGdBfWZhcuQykCqfHKXal3hssxER
         Ty9eCYD7SwaAcFGxi4esJN0cniiZp9bM8/mCPJgtWaDfIJr2/7zZv/4RTbm5dv+YARNv
         ZOJMhqk/uO2qQx5QyY3ViXadCWhpBGehSXkqnQH85PRXjjYfBcTGUGUfvQrisRhbwRM0
         cCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k3oSnnSPDS8aSpcgSX5pUmeikl4h5SoIDwUWsCX58Dg=;
        b=VmZBbKU1tOmR2HlVyTHyRVrY7Ou8bkTHm4VF/EmisargINABMjev/TdwURb9qmZNmN
         PwMXKUo4dB6CGLhZ3BmTm1j25UUkLVbdVYrIzJ9Pl1DTWOGf1mf69v/rQZoItJRYThb3
         ZXe66opCp9AEavKwZGtYXrZqfP1Vr9r0XUvXGhNPwpnzToAeBIzsxRzFgX0PIgxQhP39
         5wlfuYoC39ryDokbbSPNxMfB3IDH0GCYbwnaED1PWTB9a9sIAHEl9iPfNtEMrHWPZ9KY
         XiDEiem5tbj6OkYLF3vFShygr1zY9NgJlC2tYdpnuzzl2OEmIw8sePIX/P7GjsXxBWTN
         iDtw==
X-Gm-Message-State: AKaTC03ciiCSSHn9ijc4KOLw9ELeC0GO0fBq/fubkLL4VZdUC31KZ0/zA4vppZqlNxZGQ4rb
X-Received: by 10.84.146.140 with SMTP id g12mr100050616pla.62.1480725038379;
        Fri, 02 Dec 2016 16:30:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id 16sm10321572pfy.4.2016.12.02.16.30.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 04/17] update submodules: add is_submodule_populated
Date:   Fri,  2 Dec 2016 16:30:09 -0800
Message-Id: <20161203003022.29797-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See if a submodule is populated by checking if there
is a .git file or directory at the given path.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 11 +++++++++++
 submodule.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule.c b/submodule.c
index 78b69b5a55..c29153e9ff 100644
--- a/submodule.c
+++ b/submodule.c
@@ -930,6 +930,17 @@ int fetch_populated_submodules(const struct argv_array *options,
 	return spf.result;
 }
 
+int is_submodule_populated(const char *path)
+{
+	int retval = 0;
+	struct strbuf gitdir = STRBUF_INIT;
+	strbuf_addf(&gitdir, "%s/.git", path);
+	if (resolve_gitdir(gitdir.buf))
+		retval = 1;
+	strbuf_release(&gitdir);
+	return retval;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	ssize_t len;
diff --git a/submodule.h b/submodule.h
index 5db0b53b3f..a9eabcc3d0 100644
--- a/submodule.h
+++ b/submodule.h
@@ -58,6 +58,7 @@ extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
+extern int is_submodule_populated(const char *path);
 extern int submodule_uses_gitfile(const char *path);
 extern int ok_to_remove_submodule(const char *path);
 extern int merge_submodule(unsigned char result[20], const char *path,
-- 
2.11.0.rc2.28.g2673dad

