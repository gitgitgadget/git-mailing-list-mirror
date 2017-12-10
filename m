Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C8A1F419
	for <e@80x24.org>; Sun, 10 Dec 2017 06:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdLJGxh (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 01:53:37 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45931 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbdLJGxg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 01:53:36 -0500
Received: by mail-lf0-f66.google.com with SMTP id f13so15819054lff.12
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 22:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=T4ehHvfIsITbKYP40ph3cU6Kk1y6yi1cgLLo6hWiNoI=;
        b=gz784GhfdPyCob8l8kKA9c51S29/asAm615O92S+OPih4Fyl/zSoimzJuWUlHc4Lds
         jlXQLIl/TlpxAfcVIcUeRYpFurG1jN0d+wYH8GMZHJ8M/bJuCGxxZc8eKApvxtF2d+hK
         5BvcQInc1dqlG7o4TxFbH/t+b+acvU3/WaSZfa7l0Y0cTqzvIveCilKVf2IBmzeXH8T9
         zmto7YlNgLDKqlE9WMWqcYq/cOWHkypCQG/qvEXhQQ2RiDTwjR1JMpaUgoqBvTe4Nu+G
         PpPZui332O6mLYuRBwAwU2cf82jw5U3SkUtIvXpHQMx1v9Bijvu9T7OR6DXKpqqwmp5Z
         1rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=T4ehHvfIsITbKYP40ph3cU6Kk1y6yi1cgLLo6hWiNoI=;
        b=oVNnkV9j95+xSuaDp6IRXS7c0YPp6eVyb/D4429CO/RspjGQtbLvy5lTO/nNaayAAt
         qmns1uOlOEqC3JWXclwfqN/kRXvWZ/ToWuMUGcuDwrONNKtgQp+1bLImaS56OR9nQyYp
         Ng+UyyVeXiduh3bh9VniIMtMk29jUUK7DxqlY9YR6U55zTNuTuM1GZoRemTIk103+lLu
         WEa7PLzrNLDLdaB3qO7GWAIcxX9Q1hXHIAujtaGGQ/rXmOV0JP9HCgnB521QC5Q7q4GE
         23l26OIQisAeZ+7rZrp6mLzbg+T2h0H6d788xel50pLjrAAS3OHVMz7KXt4Xgiobohzi
         SFtw==
X-Gm-Message-State: AJaThX4j9NzVQfdirEl4cOliALrS3cZNf/IVRa4WLYAKDfFt8cCM6Dg0
        l2qsA9iUQCJfsuiVD3K9pnqTbK3WDFg=
X-Google-Smtp-Source: AGs4zMZ0xB2PyuIN76/M7hhD7zGH5R0WN1DAGqmYc8VuoEIM5Q5Okh6tLhJRfil0v2nCuNeaBHaqWA==
X-Received: by 10.46.29.207 with SMTP id w76mr17830095lje.171.1512888814537;
        Sat, 09 Dec 2017 22:53:34 -0800 (PST)
Received: from localhost ([185.65.132.137])
        by smtp.gmail.com with ESMTPSA id j8sm2181582lje.83.2017.12.09.22.53.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Dec 2017 22:53:34 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/2] merge: add config option for verifySignatures
Date:   Sun, 10 Dec 2017 06:53:57 +0000
Message-Id: <20171210065358.8156-1-hji@dyntopia.com>
In-Reply-To: <20171209090530.6747-1-hji@dyntopia.com>
References: <20171209090530.6747-1-hji@dyntopia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git merge --verify-signatures can be used to verify that the tip commit
of the branch being merged in is properly signed, but it's cumbersome to
have to specify that every time.

Add a configuration option that enables this behaviour by default, which
can be overridden by --no-verify-signatures.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 Documentation/merge-config.txt     |  4 ++++
 builtin/merge.c                    |  2 ++
 t/t7612-merge-verify-signatures.sh | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index df3ea3779..12b6bbf59 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -26,6 +26,10 @@ merge.ff::
 	allowed (equivalent to giving the `--ff-only` option from the
 	command line).
 
+merge.verifySignatures::
+	If true, this is equivalent to the --verify-signatures command
+	line option. See linkgit:git-merge[1] for details.
+
 include::fmt-merge-msg-config.txt[]
 
 merge.renameLimit::
diff --git a/builtin/merge.c b/builtin/merge.c
index 612dd7bfb..30264cfd7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -567,6 +567,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
+	else if (!strcmp(k, "merge.verifysignatures"))
+		verify_signatures = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index 8ae69a61c..2344995a1 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -39,23 +39,62 @@ test_expect_success GPG 'merge unsigned commit with verification' '
 	test_i18ngrep "does not have a GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge unsigned commit with merge.verifySignatures=true' '
+	test_config merge.verifySignatures true &&
+	test_must_fail git merge --ff-only side-unsigned 2>mergeerror &&
+	test_i18ngrep "does not have a GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge commit with bad signature with verification' '
 	test_must_fail git merge --ff-only --verify-signatures $(cat forged.commit) 2>mergeerror &&
 	test_i18ngrep "has a bad GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true' '
+	test_config merge.verifySignatures true &&
+	test_must_fail git merge --ff-only $(cat forged.commit) 2>mergeerror &&
+	test_i18ngrep "has a bad GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge commit with untrusted signature with verification' '
 	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2>mergeerror &&
 	test_i18ngrep "has an untrusted GPG signature" mergeerror
 '
 
+test_expect_success GPG 'merge commit with untrusted signature with merge.verifySignatures=true' '
+	test_config merge.verifySignatures true &&
+	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
+	test_i18ngrep "has an untrusted GPG signature" mergeerror
+'
+
 test_expect_success GPG 'merge signed commit with verification' '
+	test_when_finished "git checkout initial" &&
 	git merge --verbose --ff-only --verify-signatures side-signed >mergeoutput &&
 	test_i18ngrep "has a good GPG signature" mergeoutput
 '
 
+test_expect_success GPG 'merge signed commit with merge.verifySignatures=true' '
+	test_when_finished "git checkout initial" &&
+	test_config merge.verifySignatures true &&
+	git merge --verbose --ff-only side-signed >mergeoutput &&
+	test_i18ngrep "has a good GPG signature" mergeoutput
+'
+
 test_expect_success GPG 'merge commit with bad signature without verification' '
+	test_when_finished "git checkout initial" &&
+	git merge $(cat forged.commit)
+'
+
+test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=false' '
+	test_when_finished "git checkout initial" &&
+	test_config merge.verifySignatures false &&
 	git merge $(cat forged.commit)
 '
 
+test_expect_success GPG 'merge commit with bad signature with merge.verifySignatures=true and --no-verify-signatures' '
+	test_when_finished "git checkout initial" &&
+	test_config merge.verifySignatures true &&
+	git merge --no-verify-signatures $(cat forged.commit)
+'
+
 test_done
-- 
2.15.1.356.g13e4cf275

