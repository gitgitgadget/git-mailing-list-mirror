Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9AC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE2D207BB
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhU3t+e1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgEOPpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgEOPpo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 11:45:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06919C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:45:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so1115381pgb.7
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sx3+tGd0OCF22IpP3zBHg0EYDMld1KriAyrlHdEtYag=;
        b=mhU3t+e1Q6JECpEMUyH1beabW3L+sRinPjZxGZYY3lf1ftMSg8oOAMjCot8b36INmL
         FTSNngJMOt0cTMyBeXWHoI1zbmD+iU5uom8NkV9B2HndRvfIUCj7Lf8fcem/m9NF4841
         aeiQvgNNV8UOlLiR9J2lLEeFH6ziT2h3vJmX0M4Pqe+MGNzs3rU/T0rVuonmpiyavS/1
         ddt3+qv1xiacyP+3UNHUVztHlU2wKcKFTrWWxR8uOeR2Kl/22JNGN287ClNXy64oMH7b
         0ZytwPQrRAnpRXnJtWM1E67jv7W33K0zOKtYO3E1DU+wAp7EQYPbLn+AXJzBzNm/evlX
         Qwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sx3+tGd0OCF22IpP3zBHg0EYDMld1KriAyrlHdEtYag=;
        b=CP5Gi4BLIJOVV5tRE+LeiCuWJsHoa4J57hzrSU19yo0ocQN6mWW5o7ZBUvVeentJJD
         2pHZmmCB2UaE+LtNTsHnSAb3ef+UfbJmPdteoFUPQFi59e/+ob81ZiDfVIVQgRO6TO5J
         /6wtMTCPEdllfIH1ER6S+8ldRlPLshhMuofLe3zOHWWXsqbkgfzrCGoY2HoWcbueiyZE
         4K9REnkLklnvMDKNIDzhniBzSnEXfGMUuo45NwL+c54/D/8KFtPpQLzCR6rM2EQEOPW7
         5/WrsAncACEOx9+Wg7/CcgGC9uzDdX6w8YZ6fdPjWBBp/969lXdoxeAPV/9W8q3MR1Fw
         4wXw==
X-Gm-Message-State: AOAM532Z9/1pmri61AY123kQ5fM2LBPvJRoMPR9rX0HeGu9ibv5CNXWe
        8UDvboWRL0JqP21UTV95FOvCiAcK
X-Google-Smtp-Source: ABdhPJz6traqiIRUPgiY2NTz6ExiNXHHH3Id1qJaCsDe5odpXDTczpCxzwUCbkwedbvyuKw9/US8Pw==
X-Received: by 2002:a62:3607:: with SMTP id d7mr4373299pfa.245.1589557542409;
        Fri, 15 May 2020 08:45:42 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id u12sm2054699pgg.22.2020.05.15.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:45:41 -0700 (PDT)
Date:   Fri, 15 May 2020 08:45:39 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
Message-ID: <20200515154539.GB61200@Carlos-MBP>
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
 <20200515150041.22873-1-carenas@gmail.com>
 <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 05:38:21PM +0200, Alban Gruin wrote:
> 
> Thinking about it, I think it would make sense to put this kind of
> information in a diagnostic line, as we already do for the code of a
> failed test.
> 
> Instead of this:
> 
> > not ok 1 - plain(error:t/./t0001-init.sh:33)
> > #
> > #               false &&
> > #               git init plain &&
> > #               check_config plain/.git false unset
> > #
> 
> Something like this:
> 
> > not ok 1 - plain
> > # (error:t/./t0001-init.sh:33)
> > #
> > #               false &&
> > #               git init plain &&
> > #               check_config plain/.git false unset
> > #

indeed, and that is why I mentioned this as a workaround only.

to move to a format like the one you suggest, it might be better to
do it by also moving to TAP13[1] (which allows all that metadata)

but of course that would also require us to do more changes to the
integration with GitHub's problem matchers and probably a lot more
changes I am not even aware of.

Carlo

[1] http://testanything.org/tap-version-13-specification.html
