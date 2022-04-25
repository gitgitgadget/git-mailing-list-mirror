Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15FBC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 13:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbiDYNuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiDYNuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 09:50:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46C49F8B
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 06:47:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k2so507903wrd.5
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1r+VPGfAzRZADQf49+v8i7G7Y7xAoF+oeE5IC9bRmCc=;
        b=WoyQUM1aupXdO4cJpjlHHJXm6+gSRjvoR9CEFXpTLtOYIhMwFZctQtuacGNYPqu1vH
         FZNgpP2zVD7G6YWsXqdSWhnZv+x+wp3U2roE0XuidKlS34g/rbDwW6bD5U/FMmpRBM7w
         tnm3mcC9zxfPlk6BTQSFXoI+HJvPvK39j2G6KDBWuYP6GiA2xBZ1CpDaQ7DrVSsriu8l
         mWomG3FUsIwhNMUZQasDSUMPKHDfjzPDBvThMEyy8FjRqou3cEjvZafuNjnreQmqBceE
         a4LbFzZNj/NwfrFTZuUENktQSxaM+m69dEyUx8kOWDRDK/TBbnoXlL2TNzl0+J+8lQdf
         wtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1r+VPGfAzRZADQf49+v8i7G7Y7xAoF+oeE5IC9bRmCc=;
        b=bU+bRkj/ztPPwWKmKjZgLmltmFslJdCQPZuEATB0yij12Lm6A9CoXQYrSvl2C7fCdI
         ntfOnMh6rnXdKZmPtEI72R9uVjzHoHBszLX2YY9lkf59ANqDVmdQQ0FSYzFZhIUpVUA9
         DRYmXLxFvQHchbqOoWiylHrlsO7XoDBrYUJnoGyPJzxCXCmXh6Q26r4JmLe6iHcqBjV6
         jYH5Fk6LHAA63+W3YIHpJ8zxQelyzTsqIG6nExoo5rZxeFnnXX8A5przKmura5ipbw3s
         ifMyuXtu2c6PAvFh7MJ2yuZLgOdrNLFPGeKbgTYiYRnjvFZaL11ornbWcWDp1fTL5QG9
         cV0g==
X-Gm-Message-State: AOAM530kOTCpqTwNMbIrHXBDWyg1ns3Jl8ha840jWNEcbJ0sZTSBSXb8
        652WDzdtM5Rf6BkPvbJUEjOtN6i9s9s=
X-Google-Smtp-Source: ABdhPJxW0ETQt8ulDhWrK+uaDMdqCHH8+dkmlgnwGlSP1DcUpEzLxGfo0FMKgaZ/WG0OKtl81MjQ1Q==
X-Received: by 2002:a5d:590d:0:b0:20a:c3eb:2584 with SMTP id v13-20020a5d590d000000b0020ac3eb2584mr13912256wrd.18.1650894451657;
        Mon, 25 Apr 2022 06:47:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10-20020adf978a000000b0020ae0154f1esm1166419wrb.5.2022.04.25.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:47:31 -0700 (PDT)
Message-Id: <pull.1214.v2.git.1650894450441.gitgitgadget@gmail.com>
In-Reply-To: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
References: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 13:47:30 +0000
Subject: [PATCH v2] clone: die() instead of BUG() on bad refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When cloning directly from a local repository, we load a list of refs
based on scanning the $GIT_DIR/refs/ directory of the "server"
repository. If files exist in that directory that do not parse as
hexadecimal hashes, then the ref array used by write_remote_refs()
ends up with some entries with null OIDs. This causes us to hit a BUG()
statement in ref_transaction_create():

  BUG: create called without valid new_oid

This BUG() call used to be a die() until 033abf97f (Replace all
die("BUG: ...") calls by BUG() ones, 2018-05-02). Before that, the die()
was added by f04c5b552 (ref_transaction_create(): check that new_sha1 is
valid, 2015-02-17).

The original report for this bug [1] mentioned that this problem did not
exist in Git 2.27.0. The failure bisects unsurprisingly to 968f12fda
(refs: turn on GIT_REF_PARANOIA by default, 2021-09-24). When
GIT_REF_PARANOIA is enabled, this case always fails as far back as I am
able to successfully compile and test the Git codebase.

[1] https://github.com/git-for-windows/git/issues/3781

There are two approaches to consider here. One would be to remove this
BUG() statement in favor of returning with an error. There are only two
callers to ref_transaction_create(), so this would have a limited
impact.

The other approach would be to add special casing in 'git clone' to
avoid this faulty input to the method.

While I originally started with changing 'git clone', I decided that
modifying ref_transaction_create() was a more complete solution. This
prevents failing with a BUG() statement when we already have a good way
to report an error (including a reason for that error) within the
method. Both callers properly check the return value and die() with the
error message, so this is an appropriate direction.

The added test helps check against a regression, but does check that our
intended error message is handled correctly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    clone: ignore invalid local refs in remote
    
    Update in v2:
    
     * Subject line is improved to better match the message and fix.
     * I did not explore Ævar's idea to optimistically continue the clone as
       much as possible. That seems like a bigger change that could be
       investigated independently.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1214%2Fderrickstolee%2Frefs-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1214/derrickstolee/refs-bug-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1214

Range-diff vs v1:

 1:  6c9e85c5a98 ! 1:  9801123c534 clone: ignore invalid local refs in remote
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    clone: ignore invalid local refs in remote
     +    clone: die() instead of BUG() on bad refs
      
          When cloning directly from a local repository, we load a list of refs
          based on scanning the $GIT_DIR/refs/ directory of the "server"


 refs.c                 | 6 ++++--
 t/t5605-clone-local.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 1a964505f92..f300f83e4d4 100644
--- a/refs.c
+++ b/refs.c
@@ -1111,8 +1111,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (!new_oid || is_null_oid(new_oid))
-		BUG("create called without valid new_oid");
+	if (!new_oid || is_null_oid(new_oid)) {
+		strbuf_addf(err, "'%s' has a null OID", refname);
+		return 1;
+	}
 	return ref_transaction_update(transaction, refname, new_oid,
 				      null_oid(), flags, msg, err);
 }
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 7d63365f93a..21ab6192839 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -141,4 +141,13 @@ test_expect_success 'cloning locally respects "-u" for fetching refs' '
 	test_must_fail git clone --bare -u false a should_not_work.git
 '
 
+test_expect_success 'local clone from repo with corrupt refs fails gracefully' '
+	git init corrupt &&
+	test_commit -C corrupt one &&
+	echo a >corrupt/.git/refs/heads/topic &&
+
+	test_must_fail git clone corrupt working 2>err &&
+	grep "has a null OID" err
+'
+
 test_done

base-commit: 11cfe552610386954886543f5de87dcc49ad5735
-- 
gitgitgadget
