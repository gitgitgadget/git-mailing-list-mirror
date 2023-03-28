Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112ADC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjC1OGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjC1OGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B5CC1B
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:05:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o32so7028148wms.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF0PYtt5n9HWgHVoGWzMnk9xS8YKsx0IF17BQ+px9dU=;
        b=bDeDbVXQxmXvwi6T86RGdrdaLw6NvZ1v9HDjxcmNf7ufu4jMfzGXVp41/AkiyhcbPj
         jqny+mAj1Zizg4SssbimcgtR/+xmsB472GgaETxoldCjH302JyydTlG8Uo6JdQJg37V3
         NjReGwMqPeZ9HkDwm04IFDxCWziu/5VeIAS9GJ/dWutBjZ13fKmdYi/djfPlj3JxtT7k
         tnAPmSA/UQALPXkmZ0Ak0Z/bntico/htnftuh/k0cFtIl/mtd6TNWnkZBCuDW26pUCmo
         FsMuHFFxlhRfi8D1JtRasS+QAaGFmRSmM2+PYhkm6z/rRW0d0ZqWHL69/cT/LMlXv0cA
         B7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF0PYtt5n9HWgHVoGWzMnk9xS8YKsx0IF17BQ+px9dU=;
        b=toY5pIzGd/EfGGE5P3iTgIOELfaqwqaJhCQTDC7SrFxsT1ZXOGtY1DBJ9pI/d0Tviq
         lV1wNBG6vxZiuaT+gjvQZ6m6Q6YOkVae3TWe2uXVCkUWcnycTxKTeTLlejmn6nain+Uk
         nm+mrNavhqTGG6mvqBdCoeZZ4BikRJ6VCMrZy0PbfUxkFf7NxuXk4e5iSBWAE9Z60ltx
         4jWTRW/GcRtJb3HaI63Bts53SIGgkDOUr2L+FhjqxlTrjmR9mtr4ofM/L3dCi2KYTBHd
         Aq9npjlPgs2G7Wbogb0z9TOmp7ipV+FAvlDlLxHLyFg/UMoMN3oTIjb7Do0834gV7d5Y
         yk6g==
X-Gm-Message-State: AAQBX9eHXV4dwJqvAS8vKH8+J8ysX/NyESDFDMKKte2jZkRyEKzKf3YL
        aqPFUvpIMRrnqOXwgX1+RnYw8pVbQOnFtQ==
X-Google-Smtp-Source: AKy350bVXFXrDfVujxK7QJOgtJQm4QhnfSIxOQdcc2H3EnayzAzHL26JVk9phwOvXn2GhLkcrKJ9bg==
X-Received: by 2002:a7b:cd8f:0:b0:3ef:6396:d9c8 with SMTP id y15-20020a7bcd8f000000b003ef6396d9c8mr8394274wmj.5.1680012285322;
        Tue, 28 Mar 2023 07:04:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 9/9] for-each-repo: with bad config, don't conflate <path> and <cmd>
Date:   Tue, 28 Mar 2023 16:04:28 +0200
Message-Id: <patch-v8-9.9-6fce633493b-20230328T140127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com> <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a logic error in 4950b2a2b5c (for-each-repo: run subcommands on
configured repos, 2020-09-11). Due to assuming that elements returned
from the repo_config_get_value_multi() call wouldn't be "NULL" we'd
conflate the <path> and <command> part of the argument list when
running commands.

As noted in the preceding commit the fix is to move to a safer
"*_string_multi()" version of the *_multi() API. This change is
separated from the rest because those all segfaulted. In this change
we ended up with different behavior.

When using the "--config=<config>" form we take each element of the
list as a path to a repository. E.g. with a configuration like:

	[repo] list = /some/repo

We would, with this command:

	git for-each-repo --config=repo.list status builtin

Run a "git status" in /some/repo, as:

	git -C /some/repo status builtin

I.e. ask "status" to report on the "builtin" directory. But since a
configuration such as this would result in a "struct string_list *"
with one element, whose "string" member is "NULL":

	[repo] list

We would, when constructing our command-line in
"builtin/for-each-repo.c"...

	strvec_pushl(&child.args, "-C", path, NULL);
	for (i = 0; i < argc; i++)
		strvec_push(&child.args, argv[i]);

...have that "path" be "NULL", and as strvec_pushl() stops when it
sees NULL we'd end with the first "argv" element as the argument to
the "-C" option, e.g.:

	git -C status builtin

I.e. we'd run the command "builtin" in the "status" directory.

In another context this might be an interesting security
vulnerability, but I think that this amounts to a nothingburger on
that front.

A hypothetical attacker would need to be able to write config for the
victim to run, if they're able to do that there's more interesting
attack vectors. See the "safe.directory" facility added in
8d1a7448206 (setup.c: create `safe.bareRepository`, 2022-07-14).

An even more unlikely possibility would be an attacker able to
generate the config used for "for-each-repo --config=<key>", but
nothing else (e.g. an automated system producing that list).

Even in that case the attack vector is limited to the user running
commands whose name matches a directory that's interesting to the
attacker (e.g. a "log" directory in a repository). The second
argument (if any) of the command is likely to make git die without
doing anything interesting (e.g. "-p" to "log", there being no "-p"
built-in command to run).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c  |  2 +-
 t/t0068-for-each-repo.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 224164addb3..ce8f7a99086 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -46,7 +46,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	err = repo_config_get_value_multi(the_repository, config_key, &values);
+	err = repo_config_get_string_multi(the_repository, config_key, &values);
 	if (err < 0)
 		usage_msg_optf(_("got bad config --config=%s"),
 			       for_each_repo_usage, options, config_key);
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 6b51e00da0e..4b90b74d5d5 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -46,4 +46,17 @@ test_expect_success 'error on bad config keys' '
 	test_expect_code 129 git for-each-repo --config="'\''.b"
 '
 
+test_expect_success 'error on NULL value for config keys' '
+	cat >>.git/config <<-\EOF &&
+	[empty]
+		key
+	EOF
+	cat >expect <<-\EOF &&
+	error: missing value for '\''empty.key'\''
+	EOF
+	test_expect_code 129 git for-each-repo --config=empty.key 2>actual.raw &&
+	grep ^error actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.0.rc1.1034.g5867a1b10c5

