Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D84E784BD
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbjJBPW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbjJBPWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:22:55 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B0AC
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:22:52 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so6365786241.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696260171; x=1696864971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo68DA+1cOfp4KikESmRsCFIoh7Ysy/0dM46cNARWGI=;
        b=tHh58h9g/N8AsWGBMzT43ztVrohAvMB0CasfPLQqWHKTKTTqF0SrkI8GBFNHzfXHQp
         Mb7Q0fSsI9+Dg0/rb7rOaqcTDO/piF43whoH+1/GVtBHbQiAroVWRoKv8OgOh1PzNaXB
         FEbw8BMj2l3kauRDrCt6zE4GKYEq0j3hWxzNF1s23ncFKyU01RP/F4cx50INGQOf5Qxh
         vfZRF9D/fVyQpzYZegCMdnVyz02RKd2SxhhTncsZ5Gjxby1bAp66EwBM4gJUqREJhH67
         dgSpT/t680/EYnV17u5MK0WSNvZ0EpFqN/f/d7od76pSNfpGSXKuuYnueKcghMat5RwK
         1JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260171; x=1696864971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo68DA+1cOfp4KikESmRsCFIoh7Ysy/0dM46cNARWGI=;
        b=hGI01+utXO2jgIsJNFFV5G4KStgMzNMOitbuR8OtcFWaU8v6O1cZNIFPrZnUveisJB
         W+YBX/ECdQgVdtkbWzyRH+moZZBcrrmPvALV3V4UDtdRu78tD9zVIOerNOCJz0Sd4tFW
         lLIgbO8ey3VFGKZMfWOpbuMXoF9XbFK5Sen6a6RV6XdBPO9iQLmxWJ3Sc9axbFygEV/j
         2I88eej5DtD82j5zZXhs6UAjGwOd1ygyD5ORjb/s7nDAG49DJbeio/mQqEe0+gFLga5T
         FdefyoizBBf+3AVTAFMhwv7zZEqwC9yxbwoB4uAk8i7z3nuXigSJDfl3RwQ/My3NzDjq
         Pvow==
X-Gm-Message-State: AOJu0YxgliS6XWpiux6tIQEkoQgrTjO5ZWiY7EGcOArFdI1PYyrTcA91
        +EmhbK/aUBaW/QzN7TRd644lco+WmNnVojUFhMIMyA==
X-Google-Smtp-Source: AGHT+IGKZi9umtjrevVmSs6abhzkrW46uazCShjxjhgX8HsjHngv6+Cxzp/hSdVclb/O8beZZ4ENOg==
X-Received: by 2002:a67:b348:0:b0:44e:9313:b045 with SMTP id b8-20020a67b348000000b0044e9313b045mr9290212vsm.7.1696260171110;
        Mon, 02 Oct 2023 08:22:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r13-20020a0cb28d000000b0064f4e0b2089sm5801840qve.33.2023.10.02.08.22.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:22:50 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:22:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 12/12] Overflow discussion
Message-ID: <ZRrgSZTlZd4SXfrP@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* trackers - bug, review, etc
   * "whose turn" for patches
* (Minh): Multi-pack index and when you repack a large number of packs, you can
  rewrite pack index partially on things that have been changed but can't do
  with bitmap? Is this assumption correct
   * (Taylor): yes: bitmaps get rewritten from scratch to what pack they belong
     but it's close to an incremental approach as long as there is an existing
     bitmap.
* Back to project management practices that Junio mentioned, we seem to not shy
  away from discussing what kind of tool will help us: Bug tracker, etc but have
  more trouble with what practice to put in place to enforce it. Ex: with a
  public Bug Tracker, who responds to user issues, what does priority mean, etc.
  Wonder if people who are motivated to solve by making a small group to define
  this, bring back a proposal to the list.
   * (Josh) As Junio mentioned lot of patches getting ignored - and mostly
     directed to our day job, can we get cross company commitment to
     review/volunteer/run a bug tracker to explicitly help community
   * (Emily) Can view this as a donation, "donating project management
     headcount".
   * (Jonathan) In the linux kernel there's a "Contribution maturity model"
     document. Common definition on what it means to be doing your part, allows
     companies to assess themselves.
   * (Taylor) Open Source donation was something that happened recently
   * (Emily) The Linux Foundation sponsors work to measure contribution: which
     company contributes how many patches/reviews
   * (Pono) Can help here to define qualitative metrics. Tools: CHAOSS that
     plugs into repository. Can work with someone to outlay this.
   * (Phillip) It's easier to find reviewers in some areas than others.
     Different companies have different areas of interest.
   * (Emily) Yeah, we've noticed this at Google. Example: Submodule
   * (Josh) Specific people to volunteer and how we recognize that volunteering
     effort in a smaller group. How about a Git reviewer conspiracy to honor
     people.
   * (Jonathan Nider) Make a small group and Jonathan can volunteer in it and
     Taylor is happy to help too.. (4 people volunteered - jrn, nasamuffin,
     keanen, ttaylorr)
* (Terry) semver was brought up in the compatibility discussion
   * I'd recommend looking at the Eclipse project's practices. It's Java based,
     has very clear language-based definition of what an API or ABI break is.
     But they also have a notion of "public" versus "public-internal" --
     public-internal interfaces can be things that are known to be unstable, and
     when you use them you know you'll be doing work to keep working on top of
     it. They also built a bunch of tools for checking when you break API/ABI.
     This was very successful.
   * Teams at Google building a web service don't have to deal with nearly as
   	 much of that - you can roll forward and back quickly - but that's not the
   	 case for things running on people's desktops, where you need to take a more
   	 principled approach to API evolution.
* (Emily) library API stability (or lack thereof)
* (Minh) Reg SHA256 migration - Git forges
   * First-mover topic - once one forge moves, others will have to scramble.
     Should we coordinate?
   * (Patrick) Gitaly supports SHA256, unofficially already works in importing
     code to GitLab. But we need to adapt a lot of the frontend to support it.
   * (Taylor) GitHub is in an earlier state but is also interested in picking
     this stuff up.
* (Emily) Backward compatibility discussion - Library API Stability
   * Put off version over version API guarantees
   * From talking with the LLVM team at Google, learned the LLVM project adopts
     similar attitude towards API backward compatibility. SHould be an active
     contributor to not break your API.
   * (Jonathan Nieder) Maintaining C++ compatibility is hard, fully expressive
     API in C isn't easy. So it's a nice dividing line there. In Git it's all in
     C, annotations/signals where people can distinguish between "#include this
     header for a stable API, #include this other header for
     use-at-your-own-risk shifting foundation".
   * (Terry) LLVM is for static analysis, but the Git project should probably
     provide a higher level of API guarantee as these 2 projects are at
     different levels.
   * (Jeff Hostetler) Is there a roadmap with milestones around things like "at
     this point, you can work with multiple independent object database
     objects"?
      * (Emily) Yes, that's part of the holy grail of what we're trying to
        accomplish, and it's needed for submodules.
   * (Pono) licensing? Okay with current license, not a concern for Google but
     its a concern for other people using it.
      * (Jonathan) License as part of the interface, as soon as we have
        potential callers for whom GPL is not suitable this conversation will be
        easier. "Shall we relicense this subsystem to support this caller?"
