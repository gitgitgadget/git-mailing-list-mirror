Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02FCC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 23:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbiEaXMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 19:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348629AbiEaXMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 19:12:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB58FF9C
        for <git@vger.kernel.org>; Tue, 31 May 2022 16:12:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q7so21456wrg.5
        for <git@vger.kernel.org>; Tue, 31 May 2022 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3ibAYxxmwqdF47KI1epRuVZR6ZM02+XIW9ONctatoZk=;
        b=L2P2CttkPIPJNCGM40Y5NwHqQijDaxuqGBDUIRQHZe/rN4WVyuQlFGkDMoLNIMt9Cj
         Q00Fy1pgcpmRjXe3gsz2ZR7aIHFBQpArnDRq9uEqa0UwQygV0+Vhec3VBVDV155rDEVx
         Z4+xQYp/MXnt4M1mdOvcFtH8qqbGhzXm4KDzCUA0R/nqbM8rySLtKVR8fI9RceXN13nI
         IEJ8v7WGbQPadhIHGGWC8EJ3VVtOSNeS3720tQBoa0AMn+VMyezwXOFYsSBUXBwfkPQ0
         TbwIIgTRLP0YGSFsjmyCy0Ln9lXn+pF/vWHXHeUwxPouUdltbUZzUxaW+MUN8GRRklYe
         HtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3ibAYxxmwqdF47KI1epRuVZR6ZM02+XIW9ONctatoZk=;
        b=C56JGQy08gaQfDm0CPCCn7wObMusTEwdVII2cwTZPPXYmHkWRP63PGz9UfJUQFj0UA
         3MrJZn+FmUiak4lplyMOjVE2kNGk0V4LinrPV9UgHKaZSZbZDgFMDzEyJ1949dnVSsoM
         pKEkPhfIF4oU/ELgbN5Y9RakOnBuEGSDOBAHIyz/pmSfjAm1aOeRGULrZ25v18BfpLEQ
         qEFC1qhHuJlA+VmJ64kuGOd3cnrL0wLjznkoF+lvpwz56FvGWxVNGUoXsCFn2vQUIql1
         xoFEcdUgrPbO1uvxAUmEGUK22XHnryyw65VjlN/Pt7MBwSO29u1DjEL7yQG6v781amZc
         F0fA==
X-Gm-Message-State: AOAM531k+mZicDNJJ9BL6P3P+NJIt6HQbVRmSJVdCcpwUnyEDxhNPhWj
        Rqb/ua3LiaGfxKtcExPMIwHFIixlsBk=
X-Google-Smtp-Source: ABdhPJzQrMstw27rXp3YLCN8hZyeLVQovEHL4Z3btGXsBMlULc3rDtmiqdsGv4o8ehkE8I8wXiK6WA==
X-Received: by 2002:a05:6000:1e0a:b0:210:32e1:3b03 with SMTP id bj10-20020a0560001e0a00b0021032e13b03mr11256766wrb.642.1654038758796;
        Tue, 31 May 2022 16:12:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc349000000b0039746638d6esm102739wmj.33.2022.05.31.16.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 16:12:38 -0700 (PDT)
Message-Id: <f947cf221c0b5320d0b7438b88a0d94a5bd3a70b.1654038754.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
References: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 May 2022 23:12:34 +0000
Subject: [PATCH 2/2] remote.c: reject 0-length branch names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Branch names can't be empty, so config keys with an empty branch name,
e.g. "branch..remote", are silently ignored.

Since these config keys will never be useful, make it a fatal error when
remote.c finds a key that starts with "branch." and has an empty
subsection.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c              |  4 ++++
 t/t5516-fetch-push.sh | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index cf7015ae8ab..a3888dd789c 100644
--- a/remote.c
+++ b/remote.c
@@ -352,8 +352,12 @@ static int handle_config(const char *key, const char *value, void *cb)
 	struct remote_state *remote_state = cb;
 
 	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
+		/* There is no subsection. */
 		if (!name)
 			return 0;
+		/* There is a subsection, but it is empty. */
+		if (!namelen)
+			return -1;
 		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {
 			return git_config_string(&branch->remote_name, key, value);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index a05268952e9..e99c31f8c35 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -598,13 +598,23 @@ test_expect_success 'branch.*.pushremote config order is irrelevant' '
 	check_push_result two_repo $the_commit heads/main
 '
 
-test_expect_success 'push ignores empty branch name entries' '
+test_expect_success 'push rejects empty branch name entries' '
 	mk_test one_repo heads/main &&
 	test_config remote.one.url one_repo &&
 	test_config branch..remote one &&
 	test_config branch..merge refs/heads/ &&
 	test_config branch.main.remote one &&
 	test_config branch.main.merge refs/heads/main &&
+	test_must_fail git push 2>err &&
+	grep "bad config variable .branch\.\." err
+'
+
+test_expect_success 'push ignores "branch." config without subsection' '
+	mk_test one_repo heads/main &&
+	test_config remote.one.url one_repo &&
+	test_config branch.autoSetupMerge true &&
+	test_config branch.main.remote one &&
+	test_config branch.main.merge refs/heads/main &&
 	git push
 '
 
-- 
gitgitgadget
