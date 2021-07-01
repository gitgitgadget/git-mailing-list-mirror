Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895AAC11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D7661413
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhGAQFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhGAQFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:05:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A452C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:03:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t15so5551228wry.11
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cuZB6dre7Yqa9xzToOKmOKz+nZVO+cPRXGst0BO11TM=;
        b=ZAcUabz6lbJulJebRbGE7BFunOCd5ogBOfNyjgrhi67QbESyXAbObdOEDFKLfw+cRV
         V/ykjLPxKpVw2boJdYPyVNrDu51sq1REBploWvYzhLUChmHEEf8KrWWfheVDdX1z9HpH
         Ad3Di7mtwXDnIyAprHEge5z8d1EIeJqJDqkRUBMRfA7Imxag0QdVVrDFM1DXdxlYcY1S
         Snaum+/9p+rlelm7zjock37QUxVyQqAha85vKI9/UEIHOFT1uWrnBD8D3jyxKIBXECis
         CN+ybf/rU6oCfd1E78EB+NLjf85y+UZoQ+p6xA0KxLK0OpIzENFojYhHvzyNy7pUtgNM
         IMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=cuZB6dre7Yqa9xzToOKmOKz+nZVO+cPRXGst0BO11TM=;
        b=IFbYOyCbR0rxgUQm2+Xf2OgRzdhVybbMffQGckJn0MddseY24zbzss5WOdxaCD3UYL
         UM0veE6Mt6dJA40vNPTnHIxZ/YU+eFGdG/qM2AU6keAn9MY1Kw4NKZccRwQGkAoAUHRm
         sYbZyCVmfKVOAh+3vLZKe8QpI4AlA4EPHhbvvfoYBnph14uiqmDnuGpRm1lnOl8ZbFSk
         VlFa8k9Zn0Hboi/n+iBxg2NIWyneunyJDY4RQueCnhY+yiGSGnvPKw+SeLTVBSw8e+Xc
         fXsBER2UxlqX/TVFgHofYVRXNiYfjQFdTu0Mfo4Sz6K9eH4IBQqGZjyMZUNAwBtbvekb
         +ldQ==
X-Gm-Message-State: AOAM530V47eSb9NvsSgjTrfnEhXVOVoGZbukwMuYNHZmhpR8f8nP6hoV
        DprUpACE58AlU/VZzXGfVrB1B2+4XDs=
X-Google-Smtp-Source: ABdhPJzwzw8C8dvI/i9bRqKWcJd2piAK1/nIKgoMdkFJbibtwFaY8oX8k1tH5u8m8WozzC0ZAzXX5A==
X-Received: by 2002:a05:6000:188b:: with SMTP id a11mr472685wri.274.1625155390293;
        Thu, 01 Jul 2021 09:03:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm327954wrq.88.2021.07.01.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:03:09 -0700 (PDT)
Message-Id: <66df56f5db02fa43b28111bb9fcc9b06f8542154.1625155388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
References: <pull.66.git.gitgitgadget@gmail.com>
        <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:03:07 +0000
Subject: [PATCH v2 2/2] expand_user_path(): support specifying paths relative
 to the runtime prefix
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

After a lengthy discussion, and a way lengthier time to mull over the
problem and its best solution, we decided to introduce support for the
magic sequence `<RUNTIME-PREFIX>/`. If a path starts with this, the
remainder is interpreted as relative to the detected runtime prefix.

This solves the problem, but what new problems does it stir up? Here are
the two most obvious ones:

- What if Git was not compiled with support for a runtime prefix?

  In that case, we will simply use the compiled-in hard-coded prefix.

- What if a user _wants_ to specify a path starting with the magic
  sequence?

  In that case, the user will simply need to prefix the magic sequence
  with `./` and voilà, the path won't be expanded.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 10 ++++++++++
 path.c                   |  5 +++++
 t/t0060-path-utils.sh    |  8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a2..fd56e2c1220 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -298,6 +298,16 @@ pathname::
 	tilde expansion happens to such a string: `~/`
 	is expanded to the value of `$HOME`, and `~user/` to the
 	specified user's home directory.
++
+If a path starts with `<RUNTIME-PREFIX>/`, the remainder is
+interpreted as a path relative to Git's "runtime prefix", i.e. relative
+to the location where Git itself was installed. For example,
+`<RUNTIME-PREFIX>/bin/` refers to the directory in which the Git
+executable itself lives. If Git was compiled without runtime prefix
+support, the compiled-in prefix will be subsituted instead. In the
+unlikely event that a literal path needs to be specified that should
+_not_ be expanded, it needs to be prefixed by `./`, like so:
+`./<RUNTIME-PREFIX>/bin`.
 
 
 Variables
diff --git a/path.c b/path.c
index 7bccd830e95..d8542a7b27b 100644
--- a/path.c
+++ b/path.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "lockfile.h"
+#include "exec-cmd.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -732,6 +733,10 @@ char *expand_user_path(const char *path, int real_home)
 
 	if (path == NULL)
 		goto return_null;
+
+	if (skip_prefix(path, "<RUNTIME-PREFIX>/", &path))
+		return system_path(path);
+
 	if (path[0] == '~') {
 		const char *first_slash = strchrnul(path, '/');
 		const char *username = path + 1;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index a76728c27bf..cb7fbfb9af2 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -540,6 +540,14 @@ test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTIME_PREFIX works' '
 	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
 	GIT_EXEC_PATH= ./pretend/bin/git here >actual &&
 	echo HERE >expect &&
+	test_cmp expect actual'
+
+test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '<RUNTIME-PREFIX>/ works' '
+	mkdir -p pretend/bin &&
+	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
+	git config yes.path "<RUNTIME-PREFIX>/yes" &&
+	GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
+	echo "$(pwd)/pretend/yes" >expect &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget
