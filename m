Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28293C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E8460FED
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 17:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhKQR6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhKQR5r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 12:57:47 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC8C061206
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 09:54:48 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w22so4382368ioa.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yQ35Mhu8EZfaeEvN70BMh4YCVgfjm1NZq6Y9mUr61j8=;
        b=LHQIc+KqB9963WCFBC2ArGj9Nt6L3EcNhT48LAdJGEYr+7Ffr8HjJy7sBT/Xt7fVks
         WrV3MqjhN+aJFuVcU3NPFFZqcSCmvIFCqOP8daUmaBABDJzkwv6SpK3KZjZrhmYaSxxx
         LuZxj7mLNPKxd7YFq3nFPiyAgMJIMPiDH+s/pFVViaRJDB/1DJ/OIpPbSwnBOntPG5Gq
         4GOW0SBqUbA4GWXwcB7wmBzREJWba+UgJPWIxgga0CqCWEwzelJ1MWsdk3iee8mFnrDd
         uDP7zJA6pvj1NqOqjq3jC8NV+Le4cb4zSQoBWb7JV20KlPGL/b93iCKwQO1dnaxjDjW6
         cmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yQ35Mhu8EZfaeEvN70BMh4YCVgfjm1NZq6Y9mUr61j8=;
        b=rGD4viN9mcKYcYZJSRqqySmoPwIyrXQR1tdW6OO07dN4n/YnjqUBirsK3M4VxLXEa3
         YM0nIj612myGgM5Yvo5eIL75Yqx+DQWm56hFsaNemdmiT95aIVSN7rDVJep/9VqDJ2f0
         unApWbq6ZYMm8ytQtWdBltbuPkZwDrguruwIBubx6RZosQsPzsx2UT40P85+ljXuIHZb
         P+UTBpoiBd7FIcZohA3LqGxOn5Qjtf5uzrCAHJMAANbCr4apCuSKjE7N5b/eCuJAsGdw
         RVCH6HNOIu/RQRxtDNhAaGF8oSxU5IEq8CPo4quxpkIMM85OCudIwCz73+QnOZEsnT5H
         o0hA==
X-Gm-Message-State: AOAM530oDm0D+FFOKNA8K1lq61y+RYUgUgdasPK5MjP1XDCobbVKdlxf
        6x/IExpEtaFPVHvBEp1CydnxrQ==
X-Google-Smtp-Source: ABdhPJx9DADqIq6lUlSTKDr24HWHRG818++sbG9f0YoV0R+cDNT2aUCoYrLUSfEuyaADD3pd/KcDyA==
X-Received: by 2002:a5e:840f:: with SMTP id h15mr12462647ioj.48.1637171687740;
        Wed, 17 Nov 2021 09:54:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a13sm305069ilc.34.2021.11.17.09.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 09:54:47 -0800 (PST)
Date:   Wed, 17 Nov 2021 12:54:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Philip Oakley <philipoakley@iee.email>,
        Etienne Guillot <git@etguillot.fr>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: Need help in understanding how to submit a patch
Message-ID: <YZVB5hy4Xuim5K9B@nand.local>
References: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
 <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email>
 <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang,

On Wed, Nov 17, 2021 at 11:21:49PM +0530, Pratyush Yadav wrote:
> Hi Etienne,
>
> On 17/11/21 03:47PM, Philip Oakley wrote:
> > On 16/11/2021 21:15, Etienne Guillot wrote:
> > > Hi,
> > >
> > > I found a typo mistake in the french translation of git-gui.
> > > I did read the instructions on this page
> > > https://git-scm.com/docs/SubmittingPatches
> > > but I still not sure where should I push the correction.
> > >
> > > Thanks for your help
> > >
> > > Etienne Guillot
> > Hi Etienne
> >
> > The Git Gui is managed by Pratyush Yadav (cc'd) and hosted at 
> > https://github.com/prati0100/git-gui
> >
> > Not sure what the latest is on contributing translations (not covered in
> > the GitHub Readme..).
>
> I usually ask people to post patches on this mailing list and I review
> them here. But I make an exception for translation changes since they
> never get any reviews anyway.
>
> So I am fine with either a Pull Request on GitHub or a patch on the
> mailing list.

Since Pratyush is the maintainer, does the po/TEAMS file in your tree
need updating?

I'm not sure how up-to-date the file is in general, but the last commit
was made semi-recently back in August, so I assume that the entry for
the French translation is outdated.

Thanks,
Taylor
