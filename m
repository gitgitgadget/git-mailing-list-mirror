Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB0C47080
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56352610CB
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhEXHzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhEXHyq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD4C06138E
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i17so27475661wrq.11
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmZF1K6akKO2NoqBiv4Wd4RQ+0R/LF2TragCyFcqPx4=;
        b=nO5kbQjK1z9NWXxWxAXAvB6Ki/X1WI1sIwHbVdNUHpnkd1PDfJyhYE7Q62nRBJCl9A
         V69jNbfbP7DjC0DXEmhY/6TiPFhxa4tScW1880CY45dceDRAqnUX2Kg5M31UyV+6riTj
         T9c2jEjA+SpGdvaCCsfQumc5MJ6W+1njYg8kc7/5vJUJFKtflPaGpEFAhpCZlpTteBb8
         M9cl/Y2u4yseVwgucxKiafj3JAFn5I3bpCTJbw53hKkieKulpR8F1t82IO5+tWkkFrxF
         QvuCQpa52f2id6EANyHBg2wfQfLftl5YkcAkgYHmvb0JqrsXbWsbjfgpBaIbkUinMcoX
         vNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmZF1K6akKO2NoqBiv4Wd4RQ+0R/LF2TragCyFcqPx4=;
        b=AEr1Ypux3AtPQq4PyQL9MaIE0bvy9oj6vk30bO4+IvmvZUiQyF3svrSJMGDXRyugfc
         7b9bmQ7c4OEw5f2McQwNgVvvuag0xq660rm5mnX4j19bybbWzchAgozY85NXLDF97Q3U
         8Q/nLibWYInimTkWvdWPiS37tPNfYKvVhXLBbhDUM2q3WXvpgrQDv6M7R6hu35Z4uQKH
         Mb9b61yT40tCSNRjM68hP4MFbqijCUaqpKeDyIP+ay7c2NfjQhpo9qHUHB44DciXqI5l
         cwMdQFQXhJ0z5OkOcG8j2g0ImstOi2BSg1FMXs1fiL249WO2N4QdlQJk/rfQDI8VNY9f
         VUig==
X-Gm-Message-State: AOAM532NGdP/WJNMjgRVHpgfpT6GLJKjAa75cJfijf8P+DV+Fw3BzWNi
        WuAeItE5+Mye6N9kOZvfYMnUOnFxTW4R7EXx
X-Google-Smtp-Source: ABdhPJzN4D4Hygx8+5IfPSwSROrkuqFpiJqIxX5lqnAg3GiRyqnAAaRl2h2h1yzMktjiC8o7rAFdbA==
X-Received: by 2002:adf:d20e:: with SMTP id j14mr20115808wrh.270.1621842796470;
        Mon, 24 May 2021 00:53:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/13] perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
Date:   Mon, 24 May 2021 09:53:02 +0200
Message-Id: <patch-13.13-d36b57e429f-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been pointed out[1] that cwd() invokes "pwd(1)" while getcwd()
is a Perl-native XS function. For what we're using these for we can
use getcwd().

The performance difference is miniscule, we're saving on the order of
a millisecond or so, see [2] below for the benchmark. I don't think
this matters in practice for optimizing git-send-email or perl
execution (unlike the patches leading up to this one).

But let's do it regardless of that, if only so we don't have to think
about this as a low-hanging fruit anymore.

1. https://lore.kernel.org/git/20210512180517.GA11354@dcvr/
2.
    $ perl -MBenchmark=:all -MCwd -wE 'cmpthese(10000, { getcwd => sub { getcwd }, cwd => sub { cwd }, pwd => sub { system "pwd >/dev/null" }})'
                (warning: too few iterations for a reliable count)
                             Rate                  pwd                 cwd    getcwd
    pwd                     982/s                   --                -48%     -100%
    cwd                    1890/s                  92%                  --     -100%
    getcwd 10000000000000000000/s 1018000000000000000% 529000000000000064%        -

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 2 +-
 perl/Git.pm         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1ea4d9589d8..c6af05e8a31 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2007,7 +2007,7 @@ sub validate_patch {
 			require Cwd;
 			my $target = Cwd::abs_path($fn);
 			# The hook needs a correct cwd and GIT_DIR.
-			my $cwd_save = Cwd::cwd();
+			my $cwd_save = Cwd::getcwd();
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
diff --git a/perl/Git.pm b/perl/Git.pm
index 4d048f307b3..863bd80694c 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -405,7 +405,7 @@ sub command_bidi_pipe {
 	if ($self) {
 		shift;
 		require Cwd;
-		$cwd_save = Cwd::cwd();
+		$cwd_save = Cwd::getcwd();
 		_setup_git_cmd_env($self);
 	}
 	require IPC::Open2;
-- 
2.32.0.rc1.385.g46e826f1e55

