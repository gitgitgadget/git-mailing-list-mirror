Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E32DC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E80460E8F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 06:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhJ0Ghr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 02:37:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0Ghq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 02:37:46 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mi4un-1nAXQV0SH3-00e5Kr; Wed, 27 Oct 2021 08:35:10 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id D29911E01E7;
        Wed, 27 Oct 2021 06:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qz5pErqzgX0C; Wed, 27 Oct 2021 08:35:08 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (19-usr-pf-main.vpn.it.cetitec.com [10.8.5.19])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 302711E01E6;
        Wed, 27 Oct 2021 08:35:08 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Wed, 27 Oct 2021 08:35:07 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Fix "commit-msg" hook unexpectedly called for "git pull
 --no-verify"
Message-ID: <YXjzGzcXS/zPgk0W@pflmari>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
X-Provags-ID: V03:K1:tHHPmImvRq/Vbmh3gdCVDUCQN2es1WXZz2ywwnsqJcUfUdZ7ww8
 nBlip9sUK09oDqr1G6Pt0ZmaaZJb/Cfyki2R8hj2g4wMBbvX6ZqcAO3St04GAz3RS79+9zh
 9OK9aRZ7UQ0YgRf7Dr7/y1qEPVGRhm9VH0R6jnqMbk7pdYg5xNyuPcr2ODnY3vUpXh6OTZO
 J7mtxeLS+vKz16YMWmobA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UGyJv30LRi0=:m2n/I0zAQgG6dh+SozgKl4
 d+17oGDCfcVlZawGaqbM/t/GFnorYGDBsXC9sWGpG+gP6Z3/IOihbILh6SX56UlN/KlWJ4/Cq
 ztvGD828Y8N9MHSyR+APuxfPSrAS+UF3gT2RaRWqxS1j0xY7fnPd3/w7F1lSpFGc37DBC26bm
 anJaGYKGFJBJ3rib5rCjwAWljkOlBw+kJHZn7Yo9z1cpsm1aVo4dTDouAgZAn5Z5NVZAJbyFS
 a/dMnO0Hj+NpyzTv7YGJn6cZ9Am+xsPPEuSYsKe79uXD9WeQoVi9DoQZZBRi8j3Y7jqqzHfkv
 T0qvCjUXFUWUA52v6S+P/jLnMQdvLBC7h6gEh4azn0j9zL51kL0MP2gDwpZrTigT/aaJGzRz2
 qDkIVePDMNyr3iJkwVM7nUNhEV1Ts+oZs3R1lRWj/v9/rACLWb5kIrQEVuaeMQ7BvM4euvXKr
 OOjXaB6tvcNqvAAktUC5i2OUYhRdaKuRGM6vCXMo+JJ20ye0PBRq8f4OGYbSJXX31CRDGJ8pw
 RTu0jm2VqiPMSxJobpK/dZknzjUDcbphGPVppx2Avg1GWOwIlXye7lVBpa6lffIKWLlhKnY8v
 TfrnYe97d+9wnPoRuoU4KpqhmAZHscEMDA73wYCF86fD8xNIRItttV/VjD3VVs87ux/FOZgnO
 +rx/jR/Kb1grxwytYfNmPUuL5/+MLzwSKeyLHwjimVsudhV9x69N0Nvb8b3ON3QNf6bwqraql
 Vr1OE8gxX5HsZOdh
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option is incorrectly translated to "--no-verify-signatures",
which causes the unexpected effect of the hook being called.
And an even more unexpected effect of disabling verification
of signatures.

The manual page describes the option to behave same as the similarly
named option of "git merge", which seems to be the original intention
of this option in the "pull" command.

Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
---

Jeff King, Tue, Oct 26, 2021 23:16:09 +0200:
> On Tue, Oct 26, 2021 at 02:11:22PM +0200, Alex Riesen wrote:
> > +test_expect_success 'git pull --no-verify flag passed to merge' '
> > +	test_when_finished "rm -fr src dst actual" &&
> > +	git init src &&
> > +	test_commit -C src one &&
> > +	git clone src dst &&
> > +	echo false >dst/.git/hooks/commit-msg &&
> > +	chmod +x dst/.git/hooks/commit-msg &&
> 
> This script without #! should work portably, I think, though we
> generally prefer using the helper (which also handles the chmod):
> 
>   write_script dst/.git/hooks/commit-msg <<-\EOF
>   false
>   EOF
> 
> Other than that nit, this looks good to me.

Updated. Certainly looks nicer.

 builtin/pull.c          |  6 ++++++
 t/t5521-pull-options.sh | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 425950f469..428baea95b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,6 +84,7 @@ static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static char *opt_no_verify;
 static int opt_autostash = -1;
 static int config_autostash;
 static int check_trust_level = 1;
@@ -160,6 +161,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "no-verify", &opt_no_verify, NULL,
+		N_("bypass pre-merge-commit and commit-msg hooks"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -688,6 +692,8 @@ static int run_merge(void)
 		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		strvec_push(&args, opt_ff);
+	if (opt_no_verify)
+		strvec_push(&args, opt_no_verify);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
 	strvec_pushv(&args, opt_strategies.v);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..7d3a8ae0d3 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -225,4 +225,16 @@ test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'git pull --no-verify flag passed to merge' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	false
+	EOF
+	test_commit -C src two &&
+	git -C dst pull --no-ff --no-verify
+'
+
 test_done
-- 
2.33.0.22.g8cd9218530

