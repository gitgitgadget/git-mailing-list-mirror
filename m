Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F0C56201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 19:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6AA22240
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 19:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hi/5H1Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbgKTTOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbgKTTOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 14:14:30 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EBBC0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 11:14:30 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z24so5902163qto.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 11:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQwBxSwehP4GJgc+INWlBSxoDk09zPrMCJIzFQZ5Gxg=;
        b=hi/5H1HrINwNlIjrSFOkhG7b6k6zMTzMrGPep7e9dPopv22jHEzLPmasBDrHXnbmN4
         DFmMPsdgU51KLGG+34afp7qTGneTjVuvLMGgqpjhn67J6p3G5xCo3gj4ODMFZUk0X1gc
         FfTtxEplUgaGDtG8fBerWQTWsdmQ6RkZX3o6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PQwBxSwehP4GJgc+INWlBSxoDk09zPrMCJIzFQZ5Gxg=;
        b=jNw7E7UOPVuXfnfKw/ziALuTFzm1xuSpTdCJ21bw1h89s4LohGwszGma1ScldL99vY
         kIdLOzXnFGwIvo/nD/dzoQUE0qBLNDA0bdGBRHZhf9K/1UJX8NSP69QHGDFhtoP/bx5t
         g6tQRX/xKk22kppQm+9G2T0x+9VAAujPwTY08PlYDds5FT18tgsX7KaLXxncXw1Ny5CN
         Jvcpu1goHkWXBwg/UEa41U3kcOvdRztZfRo1m/mvf5MHSbuZw9KrLaixdDRPiv91rtjp
         DD2t0ZtrRAej6/fwVOGxaGDr3SklFYmgJ1OBZsu0r0J6sRt+YvHBE6LtPLGEGOaOMC6x
         u4Xw==
X-Gm-Message-State: AOAM533ROCzrnS43NcUY8SDhgXChdB0jhgBXzRXMdwe09swKaI3dm5TB
        3OBYFjjOjdLvDmKpK6vCvvQ3j+7Up9QSPoh2
X-Google-Smtp-Source: ABdhPJzSTHH3D7JAi2XvaqTFTIII9besjY3igzcGc019MdeWKxA4xY9Bxfr5IsRpLb0h1deyAAMc5w==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr17632250qtv.56.1605899668619;
        Fri, 20 Nov 2020 11:14:28 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id e9sm225483qtr.95.2020.11.20.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:14:27 -0800 (PST)
Date:   Fri, 20 Nov 2020 14:14:26 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Message-ID: <20201120191426.jzaiq42mmlocmd6y@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
References: <20201113010107.GL6252@camp.crustytoothpaste.net>
 <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu>
 <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu>
 <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
 <20201115034649.GC3985404@mit.edu>
 <CA+sFfMfWrSMKAogg-5dsaO_beXUV-JCBLBPeLZ5g_0jGqsom8Q@mail.gmail.com>
 <20201119133705.7q7yghymvvo7zeq4@chatter.i7.local>
 <xmqq4kllxcmw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kllxcmw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 19, 2020 at 01:25:27PM -0800, Junio C Hamano wrote:
> The question most useful to ask at this point are to what name
> (fixed? computed?) and what the transition plan would look like.

Right, hence my statement that there are no "concrete plans." I've 
previously suggested that, should this change be implemented, it makes 
sense to couple it with another upcoming major compatibility break -- 
the sha1 deprecation. Perhaps we can start with the following:

Currently:

$ git init
Initialized empty Git repository in /var/home/user/foo/.git/
$

New:

$ git init
Initialized empty Git repository in /var/home/user/foo/.git/
 Initial branch: master
  Object format: sha1

Use --initial-branch and --object-format flags to specify other values.
$

> > It is misleading in the context of git, because it implies that a 
> > branch carrying that name is in some way special compared to other 
> > branches (e.g. like "trunk" in the SVN world). In reality, the 
> > "master" branch is just a branch like all others (and can be missing 
> > entirely or have junk in it), so it really shouldn't be called 
> > "master".
> 
> I find the above answer even more confusing, in the context of major
> projects and hosting sites all moving to 'main'.  If 'master' is
> misleading for all the reasons stated in the above paragraph, 'main'
> would equally be misleading.  In other words, "It is just a branch
> like all others, so it really shouldn't be 'master'" leads to "it
> shouldn't be 'main' or 'primary', either".

In my mind, there are important semantic differences between "main" and 
"master" that make "main" more acceptable. A town with a single road can 
reasonably call it the "main road." Similarly, a "mainstream" movement 
does not imply the existence of any other movements. Etc.

-K
