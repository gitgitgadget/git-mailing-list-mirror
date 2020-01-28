Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442BC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 23:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE6922522
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 23:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjaMEENY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA1X0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:26:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36701 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1X0O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 18:26:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so1801788pjb.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 15:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FQjH5nLTCdNQHjdqbE69WXWbqoYOOEwtEE1x/nTEHK0=;
        b=VjaMEENYPAlVrHEKxIRSrZkdaTCDpPNITBTmygsM5FcUBsMs7G0VCKAVcTPdxAGOLi
         SJ2ta5B68fL2ffDAcapRGlIGrqTs8nkx7UgtY/z4Cg2tl0eDXD/ZDUBLcGCUEOyBhNP5
         XehNuIVprX1knID7/IVmsRmUBfHrzW0paziabIpRG9iBd8xpvq1ErmjirYIlzUhqNUuS
         VNJ+jBeFp237MKW8jTROJxpT9kizu/Gdq50hn1zWqcrLFZQ5adIOmS6j4whzd5jjB4ec
         UFB4SMKstzVixejdI4cnVZ0d3mQSYOkgvGlDzR3H3EkhBOw23ynzHlcPsg5t+bTxGePw
         hHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FQjH5nLTCdNQHjdqbE69WXWbqoYOOEwtEE1x/nTEHK0=;
        b=hOd9qP8nz7Yom1hRFxz/vAUBQPTpWm5+vBETzRUI1ccYO5zoEUFdbfjH6S3dHpu8Hc
         HFjGSTq724mLHISA6chKkrbf2BRXmtna575QrkHmNGvh0OTAJI1ExwOZpcyRG4rAbZNk
         4yRErlMpbRVQbl61fSDdWCow8CHww5AwVG4byK5lRenWJeqgDZYI3xgnCnfL/KX2ROqk
         LiORkb+VDl6YmerYJ+vDJrBgFlXtf8i03LtUuHBBysk0f0KxFRMMO2LsrKYcIOutXKHW
         M0Ed85t8K5HGNn3Zb4mP9ck8enWhvZfQffuPGIkTE6f/PAfLsX4AsyaGxHl40btIAcV+
         sCNw==
X-Gm-Message-State: APjAAAX5V7+c0GrN9kd8IKYTNCDyxVEhMeXaCwe6SaVuHPglWI54p/Uo
        v+bX+WVv9JjB3Fmv6fIrtCzddg==
X-Google-Smtp-Source: APXvYqyofabNl9gqJzcob6nsz5j0XQSKdOcNGBN6Q3r0E0pXB7N5YGWdUBWIQgHUf5XXEHUizPDBYA==
X-Received: by 2002:a17:902:bb88:: with SMTP id m8mr25158107pls.63.1580253973896;
        Tue, 28 Jan 2020 15:26:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id z30sm122100pff.131.2020.01.28.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:26:13 -0800 (PST)
Date:   Tue, 28 Jan 2020 15:26:08 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, martin.agren@gmail.com, aaron@schrab.com
Subject: Re: [PATCH v5 00/15] add git-bugreport tool
Message-ID: <20200128232608.GA182648@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200128230421.49994-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128230421.49994-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 03:04:21PM -0800, Jonathan Tan wrote:
> > From: Emily Shaffer <emilyshaffer@google.com>
> > 
> > This topic branch depends on the patch mailed in
> > lore.kernel.org/git/20191211233820.185153-1-emilyshaffer@google.com in order to
> > display scopes for configs gathered during "bugreport: add config values from
> > safelist".
> > 
> > I'll summarize v4-v5. Since v4 has languished for some time, I don't
> > think an interdiff is too helpful, so I won't include one. Bonus, the
> > code is much simplified from some suggestions from Junio on how to
> > inspect objects, so I hope it's easy to review anyways.
> 
> To everyone in the developer community interested in this set: what is
> the status of this?
> 
> If this needs further review, then maybe it would be best if only
> patches 1-4 were put up for submission first, with a note in the
> bugreport documentation that more information may be added in future Git
> versions. For me, patches 1-4 look good and I don't have enough
> experience with uname (especially across libcs and OSes) to determine
> what should or should not be included - if this is typical of reviewers
> in the Git project, it might be better to submit patches 1-4 first, and
> then send each additional diagnostic separately, so that people who know
> what's going on in one area but not another can just comment on the area
> they know about.
> 
> Having said that, I see that a few people have already looked at the
> entire patchset and made comments, so if they are OK with it, we don't
> need to split it up.

I'd be fine with either; from now, my gut says the only ones I'm not
comfortable merging today are maybe 10, as Junio had some concerns about
whether to allow glob expansion, and 11, as it's prone to rot and I'm
doing other work in that area which would cause 11 to be
dropped/refactored anyways once it goes in. Otherwise I think they're
all pretty OK to go in and let the other work continue later in a
different thread.

Of course, as an author my opinion that they're good to go doesn't mean
much ;)

 - Emily
