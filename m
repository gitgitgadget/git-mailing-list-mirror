Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1ECC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F81861476
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhF3WFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhF3WFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 18:05:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B7C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 15:02:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 17so3643721pfz.4
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R+EX/qv+dhI3sV8NLz88gyU/LY5bbhts1LknauAUDn8=;
        b=SdTcdN0tx3QObV6VWECL+rWh7ydGDKXrXetFhUIjEYep4VGDceVEeVVNA1o12OQaqm
         D/MvI1NVEFFjhk/uJGQS+0XKJkthpOBCrbaNw+1qcYmSgWjSQAlcln9hRpXcXJ0v7aEg
         V1IxhIGj+anhtLoRDkZTM1knoGCdvHeZAGDKeByGgFhkGTi4UHSVaut+H05zmoz6dAfB
         uJfFjx2dZQUjxHJ/Dmn49IVgyqoJ4qS3gW6TEQW9m3jOJV+qItLSJ0eetMNlBvp7WZh9
         vkUUY3LeLBuAzWWJioFMbIErLx/ZPzEEqlOJDW5wBPWQFNMk+VrgpNn5Gz/iw0gCm0TB
         mbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R+EX/qv+dhI3sV8NLz88gyU/LY5bbhts1LknauAUDn8=;
        b=Vhux70VfLVZQgOZD0f3KqdF5JyPAhdJtuNMyt9uUTlR99nFIOYDnZpCJl1LeAf9AIX
         fJXfDdVieqnVTfGhCHKk88a7U7n3B0IjOyYCmtUbTzMEAxDtU7REvONF+xCrQXhsjLLM
         l9sEhFuImODyNtp9PzohkUUBQw/7XxO829w3bIC7jZtHfomvWuG4PnCYRokabwJh4zZh
         E5cykCsGA3YUHVxKJTY8OFRAK6XQssnhfM/RwtRVOLwa1TfW0j1KNFz8yGiGaNmhA36J
         JDTnl6r6Mf2GojDxFjEPicNjJFwUcYKWC2ZrTl02IbpoAwUHcrvpW31aosjnycwv9Wfh
         JZ+w==
X-Gm-Message-State: AOAM530UH7v+Ky4FnDIRLdPXu14ptwp+Odp+FJbAluvmBvCvj8mcniiL
        ihschiAPHKbNJnr0GA+snccyYQ==
X-Google-Smtp-Source: ABdhPJyDz+oj4pf26fYI290zbOtT+FQXr3vqSfd9YRPvJ9OHHYmEMyQV2hqsLxvS9ZyAWVc5aBDNNA==
X-Received: by 2002:a63:1b0c:: with SMTP id b12mr36139250pgb.334.1625090568069;
        Wed, 30 Jun 2021 15:02:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:517:e2a4:e006:6986])
        by smtp.gmail.com with ESMTPSA id z20sm1040537pgk.36.2021.06.30.15.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 15:02:47 -0700 (PDT)
Date:   Wed, 30 Jun 2021 15:02:41 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/4] test-tool: split up "read-cache" tool
Message-ID: <YNzp4WIlZIzqD7PU@google.com>
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 01:58:23PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> When the sparse index topic was being discussed I suggested that the
> t/helper/read-cache.c tool was getting to the point of doing too many
> things and should be split up.
> 
> Since that series has landed on master here's that suggestion again in
> the form of patches on top of master. The 4/4 patch is a "while I was
> at it" addition of an extra perf test for index refreshing.
> 
> 1. https://lore.kernel.org/git/20210317132814.30175-6-avarab@gmail.com/
> 

Since "What's cooking" mentioned this series was starved for review, we
took a look at it today. Most of my comments are pretty general, so I'll
reply primarily to the cover letter instead.

The result after this series is that we have three forms of 'test-tool
read-cache':
 - one for unit testing, with no iteration (test-tool read-cache)
 - one for not-so-perfy iteration (test-tool read-cache-again)
 - one for perfy iteration and refresh_index benching (test-tool
   read-cache-perf)

Before I read patch 4, I said, "'again' and 'perf' have a lot of code in
common, but I guess we are trying to reduce the amount of overhead for
tight-loop performance testing, so OK." But patch 4 adds an alternative
body for the inside of the loop, which *looks* not very performant
(although is probably optimized well) by checking an unchanging bool on
every iteration of the loop.

I tend to think it would be easier to read
and understand to have two forms of 'test-tool read-cache' - one which
iterates and one which does not. Maybe the one that iterates should be
called -perf, maybe it should be called something else, whatever. And
perhaps it makes sense for the iterating one to look like so (heavily
pseudocoded, hope you can follow along with the rough sketch):

  enum iteration_mode;

  parse_options();
  if (should_do_again) {
    iteration_mode = AGAIN;
  else if (should_do_perf) {
    iteration_mode = PERF;
  else if (should_do_refresh) {
    iteration_mode = REFRESH;
  }

  while (passes--)
    switch (iteration_mode) {
    case AGAIN:
      read index;
      refresh index;
      index_name_pos;
      error reporting;
      write_file;
      discard_index;
      break;
    case PERF:
      read index;
      discard index;
      break;
    case REFRESH:
      refresh_index;
      break;
    }

This would put all our "loop lots of times for performance benchmarking"
into one place. We know that the switch statement is very performant,
especially if we manage to const-ify iteration_mode.  The cases make it
very clear that the body of the loop is being swapped out depending on
the arguments, and that entirely different behavior is happening in each
scenario.

There's also an orthogonal bit of cleanup here by moving to
parse_options(), which I am excited about in general :) but which I
think wasn't done very cleanly in this series. In patch 1, the commit
message makes no mention of the fairly significant refactor happening to
move 'test-tool read-cache' to parse_options(), and I think the mix of
cut&paste with refactor makes the patch a little muddy. What about a
series like so:

 1/3: teach test-tool read-cache to use parse_options()
 2/3: add test-tool read-cache-(perf|iterating|whatever)
 3/3: teach test-tool read-cache-perf "--refresh"


Thanks, and hopefully this is a welcome necromancy and not an annoying
one ;)

 - Emily
