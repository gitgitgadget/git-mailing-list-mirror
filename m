Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F84C7619A
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 05:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDOFSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 01:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOFSt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 01:18:49 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3811559D
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 22:18:47 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1879502e2afso8371913fac.5
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 22:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681535927; x=1684127927;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZe1V22bot0EnoOG/0V6aL9czqfCmkUpM4N21vEktos=;
        b=fpg6ilCELY7x06ohhvMOAuOfNne0XR2H8mAQ2rc7xuXF224hViC/HUR1eZQfFB9E+4
         oJ3ZG4iHpZp2q3rLRgXpY4UDgzx3KK5J0LrhkzjZxprPNDGrWEAf+5PRMrQP+EW+utHG
         8l15Mhj1THlaMCdkBQvsaHcuI7Sfp/MfCQylfwXrWnM92o3rVfEqWzvQ9Z+M59bhWH8A
         y0b9jAgQ9DarlkMkDxY+0Z3TxdSg2KMCOIu1vAGSiGQxROVTo/7yMYfWmBUySZyu9K/k
         Rg+HLEqLsMGuUcFCfDxUeTDtmrK/I20SSmGTCOE8z2UWwdiSLKvpyjdMgMnRt0XeuM48
         ti5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681535927; x=1684127927;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EZe1V22bot0EnoOG/0V6aL9czqfCmkUpM4N21vEktos=;
        b=C+0P1wkJr/2pSr97yH4oV1Os2mn1yWks0TJO5u56ZHMzbmDTJZ0jhJh5AQHVRlD52q
         foKeuIHXejDCvgnFzYbK20zro9jtYyUC1VHfLF47jJ0m1IOHUQqU8N5bde03Yg3kNQ+0
         RWCbxgotu92t4uxw+aBZH1oeDxD/KMUeWfoH0DKTozpE5pdUM8AZC3y+MtIn4KDW/PmB
         hU1pfpUlTNuKKd+qPBRmQ9X5/MUzNMdbAn/HNQNqemOoF7jSdTXjTfodZOGaW1H5BCmJ
         W+hQroDGcw9Cr+R0HJp8Y56vFhUWXjy16aV3HNAU3c09b/H+L77O/tWrnxKYJwNnOJib
         gNzw==
X-Gm-Message-State: AAQBX9eeo22wav1W9ItV4YXKbvoct8tp5wO7hfiTKAZ+08Cnwb04nq1R
        xHYk1BiNMI3a9MrWCFinCvg=
X-Google-Smtp-Source: AKy350a54YizzxmW63iNZYyGdpv7XqKf9bGuUMpdyYhQZtPMsT0IpSutIF7ZgygJDueSCw5iIRNc0w==
X-Received: by 2002:a05:6870:4621:b0:17a:3e4:e9df with SMTP id z33-20020a056870462100b0017a03e4e9dfmr4999403oao.6.1681535927277;
        Fri, 14 Apr 2023 22:18:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870450300b0017264f96879sm2530164oao.17.2023.04.14.22.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 22:18:46 -0700 (PDT)
Date:   Fri, 14 Apr 2023 23:18:45 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <643a33b5e6a3a_1466294b2@chronos.notmuch>
In-Reply-To: <xmqq8reuqoyk.fsf@gitster.g>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <66c7e514157f3c8220eb994cea7c4659d5241042.1681495119.git.gitgitgadget@gmail.com>
 <xmqq8reuqoyk.fsf@gitster.g>
Subject: Re: [PATCH 1/5] revisions.txt: document more special refs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Philippe Blain <levraiphilippeblain@gmail.com>
> >
> > Some special refs, namely HEAD, FETCH_HEAD, ORIG_HEAD, MERGE_HEAD and
> > CHERRY_PICK_HEAD, are mentioned and described in 'gitrevisions', but some
> > others, namely REBASE_HEAD, REVERT_HEAD, and BISECT_HEAD, are not.
> >
> > Add a small description of these special refs.
> >
> > Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> > ---
> >  Documentation/revisions.txt | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> > index 9aa58052bc7..98b8f89bc8d 100644
> > --- a/Documentation/revisions.txt
> > +++ b/Documentation/revisions.txt
> > @@ -32,8 +32,8 @@ characters and to avoid word splitting.
> >    first match in the following rules:
> >  
> >    . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
> > -    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
> > -    and `CHERRY_PICK_HEAD`);
> > +    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
> > +    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);
> 
> Adding missing ones and enumerating them indeed is good, but I
> wonder if the readers will be helped if they are exposed to the
> phrase "pseudoref" here.

First time I've heard that term.

> 	This is usually useful only for the pseudorefs, i.e. `HEAD`,
> 	`FETCH_HEAD`, ..."

Isn't `HEAD` supposed to be a "symbolic ref"?

It definitely seems some explanation is missing.

-- 
Felipe Contreras
