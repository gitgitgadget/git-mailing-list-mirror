Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C93CC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CEB2071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu/4o8Va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAXV0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:26:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42908 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAXV0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:26:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so3694893wro.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CyIyTJzRRnPLuVNDxaXVySo9KvbKBsayvaFxUEBBU6c=;
        b=Wu/4o8VaIOAYULnu1gpczO4bRd+FdQA40UA6+KJAN09wN2ZxiIymogfyr/wdXo/d97
         ZP8Yl3WQZGfBMF2nrHNtlBk+oTeViy76t0FyYt1wKNaHd4sUywkmluPnPxOfzAd2iN5K
         atmwwav18hKSoRoOnRK7OJaWxRbfaU9mGqR3xarDPB9pC1zujgnSDqtEH9n0ru0dZGN2
         iU2MbgEKWRYXw571zGPrdyCQPmdmN8L9bTPnvs/zbAuEV5CHhsNeCBZGaWM2D54Jyxdk
         //DV2MX28zkTmzKDpWaZzckQ2e+Cj10+kEC/h3+oxGJ3gRV0hqIVDDMHAa09JPrkG5+S
         yo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CyIyTJzRRnPLuVNDxaXVySo9KvbKBsayvaFxUEBBU6c=;
        b=Qd6+1M3ak1qqC0SJ7FKAuRJccjTWZ8gLXvo1UHJq4F6lBd6pTbQWyPsiygtZEgJM18
         qiz0BmOxU9gaABw6U4ELlIWohhSDM3SO87OjE9TrpmEE9END211iY7iesMccsy+oDhDu
         ltF3kRoCRC2o1uim59zTu00mv63ekcUyJgolK1LoOaocyoJliOVO4g5F8BbZFP/zFzjv
         CsFDe9ffrFA5MyHjYy0dRle4+D3X1nR+4XFS288Jh1qW111sVLUlg3VCTD7lsNtky4P/
         k0OKYGJBitpsGzf5dIU8csyRHBAmW9fqFrLv1yoEDQw4x8sr1kYMzVmymCCNDMHh0cvb
         irVQ==
X-Gm-Message-State: APjAAAV3Rla5ZJbRncmLX1Hu2eVb17DamRc9kr25rSrntL22Yii6oH+/
        dkz3tSOLFjD+iptXY7+kFT4=
X-Google-Smtp-Source: APXvYqyp0QRyg1GYLr2Cp82YYxkbb6hUGwa7CF3tL77t+uogL4z89+2uCJc7fVuf2sUhRkP9RdqjMw==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr6408874wrj.349.1579901167116;
        Fri, 24 Jan 2020 13:26:07 -0800 (PST)
Received: from szeder.dev (x4db61038.dyn.telefonica.de. [77.182.16.56])
        by smtp.gmail.com with ESMTPSA id m21sm8205474wmi.27.2020.01.24.13.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 13:26:06 -0800 (PST)
Date:   Fri, 24 Jan 2020 22:26:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org,
        James Coglan <jcoglan@gmail.com>
Subject: Re: Misrendering of git 2.25 log --graph
Message-ID: <20200124212603.GH6837@szeder.dev>
References: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr>
 <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com>
 <75f5c537-bb46-7f04-54fe-0bc62762a682@gmail.com>
 <nycvar.YFH.7.76.2001241730030.32144@n3.vanv.qr>
 <3e9089c4-8ba6-b62c-cda3-607152790566@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e9089c4-8ba6-b62c-cda3-607152790566@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 01:45:34PM -0500, Derrick Stolee wrote:
