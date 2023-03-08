Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC21AC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCHJIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCHJIE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:08:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C7A4B1D
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p26so9328330wmc.4
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF0PYtt5n9HWgHVoGWzMnk9xS8YKsx0IF17BQ+px9dU=;
        b=ghwPWwh3fm8DCURoZlue6IJhGTWIs60NrRYXtxJR34a2hFDCfxze1zDghdJyy3122Y
         bQApgSHbhUYiL9KhDop4ZNEBXO2GSypTRLEgkm3grA5E67xK8KFTddwLF69abcYIL+0i
         U5sWvYrQgguUGTylejz9HIwLGTD0p6wqX8HgpPctWCgCV9sV3P2q8JTyWNloJ3dk4MNU
         lvAD5vJKQtCMOIZEKYPdf27aRwqo67nu1tgPYk2g9PofN42yZhp0oHD9qGZuTlF+fK7E
         dpK1q4d55/EWeiUPXju/NpWSvp1wwjUQ6Fr+f++5FFabxZhuf613gt6mhP/7pQP5BG4R
         l1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF0PYtt5n9HWgHVoGWzMnk9xS8YKsx0IF17BQ+px9dU=;
        b=c9uMQfBoEuZQgP+gWQRqUEQXk8yuZ8THWSoX9R9mR5zA1PpT7Oa0WtPW6ZqeudiQKt
         gIL1Rp0nR0c8/EDsFj5ojFSjyQ6rpRuLxDtpXIAFOQxMn7q8lDX/iFhjmL3e/x1lo1Mu
         fdnHReAPBOeZ3rRgXh4iDK7jqWbp+zpxWVRFKvcOfAMzXzoeZG5Mrlkz+X5N8rqee8ZG
         adVf/lzQ79u3t03+iHDo0qou37qo+TUCtW/5vlhZdO/NogcaufgPq1P/qgh4f/Cf4tkJ
         VFzKQPSmNcHKP29NO1U2d3uLINTT+A9fwG/mUmX1v2mmPD13m/XKEaCkMnOxE+or5Aob
         ZXcA==
X-Gm-Message-State: AO0yUKVIwRMC6/yIFF1+E3PtTRcfLaXHXncXi81lLmHzytg0QsbKom/1
        oyr746GMdoOL/L5U/IYFYT/uqfVk0mcK7A==
X-Google-Smtp-Source: AK7set/TBoyWO7o1jdBuDSgbYyD/yfb8xek25QUXJ7mNAJWDYb/mhonVXRQfKR8B/Pnd8wzwI4tNhw==
X-Received: by 2002:a05:600c:5254:b0:3eb:432d:8279 with SMTP id fc20-20020a05600c525400b003eb432d8279mr16413523wmb.13.1678266447176;
        Wed, 08 Mar 2023 01:07:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:26 -0800 (PST)
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
Subject: [PATCH v7 9/9] for-each-repo: with bad config, don't conflate <path> and <cmd>
Date:   Wed,  8 Mar 2023 10:06:51 +0100
Message-Id: <patch-v7-9.9-6791e1f6f85-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
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

