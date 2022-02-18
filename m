Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84CC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbiBRSlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:41:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiBRSlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:41:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9CD2A072E
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d27so16036358wrb.5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xXUcoebB+cPE6f+bi5P9KkPMLq0GTO/olLS7UT1kOJY=;
        b=c+8WmNC4qY1gRHZHnbXxk5TtDjupmD0i8EN9OVdzX5Z3b+DiLL1tPtsBqm+8xsi09Q
         EKQroZCw1Y3uCRE/R3h/zvNVMg0AST6ykWcxYF9N1gsgGYM0gKIokplDvFgQq9qNPzOe
         r6JgDbzyOCCKtWTqXcJl43J7trk36C1/taNKsZY91QRQZkBlnG2bfbhAhZK2gW9ToxLo
         XoHrNVjhA9jI+WhidC8Gk8oLaNbNfGM5J7s+xkA/jz9CYugDYoVmupOyvmtgGH/3QHFc
         1VyT4khUqergaA1tsU5Ya+Df9HlX7w9SijyqLhGSa/VMzG2pgkB0araTYxkk7SNlL5zQ
         hSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xXUcoebB+cPE6f+bi5P9KkPMLq0GTO/olLS7UT1kOJY=;
        b=c6dx45djRJscyewBuPlyZX8iA4ki5cZeCzDHSMYd0h0ZtDq+H7JDypxMxESEWY6O+2
         AJlDn7/9BjHd5u8d48QmrAupltPRCUI5QsT7MD1bJz0PxniD4R9sAIR01OqytGnb45dP
         2ps49b9VfZh618dRAfYOH+uOZhmFATTKk2bBoibLiisFXAKrV8lzNLi3etQ3iydGx0ba
         3wSFhdfbanX6/hvR/lGvZOjHwmwa4U3Ou81ubLHfZ8B0mGAd6h8l05abs3HX804IpOqe
         WHAkXcfPvkFVYkCDFWVva7D1+mymFLcOSD07sg22AF77BinHu1vuM2Xpg0INak5ep3UG
         xHqw==
X-Gm-Message-State: AOAM5334eY39gmBkygHSpid+icFg65XuqsPEFSpMyq6Pd+7qA42iGVQD
        gd1C/nC+O6xzf6xwgiWDXq+rx2SAa14=
X-Google-Smtp-Source: ABdhPJztcjXufPsR5p3XiqVtGyRjIxxLKOt8tM5O0pRghQQvW6mgZRCDMBKUvd8YcfKkA3QwVP8fNg==
X-Received: by 2002:a5d:5262:0:b0:1e3:15c1:cbad with SMTP id l2-20020a5d5262000000b001e315c1cbadmr6911234wrc.534.1645209650821;
        Fri, 18 Feb 2022 10:40:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm34450464wrw.100.2022.02.18.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:40:50 -0800 (PST)
Message-Id: <e4c0047a17ca1b5f824acfb209884a59a93ea523.1645209647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:40:46 +0000
Subject: [PATCH 2/3] reflog: call reflog_delete from reflog.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Now that reflog is libified into reflog.c, we can call reflog_delete
from the reflog.c library.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/reflog.c | 42 ++----------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 65198320cd2..03d347e5832 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -316,12 +316,10 @@ static const char * reflog_delete_usage[] = {
 
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
-	struct cmd_reflog_expire_cb cmd = { 0 };
 	int i, status = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
 
-	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
 	const struct option options[] = {
 		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
 			EXPIRE_REFLOGS_DRY_RUN),
@@ -337,48 +335,12 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, reflog_delete_usage, 0);
 
-	if (verbose)
-		should_prune_fn = should_expire_reflog_ent_verbose;
-
 	if (argc < 1)
 		return error(_("no reflog specified to delete"));
 
-	for (i = 0; i < argc; i++) {
-		const char *spec = strstr(argv[i], "@{");
-		char *ep, *ref;
-		int recno;
-		struct expire_reflog_policy_cb cb = {
-			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
-		};
-
-		if (!spec) {
-			status |= error(_("not a reflog: %s"), argv[i]);
-			continue;
-		}
-
-		if (!dwim_log(argv[i], spec - argv[i], NULL, &ref)) {
-			status |= error(_("no reflog for '%s'"), argv[i]);
-			continue;
-		}
-
-		recno = strtoul(spec + 2, &ep, 10);
-		if (*ep == '}') {
-			cmd.recno = -recno;
-			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
-		} else {
-			cmd.expire_total = approxidate(spec + 2);
-			for_each_reflog_ent(ref, count_reflog_ent, &cmd);
-			cmd.expire_total = 0;
-		}
+	for (i = 0; i < argc; i++)
+		status |= reflog_delete(argv[i], flags, verbose);
 
-		cb.cmd = cmd;
-		status |= reflog_expire(ref, flags,
-					reflog_expiry_prepare,
-					should_prune_fn,
-					reflog_expiry_cleanup,
-					&cb);
-		free(ref);
-	}
 	return status;
 }
 
-- 
gitgitgadget

