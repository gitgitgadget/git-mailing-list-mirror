Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5420CC432BE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C160606A5
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhGXV0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhGXV02 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 17:26:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C4EC061760
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:07:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so5698915wms.2
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lnQvCCgXIKYagGNLDYsPxjYsJR3p/tSWk47a9/2CEyM=;
        b=tPE8T248l5PQSIRhK26ScMfePUvs180N/RxZKLKciSBuqEABHFav526z97+gm5eWfI
         mkQgd9Z649yVnvmqIayfzy23yg4hQ/gUlir2IatkhbESvbECVhQXh+aLCHGqKA37rG0g
         WpWA4bC9/OQYnjK/vXgGZsztL3HQnvT47Hgb6urtktjOeGx2izaqwMfOSFxvOb6W6H/n
         c++VXgfekmJUrsl/HZTWW/cC19ap1LGYIqWl9N+nokbY8QfsbdO8zCC+8qRO60S8d4mS
         MctUSMfC9h4QFVN5XjqRDeePhBYGrzq0NodDD1xYurzFqmzKzkVT5nmO9AjS66SQEhd8
         A9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lnQvCCgXIKYagGNLDYsPxjYsJR3p/tSWk47a9/2CEyM=;
        b=HRwmERuFzyloG9recsoLVB1TeKoOepyC/LtsyCPORQfdlqkMi2iZf9P4XOTGejNA96
         2ctOvN3DijmQMPSjl/jE199T3i3OMvBjw5szt91AGrzanxpj1G8GSjLgGTIOIsHsbibT
         0o4YFzkC/gQ9xT+GBrXalDVCi1Puc2/ioBI3vrfea7HMoZYOO7h8zfSbyhm1wXtePTFQ
         hNj6OtganuFAC7X0ipVor5aOlzQZxVCqi4Hx9Omlogb0I0kQVv5RU/Y+hDTJPzDnG385
         DmnUoIt/grtw6M0u7RVIhTn/nIvVEtATGzYEiGJR3DR9J0TSPqaWV4iv9JlsqtINWsUX
         XCBA==
X-Gm-Message-State: AOAM533gxY2nsiaZYkzPvJCNEZbl6r9kw0bmS/i5n+uuSWrWXISOt0IE
        N1C41d0LPR3dEtLKGMvjmAWnA0aCpU8=
X-Google-Smtp-Source: ABdhPJw5R2OgikwdMt34CbXD13pDSo+KlDVG3dMtytQ0zj8gRgtn2RKWU6SIDO++NgS7AvYVL/nOcQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr1913692wmi.42.1627164418637;
        Sat, 24 Jul 2021 15:06:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm37873950wrp.34.2021.07.24.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:06:58 -0700 (PDT)
Message-Id: <d286583082e13be0ed4e1d4d923b6bdcf0c234a6.1627164414.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 22:06:53 +0000
Subject: [PATCH v3 5/5] interpolate_path(): allow specifying paths relative to
 the runtime prefix
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Ever since Git learned to detect its install location at runtime, there
was the slightly awkward problem that it was impossible to specify paths
relative to said location.

For example, if a version of Git was shipped with custom SSL
certificates to use, there was no portable way to specify
`http.sslCAInfo`.

In Git for Windows, the problem was "solved" for years by interpreting
paths starting with a slash as relative to the runtime prefix.

However, this is not correct: such paths _are_ legal on Windows, and
they are interpreted as absolute paths in the same drive as the current
directory.

After a lengthy discussion, and an even lengthier time to mull over the
problem and its best solution, and then more discussions, we eventually
decided to introduce support for the magic sequence `%(prefix)/`. If a
path starts with this, the remainder is interpreted as relative to the
detected (runtime) prefix. If built without runtime prefix support, Git
will simply interpolate the compiled-in prefix.

If a user _wants_ to specify a path starting with the magic sequence,
they can prefix the magic sequence with `./` and voilà, the path won't
be expanded.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 9 +++++++++
 path.c                   | 8 ++++++++
 t/t0060-path-utils.sh    | 8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a2..0c0e6b859f1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -298,6 +298,15 @@ pathname::
 	tilde expansion happens to such a string: `~/`
 	is expanded to the value of `$HOME`, and `~user/` to the
 	specified user's home directory.
++
+If a path starts with `%(prefix)/`, the remainder is interpreted as a
+path relative to Git's "runtime prefix", i.e. relative to the location
+where Git itself was installed. For example, `%(prefix)/bin/` refers to
+the directory in which the Git executable itself lives. If Git was
+compiled without runtime prefix support, the compiled-in prefix will be
+subsituted instead. In the unlikely event that a literal path needs to
+be specified that should _not_ be expanded, it needs to be prefixed by
+`./`, like so: `./%(prefix)/bin`.
 
 
 Variables
diff --git a/path.c b/path.c
index 8dc5ad2cb55..0bc788ea40f 100644
--- a/path.c
+++ b/path.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "lockfile.h"
+#include "exec-cmd.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -723,6 +724,9 @@ static struct passwd *getpw_str(const char *username, size_t len)
  * failure or if path is NULL.
  *
  * If real_home is true, strbuf_realpath($HOME) is used in the `~/` expansion.
+ *
+ * If the path starts with `%(prefix)/`, the remainder is interpreted as
+ * relative to where Git is installed, and expanded to the absolute path.
  */
 char *interpolate_path(const char *path, int real_home)
 {
@@ -731,6 +735,10 @@ char *interpolate_path(const char *path, int real_home)
 
 	if (path == NULL)
 		goto return_null;
+
+	if (skip_prefix(path, "%(prefix)/", &path))
+		return system_path(path);
+
 	if (path[0] == '~') {
 		const char *first_slash = strchrnul(path, '/');
 		const char *username = path + 1;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index a76728c27bf..34d1061f321 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -540,6 +540,14 @@ test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
 	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
 	echo HERE >expect &&
+	test_cmp expect actual'
+
+test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
+	mkdir -p pretend/bin &&
+	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
+	git config yes.path "%(prefix)/yes" &&
+	GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
+	echo "$(pwd)/pretend/yes" >expect &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget
