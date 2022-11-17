Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3ECC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 01:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiKQBhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 20:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiKQBg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 20:36:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D27E532DF
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 17:36:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so551067wmg.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 17:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/S8dZZt2LeC+i/fxB4RfekrCK1LbkNcbS6QEmqUNlA=;
        b=N5rEq7YKDbigf/QMB1vTLWHbO3Qrj1hHCkEvBNdvxTVugjLvFpGqTWBlV8TchSZX8C
         67N7/pSMJ7/n1q21/Xgf2FI2DZwUwoDKJk2uFeVMpkbUC8UqM684tYMkzyYXdTL9nPfQ
         n4UWUCHLaEY7T/YZ1nYGMjmffrrT9cC9eiF6B+eNT9PZiskG9/RHiKxqXC3f8BnBouL2
         sxZPTmtwr4ZCgpf12a7kDqjNWlNy7h87pJyEGynk0tsZ3HEZAXxebV0Ywq0uEvradxZk
         ZHvVXp2qCos3krxI7EtPoh2nTxTaNnA/ZdwvPHSTykdfLkI5REf52bd1qSSFPbd6fBDj
         RjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/S8dZZt2LeC+i/fxB4RfekrCK1LbkNcbS6QEmqUNlA=;
        b=WgvnOYhoUxoHf94pYi3AcCnhrT6B+l+b2sC/sQu0uIteVxUBBspfY+IIrVLvGnJQxh
         Ke6+m3rFX8BqTRF409m2l+nh+Vl7u9nOXgLNIpb/o5vhP0tWLg3GqfrxStHjsl51z3xt
         DlIMFmCuM5PUduT2u32kJKjJZxaBg6Yem+UEmGKptAYrgBKxXGvdKQAhypqFjYoTzI45
         NtWzaADq2b/0rBXmp5Ad0nXHnjqwTnnt3FwjpIE7zj7QPC6XDnG/T7rhGXXqF6WCCxs0
         BcDKsNRQx0aKo35WnW3mzmZ+8oKzfa6G+ppjd3ngrT/FVCVa6AMDU2Q1aPJbuOyULS9Y
         2B2Q==
X-Gm-Message-State: ANoB5pmVWZcVtV1fH6zfdFuFeepW3yamlqLs0LN2kYZLTKXnVcpKfh6U
        nszF2QFv43EyKhuDmbaNzaCUjgQ1CS8=
X-Google-Smtp-Source: AA0mqf6i4sFFNC/sBu6VczUopsnsILmnTfSydTGIRlgiV7hJ4h0vGIslm5b9JfELpGx3PosduGWmBA==
X-Received: by 2002:a05:600c:41c7:b0:3cf:a0f4:7879 with SMTP id t7-20020a05600c41c700b003cfa0f47879mr3713038wmh.152.1668649013708;
        Wed, 16 Nov 2022 17:36:53 -0800 (PST)
Received: from [192.168.2.52] (104.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.104])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c13c500b003cfb7c02542sm3425863wmg.11.2022.11.16.17.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 17:36:53 -0800 (PST)
Subject: [PATCH 1/2] branch: force-copy a branch to itself via @{-1} is a
 no-op
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
Message-ID: <db182322-1383-4311-8baa-c4a9aeed3b4d@gmail.com>
Date:   Thu, 17 Nov 2022 02:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 52d59cc645 (branch: add a --copy (-c) option to go with --move
(-m), 2017-06-18) we can copy a branch to make a new branch with the
'-c' (copy) option or to overwrite an existing branch using the '-C'
(force copy) option.  A no-op possibility is considered when we are
asked to copy a branch to itself, to follow the same no-op introduced
for the rename (-M) operation in 3f59481e33 (branch: allow a no-op
"branch -M <current-branch> HEAD", 2011-11-25).  To check for this, in
52d59cc645 we compared the branch names provided by the user, source
(HEAD if omitted) and destination, and a match is considered as this
no-op.

Since ae5a6c3684 (checkout: implement "@{-N}" shortcut name for N-th
last branch, 2009-01-17) a branch can be specified using shortcuts like
@{-1}.  This allows this usage:

	$ git checkout -b test
	$ git checkout -
	$ git branch -C test test  # no-op
	$ git branch -C test @{-1} # oops
	$ git branch -C @{-1} test # oops

As we are using the branch name provided by the user to do the
comparison, if one of the branches is provided using a shortcut we are
not going to have a match and a call to git_config_copy_section() will
happen.  This will make a duplicate of the configuration for that
branch, and with this progression the second call will produce four
copies of the configuration, and so on.

Let's use the interpreted branch name instead for this comparison.

The rename operation is not affected.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c                      |  6 +++---
 t/t3204-branch-name-interpretation.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 15be0c03ef..a35e174aae 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -584,13 +584,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	strbuf_release(&logmsg);
 
 	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
-	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
-	strbuf_release(&newref);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is renamed, but update of config-file failed"));
-	if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
+	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is copied, but update of config-file failed"));
+	strbuf_release(&oldref);
+	strbuf_release(&newref);
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
 }
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 793bf4d269..3399344f25 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -57,6 +57,16 @@ test_expect_success 'create branch with pseudo-qualified name' '
 	expect_branch refs/heads/refs/heads/qualified two
 '
 
+test_expect_success 'force-copy a branch to itself via @{-1} is no-op' '
+	git branch -t copiable main &&
+	git checkout copiable &&
+	git checkout - &&
+	git branch -C @{-1} copiable &&
+	git config --get-all branch.copiable.merge >actual &&
+	echo refs/heads/main >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'delete branch via @{-1}' '
 	git branch previous-del &&
 
-- 
2.36.1
