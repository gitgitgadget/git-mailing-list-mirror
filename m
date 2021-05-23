Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A790C47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABC9610C8
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhEWI6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhEWI6B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:58:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B8C06138F
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so25280661wrs.4
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LRloA5jbWOWCIZFXLZ6FANZWgBZkMT0RGdVlQzw9ZQ=;
        b=pxDIYXLXxVTi1b9fzxX7wd9GcomNfGdRVokpbbB82gE+r9svoXWdb/4jYfzZsqXFAP
         XfBj25Nsi0TNj1v4fWOrtYhc4Ija/ymbfj0kRgct6AF9Cl+1ZfO1O9W+2TOk0tO5S74J
         sGv16Jd/rjmCh9BIQ6EegntimFWf/DAUEHQoDRrFlA7hzTh1/+7Rl/OOcNkNlcPpebbH
         4AQl/+imF3IafD4zc4eW52SJ67H30djMk6T7vC3Rc0o1QVg7L2c5ZqEdALxgplaICKWJ
         yjVzns+zkfwCqpUlu9+g04B2TetCUnqo/T1nP7pI0awp7k5T4rBsZnEsduYOZagEINOD
         K19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LRloA5jbWOWCIZFXLZ6FANZWgBZkMT0RGdVlQzw9ZQ=;
        b=GGAlB5SPu4UJILcgI5KVs1CEFYei2uy8t8bXyAatqrjPHks/mOSfOqcEydU0gvd1vK
         R1feL0kamDdvT4prw5NXbcsRQxG/HIGvwIMPVifLVL5wgYMzm+7cbEVQ3Qk3rfuyE4sb
         dsVlvy/vciiwrVxSuWlo0iNbvYmqtto2EeSK5pCLkbEIcNL3pa5nH8U2zImwllmSQ4bv
         6n0qFyn53LQyF6zpHm7mCmAr1h4K8ziq0y0jhIewWkPnvnhX2PgqNTCk8H0wUTX17xNz
         sztz34MR8LrbBMdNq4fBawwTvVGHnbFz4Uy5l1P9+Q2I6JlRO7KdHSdzf0OU6TWlkL61
         BVjg==
X-Gm-Message-State: AOAM5323N4JL65kqAVqKTZGXmbPs9kMmFlTcz9XvAo0iW+5B+rWcQp4H
        ECwmsQuhWcRYopE91ySzk7ry9rU5y73B+S0A
X-Google-Smtp-Source: ABdhPJzjR1kPELiBeuyfUOKQphqDNeCN9I3zREX7SylA+cnxUx1DlmJEzfcqlvj8ubTRvXsjH82OYA==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr17016154wrs.333.1621760192389;
        Sun, 23 May 2021 01:56:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:31 -0700 (PDT)
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
Subject: [PATCH v3 13/13] perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
Date:   Sun, 23 May 2021 10:56:18 +0200
Message-Id: <patch-13.13-c1d7ea664a-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
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
index 1ea4d9589d..c6af05e8a3 100755
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
index 4d048f307b..863bd80694 100644
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
2.32.0.rc0.406.g05cb3eebfc

