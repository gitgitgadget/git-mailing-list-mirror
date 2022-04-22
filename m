Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA8C4167D
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiDVJQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445857AbiDVJKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:10:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE251E6E
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k22so10115753wrd.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xgedhMa4ID+6ZRxWmK8qnafzwevXp3shayu7Vvskus=;
        b=G8+GJM32MEhqbg5MQPeJedmmasIySvWXNDtHT19qhUtDeCXXWxCHiINqHDxvNLlCWl
         h+PACWnV1ROXjXF36G1s1gGUe26Q4db5HuvOFJaGi/icGv30N/4SwB18b3NSaRHFI8WF
         6JJpjO8PKG8CMCJR40CpbVdlcNNyDDvDaisTMBSHW65XXAu4jeqsVv2+RscuE/b2RpJE
         O00RT/9Bg19l8lfXqoe75Ah7W8bmx9ecsgjF55ZAdlKYo05GeXA0Ax8h2ygcRm00tmpe
         qN8CnGasYT+bmCjp8XifmsreyD7NAEV14VVDQlgvd6+dJZNx2YoMnyky2MKtR1fNdyHy
         Rm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xgedhMa4ID+6ZRxWmK8qnafzwevXp3shayu7Vvskus=;
        b=LDmrFgb7MBOw0XqJCdLJOUDPs5iQ+MnXvhkYn5xsKmyRZ5KuiJ9JdCmzY6yKOW95Rb
         N4xI9Y/WOWgiHdHPaPC1BNoHaE3fxP+T/FylOp6Ml6HEQbpo1MhyMFlttCBAv7nRkwWc
         0oxe3/rKm648F0SHExNSOo+JoW1nJ3cHQeB0IcYcl50Lk4deUmEsdpGGtTJeEMBUQSpG
         4aL4ErMlRlrhBeLWG3Rtn2ybq6n0D6kICcj3TxdHTMhXqPNls6vZFpYjOJwMKTC2I69q
         XuL2LZWxAS+fyV12zW78slfD6hJj8/1tEKOCgWRlqQY1nLfMhKhWY3LKYJsmfaBKMA+Y
         JxqQ==
X-Gm-Message-State: AOAM530hB4tfhwuYQ3vwclKeA2WxBzQ4Snx5ef7QSK7fbdWaRwLo8urC
        8Cq6ju/2t43mquUyfnU7S/XXgRifSj48JA==
X-Google-Smtp-Source: ABdhPJzVmYB4GGlHuXHBqp54M/gYQEimWPqQCMqSvUG4Mi3nYLBB94jVWdcVWRPwLtbExqmHnTja7A==
X-Received: by 2002:a5d:4d91:0:b0:207:ac32:cffb with SMTP id b17-20020a5d4d91000000b00207ac32cffbmr2882217wru.644.1650618465056;
        Fri, 22 Apr 2022 02:07:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm1282700wmn.16.2022.04.22.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:07:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] CI: don't care about SHA256 mismatch on upstream "perforce" package
Date:   Fri, 22 Apr 2022 11:07:38 +0200
Message-Id: <patch-v2-2.3-2805e89623c-20220422T085958Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As can be seen in the commit history[1] of the upstream perforce.rb in
homebrew-cask the upstream perforce package URL and its SHA-256 are
aren't a unique pair. The upstream will start publishing an updated
package at the same URL as the previous version, causing the CI to
routinely fail with errors like:

	==> Downloading https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz
	Error: SHA256 mismatch
	Expected: ffc757b9d4d0629b2594e2777edfb18097825e29c70d8f33a444c7482d622806
	  Actual: 37bc306f0bdfd1d63cfcea113ada132d96f89d53cbb20c282735d51d06223054

Once someone gets around to updating the perforce.rb the failure of
git's CI will be cleared up, but in the meantime all osx-{gcc,clang}
jobs will encounter hard failures.

Let's not be so anal about this and fallback to a "sha256 :no_check"
on failure. For the "ubuntu-latest" jobs just a few lines earlier we
"wget" and chmod binaries from http://filehost.perforce.com (no
https!).

We're already trusting the DNS in the CI to do the right thing here,
and for there not to be any MitM attacks between the CI and
filehost.perforce.com. Even if someone managed to get in the middle
the worst they could do is run arbitrary code in the CI environment.

The only thing we were getting out of the SHA-256 check was to serve
as a canary that the homebrew-cask repository itself was drifting out
of date. It seems sensible to just cut it out as a middle-man
entirely (as the ubuntu-latest jobs do). We want to run the
t/*-git-p4-*.sh tests, not to validate the chain of custody between
perforce.com and the homebrew-cask repository.

See [2] for the "no_check" syntax, and [3] for an example of a failure
in "seen" before this change.

It's been suggested as an alternative [4] to simply disable the p4
tests if we can't install the package from homebrew. While I don't
really care, I think that would be strictly worse. Before this change
we've either run the p4 tests or failed, and we'll still fail now if
we can't run the p4 tests.

Whereas skipping them entirely as [4] does is introducing the caveat
that our test coverage in these jobs today might be different than the
coverage tomorrow. If we do want to introduce such dynamic runs to CI
I think they should use the relevant "needs" or "if" features, so that
the UX can make it obvious what was or wasn't dynamically skipped.

1. https://github.com/Homebrew/homebrew-cask/commits/master/Casks/perforce.rb
2. https://docs.brew.sh/Cask-Cookbook#required-stanzas
3. https://github.com/git/git/runs/6104156856?check_suite_focus=true
4. https://lore.kernel.org/git/20220421225515.6316-1-carenas@gmail.com/
---
 ci/install-dependencies.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 82fa87f97af..cab6e04a358 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,7 +37,14 @@ macos-latest)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew install perforce
+	brew install perforce || {
+		echo Installing perforce failed, assuming and working around SHA256 mismatch >&2 &&
+
+		path=$(brew edit --print-path perforce) &&
+		sed 's/\(sha256.\).*/\1:no_check/' <"$path" >"$path".tmp &&
+		mv "$path".tmp "$path" &&
+		brew install perforce
+	}
 
 	if test -n "$CC_PACKAGE"
 	then
-- 
2.36.0.879.g56a83971f3f