> On 1/24/2020 11:34 AM, Jan Engelhardt wrote:
> > On Friday 2020-01-24 15:06, Derrick Stolee wrote:
> >>
> >> I completely misread your ordering here. You are clear that this
> >> is an issue in 2.24 and NOT 2.25. Sorry.
> >>
> >> I'm not sure that there is anything to do since the graph rendering
> >> has changed so much, and we intend to keep the new version instead.
> > 
> > I now have a minimized reproducer, for *2.25*:
> > 
> > » ../git/git log --oneline --graph --all --decorate --topo-order
> > *   e1ee7b8 (HEAD -> master) Merge branch 'k9' into k10
> > |\  
> > | *   7b48214 Merge branch 'k8' into k9
> > | |\  
> > | | *   ed02a51 Merge branch 'blah' into k8
> > | | |\  
> > | | | * 44279cf blah
> > | | * |   4053c4d Merge branch 'k7' into k8
> > | | |\ \  
> > | |/ / /  
> > | | | _   
> > | | * 5b449d6 update 8.7 news
> > | |/  
> > | * 43a324f foo
> > |/  
> > * 5932a51 root
> 
> Hm. I get the above output for v2.24.1. Since you are using a
> specific path for your execution, then perhaps that version
> disagrees with the one on your PATH that reported "git version"?
> 
> For v2.25.0 I get this:
> 
> *   e1ee7b8 (HEAD -> master, origin/master, origin/HEAD) Merge branch 'k9' into k10
> |\  
> | *   7b48214 Merge branch 'k8' into k9
> | |\  
> | | *   ed02a51 Merge branch 'blah' into k8
> | | |\  
> | | | * 44279cf blah
> | | * | 4053c4d Merge branch 'k7' into k8
> | |/| | 
> | | |/  
> | | * 5b449d6 update 8.7 news
> | |/  
> | * 43a324f foo
> |/  
> * 5932a51 root

I get this good-looking graph with v2.25.0, too.

A few notes to add:

  - We don't need the topmost commit e1ee7b8 to reproduce that strange
    underscore below the kink with v2.24.0:

      $ git --no-pager log --oneline --graph --topo-order 7b48214
      *   7b48214 Merge branch 'k8' into k9
      |\  
      | *   ed02a51 Merge branch 'blah' into k8
      | |\  
      | | * 44279cf blah
      | * |   4053c4d Merge branch 'k7' into k8
      | |\ \  
      |/ / /  
      | | _   
      | * 5b449d6 update 8.7 news
      |/  
      * 43a324f foo
      * 5932a51 root

  - Git behaved like that up until about the middle of the patch
    series simplifying the graph output, namely until commit
    458152cce1 (graph: example of graph output that can be simplified,
    2019-10-15).  The next commit 0f0f389f12 (graph: tidy up display
    of left-skewed merges, 2019-10-15) changed the bahavior for the
    worse:

      *   7b48214 Merge branch 'k8' into k9
      |\  
      | *   ed02a51 Merge branch 'blah' into k8
      | |\  
      | | * 44279cf blah
      | * | 4053c4d Merge branch 'k7' into k8
      |/|\  
      | |/  
      | * 5b449d6 update 8.7 news
      |/  
      * 43a324f foo
      * 5932a51 root

    Notice how 4053c4d looks like an octopus merge, and 44279cf
    seemingly comes out of nowhere.

    And then the next commit d62893ecc1 (graph: commit and post-merge
    lines for left-skewed merges, 2019-10-15) seems to have fixed this
    issue, and we see the same good-looking graph that we get with
    v2.25.0 as well:

      *   7b48214 Merge branch 'k8' into k9
      |\  
      | *   ed02a51 Merge branch 'blah' into k8
      | |\  
      | | * 44279cf blah
      | * | 4053c4d Merge branch 'k7' into k8
      |/| | 
      | |/  
      | * 5b449d6 update 8.7 news
      |/  
      * 43a324f foo
      * 5932a51 root

  - Interestingly, the issue of an underscore below the kink is
    mentioned in the later commit 92beecc136 (graph: flatten edges
    that fuse with their right neighbor, 2019-10-15), quoting the last
    part of its log message:

      One of the test cases here cannot be correctly rendered in Git v2.23.0;
      it produces this output following commit E:
      
              | | *-. \   5_E
              | | |\ \ \
              | |/ / / /
              | | | / _
              | |_|/
              |/| |
      
      The new implementation makes sure that the rightmost edge in this
      history is not left dangling as above.

    This is part of the new test case 'log --graph with octopus merge
    with column joining its penultimate parent' in t4215 that was
    added in 92beecc136.  Usually when a commit both changes the code
    and add new tests, then that means that that new test would have
    failed on previous versions.  However, that is not the case here:
    I tried this new test case on earlier commits in that series, and
    it already succeed with commit d62893ecc1, i.e. the same commit
    that fixes Jan's cases. 

