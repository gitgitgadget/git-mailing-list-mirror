Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEFC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C6D613AB
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhE1J0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbhE1JZv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A1C06138F
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q5so2592245wrs.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fkdJxmF6FhRLfxsGl5M79qLuD3sqvanHP5RvQKO2lYU=;
        b=eZBkgJMaFUDDCP0lRWKFkNp5P8LsrRZAub/Y/h1QjVxOX/Y0LKkRm7vClr97C73Yd6
         ZK7+Bzf/8EAcI+9cRVd3BegFh3mfcilTmziev1JoSGiu9+kxETNeeRFuFNh9LoCf2wGp
         ecRyaJ19N/FtSoWzA5cpB+ITPK9Ruco+BQxvvgebUJYKRvDBbPbcS+ke1HJAwKR6IWKk
         /h5p8FDEGSwTAiV9BXyCAdBBGVENhK4xIQk6mvalIeKdKMdVew0zhu0xwB1qmMnUcaV3
         cmcy28sxv7H6XjECoqhSyM/UbY2NUahyrt4yhCHrnjjta6INCEpvu+SO40BdSK2eA1Rq
         qoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkdJxmF6FhRLfxsGl5M79qLuD3sqvanHP5RvQKO2lYU=;
        b=C8mUxh9v0b1d/COcKDQ+Cyxw39hCkaobwU45bgyrSFT3TfWQVJEJuoRt3nQSa7i+s/
         bBWwmVCIE3S2BjGt+J9rl7Lgt9fpwXK3cd5vJMMOePRjtm3kW8PpeY/GKkrwPtzOfKXn
         IaGtjtFJ1iUpViKfVsrUxZ1z0/TlBTi4PeXkHjpZjlqc0DXE8fwWOgkBWDjNzA3ThJWY
         6kMNclUG5xo/NLafKKwzC2ZHlooOXZOH4coeDAg8oOZ2pO9jl1ah/TxbfWNnuwcACTWt
         VvhgIQm08DCT75/nQPuMVrIT8feOF2R/zJjKxwFu9Qkyqb7qZpSEmXUT1IncqZT29+6Y
         c/lA==
X-Gm-Message-State: AOAM530NKCgdj7Oc3LxXXwu4oFAWvSr1i6UPIQI62iXFt6IFtq+Fvbxx
        l25qbV9Q0WPR/bhZIhHYRGlNI+XmaE7cOA==
X-Google-Smtp-Source: ABdhPJwUpbz2ibhkOEaDtUo7wrlU54t/wmMdWe0UsIMfkhx2d12GESyJAsEroyUAYKvsqGczZKXHwg==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr1476136wrt.169.1622193846067;
        Fri, 28 May 2021 02:24:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:24:05 -0700 (PDT)
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
Subject: [PATCH v5 13/13] perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
Date:   Fri, 28 May 2021 11:23:52 +0200
Message-Id: <patch-13.13-aa3a2de7047-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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
index 57911386835..0efe85c0b02 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2020,7 +2020,7 @@ sub validate_patch {
 			require Cwd;
 			my $target = Cwd::abs_path($fn);
 			# The hook needs a correct cwd and GIT_DIR.
-			my $cwd_save = Cwd::cwd();
+			my $cwd_save = Cwd::getcwd();
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
diff --git a/perl/Git.pm b/perl/Git.pm
index 5562c0cede2..090a7df63fc 100644
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
2.32.0.rc1.458.gd885d4f985c

