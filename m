Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC6C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385192AbiDUM4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386066AbiDUM4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:56:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084F33364
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:54:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so6602799wrc.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKyiE99h+4gVEf89FPdhcdo/DI09Tntri9egZ/vWudg=;
        b=k1q5pyczyTh/HQD55uJnz5DQRYff1cTr0vbBwh0lYLDuJdxJUh+ob3GDgzILTe1Db1
         //9ob93vGh1wFzpL1OJSfOSXjzs0jbM4hpzPZnxmA6CPemzw/rE3CWkK0urmIBzkSEVM
         ZLU3eJExfrfcKZsfVQ4ZrzBFMClyrFwiy20YONY2lDAiqFYg+Dp9cdXjKFqEZPd4kDc1
         qCnfN2Fq3ywZUfDuevKkv1AyX77Pf9CSvFKCorYvIeSHWoS3K5ZoXt2UWDS9HmUBb77T
         ws3BYliD6e/Dlekcxa8SmVWUkAEcOXY6cSc/S1iy3aOj3rcHZNJCstICKtPwwo/cXJ8k
         piXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKyiE99h+4gVEf89FPdhcdo/DI09Tntri9egZ/vWudg=;
        b=CWVmye6krtBJsEJ1x7s3HoIlEie+/6zGeGa8BeupkEfE/cmPZiO/IUQkPjiQOvVOti
         HcZyBu3N2dW5HQMbp4XFrEbTws1k2rEeLv0e3UF0BVokwEqPh8kr8M8RW0u4NdBPyGye
         dOl8Mg7PGO8SKVZbMpznjyt3TMPXR6ccB2hqfTebWDDSY93RNZ6idf2aQrQKV4W06DMO
         lenJ37LwZRtiL7SKVIeSZpjpNFw28kjQ0IocsROiVSB5giIYPmtDTnvQ/UUYmSN14uDP
         yoPlQvMdBjBzToQi+zBon9waNsVTl0LGYbb+q8EgbImYozNB+JgnJpkYzd3DHA5LdEGA
         JHzQ==
X-Gm-Message-State: AOAM533TZ0sJUIORbjjYG/UGcWI+Kz7IKxc5KQXspZz5zcnCGkLZRiRt
        CaPWMXPruaBMCxD0PKFqZWjUg64YnrsV6A==
X-Google-Smtp-Source: ABdhPJwGH1nOF2caCizxl7T60NwxH85CN6sBvNKF9PLZliycvv16eLmF/BkAuRJ8SHKrsAj1f19KrQ==
X-Received: by 2002:a05:6000:8c:b0:207:a4dc:dfab with SMTP id m12-20020a056000008c00b00207a4dcdfabmr19113946wrx.441.1650545638503;
        Thu, 21 Apr 2022 05:53:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm2163685wmn.16.2022.04.21.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:53:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream "perforce" package
Date:   Thu, 21 Apr 2022 14:53:52 +0200
Message-Id: <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.876.g4bfefc07680
In-Reply-To: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
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
on failure. We are already downloading arbitrary binaries from
perforce's servers, and the point of doing so is to run the
t/*-git-p4-*.sh tests, not to validate the chain of custody between
perforce.com and the homebrew-cask repository.

In the obscure (but unlikely to ever happen) that the failure is
specifically because perforce.com published a bad updated package, and
it a failure that their testing wouldn't have caught, but whoever's
updating the homebrew SHA-256 recipe would have caught, we will have a
failure in our p4 tests that we wouldn't have otherwise had.

But I think that's so unlikely that we don't need to worry about it,
whereas seeing failures due to the homebrew recipe lagging upstream is
a real issue. E.g. "seen"'s latest push-out has such a failure: [3]

Note: It's probably possible to embed this "sed" one-liner directly in
the HOMEBREW_EDITOR variable, i.e.:

    HOMEBREW_EDITOR='...' brew edit perforce

But my attempts to do so were unsuccessful, particularly since I don't
have access to a Mac OS X machine other than via by round-tripping
through the CI. This version of getting the path via --print-path
works, and is arguably easier to reason about and debug than a cute
one-liner.

1. https://github.com/Homebrew/homebrew-cask/commits/master/Casks/perforce.rb
2. https://docs.brew.sh/Cask-Cookbook#required-stanzas
3. https://github.com/git/git/runs/6104156856?check_suite_focus=true
---
 ci/install-dependencies.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 82fa87f97af..540deab4488 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,7 +37,13 @@ macos-latest)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew install perforce
+	brew install perforce || {
+		echo Installing perforce failed, assuming and working around SHA256 mismatch >&2 &&
+
+		path=$(brew edit --print-path perforce) &&
+		sed -i -e 's/\(sha256.\).*/\1:no_check/' "$path" &&
+		brew install perforce
+	}
 
 	if test -n "$CC_PACKAGE"
 	then
-- 
2.36.0.893.g80a51c675f6

