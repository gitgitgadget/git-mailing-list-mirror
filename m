Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE10C41535
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiDVJQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445854AbiDVJKi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:10:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E964151E65
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m14so10106440wrb.6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6A5xEwy2NNRR51nG978K8VjzJ1oPmETYeIcrt7pvbw=;
        b=i1ktBvu7YOjDYMTZlprt1XSQFYL9GN6Do5XQvSwHNciZ7IO3/dvAfrKZ9PQRNPGI63
         4kazHpqP3Gff/d7xvX+8tsDhrdrgTLoB2hVZjHphm4+PXE9ciybJ1+seqO8SMhtWxLx0
         Rq/IxslLrrfOMRzsnMH/zRPUpb1RB+bOGrcg4w29G+xgUrmMEiAvyfbUcpMkjE32K7df
         mEsxWcP19yKCwlqTgmRNt3q+N454cPVvQ/PvTGcg4kGenFSMeL92p9R4LF64VvPNMzdr
         asPUxyAde2eL6yG7BaXSp5hfTZpswoFWxJ34DDkPr7HK+HYOQapy2OtcH3YgGiIskvWg
         LhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6A5xEwy2NNRR51nG978K8VjzJ1oPmETYeIcrt7pvbw=;
        b=CRnHYwR4yhcsMES3etOI6QY8u1rjKMJSeHyDaYamAjdT2qv8+5CENbf9ncxq8eSAIR
         MnWgC0FBwtQnxYWivGgVyGQsl+EflrOmZkmySchEjvIBiuMp92uOuzwFzNM3kP2aMRD1
         4piVrQlkfuNe/samio0tpY0/KeD8USa4HGso25FOnnpoaR3YVOat+11TiUkWFLuEFhZo
         1aqwmIW9lmi3oLyuZ31Q2A0mFW7Y/NkTWBJXgxdFwMAvn7VoZfaga4zSYMMaz66tEAic
         Tu6+FlC1fv7va+TuYypu2Xpy3Vn+e2ss+SztKbn8xPRbqJ4sYOoutgfx6qlVg08bU1EP
         Qliw==
X-Gm-Message-State: AOAM532OUpigE6K2L9lz+KISVEEqUgGG/NFiNlSNR7G2cNMN6tk5y35V
        1mtc/RlT8JvQvQEqW9xJeZYorsG31xEOTA==
X-Google-Smtp-Source: ABdhPJy1oZ2s8U7LdMHnd6auKxnTwBaJlbvJn5RuuRBi1+U7WHgtcR4gxrg5lc1ciEsXO4v4v9crrA==
X-Received: by 2002:adf:f611:0:b0:207:ac80:73f5 with SMTP id t17-20020adff611000000b00207ac8073f5mr2856541wrp.623.1650618462973;
        Fri, 22 Apr 2022 02:07:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm1282700wmn.16.2022.04.22.02.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:07:42 -0700 (PDT)
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
Subject: [PATCH v2 0/3] CI: don't fail OSX tests due to brew v.s. perforce.com mis-match
Date:   Fri, 22 Apr 2022 11:07:36 +0200
Message-Id: <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this re-roll should address outstanding feedback with the v1.

I also added an extra patch to change the existing http:// download of
the perforce binaries to use https://, which should further make the
case that we can do without any homebrew-specific sanity checking in
this area: It's what we're already doing for the ubuntu-latest jobs.

I think a sensible follow-up to this would be to skip invoking
homebrew entirely, we can simply:

    wget https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz

And then do the exact same thing we're doing to get the linux p4
binaries.

A CI job showing this series working (including the working OSX fallback):
https://github.com/avar/git/runs/6125736258?check_suite_focus=true#step:3:83

In addition to that the wget via https for the linux perforce package works:
https://github.com/avar/git/runs/6125736067?check_suite_focus=true#step:3:273

Ævar Arnfjörð Bjarmason (3):
  CI: run "brew install perforce" without past workarounds
  CI: don't care about SHA256 mismatch on upstream "perforce" package
  CI: use https, not http to download binaries from perforce.com

 ci/install-dependencies.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Range-diff against v1:
