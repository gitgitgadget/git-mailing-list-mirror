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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93CCC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D52610A2
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhETIUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhETIUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:20:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC59C061761
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j14so14923318wrq.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZGB6i2oJiRkl8UzFplpjDcK87CRCHvFjc33vqrxLSs=;
        b=S/dxIcMnoJE9zlfQ0ZIm0TPBy9pjDdTASkqtjqOYyQOrz9GkeSs/BGSFSo/LmkpC2A
         wSqyKsLliuP43B10L/jGrBRldSfPgprui2t/PFWe62otlK0AJ8ZMSJXma4+YAHw0wWWC
         2dgYLFZuoKbQgR2PgUjSW6CdTojqq8B8StEmErXkPOgogBPSvSTXjzhf7lx2/9onobaO
         06tmepGdyGKW+OjGtiVhYb8SChSixk0czEKCYXz0+OoCzcWNqvMIfwLzr7HqXiRe04El
         hCYJX0SiojuuKT1HbIzJAInCGyFcoFR/zkshhWeSKM5PQq+xtiJNbVz4Ig10SNLimobg
         UDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZGB6i2oJiRkl8UzFplpjDcK87CRCHvFjc33vqrxLSs=;
        b=B2Y3benHrKrlDfzh4yO2k7JZlb61idVfLcl/FV4OMikM5jPaVppao7IKAIklt0t2ZT
         KkfRAEQHvAzYsBy5HdrDe9d8ztK5t2g/us6N831iUUE2wILR7wmmZ65eh2E3wLf5MeDT
         7KBH0U6s4YNu8GjqmQyci2Uk2oZJ7uGBMK5s31YFmLCaN9Uuiit8wzKaA/+3H5g5yIri
         a3mt2hrEVO3n0ZzXtR370d/QT+ol24Zf4FwMPzTqcULcas49BStyU/NoI2GvKIh2bSCu
         Cu4Y2wU4vJ1Xk8pAQRenrzCxi/vGGpasoQo20JHxpFfa5JunKvGT6HhFKU18HzyhZBbp
         55Fw==
X-Gm-Message-State: AOAM531rOSi5Ao04NUOSBDRJHxOs21zqCp7WjRNZUbwat4iK+V66sKR3
        Fb5h4VDOd6yrqn0YXsqPtSv52D2q5ZMEkA==
X-Google-Smtp-Source: ABdhPJwUjS++IbKIxl0D9HjocBIJiFAK93dmrY9+vIHDnOONfvjThg44zQeDUinbYqk6Q9Snjvy9vA==
X-Received: by 2002:a05:6000:104a:: with SMTP id c10mr2960259wrx.45.1621498762057;
        Thu, 20 May 2021 01:19:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm8900004wmi.0.2021.05.20.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 01:19:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
Date:   Thu, 20 May 2021 10:19:07 +0200
Message-Id: <patch-10.10-97455f993d5-20210520T081826Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.405.g5d387561bb3
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com> <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
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
index 28b9a20a7f2..ff3008bfa34 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1981,7 +1981,7 @@ sub validate_patch {
 			require Cwd;
 			my $target = Cwd::abs_path($fn);
 			# The hook needs a correct cwd and GIT_DIR.
-			my $cwd_save = Cwd::cwd();
+			my $cwd_save = Cwd::getcwd();
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
diff --git a/perl/Git.pm b/perl/Git.pm
index a9020d0d01f..358a5f5625e 100644
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
2.32.0.rc0.405.g5d387561bb3

