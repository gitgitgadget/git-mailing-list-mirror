Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E0C43217
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiKDN0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiKDNZp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2922F3A5
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:24:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so13369639ejd.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PDD8EjVnRMIRM9lXuA12DnnRY5iFg8ZCyK7/Aekmso=;
        b=ZS6fhqbTYuxyLF4HLq4Z4lpvfV+2eqe0HY5Kkj7h5+o5xGlhpGggVfzjmcZQ3GResw
         2+al23yp0Nc3qZEhs3YfflgAFwqoTCg29uLuaEVbTA/A0XBPPlcWidc8ePSncp7eX0wj
         P7CaC35jFgMtZz3I7rkfa3vPgWQa5/NSwB7yfj0h96T3PPXW47YYibuxRZDwX76ZQqcD
         3EjU3RIcfJ7G7eFlk3BAEeABU8wC+abziv7YVvWafOXuiK6AGu8Z1hRWV1a4m7fnP1ba
         3pwBxqonVsrncJE0AS/FI/6XogPQaSuqbg8BcesFQ7bZDYP0f8TDmhaRm5fXfcKwQeW8
         yP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PDD8EjVnRMIRM9lXuA12DnnRY5iFg8ZCyK7/Aekmso=;
        b=wmKSIQOsQmPN/bs8qunWjXj30RVLMGePAh1AUERZtF2et1Cmv5PW/E8/Kc9GmZKSA+
         x9K9PMBLB1t0rkn25npYdXzRXD3SAxI0j/30ZOTFrUmRurh/JdruKC212OUyLJx7YoPQ
         qCRLZe+2T/Cb2aL7nqmBA9xQ2lg+N+26zFJBosLsA/Y8PraTAEq5KOU0Ru5ixk0Intaa
         h32w7wv+JFyCmoMqVOLpG4uZIQGAfoAaOlFX5+UFk5QSiDZpR1h9WPD+sbj7TDgj4/9P
         +nIgah4qfixftnLojGRu2lxsnj9izCcstzi/slfzIfDrvIyP/W5h21Vr9E1Vyjo3h2zw
         k07A==
X-Gm-Message-State: ACrzQf0lYeybtFGEuvcku6XvsJ673JrSmQ1XVEonJyZgex0RuIj92Fv/
        /j2Fhq6Goa2QQhGWNTzF6D5ElzX4nkYo6w==
X-Google-Smtp-Source: AMsMyM7oyfH3MmC5viKHOD0nOaxTZrj5VdRi3Dd6MdRckX/x5C7+vsysYbcHw/4Z4pkN13Qw2MK8Zg==
X-Received: by 2002:a17:906:f89a:b0:7ac:2e16:a8d2 with SMTP id lg26-20020a170906f89a00b007ac2e16a8d2mr307370ejb.584.1667568295763;
        Fri, 04 Nov 2022 06:24:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/13] bisect: fix output regressions in v2.30.0
Date:   Fri,  4 Nov 2022 14:22:40 +0100
Message-Id: <patch-03.13-03d704ca26f-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13) reimplemented parts of "git bisect run" in
C it changed the output we emitted so that:

 - The "running ..." line was now quoted
 - We lost the \n after our output
 - We started saying "bisect found ..." instead of "bisect run success"

Arguably some of this is better now, but as d1bbbe45df8 did not
advocate for changing the output, let's revert this for now. It'll be
easy to change it back if that's what we'd prefer.

This does not change the one remaining use of "command.buf" to emit
the quoted argument, as that's new in d1bbbe45df8.

Some of these cases were not tested for in the tests added in the
preceding commit, I didn't have time to fleshen those out, but a look
at f1de981e8b6 will show that the other output being adjusted here is
now equivalent to what it was before d1bbbe45df8.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect--helper.c    | 8 +++++---
 t/t6030-bisect-porcelain.sh | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7dd90da72d3..ee1509c198a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1192,6 +1192,8 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 	sq_quote_argv(&command, argv);
 	strvec_push(&run_args, command.buf);
+	strbuf_reset(&command);
+	strbuf_join_argv(&command, argc, argv, ' ');
 
 	while (1) {
 		printf(_("running %s\n"), command.buf);
@@ -1257,13 +1259,13 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		if (res == BISECT_ONLY_SKIPPED_LEFT)
 			error(_("bisect run cannot continue any more"));
 		else if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
-			printf(_("bisect run success"));
+			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			printf(_("bisect found first bad commit"));
+			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'git bisect--helper --bisect-state"
+			error(_("bisect run failed: 'bisect-state"
 				" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 478e74e1f0f..30124b6f059 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -285,7 +285,7 @@ test_bisect_run_args () {
 	test_cmp expect.args actual.args
 }
 
-test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' '
+test_expect_success 'git bisect run: args, stdout and stderr with no arguments' '
 	test_bisect_run_args <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	EOF_ARGS
 	running ./run.sh
@@ -295,7 +295,7 @@ test_expect_failure 'git bisect run: args, stdout and stderr with no arguments'
 	EOF_ERR
 '
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' '
+test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' '
 	test_bisect_run_args -- <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<-->
 	EOF_ARGS
-- 
2.38.0.1452.g710f45c7951