1:  dcedf03c2d7 = 1:  dcedf03c2d7 CI: run "brew install perforce" without past workarounds
2:  28208bac859 ! 2:  2805e89623c CI: don't care about SHA256 mismatch on upstream "perforce" package
    @@ Commit message
         jobs will encounter hard failures.
     
         Let's not be so anal about this and fallback to a "sha256 :no_check"
    -    on failure. We are already downloading arbitrary binaries from
    -    perforce's servers, and the point of doing so is to run the
    -    t/*-git-p4-*.sh tests, not to validate the chain of custody between
    -    perforce.com and the homebrew-cask repository.
    +    on failure. For the "ubuntu-latest" jobs just a few lines earlier we
    +    "wget" and chmod binaries from http://filehost.perforce.com (no
    +    https!).
     
    -    In the obscure (but unlikely to ever happen) that the failure is
    -    specifically because perforce.com published a bad updated package, and
    -    it a failure that their testing wouldn't have caught, but whoever's
    -    updating the homebrew SHA-256 recipe would have caught, we will have a
    -    failure in our p4 tests that we wouldn't have otherwise had.
    +    We're already trusting the DNS in the CI to do the right thing here,
    +    and for there not to be any MitM attacks between the CI and
    +    filehost.perforce.com. Even if someone managed to get in the middle
    +    the worst they could do is run arbitrary code in the CI environment.
     
    -    But I think that's so unlikely that we don't need to worry about it,
    -    whereas seeing failures due to the homebrew recipe lagging upstream is
    -    a real issue. E.g. "seen"'s latest push-out has such a failure: [3]
    +    The only thing we were getting out of the SHA-256 check was to serve
    +    as a canary that the homebrew-cask repository itself was drifting out
    +    of date. It seems sensible to just cut it out as a middle-man
    +    entirely (as the ubuntu-latest jobs do). We want to run the
    +    t/*-git-p4-*.sh tests, not to validate the chain of custody between
    +    perforce.com and the homebrew-cask repository.
     
    -    Note: It's probably possible to embed this "sed" one-liner directly in
    -    the HOMEBREW_EDITOR variable, i.e.:
    +    See [2] for the "no_check" syntax, and [3] for an example of a failure
    +    in "seen" before this change.
     
    -        HOMEBREW_EDITOR='...' brew edit perforce
    +    It's been suggested as an alternative [4] to simply disable the p4
    +    tests if we can't install the package from homebrew. While I don't
    +    really care, I think that would be strictly worse. Before this change
    +    we've either run the p4 tests or failed, and we'll still fail now if
    +    we can't run the p4 tests.
     
    -    But my attempts to do so were unsuccessful, particularly since I don't
    -    have access to a Mac OS X machine other than via by round-tripping
    -    through the CI. This version of getting the path via --print-path
    -    works, and is arguably easier to reason about and debug than a cute
    -    one-liner.
    +    Whereas skipping them entirely as [4] does is introducing the caveat
    +    that our test coverage in these jobs today might be different than the
    +    coverage tomorrow. If we do want to introduce such dynamic runs to CI
    +    I think they should use the relevant "needs" or "if" features, so that
    +    the UX can make it obvious what was or wasn't dynamically skipped.
     
         1. https://github.com/Homebrew/homebrew-cask/commits/master/Casks/perforce.rb
         2. https://docs.brew.sh/Cask-Cookbook#required-stanzas
         3. https://github.com/git/git/runs/6104156856?check_suite_focus=true
    +    4. https://lore.kernel.org/git/20220421225515.6316-1-carenas@gmail.com/
     
      ## ci/install-dependencies.sh ##
     @@ ci/install-dependencies.sh: macos-latest)
    @@ ci/install-dependencies.sh: macos-latest)
     +		echo Installing perforce failed, assuming and working around SHA256 mismatch >&2 &&
     +
     +		path=$(brew edit --print-path perforce) &&
    -+		sed -i -e 's/\(sha256.\).*/\1:no_check/' "$path" &&
    ++		sed 's/\(sha256.\).*/\1:no_check/' <"$path" >"$path".tmp &&
    ++		mv "$path".tmp "$path" &&
     +		brew install perforce
     +	}
      
-:  ----------- > 3:  3fdd54aa8df CI: use https, not http to download binaries from perforce.com
-- 
2.36.0.879.g56a83971f3f

