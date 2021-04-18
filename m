Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEFC433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 09:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2661245
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 09:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDRJoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhDRJoT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 05:44:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D475C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 02:43:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sd23so39780772ejb.12
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ThoCrQ5u1sB1edSkr3QX/Jms/gAI+bqDT4/tCZvOAls=;
        b=AezhuW8vAs3JqgOMpkagQoJK4jrXz/TsFd2xPVQFkXzoy/RNyNDIqM11pf5RwlKz7K
         bU4uLQMB6cfvltPFU8CRyUTgPRow/hA8JwRzhCGNdCwsfRAxQX9zTGE+/bNa+RCSbBTL
         /wGLTBOb9WsaK/cdYgwXy5eazpVlNCtwNguYOkWHD7lcSfkYSvFIX7c5X3A0TIg1ZWuX
         CzMrPqZD/CqyDj4o29rRtuVRp+Ty9+R28XXsktL0xoB6P0J5JFWvsp3F/f3sOcm7y2Xh
         7Ifv0L71bxeW3IqY//bNNAZM8smGz6iEAxwYgc39vPOyxcJZYcYXl4juplKSCcRn+OMq
         /t6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ThoCrQ5u1sB1edSkr3QX/Jms/gAI+bqDT4/tCZvOAls=;
        b=jrfThaMdx/BNI9WGxCbMrNUhHLC1D8QSq7h48OkgTNEUWz26qkuH1vVWfXmFHzIMOL
         Xmi/dtZYhbgFNTc1mlKs678T3kRb/vJFF3Kv94vGB2ntfFUcwsAk5noiUALe35Rtsi9K
         KA0wd/E1NXY08wHb6CpjlNmQN84ATw7JrrHxSWfINbicmFxDefe7mHCZQojGe34msmZz
         JOGOxe9NHx3/QKz1o/bkR6zHITJ6VU0wb/NQeasZudAGX38YJulY/cLQdUMHjZdyf3oC
         vaJ9gib7VaLrgjSDTxM34L75h0uVCH9EA7eUzWefxCfJcn3SgjwF7OKAitU+ljXEqZMy
         /nWQ==
X-Gm-Message-State: AOAM530XQmYohSCy6cLTjMzYhOK9PO5vrpI0yth0uGPUa1iU12TUr6rH
        YO0y/N2eh4HHR0sIWcotChg=
X-Google-Smtp-Source: ABdhPJwSkjIshUMpNS+X3rycWJkXMpiYo99M52QUipMu8Lxu9eAlA7sacWb8gCjtvQhn63mzpmj7iA==
X-Received: by 2002:a17:906:d102:: with SMTP id b2mr17423022ejz.451.1618739029274;
        Sun, 18 Apr 2021 02:43:49 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id c13sm3768875edw.88.2021.04.18.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 02:43:49 -0700 (PDT)
Date:   Sun, 18 Apr 2021 11:43:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] 'git describe seen'?
Message-ID: <20210418094347.GU2947267@szeder.dev>
References: <xmqq1rb8bhl4.fsf@gitster.g>
 <20210418082104.GT2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210418082104.GT2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 18, 2021 at 10:21:04AM +0200, SZEDER Gábor wrote:
> On Sat, Apr 17, 2021 at 04:45:59PM -0700, Junio C Hamano wrote:
> > This does not seem a new problem at all, as v2.10.0 thru more recent
> > versions of "git describe" seem to give me the same answer.
> > 
> > Anyway, I am seeing a curious symptom.
> > 
> > $ git rev-list --count v2.31.0..seen
> > 716
> > $ git rev-list --count v2.31.1..seen
> > 687
> > 
> > The above means that 'seen' is closer to v2.31.1 than v2.31.0; there
> > are fewer commits that are not in v2.31.1 that are in 'seen', than
> > commits that are not in v2.31.0 that are in 'seen'.  
> > 
> > That is naturally expected.
> > 
> > $ git rev-list --count v2.31.0..v2.31.1
> > 29
> > 
> > And that difference of 29 matches the difference, which is 716 - 687.
> > 
> > But here is what is puzzling.
> > 
> > $ git describe seen
> > v2.31.0-716-g7b65b53281
> > 
> > $ git rev-list --first-parent master..seen |
> >   while read v
> >   do
> > 	d=$(git describe $v)
> > 	echo $v $d
> > 	case "$d" in v2.31.1-*) break ;; esac
> >   done
> > 7b65b53281ae06ee25dd47dead4062125eb54427 v2.31.0-716-g7b65b53281
> > eec14f0fec886c909a29d63a94537df5a62be618 v2.31.0-714-geec14f0fec
> > ...
> > 103835562c64abef2319995716230f92092f87af v2.31.0-569-g103835562c
> > d4324831d9152b16e091646e22a6e03423a59c93 v2.31.1-516-gd4324831d9
> > 
> > Is there something tricky about the topic merged at 10383556 (Merge
> > branch 'jh/rfc-builtin-fsmonitor' into seen, 2021-04-17) to confuse
> > the counting done in "git describe"?
> 
> Subsequent merges with identical timestamps can easily confuse 'git
> describe', I wonder whether this is another symptom of the issue
> reported at:
> 
>   https://public-inbox.org/git/20191008123156.GG11529@szeder.dev/

