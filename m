Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F8FC5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1962223D
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcvKQz9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgKPQIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgKPQIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:35 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F5C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:35 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id j7so19263684wrp.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dFrYG3RUeNm3xspjhF+Rro27OZBY3Hr4CqDMC2SftzQ=;
        b=RcvKQz9TEwNjAtgl84kPSgicLIrZhrU91NQnr1XrggfQ75VhpsEgg7DE/As5PYDI2I
         f79hZNOlMISPwysf7yp8M4okst6Sl8MGaBs/TUvm75xYQ611i6G1wq1YDFuwRfgQTvQo
         /O6t2I0Fv5IocUz7F8SnLvX0aM13mihZ4e5NDl/1QI2N63VBvmKhm/rUlBbR8n688NDa
         XvaX4dNtyt07V38VBNza/68Epewjs96DWdA26LIWA7OEFOA0UE5oNHh3TSxH8SQgirz2
         ihhuSDuJjiEOWkjGGoHUr5OANr5lS6BaLZxh2bQYNM2uw9cnG273FRFBSkDQymDTAgbL
         fDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dFrYG3RUeNm3xspjhF+Rro27OZBY3Hr4CqDMC2SftzQ=;
        b=EWAyv/LVHtSudpEb8zdebj2Ewp7lQnz5bKK2fVBpyicUJpcwAOcWXCiyd7eS5M8AVe
         7lfoHXzH65Nkh+uqBMqgD03GLYFFOMT6MyZeerhh65vKPw8i9GLYQoS3Qbmhgnq9wS5n
         kHXEAo5KeH9k0jgjUExFoOi/Fx15RJoYSmMK84Nvbfucu0khnqZI5WX4O1vYFktSIAo+
         zVQEygeCknHtxdibo18CFFeWwlCeDKUapGXKq33bgUpZxHMvaLmUNC3/wqYHQgwaUXR5
         GFHGuYa4ow69wqdPEkJlGe8Zexp3S0SI/gZzTXgJK/o2CLw8Kcni2P5qoHNL2a+2KnR+
         J9dQ==
X-Gm-Message-State: AOAM530QZDsX6AWTDQgH7WYTctygQY4TGTyU5hVcw4zoX043+QBOYdn+
        dZR7l0v/dyv958lVWRkU+BpiGGP8V8o=
X-Google-Smtp-Source: ABdhPJwkUD4qXZqZYy++A6ItoqDZ1B6YT9tiUcmAE/ZAh+BNJe8IoTM5EkQfLnGiPvp5+hOIGppbNg==
X-Received: by 2002:a05:6000:1cf:: with SMTP id t15mr20547597wrx.92.1605542913821;
        Mon, 16 Nov 2020 08:08:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm1330274wre.43.2020.11.16.08.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:33 -0800 (PST)
Message-Id: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:21 +0000
Subject: [PATCH v3 00/11] Fix color handling in git add -i
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series started out as a tiny fix for a bug reported by Philippe
Blain in 
https://lore.kernel.org/git/313B8999-1E99-4695-A20D-E48840C30879@gmail.com/.
And then I only wanted to add a regression test to make sure that this does
not regress. And then I just wanted to ensure that it passes both with the
Perl version of git add -i as well as with the built-in version.

And in no time I was looking at a real patch series.

Changes since v2:

 * The commit messages of patches 7/11 and 9/11 now stress why we want to
   align the output of the Perl vs the built-in version so slavishly: to be
   able to validate both versions against prerecorded output.
 * A typo was fixed in the commit message of patch 10/11.

Changes since v1:

 * The regression test now actually exercises the re-coloring (that is the
   primary purpose of git add -p looking at the color.diff.* variables).
 * The way the built-in git add -p renders hunk headers of split hunks was
   aligned with how the Perl version does things.
 * We now consistently prefer color.diff.context over color.diff.plain, no
   matter whether using the Perl or the built-in version of git add -p.
 * The commit message for the regression test no longer confuses readers by
   mentioning dash.
 * The regression test was structured a bit better, first testing error
   message coloring, then the menu in git add -i and then the diff coloring
   in git add -p.

