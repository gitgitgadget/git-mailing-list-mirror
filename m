Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C2C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F0D611EE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhKFVNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhKFVNp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587E7C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso8945356wmf.0
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asVw0l2B8SogumKq2c4l5ixln9iTMkKAgxebHGlS0D0=;
        b=iN3YaifwU1SMQuzsDtZ6sPmYCWG91tVoKFAPbtwXeEgKXTZNGeWS4k0ttbPW0PDXEb
         7MGZRZiwim/2/wYu501V7/VTzYHlbd6jyB3AnQuo5dqqegrJgjhBRTFcpVA06z80xh99
         qcm1j516DEiAvhO/U8jBWWgamcSH//5djP132O2WUbDl2qSjr5iAINJxiYYn2xni4pix
         nXdHy2a4g/DhN0DZqZeQVRqsovGpt/lcVoqz5Suop5WMq4FmV8MEi5MBBPHTuIYLa3K1
         kP0ZUmeSF5hkk6GGD5pPyyXDq4VQxkMT3RUlZ1rSzUK2fdJtNwyGkVPR6987xzD8SiFD
         jqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asVw0l2B8SogumKq2c4l5ixln9iTMkKAgxebHGlS0D0=;
        b=23hnf+Vja62OiJ7nfd/5+GqBTnIcx3HRKdYVBFAnCgl1RGaTV+ZvqX5Sg6H2ThpvHy
         DqHbs2w2NO7wjkOOwNYtVGTRco1OM4eZs1/w4t3rc4oRAsj9udJsIlNF9Qc4njjapUh4
         Y1QCWRfa9VXOPuDsCNuGRAmuk6wHw035dDfQ47zFAKXGv1gwrvwlEDFfsm2rCtMcX3Y+
         LXoDwf5JB1cF17RC2kg/wuOj7pA6soPI6K0XJ3CBNCfoT+yfWOvk00WIL3r4IM3tUzK+
         hhR7E+l7GtIkDVyEVSTbFLmmw6VCBVcKPLomGmxPotFV7X0EIvlaDWIi4I6vi5I/PCIk
         WsLA==
X-Gm-Message-State: AOAM532SJ9lV9kuDPTcbQ60BhCXuamx9H1ykZR7uVjmkrGrupsTojUnF
        rGVdiTf3+4E3PB4mZYDaGAF6Vj8S91Vowg==
X-Google-Smtp-Source: ABdhPJxluXC4somo0yjW7jGLMqYOcMHiY6eOilsCzWiyMQfAAbuxwCn53fOExEx/oKoLP+kuG7Mr9g==
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr41595980wmr.157.1636233061701;
        Sat, 06 Nov 2021 14:11:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:11:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] grep: remove unused "prefix_length" member
Date:   Sat,  6 Nov 2021 22:10:49 +0100
Message-Id: <patch-3.8-3338cc95b81-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "prefix_length" member, which we compute with a strlen() on
the "prefix" argument to grep_init(), but whose strlen() hasn't been
used since 493b7a08d80 (grep: accept relative paths outside current
working directory, 2009-09-05).

When this code was added in 0d042fecf2f (git-grep: show pathnames
relative to the current directory, 2006-08-11) we used the length, but
since 493b7a08d80 we haven't used it for anything except a boolean
check that we could have done on the "prefix" member itself.

Before a preceding commit we also used to guard the strlen() with
"prefix && *prefix", but as that commit notes the RHS of that && chain
was also redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 grep.c         | 1 -
 grep.h         | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9e34a820ad4..bd4d2107351 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -315,7 +315,7 @@ static void grep_source_name(struct grep_opt *opt, const char *filename,
 	strbuf_reset(out);
 
 	if (opt->null_following_name) {
-		if (opt->relative && opt->prefix_length) {
+		if (opt->relative && opt->prefix) {
 			struct strbuf rel_buf = STRBUF_INIT;
 			const char *rel_name =
 				relative_path(filename + tree_name_len,
@@ -332,7 +332,7 @@ static void grep_source_name(struct grep_opt *opt, const char *filename,
 		return;
 	}
 
-	if (opt->relative && opt->prefix_length)
+	if (opt->relative && opt->prefix)
 		quote_path(filename + tree_name_len, opt->prefix, out, 0);
 	else
 		quote_c_style(filename + tree_name_len, out, NULL, 0);
diff --git a/grep.c b/grep.c
index 88ebc504630..755afb5f96d 100644
--- a/grep.c
+++ b/grep.c
@@ -145,7 +145,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
 
 	opt->repo = repo;
 	opt->prefix = prefix;
-	opt->prefix_length = prefix ? strlen(prefix) : 0;
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
 }
diff --git a/grep.h b/grep.h
index 95cccb670f9..467d775b5a9 100644
--- a/grep.h
+++ b/grep.h
@@ -135,7 +135,6 @@ struct grep_opt {
 	struct repository *repo;
 
 	const char *prefix;
-	int prefix_length;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.0.rc1.741.gab7bfd97031

