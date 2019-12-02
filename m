Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586DCC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C93120640
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 17:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJoTtUIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfLBRkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:40:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45108 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfLBRkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 12:40:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so104747wrj.12
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xl6WsvaR7TTX2DSqyvAxC+1SGN5P++rM1s0/r6bstsA=;
        b=aJoTtUIrzWwAAS565Gi81aRk9s/X5ljojWe8sSKOkkr8bRVITFw26jmxhR2Sl4VwBG
         rWW952zQFZfWFfhReiD73qAfP4LmQHHUecsNskG1Ms66SD5iZy5TNHs9gio17/1l+R07
         jhzbJrFLYjCYFmAN+G2c8vAN3Z51JIvpUzSzLB9ZJO9Gti28NpjYs/N7Ls0sjQPLsjGL
         Z7AeTgxd/G7CnPP35c3GeukkgUzBWYB9D9Ptin09rqpIDa+WdqQqeFhulg77Ml7TMbe0
         xoQVqw6nsoWIBLaIi9kGqjvtFH9JbTj8EkZAr2cppsMs5NWtJbwBBsn0g8kDLKIPiCej
         2PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xl6WsvaR7TTX2DSqyvAxC+1SGN5P++rM1s0/r6bstsA=;
        b=poJ+opRMxZKSj590sE83BiaPwVivqpVLZaa0330ueMbR0T+HfBYcc3X6ZsDp/xlF8j
         4Yr23S1SKfc7HG7NsfjmD30MjtYKyODlGkQ0vTm66ljmdFtwG6W4a4vqD5ewfo7ogP+F
         8gq5Daqc7Ih/wNQ+u3bb/NCcSl5ip37wGufqk2nDnCYeDr7e548g4RwFOh45p7B5D+nd
         duOuXrzZk6HvmcIDhz2WDIIc2e4GkQpbLm87sLytvUVyT4+Csmg8PVy/44YrdLTDFQM6
         hJMIFIbM51jS0Zb6DHCmbIJRTly1srcWZ+N1lEY+T9NcSdjzLrfUlPVaEulV55MqH4eD
         kW0g==
X-Gm-Message-State: APjAAAWID9/LbKWMGN8SKlooXRhvkOHncFMMfn9xV67apVvNroPM8zqB
        UDfXufJI/DM8PgmjEjl5ktZi9GEZ
X-Google-Smtp-Source: APXvYqzzJdKzrylU7E6qs4b6ZVZTtOElj47N6J9nOuu+6/32s6U7QQhKPOhHYFf//0kC3SkCKlfhzA==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr106733wrx.66.1575308438317;
        Mon, 02 Dec 2019 09:40:38 -0800 (PST)
Received: from szeder.dev (x4db59591.dyn.telefonica.de. [77.181.149.145])
        by smtp.gmail.com with ESMTPSA id 189sm150818wmc.7.2019.12.02.09.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 09:40:37 -0800 (PST)
Date:   Mon, 2 Dec 2019 18:40:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Colin Stolley <cstolley@runbox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191202174035.GJ23183@szeder.dev>
References: <20191127222453.GA3765@owl.colinstolley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127222453.GA3765@owl.colinstolley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 04:24:53PM -0600, Colin Stolley wrote:
> When loading packfiles on start-up, we traverse the internal packfile
> list once per file to avoid reloading packfiles that have already
> been loaded. This check runs in quadratic time, so for poorly
> maintained repos with a large number of packfiles, it can be pretty
> slow.
> 
> Add a hashmap containing the packfile names as we load them so that
> the average runtime cost of checking for already-loaded packs becomes
> constant.
> 
> Add a perf test to p5303 to show speed-up.
> 
> The existing p5303 test runtimes are dominated by other factors and do
> not show an appreciable speed-up. The new test in p5303 clearly exposes
> a speed-up in bad cases. In this test we create 10,000 packfiles and
> measure the start-up time of git rev-parse, which does little else
> besides load in the packs.
> 
> Here are the numbers for the new p5303 test:
> 
> Test                         HEAD^             HEAD
> ---------------------------------------------------------------------
> 5303.12: load 10,000 packs   1.03(0.92+0.10)   0.12(0.02+0.09) -88.3%
> 
> Thanks-to: Jeff King <peff@peff.net>
> Signed-off-by: Colin Stolley <cstolley@runbox.com>
> ---

