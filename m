Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627EDC77B7E
	for <git@archiver.kernel.org>; Mon, 29 May 2023 09:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjE2Jy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 05:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjE2JyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 05:54:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DDBA4
        for <git@vger.kernel.org>; Mon, 29 May 2023 02:54:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96fab30d1e1so652605866b.0
        for <git@vger.kernel.org>; Mon, 29 May 2023 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685354062; x=1687946062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSkhsbBzzYkMM+fDTv/RTYp1Iy3n0uEbpNNNj5THTIk=;
        b=HT4Y153F1o3hEO4ufZBwEEFqoYzUBwdBmqpGwtgabxIUyTUdh/4tXeW7I2SoEvlFR2
         5mnCmE2Q+M+r0jn4nYKxt7bpGaj7OgeP0Kvusuq7547+IurBFzXzglkCNpwUxxiEssZm
         6Rb4bdLXsWvBs7TYYxvDEWwnAU2Bvz7XNj9f7pSlYSipejXJIQ9jV5tAX8JOziqsJyw9
         RKRAlAououYjnHiRsq66Yl54G52GcLnUCYz/WJMlOE6ucH9+pmalxrGmDxhwXqK7u80S
         8LwOdELjhTA7ZoshkeCCqS4+euvL7aL13NONGg5CbmYAJefCSW7oQFuiye/ELVw9jbgE
         ksIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685354062; x=1687946062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSkhsbBzzYkMM+fDTv/RTYp1Iy3n0uEbpNNNj5THTIk=;
        b=mASfjV6HZhvKpDRPrYMv1kcU3saPYBPSpP4xM+yO2LhTi4iAIa8WG3EFygfz6zjPPN
         LGvc4wdNSO0AbhGtolqzJUjCLaF2EDbEm4eLjoSGgH3wuPlXBldZmbaKIwrr6VPKUyf6
         frMl3qvM250fQWSM3p9yol1q8fLCO34VhnHC/4PwqRQJj2dfSjnCwY/vgPxXWVgbmvVM
         5C6j5sUnGmOh0wtN0vUNxczLgUEJYyvzPKiYSs/qaXrJZ24C+v69U2Jt2/Wo+3pUzQYe
         qwXncPWJPjG0mh1F2icPQnUBfoTN1ABgddeHypmPBTi6NGXirK0uYw6EWR5RRtdnGUAJ
         fwEw==
X-Gm-Message-State: AC+VfDzbG20E1nDBqIqwRmv0Blbz3iUk4WFMz/tyBhEM3h/kl9M+iqTi
        BAp/heCoV/0ug5miAAsNc1SEOPK9BAeZ1HShhC4=
X-Google-Smtp-Source: ACHHUZ4C2qvIrF71yPkap15P7bryzC2sMjQLNnoaYMdmqANffr98D/25JvAshoFt7etJZ24Sx6PMUpDRPp6omI3hFoU=
X-Received: by 2002:a17:907:5c8:b0:973:e5bf:281e with SMTP id
 wg8-20020a17090705c800b00973e5bf281emr5233805ejb.27.1685354062056; Mon, 29
 May 2023 02:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net> <AS2PR03MB98158D49DC655F6DC6D10ECDC0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
 <Y3aCx1SYq6jrYfuO@coredump.intra.peff.net> <a76a5e37-0c0a-b9e8-13cb-abaa44cf8911@gmail.com>
 <Y3ac9ZuvpDJO3k9F@coredump.intra.peff.net>
In-Reply-To: <Y3ac9ZuvpDJO3k9F@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Mon, 29 May 2023 10:53:45 +0100
Message-ID: <CAGJzqsmZSTDLLHO1B87c-GUW_7awgCv2Eci_OKVoWLaU8DP+Eg@mail.gmail.com>
Subject: Re: The enduring popularity of git-credential-store
To:     Jeff King <peff@peff.net>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 17 Nov 2022 at 20:43, Jeff King <peff@peff.net> wrote:
>
> On Thu, Nov 17, 2022 at 11:29:35AM -0800, Lessley Dennington wrote:
>
> > On 11/17/22 10:51 AM, Jeff King wrote:
> > > I do think having the docs say "you should go use X" means that X will
> > > have an advantage over other projects which may compete with it. So I
> > > think we need to be careful to be inclusive of what we'll mention, and
> > > to word it so that we're not endorsing any one project.
> > >
> > > -Peff
> >
> > Completely agree with this. I've long wished for a page on git-scm.com
> > that's dedicated to (1) explaining what a credential helper is and
> > (2) offering a list of suggested helpers along with scenarios for which
> > each is best-suited. This could also be a good place to call out the risks
> > of using helpers like git-credential-store in a factual, unbiased way.
>
> It's also a nice place because it's easier to keep up-to-date compared
> to say, a manpage.
>
> -Peff

Great idea Lessley! Here's a pull request
https://github.com/git/git-scm.com/pull/1786 to create such a page at
https://git-scm.com/doc/credential-helpers
