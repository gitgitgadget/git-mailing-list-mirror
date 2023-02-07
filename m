Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6008C6379F
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 16:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjBGQLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjBGQL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 11:11:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDF11644
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 08:11:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x9so8237476eds.12
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNEE6YngCWotKpo78uJw0gK0rvjn/jPkCMMbGmd8JdU=;
        b=isY7j5QH0SRYBWJwOiOBlSZeN6PQhuQMuJDpk26YfGzZC0mR2PnbSIS+D9ZIJ+E1c0
         83nafJp/7NZdkOKpbdzuoHu6zp3mq87C4CAmWzF6TYa/ZRpIP8zjm+45S6qYpb+E66uN
         hMJz/xx5JcPsRPUuRGggEiJ8d5Vw55SYV0n7WMKdXA2YStBM/bfxLRIm3cW9StCo+hB4
         A2cinpUlHXwQd3gXW3B82iB/hatC33JHwkiIWX3EuhYCo+YQjalk5a5E9P9LM3AyTkhi
         D55CPn6MTu5fd/aq7x5AoTD/ReIPE09ZQcfa6513HyFZhrBjWOoUT5HxUJZYn3zpzQWK
         5KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNEE6YngCWotKpo78uJw0gK0rvjn/jPkCMMbGmd8JdU=;
        b=7ARahFLbEURBL8+SAbW/v9ploVhTsJXoJP3z5zhKNT/VC06Go0roYmeUCi8nP06/po
         7clLQA/a+Bf2HS2B+caimTgn/6YPWz5bOHgyi71j9PI63leOvWiHCAbksbxlzBNvIJlF
         n5F9KdYOxGacj/8QXjtECbTd1qTW1//q7IXQ6vnsGfDa7QuB+2DnWtqyvqx/0UhLU9DH
         fRsybMtKTJBcPzlY8IvdEtTc+Wq3xwcFGA5mVgy5sAVXO1pnThxkMRmbDc2BfW9jb6Fg
         CLHh8fizxjxTj1EDoGuvMiDSam9Nu/GFYWoJ9Z4W898xPKz8PjedHBkgmNJDANS39biE
         Vafg==
X-Gm-Message-State: AO0yUKXHu4sWwRJv7y0sEJhdkixzK0ax3fshTEJhorpylf6qxYa2dqyr
        IW4ucWzOp0mOy3tQ8jN7P9r53uHPfjluhJJA
X-Google-Smtp-Source: AK7set+64gfqIZuw+vEsyQxKnuBSCjFOmTRvyqhD5/bTYPlsxRNHhz7O6yogPjTnkJKhMnlB17upzQ==
X-Received: by 2002:a17:906:280f:b0:85f:5d72:1841 with SMTP id r15-20020a170906280f00b0085f5d721841mr3756408ejc.39.1675786265965;
        Tue, 07 Feb 2023 08:11:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906080400b008a60ed04e42sm2401167ejd.110.2023.02.07.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:11:05 -0800 (PST)
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
Subject: [PATCH v5 10/10] for-each-repo: with bad config, don't conflate <path> and <cmd>
Date:   Tue,  7 Feb 2023 17:10:50 +0100
Message-Id: <patch-v5-10.10-4db3c6d0ed9-20230207T154000Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1430.gb2471c0aaf4
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
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
2.39.1.1430.gb2471c0aaf4

