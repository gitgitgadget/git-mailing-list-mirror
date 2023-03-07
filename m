Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8278C6FD1B
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjCGS3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjCGS3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:29:12 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A21B04AA
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:22:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so56073186eda.7
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678213326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEZGWhavCn6friGrrMstoVKTk7A1i01dm9SPWNQg92I=;
        b=AuFj8EbeBqCyxcUVJE6C97yQ7dOI6cicZ8bTlwZSz9b6iyhshMzddq0SU4aQs5uqMq
         dBbD1jJOVUOUITxWsXTCaC4jCBgP9RcF4/PQfwE7MnPAoYcTrrvK+ZM1OoShpi4rs7/6
         TJFVjpPUusGv7YTFaneFmP3EKEDjWHtWJvkXWxVYaR0879RPmgjA18rx4pZmlunNXhHZ
         ImUtQacJC5sJagQlTWfCh76kJ1v/QxBeuO3RqZC4odT3qUAGTm+hY6OlA1znK7LtL61h
         yAiCxgqoFM5VrvRANgzzOShQsDpZmopaQUTZiPIU4AteZa3t+E7AcE4IcCxQoM5IkGJm
         VEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEZGWhavCn6friGrrMstoVKTk7A1i01dm9SPWNQg92I=;
        b=Ckecr12NRcD+NYbEaSLwPqqFnvwYTBhTOFLL9kmNu7YsArEMBZxReW7eqaN3u0cKnr
         3D3RYovhnmErjcX08pcMMj4vNFBkQbLIXA9eRW9Vf6QI0f70u3qoNDX7ioKmNVQdBmyb
         VFZbogKgxnyWciAS+7Nq0xrvGtwPVaouToS0pC/e5x31Fkiq5Zb0PFxT6ekUBT8KkDcF
         E3ibOcaJqENDR/DZdS0rx96buBVNWF59AEhHFD09Bg9i5esGza0qiRBUdqLhjmH7RlD3
         9BHmouGVDVEup5TNfawcrfCaGXmJ0qubG0oc+csQL/u605H1UKaCGfkPxfXKvtKYOiOh
         W4dQ==
X-Gm-Message-State: AO0yUKW1L6UZIla8ov6NGRcdq5w6W8k3G2j8WlVG09p9ghNDm1BNfWSj
        y/uytY0G3PhU1CYuyKFqdWVAjsMkcGtMlQ==
X-Google-Smtp-Source: AK7set87j9lig59rM/3M/ZiFFqrsdX4WfB2H0Edq8+qwQAZZve/urC5UNtleq9Xy47ETPVH6Zyik1g==
X-Received: by 2002:a17:906:5dcb:b0:8b1:7eb7:d53d with SMTP id p11-20020a1709065dcb00b008b17eb7d53dmr17251534ejv.49.1678213326275;
        Tue, 07 Mar 2023 10:22:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906c18e00b008b1b86bf668sm6398548ejz.4.2023.03.07.10.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:22:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] sequencer.c: fix overflow & segfault in parse_strategy_opts()
Date:   Tue,  7 Mar 2023 19:21:59 +0100
Message-Id: <patch-1.1-f6a06e25cf3-20230307T182039Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The split_cmdline() function introduced in [1] returns an "int". If
it's negative it signifies an error. The option parsing in [2] didn't
account for this, and assigned the value directly to the "size_t
xopts_nr". We'd then attempt to loop over all of these elements, and
access uninitialized memory.

There's a few things that use this for option parsing, but one way to
trigger it is with a bad value to "-X <strategy-option>", e.g:

	git rebase -X"bad argument\""

In another context this might be a security issue, but in this case
someone who's already able to inject arguments directly to our
commands would be past other defenses, making this potential
escalation a moot point.

As the example above & test case shows the error reporting leaves
something to be desired. The function will loop over the
whitespace-split values, but when it encounters an error we'll only
report the first element, which is OK, not the second "argument\""
whose quote is unbalanced.

This is an inherent limitation of the current API, and the issue
affects other API users. Let's not attempt to fix that now. If and
when that happens these tests will need to be adjusted to assert the
new output.

1. 2b11e3170e9 (If you have a config containing something like this:,
   2006-06-05)
2. ca6c6b45dd9 (sequencer (rebase -i): respect strategy/strategy_opts
   settings, 2017-01-02)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

CI & branch for this at
https://github.com/avar/git/tree/avar/sequencer-xopts-nr-overflow

Not a new issue, but I figured with other discussions in this area
kicking this out the door sooner than later was better.

 sequencer.c                    |  9 +++++++--
 t/t3436-rebase-more-options.sh | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..79c615193b6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2876,13 +2876,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 {
 	int i;
+	int count;
 	char *strategy_opts_string = raw_opts;
 
 	if (*strategy_opts_string == ' ')
 		strategy_opts_string++;
 
-	opts->xopts_nr = split_cmdline(strategy_opts_string,
-				       (const char ***)&opts->xopts);
+	count = split_cmdline(strategy_opts_string,
+			      (const char ***)&opts->xopts);
+	if (count < 0)
+		die(_("could not split '%s': '%s'"), strategy_opts_string,
+			    split_cmdline_strerror(count));
+	opts->xopts_nr = count;
 	for (i = 0; i < opts->xopts_nr; i++) {
 		const char *arg = opts->xopts[i];
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 94671d3c465..195ace34559 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -40,6 +40,24 @@ test_expect_success 'setup' '
 	EOF
 '
 
+test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
+	cat >expect <<-\EOF &&
+	fatal: could not split '\''--bad'\'': '\''unclosed quote'\''
+	EOF
+	test_expect_code 128 git rebase -X"bad argument\"" side main >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
+	cat >expect <<-\EOF &&
+	fatal: could not split '\''--bad'\'': '\''cmdline ends with \'\''
+	EOF
+	test_expect_code 128 git rebase -X"bad escape \\" side main >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
 test_expect_success '--ignore-whitespace works with apply backend' '
 	test_must_fail git rebase --apply main side &&
 	git rebase --abort &&
-- 
2.40.0.rc1.1034.g5867a1b10c5

