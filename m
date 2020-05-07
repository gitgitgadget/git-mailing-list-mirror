Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8250FC35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5801F20CC7
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMWS/hoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEGXfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbgEGXfu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:35:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17CDC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 16:35:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so3369208pjh.2
        for <git@vger.kernel.org>; Thu, 07 May 2020 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UDkUl/v5nhys55s/0RoJu2CZoxY/RsGDtVIUuJcUwws=;
        b=RMWS/hoaSVUTInhJ3NCKz3hqxjVxPsFGbDjUPDkfHqtwSEe7FFYFtJqaY1NHKhqwFb
         8sfr8sBJxrwbl0VVZ0xAaFvHO150E8PRKRlXza1/1fVbJ4vUo8V0SJXoSaQoDDq+8OKH
         uFLbiNlX0EQvxjIDqyx4Y3vU9Aj/YIVzZNEZANTGrZOkOu2FcO7R8KGogNcBX0y068XU
         0s469LJ8qrlEssQE9N4HIgkceGghT/CmftgVWQfbCd5pCsFiM9JwY1aF7C1HYv90FN96
         z4PWCRgSeoqVIvRaa1BzcGUlScSlJyvltAT1OvUYWGofD1SeMuXTFQRSmNOX3C9Qvkxk
         t/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UDkUl/v5nhys55s/0RoJu2CZoxY/RsGDtVIUuJcUwws=;
        b=M9hLU9vYwaon+04mZZHUXuCmrvMP7TqWBkXnOwoJMTNn/YS67ETNtor/PYcFaUtv03
         vV3yRWk4yO9Bbi/HMxJ9WIAQhXCzxGUtYKpI+KFiqhndNaAGVZi2/zzOc9pgotAeG4NI
         C1C38+HKHoY/h7YicfkHXkLH3U+8D7QGUdmZJlv/g6zktL98tu+jXAhsS7xhACrVb+bM
         jd/lEBKD0QStLc9nN3OJXag5MvfO3Em+RPcDrJH9rRaNQ0qcNzXWr3FtmpZ9V4FSmi8S
         NYuKgeu1KfQ5GczcGzDdCMRkPZ22zcavpWF0MW8qbqqd5i4sIffu+G0U3arADX9TKrgV
         IssQ==
X-Gm-Message-State: AGi0PuaT/SvoZ6CESyhvCnt+E3kNWpnCjL3OcpS9mWE3RlUX20UZ/YZl
        r9uu5VC64ihEN8fylDvk+6o=
X-Google-Smtp-Source: APiQypLOiliJrjUHbYMVgniCeQrheFb2CvYtXiCO+3nKfblyfkTyMm9DP2KYEwPihrx/KDO+X8/BUA==
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr15430686plk.255.1588894548983;
        Thu, 07 May 2020 16:35:48 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id c28sm5915034pfp.200.2020.05.07.16.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:35:48 -0700 (PDT)
Date:   Thu, 7 May 2020 16:35:46 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] credential: documentation updates for maint
Message-ID: <20200507233546.GB19917@Carlos-MBP>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
 <20200506162712.GB1275237@coredump.intra.peff.net>
 <20200506232848.GB75901@Carlos-MBP>
 <20200507205909.GA38308@coredump.intra.peff.net>
 <20200507212348.GA19917@Carlos-MBP>
 <20200507221748.GA41996@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200507221748.GA41996@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 06:17:48PM -0400, Jeff King wrote:
> On Thu, May 07, 2020 at 02:23:48PM -0700, Carlo Marcelo Arenas Belón wrote:
> > On Thu, May 07, 2020 at 04:59:09PM -0400, Jeff King wrote:
> > > On Wed, May 06, 2020 at 04:28:48PM -0700, Carlo Marcelo Arenas Belón wrote:
> > > 
> > > > Subject: [RFC PATCH 5/4] credential: document encoding assumptions for values
> > > > 
> > > > Because of the similarity on the names of the keys with what is defined
> > > > in RFC3986 is easy to assume the same rules would apply here.
> > > > 
> > > > Make sure that the format and encoding is well defined to avoid helper
> > > > developers assuming incorrectly.
> > > 
> > > I'm not sure this really clarifies anything, because it just says "no
> > > assumptions can be made". Which I guess is a statement, but I'm not sure
> > > what I'd do with it as a helper developer.
> > 
> > not sure what part of the added lines you are referring to but I am happy
> > to provide some examples of what I would expect to clarify below from
> > what I'd seen from some helpers that I'd read the code from recently.
> > 
> > as an example, I would expect the helper developer to start checking for
> > the locale and calling iconv in cases where it is not using utf-8, before
> > sending it to a storage that requires that (ex: osxkeychain), or utf-16
> > (maybe in windows).
> > 
> > osxkeychain will probably also check for protocol in a case insensitive
> > way to make sure it is not ignoring credentials that are not all lowercase
> > as it does now.
> 
> Those things all seem reasonable. I just meant that reading:
> 
>   No assumptions of case insensitivity can be made on their contents and
>   if a specific encoding is required (e.g. "UTF-8") then the byte
>   contents should be re-encoded before use.
> 
> didn't point me in a useful direction there. Reading it again, I'm still
> not sure if you're trying to say that helpers should match protocols
> case-insensitively or not.

What I am trying to clarify is that the URL or parameters they were passed
were not normalized (as it is usually expected for internal use as per
RFC3986), and therefore they can't just do a lowercase check for protocol
hoping it will match regardless of what was input by the user.

they could decide after that to treat credentials for HTTP differently
than the ones for http (like store does) or not, but at least now they
know what to expect.

then again, writing specs is not my forte, so if there is a better way to
express that I am happy to see an alternative.

> And TBH, I don't think it matters that much.
> It's a quality-of-implementation issue for helpers, and if nobody is
> complaining about their behavior, does it really matter?

it matters in principle; deep down any inconsistencies on behaviour
would eventually lead to bugs, and some of them (like the ones that
were raised recently) could have security implications.

one way we could help avoid inconsistent behaviour is by having a spec
that while allowing for a flexible implementation makes sure there is
no ambiguity that could result in mismatching interpretations.

> I'd be more
> concerned if doing the wrong thing involved a security vulnerability,
> but the worst case with case-insensitivity is probably that they _fail_
> to match a credential when they should.

I don't think any of these suggestions is directly related to a security
risk, eventhough as explained earlier has the longterm effect to reduce
the risk of one.

it is also not a final word, as usually having these controls implemented
multiple times is also a risk, and will be better IMHO longterm to do
the normalization once and get rid of them, but leaving them undefined
is IMHO a lost opportunity until then.

Carlo
