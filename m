Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD9EB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGKRcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKRcf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:32:35 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C151C133
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:32:33 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1b06ea7e7beso5434935fac.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689096753; x=1691688753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0cSX+82e9v9VKMYi/qlU9VisNpwtvFeSRgYYDTmVG4=;
        b=Jqy5Zb2Ey1roFu9yLWIRaKnFC1toaki21miiVucqq/W6ldT5gm1f9nzkSACzOScEHH
         WRlxY3K+h85TLdRWfv6BRHCtDaRQFjRKkU4km9FxbQWihfCdM/zKMzmuwvlTwvVARe26
         J5xaNVWFJsk2L/zi/qnfgyu3e6TOJvYmQc5wXpo4T+lFHJJ6I3V3mIsnSVhhqbP79LNq
         laHQPismqHIbNMLVL+FWwAa5gLB6Hu28jyCgNFiptJGkusJM2G2W8ziSlgKrVlYynfew
         0KaVGRdkGe78q0z5cMcz70eTAkIRYqWOWC+hbJAr531DgEZwtbzyf4ucj0zsWNWifOha
         UdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096753; x=1691688753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0cSX+82e9v9VKMYi/qlU9VisNpwtvFeSRgYYDTmVG4=;
        b=RpiwCAcOvm/Bxff0mJ0vFC2aSM2I6kLoNUDCamWjygLRJ7nU7z4LePsboBBpqRbH6i
         SoqcrTzaRTYH64Y0iPxaNj4a5FuJrRPzqUL7agDJN69e+lsreP3+wXZyn4d7r+/atxUH
         Xjk4UUBhk4HJIEAtg1juePgl5nWjNLoxkxLRp7eHtlmegHvxvM8+9OlhInAwWR9agp4w
         U8oleQ8JkqdcmIidI81SX3yQmf/PvIc18iZZ55RjOov/x3MNFkBUdIl75iZYC0fR5XLI
         /co6aWxIZqHyJ7HXTMz1zxFV4DrtMRO6h9FbW6iMAAEoCAr1u7cphZZAxCsJ6pjhAwOb
         MslQ==
X-Gm-Message-State: ABy/qLanKDkRbEq5DIQmh9qRUIYead3yXKJBbI/8O2E+wBquIx54OnIO
        tAUltH55u8Cb4P/Ys0zBPTRtuYbhAsH3QMqZU39RBQ==
X-Google-Smtp-Source: APBJJlH0rTqs7D9g9gjnbOnM+3jV9ZI8b+6JxojUBqzh1/kANJ7UyfDwSAiepHv26Azd6sAZN3frag==
X-Received: by 2002:a05:6870:c153:b0:1b7:609f:e0d4 with SMTP id g19-20020a056870c15300b001b7609fe0d4mr1557835oad.15.1689096752876;
        Tue, 11 Jul 2023 10:32:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c124-20020a0dc182000000b0057a05834754sm684245ywd.75.2023.07.11.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:32:32 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:32:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] repack: make `collect_pack_filenames()` consistent
Message-ID: <cover.1689096750.git.me@ttaylorr.com>
References: <cover.1689017830.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689017830.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small replacement for a series that Stolee and I worked on
together to make the behavior of `collect_pack_filenames()` consistent
with the rest of Git's pack liveness rules.

Nothing much has changed since v1, with the exception of removing
unnecessary conversions from 'ls' -> 'find ... | sort'. As always, a
range-diff is included below for convenience.

Thanks in advance for another look.

Derrick Stolee (1):
  builtin/repack.c: only repack `.pack`s that exist

Taylor Blau (1):
  builtin/repack.c: avoid dir traversal in `collect_pack_filenames()`

 builtin/repack.c  | 38 +++++++++++++++-----------------------
 t/t7700-repack.sh | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 24 deletions(-)

Range-diff against v1:
1:  f14a88f107 ! 1:  410d2f0165 builtin/repack.c: only repack `.pack`s that exist
    @@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
      		git config pack.window 0 &&
      		P1=$(commit_and_pack 1) &&
      		P2=$(commit_and_pack 2) &&
    - 		P3=$(commit_and_pack 3) &&
    - 		P4=$(commit_and_pack 4) &&
    --		ls .git/objects/pack/*.pack >old-counts &&
    -+		find .git/objects/pack -name "*.pack" -type f | sort >old-counts &&
    - 		test_line_count = 4 old-counts &&
    - 		git repack -a -d --keep-pack $P1 --keep-pack $P4 &&
    --		ls .git/objects/pack/*.pack >new-counts &&
    -+		find .git/objects/pack -name "*.pack" -type f | sort >new-counts &&
    - 		grep -q $P1 new-counts &&
    - 		grep -q $P4 new-counts &&
    - 		test_line_count = 3 new-counts &&
     @@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
      			mv "$from" "$to" || return 1
      		done &&
    @@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
     +		# repacking what we can.
     +		touch .git/objects/pack/pack-does-not-exist.idx &&
     +
    -+		find .git/objects/pack -name "*.pack" -type f | sort >packs.before &&
      		git repack --cruft -d --keep-pack $P1 --keep-pack $P4 &&
    -+		find .git/objects/pack -name "*.pack" -type f | sort >packs.after &&
      
    --		ls .git/objects/pack/*.pack >newer-counts &&
    --		test_cmp new-counts newer-counts &&
    -+		test_cmp packs.before packs.after &&
    - 		git fsck
    + 		ls .git/objects/pack/*.pack >newer-counts &&
    +@@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
      	)
      '
      
    @@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
     +		P2=$(commit_and_pack 2) &&
     +		P3=$(commit_and_pack 3) &&
     +		P4=$(commit_and_pack 4) &&
    -+		find .git/objects/pack -name "*.pack" -type f | sort >old-counts &&
    ++		ls .git/objects/pack/*.pack >old-counts &&
     +		test_line_count = 4 old-counts &&
     +
     +		# Remove one .pack file
     +		rm .git/objects/pack/$P2 &&
     +
    -+		find .git/objects/pack -name "*.pack" -type f |
    -+			sort >before-pack-dir &&
    ++		ls .git/objects/pack/*.pack >before-pack-dir &&
     +
     +		test_must_fail git fsck &&
     +		test_must_fail git repack --cruft -d 2>err &&
    @@ t/t7700-repack.sh: test_expect_success 'repack --keep-pack' '
     +
     +		# Before failing, the repack did not modify the
     +		# pack directory.
    -+		find .git/objects/pack -name "*.pack" -type f |
    -+			sort >after-pack-dir &&
    ++		ls .git/objects/pack/*.pack >after-pack-dir &&
     +		test_cmp before-pack-dir after-pack-dir
     +	)
     +'
2:  b3d0d9308e = 2:  ffdf85f6d3 builtin/repack.c: avoid dir traversal in `collect_pack_filenames()`
-- 
2.41.0.329.gffdf85f6d39
