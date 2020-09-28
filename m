Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B426CC4727F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B85F206FC
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJEks6bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgI1Lkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgI1Lk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 07:40:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1982C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so947744wrs.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+iT0k2kjhwz1BPcggVrGNP9SOGI46vABgBecsBleWs4=;
        b=MJEks6bpJdLb2SmIAsF2Td3KB239h6yrUhDEWRMpAWRJmehj/l3iIdSn8GGLCyPjcM
         vMmzVdtBp7Sfl8ahnyWGSvXSyWksqnCFfpqDXred/ZYLUMjj0EB0Q2ou83Xr0tkCfUyf
         O2SI8UTNLYFBI+JGY3J8/uDUSrNqgXw50yS97C7ZMNQchw4slHtMoKORmaTbMh+OWzcM
         r5gnvMwHfwAxYw2mtFO9fIfwUq5xJRqkPP0FhKoSi7CtTzyhkDn3tADFkIBiYcupQbxe
         Y5Ix0uyxbSbIyGrxXQ/RYRF5SzOOgO/GH6F+x+QGdL6kbsDp21ClYwx2c7UZm3XOvFMe
         cFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+iT0k2kjhwz1BPcggVrGNP9SOGI46vABgBecsBleWs4=;
        b=G6HQpvHLNCSNikgWt4d3vkjTllDLY/+fo4t3661AXhHh7nkuz1nOyKY/hVau+YIIq2
         UR0wFqmZjeAzDf+h8J5fpUIAPxIbN5FQ648DZT2EYMaaM7YHCGY6hIAZLlcRmiFeVey4
         fTx9NcNyoGXlWmJAJnN2lpnFiED5JOrw3vhYGDHVJce60ZaZWE5cd0P/2sbyCmhXiCDR
         jLOppym/KoggofF1SlvCKJ0m8dSzVzsFQkobd8ItZ/VoR6/Fgxtw7ipt85cQiEV7/zuY
         aDvflSAPnhMG3ejvE4GM9xWSJM8CG7piAKcvRevSemlR+tVbrv+OuX3tyKea7RSwoj1p
         4Apw==
X-Gm-Message-State: AOAM530VNH/GrT54Pc8OrpBedBqm68FdObtxZxij/rxck3YK/XCLbgUE
        2qbdOxCv8atiVagX56Tx81e12EmZku4=
X-Google-Smtp-Source: ABdhPJzAeFiJbynOo/UoCWqqaYaHQpGGNLp9lWsjvjJhvuIRljLYVXGk27GeJDoxCMOxKyMP4nYljg==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr1272558wrp.187.1601293227202;
        Mon, 28 Sep 2020 04:40:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm1218712wrp.47.2020.09.28.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:40:26 -0700 (PDT)
Message-Id: <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
From:   "Nikita Leonov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 11:40:23 +0000
Subject: [PATCH v2 2/3] credentials: make line reading Windows compatible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nikita Leonov <nykyta.leonov@gmail.com>

This commit makes reading process regarding credentials compatible with
'CR/LF' line ending. It makes using git more convenient on systems like
Windows.

Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/credential-cache--daemon.c |  4 ++--
 builtin/credential-store.c         |  2 +-
 t/t0302-credential-store.sh        | 16 ++++++----------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index c61f123a3b..17664bb0d5 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -99,12 +99,12 @@ static int read_request(FILE *fh, struct credential *c,
 	static struct strbuf item = STRBUF_INIT;
 	const char *p;
 
-	strbuf_getline_lf(&item, fh);
+	strbuf_getline(&item, fh);
 	if (!skip_prefix(item.buf, "action=", &p))
 		return error("client sent bogus action line: %s", item.buf);
 	strbuf_addstr(action, p);
 
-	strbuf_getline_lf(&item, fh);
+	strbuf_getline(&item, fh);
 	if (!skip_prefix(item.buf, "timeout=", &p))
 		return error("client sent bogus timeout line: %s", item.buf);
 	*timeout = atoi(p);
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 5331ab151a..d4e90b68df 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -23,7 +23,7 @@ static int parse_credential_file(const char *fn,
 		return found_credential;
 	}
 
-	while (strbuf_getline_lf(&line, fh) != EOF) {
+	while (strbuf_getline(&line, fh) != EOF) {
 		if (!credential_from_url_gently(&entry, line.buf, 1) &&
 		    entry.username && entry.password &&
 		    credential_match(c, &entry)) {
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 716bf1af9f..f2c672e4b6 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -142,7 +142,7 @@ invalid_credential_test "scheme" ://user:pass@example.com
 invalid_credential_test "valid host/path" https://user:pass@
 invalid_credential_test "username/password" https://pass@example.com
 
-test_expect_success 'get: credentials with DOS line endings are invalid' '
+test_expect_success 'get: credentials with DOS line endings are valid' '
 	printf "https://user:pass@example.com\r\n" >"$HOME/.git-credentials" &&
 	check fill store <<-\EOF
 	protocol=https
@@ -150,11 +150,9 @@ test_expect_success 'get: credentials with DOS line endings are invalid' '
 	--
 	protocol=https
 	host=example.com
-	username=askpass-username
-	password=askpass-password
+	username=user
+	password=pass
 	--
-	askpass: Username for '\''https://example.com'\'':
-	askpass: Password for '\''https://askpass-username@example.com'\'':
 	--
 	EOF
 '
@@ -172,7 +170,7 @@ test_expect_success 'get: credentials with path and DOS line endings are valid'
 	EOF
 '
 
-test_expect_success 'get: credentials with DOS line endings are invalid if path is relevant' '
+test_expect_success 'get: credentials with DOS line endings are valid if path is relevant' '
 	printf "https://user:pass@example.com/repo.git\r\n" >"$HOME/.git-credentials" &&
 	test_config credential.useHttpPath true &&
 	check fill store <<-\EOF
@@ -181,11 +179,9 @@ test_expect_success 'get: credentials with DOS line endings are invalid if path
 	protocol=https
 	host=example.com
 	path=repo.git
-	username=askpass-username
-	password=askpass-password
+	username=user
+	password=pass
 	--
-	askpass: Username for '\''https://example.com/repo.git'\'':
-	askpass: Password for '\''https://askpass-username@example.com/repo.git'\'':
 	--
 	EOF
 '
-- 
gitgitgadget

