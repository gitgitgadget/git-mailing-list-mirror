Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AF3200B9
	for <e@80x24.org>; Sun,  6 May 2018 03:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeEFDhi (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 23:37:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33227 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeEFDhh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 23:37:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id o4-v6so24604829wrm.0
        for <git@vger.kernel.org>; Sat, 05 May 2018 20:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iiIOD/PW2cxrOqhOb7wZ19pPO1PON+y6riF3GXSlbQY=;
        b=P0ncr71WIBkpbXH1bzfqV9YnihtOJ5++Phk7Y2KR8Ksh7Ewou6v//p0qQbLWaJBfpB
         ubIwqdamEkZvawwWTFn03wIVdRY06RyDFgNw6sSCeeY3p7cOdKbr6hoKm5Yml/ZxD+48
         qNBbRdrPoVVRs9uDy92D2Uaps18dcDs/o39lcrboXS4sw23iMR61gEskveq7qRkTUfGP
         m1LhvLz6gZlMc6QgxTWXTYVqJvLzv+c5MNPW9OxKDkRLkMtP2IQl0vx6QKdMuAnjTAY/
         oUSA2LGyGbINu0XD6OHMf2rPuy0nYlIChHlbcDZgfRVGejn+iPBQdz07Ctfepkla6vfB
         cQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iiIOD/PW2cxrOqhOb7wZ19pPO1PON+y6riF3GXSlbQY=;
        b=FPnWtndA1/bL4v2aHayJft4T/5SoZEDmkI/0MSabMxqlKHAD/T6EvGBnUQg7TDVmEL
         pHqDCsx0xxi6YBPVniLYMMM12voTMmal1nzvVV0n/TeSXw3R6Dc7FGssEHer4jYTYJS1
         SPmTuSAsYqiPJ9UCHevtS1QhFdYMvHOjx+sqU+2lhSAsJ7RT8fBTlmniun1SKHRKTKlR
         7Uo0J16ffRHWHLP9SeJ5cfAvM8jM8wtZe5Pw3rpGwU0FkfVbfgxpLIJPkP6OMcvW6HhJ
         e1TrqZiehJIvpZoaoUrwUCEXiNicGtV115PCVqYit0q97REtAVKxqFtRbRdXMTxspVVf
         NZgQ==
X-Gm-Message-State: ALQs6tAfnCQ9QmO2f43nIMnPGh400rmk9Uw48AZ7z0M7QiewjLVwolan
        m3x9yq5WinETuKVCjpLROlY=
X-Google-Smtp-Source: AB8JxZqckpua6L1z03mFH818ibzFCgsGQaGuhLrtlxjFREXyc6cB+9mzpo11yrYLbV9SqafRcxbmWg==
X-Received: by 2002:adf:8e27:: with SMTP id n36-v6mr24252598wrb.27.1525577856403;
        Sat, 05 May 2018 20:37:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t203-v6sm5231189wmt.33.2018.05.05.20.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 May 2018 20:37:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
References: <20180413170129.15310-1-mgorny@gentoo.org>
        <20180505184426.GA18385@sigill.intra.peff.net>
Date:   Sun, 06 May 2018 12:37:33 +0900
In-Reply-To: <20180505184426.GA18385@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 5 May 2018 14:44:26 -0400")
Message-ID: <xmqq8t8xsbcy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The files in your checkout would all be consistent, but they might be
> inconsistent with other files _not_ created by Git (e.g., one might be
> saved in your editor). Now you may have introduced skew that cause
> "make" to do the wrong thing, because your source and target files are
> really operating from two different clocks.
>
> I really don't know how possible or common this is, but I feel like I've
> been warned about this distinction in the past. I wouldn't be surprised
> to find that it's an archaic thing found only on ancient versions of
> NFS, and oral tradition passed down the warnings. But I also would not
> be surprised if it's still possible and common.

It was pretty common back when I still was on NFS ;-)  I do not
think we care too deeply about a working tree that spans across
filesystem boundary, so one possible workaround is to read the fs
timestamp back out of the _first_ file we write in the process, and
then consistently use that time for the rest of the files that are
checked out by the same process with utimes().  

I personally still do not think it is worth the complication; these
projects are "holding it wrong" by placing build artifacts in SCM
(not in tarball) ;-).