This patch break test 'gc --keep-largest-pack' in 't6500-gc.sh' when
run with GIT_TEST_MULTI_PACK_INDEX=1, because there is a duplicate
entry in '.git/objects/info/packs':

  expecting success of 6500.7 'gc --keep-largest-pack':
          test_create_repo keep-pack &&
          (
                  cd keep-pack &&
                  test_commit one &&
                  test_commit two &&
                  test_commit three &&
                  git gc &&
                  ( cd .git/objects/pack && ls *.pack ) >pack-list &&
                  test_line_count = 1 pack-list &&
                  BASE_PACK=.git/objects/pack/pack-*.pack &&
                  test_commit four &&
                  git repack -d &&
                  test_commit five &&
                  git repack -d &&
                  ( cd .git/objects/pack && ls *.pack ) >pack-list &&
                  test_line_count = 3 pack-list &&
                  git gc --keep-largest-pack &&
                  ( cd .git/objects/pack && ls *.pack ) >pack-list &&
                  test_line_count = 2 pack-list &&
                  awk "/^P /{print \$2}" <.git/objects/info/packs >pack-info &&
                  test_line_count = 2 pack-info &&
                  test_path_is_file $BASE_PACK &&
                  git fsck
          )
  
  + test_create_repo keep-pack
  Initialized empty Git repository in /home/szeder/src/git/t/trash directory.t6500-gc/keep-pack/.git/
  + cd keep-pack
  + test_commit one
  [master (root-commit) d79ce16] one
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 one.t
  + test_commit two
  [master 139b20d] two
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 two.t
  + test_commit three
  [master 7c7cd71] three
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 three.t
  + git gc
  Computing commit graph generation numbers:  33% (1/3)^MComputing commit graph generation numbers:  66% (2/3)^MComputing commit graph generation numbers: 100% (3/3)^MComputing commit graph generation numbers: 100% (3/3), done.
  + cd .git/objects/pack
  + ls pack-a4b37b9b5458e8116b1c1840185b39fb5e6b8726.pack
  + test_line_count = 1 pack-list
  + BASE_PACK=.git/objects/pack/pack-*.pack
  + test_commit four
  [master fd8d77e] four
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 four.t
  + git repack -d
  + test_commit five
  [master a383792] five
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 five.t
  + git repack -d
  + cd .git/objects/pack
  + ls pack-057d7f493a7c26d58090f4777ff66d4c226c4408.pack pack-54feec766fc7d2d204b03879d96f4595d7e48c37.pack pack-a4b37b9b5458e8116b1c1840185b39fb5e6b8726.pack
  + test_line_count = 3 pack-list
  + git gc --keep-largest-pack
  Computing commit graph generation numbers:  20% (1/5)^MComputing commit graph generation numbers:  40% (2/5)^MComputing commit graph generation numbers:  60% (3/5)^MComputing commit graph generation numbers:  80% (4/5)^MComputing commit graph generation numbers: 100% (5/5)^MComputing commit graph generation numbers: 100% (5/5), done.
  + cd .git/objects/pack
  + ls pack-390dbbb8e27c014b080c08dfc482d4982d4c6644.pack pack-a4b37b9b5458e8116b1c1840185b39fb5e6b8726.pack
  + test_line_count = 2 pack-list
  + awk /^P /{print $2}
  + test_line_count = 2 pack-info
  test_line_count: line count for pack-info != 2
  pack-a4b37b9b5458e8116b1c1840185b39fb5e6b8726.pack
  pack-a4b37b9b5458e8116b1c1840185b39fb5e6b8726.pack
  pack-390dbbb8e27c014b080c08dfc482d4982d4c6644.pack
  error: last command exited with $?=1
  not ok 7 - gc --keep-largest-pack


