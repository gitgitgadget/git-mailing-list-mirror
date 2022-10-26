Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A89C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJZVcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJZVcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:32:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4513ECE2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z9so6663627ilu.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6RTxr0PGAp/uG0b1VsWwaVWfBCs5Fyk2XFZy06SfKhg=;
        b=eL4yU4l3mEtFE2ONf0J7i67I9YWhLSQF2oYWSZ5UyaMB6aruk7I8yjOv851taqhM2+
         aqzyN+8i2Ue1JxX4DI+4dMEC8oOZsyGBjTWtZYLyD4UrpiQqIRQolmoWBFEEYBtk87BO
         ci30oO2PeOgtP6/NrpgCkit5cOMY8ar7wit+3gI8sGhZ2/Z2t+R7UR9l/ORNU5A5+pgS
         C4r4HlfsBkPLHkLGZ16NSRhw2puB+D7Vwg4WAoLInDVNmFIC0qwtfxDP7ibEdFQaik1m
         PhKvGaQ9YVYifBpC2O9X0mj+gyjSWnChsbJ40jJXU2kpKaPEiyIlYMmYZdoK3vD8C6oa
         sTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RTxr0PGAp/uG0b1VsWwaVWfBCs5Fyk2XFZy06SfKhg=;
        b=Bbj3y8vlgL6OsKYKNiGP22rr54l03GNXtrU0kBzfC9CDfB132p8jQPrBxqLCNLvaN/
         uTZGph6eDOyRjv6Cy/oYzju0/3eapGOGyEddRNa22uCo+qm4WzwDxdNg4O29YO972lQ2
         8GzWT8pla6mrJJI60Gv/dyxz77RbeDEyeiLeawhvsrEBIodt2MqquP1LLFH5pEyWTgqT
         ld6f+xDZCUM+2Mvq1XegHO0rGIpcREAQxClqgKHhBMBkR7UHjWG/2fGUdDiqt2g8QK/6
         0K3SYs4fe6HvHG/8jYWoAt8i/flMnFIoR0ibFKP9eMP6LtM+pZofwhEQAlsel7CGBfR7
         mKWg==
X-Gm-Message-State: ACrzQf2sFfFtFTXVEM0WF+2lkZ4ZAOrflyCsB957AVIT8eldapEL2J1z
        Bwp82QMcf90kcWWcK3JbkQR02Rwpc+RAr51f
X-Google-Smtp-Source: AMsMyM5kULLcv+Fr4xX2KwVKpkrb1it25p5yEYVLkQm6UGeVV8cip9lxwuoes5wMkQx+KNA4D23K/g==
X-Received: by 2002:a05:6e02:1d8c:b0:300:229:d9d2 with SMTP id h12-20020a056e021d8c00b003000229d9d2mr9364286ila.221.1666819960489;
        Wed, 26 Oct 2022 14:32:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c47-20020a023f6f000000b00363d6918540sm2367070jaf.171.2022.10.26.14.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:32:40 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:32:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v3 0/2] gc: let feature.experimental imply gc.cruftPacks
Message-ID: <cover.1666819953.git.me@ttaylorr.com>
References: <cover.1666815209.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666815209.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small reroll of an adopted version of Emily's series[1], which
I saw while sifting through old mail in my inbox.

This is substantively unchanged from the previous round, save:

  - renaming the helper functions which assert and refute the existence
    of cruft packs, and

  - an additional test which ensures that we can opt out of cruft packs
    via config

A range-diff is included below for convenience.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/20220803205721.3686361-1-emilyshaffer@google.com/

Emily Shaffer (2):
  gc: add tests for --cruft and friends
  config: let feature.experimental imply gc.cruftPacks=true

 Documentation/config/feature.txt |  3 +
 builtin/gc.c                     |  7 ++-
 repo-settings.c                  |  1 +
 repository.h                     |  1 +
 t/t6500-gc.sh                    | 96 ++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  35d2c97715 ! 1:  e8726f3de7 gc: add tests for --cruft and friends
    @@ t/t6500-gc.sh: test_expect_success 'one of gc.reflogExpire{Unreachable,}=never d
     +	git reset HEAD^^
     +}
     +
    -+assert_cruft_pack_exists () {
    ++assert_cruft_packs () {
     +	find .git/objects/pack -name "*.mtimes" >mtimes &&
     +	sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&
     +
    @@ t/t6500-gc.sh: test_expect_success 'one of gc.reflogExpire{Unreachable,}=never d
     +
     +		prepare_cruft_history &&
     +		git gc --cruft &&
    -+		assert_cruft_pack_exists
    ++		assert_cruft_packs
     +	)
     +'
     +
    @@ t/t6500-gc.sh: test_expect_success 'one of gc.reflogExpire{Unreachable,}=never d
     +
     +		prepare_cruft_history &&
     +		git -c gc.cruftPacks=true gc &&
    -+		assert_cruft_pack_exists
    ++		assert_cruft_packs
     +	)
     +'
     +
2:  eb151752b8 ! 2:  13a25a425b config: let feature.experimental imply gc.cruftPacks=true
    @@ repository.h: struct repo_settings {
      	int sparse_index;
     
      ## t/t6500-gc.sh ##
    -@@ t/t6500-gc.sh: assert_cruft_pack_exists () {
    +@@ t/t6500-gc.sh: assert_cruft_packs () {
      	done <packs
      }
      
    -+refute_cruft_packs_exist () {
    ++assert_no_cruft_packs () {
     +	find .git/objects/pack -name "*.mtimes" >mtimes &&
     +	test_must_be_empty mtimes
     +}
    @@ t/t6500-gc.sh: test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
     +
     +		prepare_cruft_history &&
     +		git -c feature.experimental=true gc &&
    -+		assert_cruft_pack_exists
    ++		assert_cruft_packs
     +	)
     +'
     +
    @@ t/t6500-gc.sh: test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
     +
     +		prepare_cruft_history &&
     +		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
    -+		assert_cruft_pack_exists
    ++		assert_cruft_packs
    ++	)
    ++'
    ++
    ++test_expect_success 'feature.experimental=true can be overridden' '
    ++	git init crufts &&
    ++	test_when_finished "rm -fr crufts" &&
    ++	(
    ++		cd crufts &&
    ++
    ++		prepare_cruft_history &&
    ++		git -c feature.expiremental=true -c gc.cruftPacks=false gc &&
    ++		assert_no_cruft_packs
     +	)
     +'
     +
    @@ t/t6500-gc.sh: test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
     +
     +		prepare_cruft_history &&
     +		git -c feature.experimental=false gc &&
    -+		refute_cruft_packs_exist
    ++		assert_no_cruft_packs
     +	)
     +'
     +
-- 
2.38.0.16.g393fd4c6db