Johannes Schindelin (11):
  add -i (built-in): do show an error message for incorrect inputs
  add -i (built-in): send error messages to stderr
  add -p (built-in): imitate `xdl_format_hunk_hdr()` generating hunk
    headers
  add -i: use `reset_color` consistently
  add -i (built-in): prevent the `reset` "color" from being configured
  add -i (built-in): use correct names to load color.diff.* config
  add -p (built-in): do not color the progress indicator separately
  add -i (built-in): use the same indentation as the Perl version
  add -i (Perl version): color header to match the C version
  add -p: prefer color.diff.context over color.diff.plain
  add -i: verify in the tests that colors can be overridden

 add-interactive.c          | 38 ++++++++++-------
 add-patch.c                | 25 +++++++-----
 git-add--interactive.perl  | 12 +++---
 t/t3701-add-interactive.sh | 84 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 32 deletions(-)


base-commit: e4d83eee9239207622e2b1cc43967da5051c189c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-785%2Fdscho%2Ffix-add-i-colors-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-785/dscho/fix-add-i-colors-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/785

Range-diff vs v2:

  1:  6152122c04 =  1:  6152122c04 add -i (built-in): do show an error message for incorrect inputs
  2:  068813912b =  2:  068813912b add -i (built-in): send error messages to stderr
  3:  98deb538d9 =  3:  98deb538d9 add -p (built-in): imitate `xdl_format_hunk_hdr()` generating hunk headers
  4:  c857c44932 =  4:  c857c44932 add -i: use `reset_color` consistently
  5:  337b45cad8 =  5:  337b45cad8 add -i (built-in): prevent the `reset` "color" from being configured
  6:  dcd2ffc458 =  6:  dcd2ffc458 add -i (built-in): use correct names to load color.diff.* config
  7:  73b6d60a80 !  7:  6a68bc5511 add -p (built-in): do not color the progress indicator separately
     @@ Commit message
          add -p (built-in): do not color the progress indicator separately
      
          The Perl version of this command colors the progress indicator and the
     -    prompt message in one go, let's do the same in the built-in version.
     +    prompt message in one go.
     +
     +    Let's do the same in the built-in version so that the same upcoming test
     +    (which will compare the output of `git add -p` against a known-good
     +    version) will pass both for the Perl version as well as for the built-in
     +    version.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
  8:  91ded2fbbe =  8:  168891f9f8 add -i (built-in): use the same indentation as the Perl version
  9:  304614751e !  9:  094a4ad90c add -i (Perl version): include indentation in the colored header
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    add -i (Perl version): include indentation in the colored header
     +    add -i (Perl version): color header to match the C version
      
     -    The header is formatted by padding each column heading with spaces up to
     -    the length of 12 characters. These padding spaces are naturally included
     -    when coloring the entire header.
     -
     -    However, the preceding five spaces indentation for non-flat lists were
     -    _not_ included in the Perl version, but _were_ included in the built-in
     -    version. Let's adjust the former to align with the latter's behavior.
     +    Both versions of `add -i` indent non-flat lists by five spaces. However
     +    when using color the C version prints these spaces after the ANSI color
     +    codes whereas the Perl version prints them before the color codes.
     +    Change the Perl version to match the C version to allow for introducing
     +    a test that verifies that both versions produce the exact same output.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 10:  48d8e0badf ! 10:  9a4d2a33b5 add -p: prefer color.diff.context over color.diff.plain
     @@ Commit message
          the hard-coded default (which in this case is simply the empty string,
          as context lines are typically rendered without colored).
      
     -    This still needs to inconsistencies when both config names are used: the
     +    This still leads to inconsistencies when both config names are used: the
          initial diff will be colored by the diff machinery. Once edited by a
          user, a hunk has to be re-colored by `git add -p`, though, which would
          then use the other setting to color the context lines.
 11:  c94abff72f = 11:  492f46833a add -i: verify in the tests that colors can be overridden

-- 
gitgitgadget