That is not the only issue playing a role here, though.

'git describe --debug ...' shows a handful of candidate tags sorted
(primarily) by their depth counted from the to-be-described commit:

  $ git describe --debug origin/seen
  describe origin/seen
  No exact match on refs or tags, searching to describe
   annotated        716 v2.31.0
   annotated        708 v2.31.1
   annotated        733 v2.31.0-rc2
   annotated        755 v2.31.0-rc1
   annotated        818 v2.31.0-rc0
   annotated        895 v2.30.2
   annotated        897 v2.29.3
   annotated        899 v2.28.1
   annotated        901 v2.27.1
   annotated        903 v2.26.3
  traversed 3768 commits
  more than 10 tags found; listed 10 most recent
  gave up search at 42ce4c7930ff494136256554cbed730857084c70
  v2.31.0-716-g7b65b53281

Notice two issues with this output:

  - v2.31.0's depth is ok, but v2.31.1's is wrong:

      $ git rev-list --count v2.31.0..origin/seen
      716
      $ git rev-list --count v2.31.1..origin/seen
      687

  - The order of v2.31.0 and v2.31.1 is clearly wrong.

    I think this is because of the following code snippet from
    builtin/describe.c:describe_commit():

        QSORT(all_matches, match_cnt, compare_pt);

        if (gave_up_on) {
                commit_list_insert_by_date(gave_up_on, &list);
                seen_commits--;
        }
        seen_commits += finish_depth_computation(&list, &all_matches[0]);
        free_commit_list(list);

    I.e. we sort based on depth before calling
    finish_depth_computation(), which doesn't look right...  Looking
    at the depths before sorting shows that v2.31.1's depth is the
    same (708), but v2.31.0's depth is only 696 instead of 716.  Now,
    while this explains why those two tags are listed in the wrong
    order, it is still troubling that v2.31.0's depth is lower that
    v2.31.1's.

    Switching the order of finish_depth_computation() and QSORT() does
    fix thier order based on their depth, but, alas, those depths are
    still wrong:

      $ ./bin-wrappers/git describe --debug origin/seen
      describe origin/seen
      No exact match on refs or tags, searching to describe
       annotated        696 v2.31.0
       annotated        729 v2.31.1
       annotated        733 v2.31.0-rc2
       annotated        755 v2.31.0-rc1
       annotated        818 v2.31.0-rc0
       annotated        895 v2.30.2
       annotated        897 v2.29.3
       annotated        899 v2.28.1
       annotated        901 v2.27.1
       annotated        903 v2.26.3
      traversed 3768 commits
      more than 10 tags found; listed 10 most recent
      gave up search at 42ce4c7930ff494136256554cbed730857084c70
      v2.31.0-696-g7b65b53281

    However, switching the order of finish_depth_computation() and
    QSORT() might be wrong in itself: finish_depth_computation() was
    introduced in 1b600e659a (Compute accurate distances in
    git-describe before output., 2007-01-27), which states [1] the
    following in its commit message:

      We can easily reduce the total number of commits that need to be
      walked at the end by stopping as soon as all of the commits in the
      commit queue are flagged as being merged into the already selected
      best possible tag.

    But which candidate is that "best possible tag"?  The one whose
    depth is the lowest, so we do have to sort before calling
    finish_depth_computation() (or, strictly speaking, we don't have
    to sort, we only have to find the candidate with the lowest
    depth).

At this point I call it quits, because I don't think we can't talk
about accurate depth at all without first fixing the issue I linked in
my previous message.


[1] 1b600e659a also states the following:

      This means we can simply finish
      counting out the revisions still in our commit queue to present
      the accurate distance at the end.  The number of commits remaining
      in the commit queue is probably less than the number of commits
      already traversed, so finishing out the count is not likely to take
      very long. 

   Looking at the 'seen_commits' variable shows that in this
   particular case we traverse 905 commits before calling
   finish_depth_computation(), which then traverses an additional
   3768 - 905 = 2863 commits, i.e. the assumption in 1b600e659a might
   not hold.

