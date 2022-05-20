Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1EBC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352013AbiETSln (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352960AbiETSlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9A33EA4
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e28so12029752wra.10
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1DVIcTWk8cDkE79S+hn14HeQRHkbq1Nzraaodiv24OU=;
        b=WDy8yscN4psCawHydMjQYUXFMj640hkPqorqtw2Ml0+G6faFG1v5QhmLMhGXoDs+PA
         iDt9k7aXdBQRYhWhif89ERdrA7tf/nkVx2OdjdGZKCF89bpKxIhbetVt/y1UmqrJ0FHg
         3UmGECEJ6ubiJltGIWT5pLgVSkRhJgm2XWf349R1ScdPJCxEvReoyiUKk0AKc8qUvr+V
         hDqE7obh0pgNzumZWzS/Vx7ZqRQt7IDUBfih4AXHIpDj7rxYrDTOxuYhYq2hbJruKiue
         Tk6WqanhbINNY8uky5o0nUglq8Ed5N6z1b+5EwyFVZ8YWwBOk2LDXF3dbdLkMxX7nscd
         GTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1DVIcTWk8cDkE79S+hn14HeQRHkbq1Nzraaodiv24OU=;
        b=h1zac3DqKN3bKeKg6CYvZpe+BAA6j3vKMGCRl1m4UIhNNEOq1v2R8iAxBoH2Q88QjM
         /r+DK8ivOtYbsZ1aajiR8rT3kPazG8t11WHj37MdPt5/7EPzdFXOSsN7xffN1BKp3Xe+
         QsNFg6BhOMvpe/mYpY2dkwUFUPJRQzaHp+vQWot9oXKwacBjnSwn+dV22On3QsEbATIq
         5ayd3w2JxpxCpmbUYumiJ+89xWxCg/+up6ikKgXow7ZBYuPkpDgrFTPASOjB2yiP9Iq0
         qlvt2kmQpu45a81GRQMhgZ5NkJd+hChZGtFnzr//48tQWCx+IHbBM4sGMFsVJ7YNFhgl
         SRFg==
X-Gm-Message-State: AOAM531DuzWV18JEsW5ugUIKI0vxKXjaV2FD7sfw1kIFHQLfH+xkbr0Q
        LfzhDQ/wOAKu/sWh3XUIT0J3O5bMZTI=
X-Google-Smtp-Source: ABdhPJwTtpV2I5nleLbB+uxBaLkeQwsw8z3Ffo5Es59jCk/ayKp9xuWDvPGrmAWwZV9G/enT0HjSHg==
X-Received: by 2002:a5d:4492:0:b0:20d:740:beb9 with SMTP id j18-20020a5d4492000000b0020d0740beb9mr9424252wrq.179.1653072049134;
        Fri, 20 May 2022 11:40:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12-20020adfa70c000000b0020e0b9487besm2977594wrd.109.2022.05.20.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:48 -0700 (PDT)
Message-Id: <7bd508d5ebb5433615bee4a6d7777486a38213c4.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:22 +0000
Subject: [PATCH 04/24] bundle-uri: add support for http(s):// and file://
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change created the logic for copying a file by name. Now,
first inspect the URI for an HTTP(S) prefix and use git-remote-https as
the way to download the data at that URI. Otherwise, check to see if
file:// is present and modify the prefix accordingly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 91aba061833..08de7257c74 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -19,10 +19,73 @@ static void find_temp_filename(struct strbuf *name)
 	unlink(name->buf);
 }
 
+static int download_https_uri_to_file(const char *uri, const char *file)
+{
+	int result = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	FILE *child_in = NULL, *child_out = NULL;
+	struct strbuf line = STRBUF_INIT;
+	int found_get = 0;
+
+	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);
+	cp.in = -1;
+	cp.out = -1;
+
+	if (start_command(&cp))
+		return 1;
+
+	child_in = fdopen(cp.in, "w");
+	if (!child_in) {
+		result = 1;
+		goto cleanup;
+	}
+
+	child_out = fdopen(cp.out, "r");
+	if (!child_out) {
+		result = 1;
+		goto cleanup;
+	}
+
+	fprintf(child_in, "capabilities\n");
+	fflush(child_in);
+
+	while (!strbuf_getline(&line, child_out)) {
+		if (!line.len)
+			break;
+		if (!strcmp(line.buf, "get"))
+			found_get = 1;
+	}
+	strbuf_release(&line);
+
+	if (!found_get) {
+		result = error(_("insufficient capabilities"));
+		goto cleanup;
+	}
+
+	fprintf(child_in, "get %s %s\n\n", uri, file);
+
+cleanup:
+	if (child_in)
+		fclose(child_in);
+	if (finish_command(&cp))
+		return 1;
+	if (child_out)
+		fclose(child_out);
+	return result;
+}
+
 static int copy_uri_to_file(const char *uri, const char *file)
 {
+	const char *out;
+	if (skip_prefix(uri, "https:", &out) ||
+	    skip_prefix(uri, "http:", &out))
+		return download_https_uri_to_file(uri, file);
+
+	if (!skip_prefix(uri, "file://", &out))
+		out = uri;
+
 	/* Copy as a file */
-	return copy_file(uri, file, 0444);
+	return !!copy_file(out, file, 0);
 }
 
 static int unbundle_from_file(struct repository *r, const char *file)
-- 
gitgitgadget

