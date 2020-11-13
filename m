Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561BC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045D822256
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeVDDYUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgKMWXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 17:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMWXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 17:23:36 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C60C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 14:23:35 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id oq3so15928693ejb.7
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85MLdUn9b9nQk3/6Ch+LEbL8zHagLC7zP3X97SXaIyI=;
        b=FeVDDYUtRw23KDpCXmOm8pDz/PnWAChWoPEgekCU+X5oMHE8kaYzrjGDvjCNjn6iqu
         IMIiDWOMdgAcHWsIgReMxB08dGOmu3CFZw2BXpOUkMp8w1FcjeDXtqGHw9VZB+lDk7aF
         c6n/9jseYk7JOvN7A8Sv8kCOmjAUefU+T4xOCS1dELy7neMBq+cWrFUwBaUfwGphWyH4
         sFZeX7vql0DDxukmPV7KVWoPIh5ZINm6kJ+RJ96F0HrTZ8qVx0v6qmNFzh3UXrq+qRy1
         Oxs2sVOglxjOWAexggEngrHJd56TYzQQmoiWtUkIpYrIqdlcF62Yu8ivyHDBX6bp9ngw
         /P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85MLdUn9b9nQk3/6Ch+LEbL8zHagLC7zP3X97SXaIyI=;
        b=jap9+tPFxuEaqWyUcuBcYJr7ydaeak4Zt0vvJixYBvrpHxz6s+HLVA4svwcd0HoLsX
         tCex+AZmK+yVwKcqqPrZcDPOZanlpNiwC8eQt1ROgG1x8TuutnlFQnhohK8nxPNmm+18
         DKj7cx4l83E1q21ZRCUPUzogMLB78SGWhJRokz9GzYCUeZKcFn+PpGSwnSDLvrEwVD0Q
         8vlSJu80C04B2BmP7o5iOQfMhoSGguVhxEqyTBERBzF+TGOYrqe7qZMpFOQ+H8rTZlcx
         NpJBYaxY+r729U8JYB/JIQpcvrR1vq4uAhYN4dLeNwkQ9tQFOTl2hzRqWl3mBwQ5Nt8w
         b38w==
X-Gm-Message-State: AOAM531Iqy5qhVFYrlfBSJZ5n3KG71OkEdAu+qAzi2YWtufFuAQsgm/2
        Fk/+KeCHDRhVDJifHRQ/eVk=
X-Google-Smtp-Source: ABdhPJzV54fwXO0ifQFk5f5gLcRrgVKI226TuTCjegs4opK5XaiLo54936aDaqMTh0G9vCgnIW3aUQ==
X-Received: by 2002:a17:906:f84f:: with SMTP id ks15mr3977392ejb.337.1605306214614;
        Fri, 13 Nov 2020 14:23:34 -0800 (PST)
Received: from szeder.dev (94-21-58-64.pool.digikabel.hu. [94.21.58.64])
        by smtp.gmail.com with ESMTPSA id e19sm4740814ejz.35.2020.11.13.14.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 14:23:33 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:23:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 17/23] pack-bitmap-write: build fewer intermediate bitmaps
Message-ID: <20201113222328.GA8033@szeder.dev>
References: <cover.1605123652.git.me@ttaylorr.com>
 <ab64354851e2aa61e901e37814b2ae33d8f855d1.1605123653.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab64354851e2aa61e901e37814b2ae33d8f855d1.1605123653.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 02:43:51PM -0500, Taylor Blau wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The bitmap_writer_build() method calls bitmap_builder_init() to
> construct a list of commits reachable from the selected commits along
> with a "reverse graph". This reverse graph has edges pointing from a
> commit to other commits that can reach that commit. After computing a
> reachability bitmap for a commit, the values in that bitmap are then
> copied to the reachability bitmaps across the edges in the reverse
> graph.
> 
> We can now relax the role of the reverse graph to greatly reduce the
> number of intermediate reachability bitmaps we compute during this
> reverse walk. The end result is that we walk objects the same number of
> times as before when constructing the reachability bitmaps, but we also
> spend much less time copying bits between bitmaps and have much lower
> memory pressure in the process.
> 
> The core idea is to select a set of "important" commits based on
> interactions among the sets of commits reachable from each selected commit.

This patch breaks the test 'truncated bitmap fails gracefully (ewah)'
when run with GIT_TEST_DEFAULT_HASH=sha256:

  expecting success of 5310.66 'truncated bitmap fails gracefully (ewah)':
          test_config pack.writebitmaphashcache false &&
          git repack -ad &&
          git rev-list --use-bitmap-index --count --all >expect &&
          bitmap=$(ls .git/objects/pack/*.bitmap) &&
          test_when_finished "rm -f $bitmap" &&
          test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
          mv -f $bitmap.tmp $bitmap &&
          git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
          test_cmp expect actual &&
          test_i18ngrep corrupt.ewah.bitmap stderr
  
  + test_config pack.writebitmaphashcache false
  + git repack -ad
  + git rev-list --use-bitmap-index --count --all
  + ls .git/objects/pack/pack-23fe19963d67a1d4797a39622c15144bbf35ab76a2c0638ba9288cc688c24c16.bitmap
  + bitmap=.git/objects/pack/pack-23fe19963d67a1d4797a39622c15144bbf35ab76a2c0638ba9288cc688c24c16.bitmap
  + test_when_finished rm -f .git/objects/pack/pack-23fe19963d67a1d4797a39622c15144bbf35ab76a2c0638ba9288cc688c24c16.bitmap
  + test_copy_bytes 256
  + mv -f .git/objects/pack/pack-23fe19963d67a1d4797a39622c15144bbf35ab76a2c0638ba9288cc688c24c16.bitmap.tmp .git/objects/pack/pack-23fe19963d67a1d4797a39622c15144bbf35ab76a2c0638ba9288cc688c24c16.bitmap
  + git rev-list --use-bitmap-index --count --all
  + test_cmp expect actual
  --- expect      2020-11-13 22:20:39.246355100 +0000
  +++ actual      2020-11-13 22:20:39.254355294 +0000
  @@ -1 +1 @@
  -239
  +236
  error: last command exited with $?=1

