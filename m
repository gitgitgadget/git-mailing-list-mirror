Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51326EB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 21:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjF3Vdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 17:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjF3Vdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 17:33:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940235B6
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 14:33:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso17610725ad.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160823; x=1690752823;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uq6/Jz86Bvn8SbuevLD5efxYhGd+NyCjapobrEs0G30=;
        b=oCEn5OKyDhv7cHBzYRkDEhRlllWoGwMoKrDAXHxkF7+HiAm/6FcgglEsS4Ipr0HzXp
         PPsxQR5TSO2qnKTe5oDttAIl6g3mubdIaIJgC/QceBjQeGnpGkz0M629S32q2xpKkjTv
         Bn4Fg/5y8SV+lFQsOeQkUmoW1vaiTpSZB78sJXalMeR9OHhS9ONHLZ0kQHQ81SOSCgIo
         +O+4o0JpVDr9bQeqmbmJXT/RaZlNAsL4jKvlhcZpgAk4vP54y7XdIr6ob0RZ/xJHnM6C
         w+xMFj9J9R94rzhY28wUDxdB/wA4BN1Xr05tZC/WJUo1+hBsncxFwkzjQiDi8cGiGk3e
         9r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160823; x=1690752823;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uq6/Jz86Bvn8SbuevLD5efxYhGd+NyCjapobrEs0G30=;
        b=dALrayfwSYy6gUBBo9VZI1G1t5kV8P7XOUeN8wIagLHeEt24f9e5pC6dffscGpu0Je
         GkQ/kmijsXuWiGjslSCJ/v0rJuao7HYxx7BkWNQaFuKrPn8CIQfQGCEtonMxIQ1S31j8
         TGPahshEO0K1DESPmjCTv4ZXGEbxg2VeBDfeO1hmddqTLHbQneHBTQ4GTAr4rlJm0gfb
         GICG2Y3wpcRGtAKNcsP7JMVSjFUQYIpMbg6yVZMeP+4nQ5ZLgFNDYTBOgEYtx75+loZp
         RrAGo0P73D5AZHzjdz78eaE3JvQPk+x0C+jmUN7slv8MJmQY//v0g/ND2Phz/pdpIVLo
         2vZA==
X-Gm-Message-State: ABy/qLZzst7c0eL7kStaPBh24iD8cdjcoSBnmcNs0LbZqScy7xS6visx
        rLAA7U1hmo4UvoyHE9j9f96lOQ==
X-Google-Smtp-Source: APBJJlEUpSuv6ek0IG6gvpo6/AN+HLE/8qgCkPWveuwO9cn5z43hQx5LIHQqlu1ehw1XTBGC1SiWhw==
X-Received: by 2002:a17:902:ce8b:b0:1b8:d4c:725 with SMTP id f11-20020a170902ce8b00b001b80d4c0725mr3847063plg.15.1688160822652;
        Fri, 30 Jun 2023 14:33:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:1498:3821:7231:6e96])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001b53d3d911dsm6903628pls.69.2023.06.30.14.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 14:33:42 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:33:36 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Linus Arver <linusa@google.com>, git@vger.kernel.org,
        calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
Message-ID: <ZJ9J1bW+bHaUygP0@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Linus Arver <linusa@google.com>, git@vger.kernel.org,
        calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <owlybkgy837j.fsf@fine.c.googlers.com>
 <ZJ3uGBEEvYmbPnoQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ3uGBEEvYmbPnoQ@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.06.29 13:48, Josh Steadmon wrote:
> On 2023.06.29 12:42, Linus Arver wrote:
> > I can think of some other metrics to add to the comparison, namely:
> > 
> >     1. Age (how old is the framework)
> >     2. Size in KLOC (thousands of lines of code)
> >     3. Adoption rate (which notable C projects already use this framework?)
> >     4. Project health (how active are its developers?)
> > 
> > I think for 3 and 4, we could probably mine some data out of GitHub
> > itself.
> 
> Interesting, I'll see about adding some of these.

For now, I'm going to exclude Age (because all else being equal, it's
not clear to me why we would prefer and older or younger project) and
Project Health (because it's not clear how to begin to measure this). If
you have further thoughts that could clarify, I'd be happy to
reconsider.

Thanks!
