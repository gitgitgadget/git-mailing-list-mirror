Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A5EC6FA83
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiIESuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiIESuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:22 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10327CE5
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 11:50:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id se27so18662420ejb.8
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Gh98o/9Qp9MKQDICn+5msJCqS0wERH2XWbsIsgVc+wQ=;
        b=V7vcT2yUFJhmWUPLnqlzHt0N1oarBAYF2Sngq2DIWle7prBDkNASvbowFxfEqhgEkA
         Yf+nqz6D8A855zjNPhBQg2ySxloW61qrdIBUM+G0TNRpShziMOuDJvCX17WQmyH6TNSE
         qJZrZa9DDnHquCrOkjqAhQBs4cOVEKKGkHngOKPjFYIXl80AZ/zhK3eI9wfZiHrU8nyH
         fB8RkFcAjQvqrxVlMIYIpgsQ9Ua5UmtaxqkgL+RYrMuVXQWJTpVrvaqqfnluYtlfDNfI
         BsF5K6JUeq07uk8/nRPtDqc+s3HJbuEEswWpZ8YuWoRqCPv+BO5vH8gLRDxjOzJ8kTKj
         NwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Gh98o/9Qp9MKQDICn+5msJCqS0wERH2XWbsIsgVc+wQ=;
        b=z6L5j7UnDaYi1V/w7dT2A6w5Ek1WYFb23/WRdssFQsaAQn5Pr3cIpn1o6jkxXKRofx
         rVXml1t3FJ0kGL1xkZ4bJv4iiB7tFd1uj/maPXpIxKIPwbFeLjm82xbu4aZjBULVSu7a
         4MjOQShvW5zhfYfrXTJzNozTGnSMINJR5DC8A9zdqCZQiiu/GOFsJdcd7wP5urZ/Gj0r
         7CRq4XlFU2oQOR4UnPRXpNVunjSv1ApSB2dPM0uZqkIGVHyB27ev9FokrcEoyHDkdILA
         thahO7g/Z6RkKLB0sp0KPMP+VnKpj+aTlb1r7pcXqdRUSd7TA8AV3BTtXZLxxSUQ6GSK
         u7Zg==
X-Gm-Message-State: ACgBeo0gsaFk3Vb/Bub3hKMfBt0J7B6BnwexaOhT1mlRBw/fhBKsa/ql
        YcrUTs8zDxd/qjx73pE7AysMUbP7cK4=
X-Google-Smtp-Source: AA6agR7CgQLxigVli4h4U9lVKafBgluC5XDIft4WsNjL5VYU3bldJ7MiaLy64g8ovLfTDvFulcExAw==
X-Received: by 2002:a17:907:80d:b0:73d:a576:dfbd with SMTP id wv13-20020a170907080d00b0073da576dfbdmr36376887ejb.402.1662403817123;
        Mon, 05 Sep 2022 11:50:17 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906318c00b0073923a68974sm5246154ejy.206.2022.09.05.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 11:50:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] notes: simplify default operation mode arguments check
Date:   Mon,  5 Sep 2022 20:50:06 +0200
Message-Id: <20220905185007.9042-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.3.989.g4c3dfb3304
In-Reply-To: <20220905185007.9042-1-szeder.dev@gmail.com>
References: <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220905185007.9042-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git notes' has a default operation mode, but when invoked without a
subcommand it doesn't accept any arguments (although the 'list'
subcommand implementing the default operation mode does accept
arguments).  The condition checking this ended up a bit awkward, so
let's make it clearer.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/notes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 42cbae4659..60410af572 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -995,7 +995,7 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
 	const char *override_notes_ref = NULL;
-	parse_opt_subcommand_fn *fn = list;
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
 			   N_("use notes from <notes-ref>")),
@@ -1015,9 +1015,12 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
-	if (fn == list && argc && strcmp(argv[0], "list")) {
-		error(_("unknown subcommand: %s"), argv[0]);
-		usage_with_options(git_notes_usage, options);
+	if (!fn) {
+		if (argc) {
+			error(_("unknown subcommand: %s"), argv[0]);
+			usage_with_options(git_notes_usage, options);
+		}
+		fn = list;
 	}
 
 	if (override_notes_ref) {
-- 
2.37.3.989.g4c3dfb3304

