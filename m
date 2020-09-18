Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD30C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0978520878
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lc612k5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgIROCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIROCk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:02:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5404C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:02:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k25so5025305qtu.4
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4RIujK6hiujbeJge28OdrdhLVZ+nNyIAwRNGNj7Jkgc=;
        b=lc612k5qg6QRNn4ehhUEPME9O50TSZIlCSNBNHNEJ5DSnHm/SRCmc8u0k8rJm3ZNta
         lxOw/XbI/pcY5L+ipL2Lr5O2RYMrHFQs1dXL3o6bXNxDpnV3QjSGcoT1/Nl9PT5fEaD0
         olrs4tve9sdpTqveeDQ8Wo8Q/ou5bG0J5Gvja6QU8a9NCJz36j01QIegTgux5mHlHFdf
         r3UqTQgqgy69bSWlmmeM0nDEfbnDCgZC2KAD2jHbY14yVCKlyfsDMeD54TR7+ufGkETo
         NqCoRUSmorQZNgwnuyPBEzB1JX9e0D2K7TtiK7xJeY/zCbvL09g+Pk57ihBUScMZFfZ+
         jELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4RIujK6hiujbeJge28OdrdhLVZ+nNyIAwRNGNj7Jkgc=;
        b=j5/B5mxDkEC+Kh6m8ot/7Z8sMcwZ6F792wfrIN1nRvAbYbvfeYOQAkHzboxmGMyEd/
         uhrDP8a3KVJykqVXmmdQ7xpv7liB0/J6qq6Y9GDGDuyvSQjY9kC539o5ISd9C5BrGgxF
         Ns2A/1Jr2/us33E8v2x4X8+Qnh4o1cmRg/3iGF3tY5Qbz/z3YwJLxeWL8/XxauZwdXfF
         PP4HvPC7wlnj4uaRAF8wA7tNnbiiFVoYxAg3fT9tuPc2S4VzvboxGy7RRpTQXdbUZ6QZ
         8SkYcs0qWJqjgjgPJYSFntW/wQYAH3GYeUVUk5tJ1lPr1YrheXV3S7WjVkB3NI+JOoNk
         ME5A==
X-Gm-Message-State: AOAM532++r9qP5I6bPOI0j41QnjUngcOLASgTGJt2Ml6MegmNCJQOegS
        KI6gLwVG/aEXC4c2eE5acHjEhA==
X-Google-Smtp-Source: ABdhPJwuOpHg5AJCU3Z6O54PkZxrxPnu2evNkaiaUQsIQVF4ZqTN5ISlhapYqkPCBkGHvRrIKvFuyA==
X-Received: by 2002:ac8:67ca:: with SMTP id r10mr8794868qtp.303.1600437758925;
        Fri, 18 Sep 2020 07:02:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id f24sm2081386qka.5.2020.09.18.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:02:38 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:02:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Apply git bundle to source tree?
Message-ID: <20200918140236.GA1602321@nand.local>
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

On Fri, Sep 18, 2020 at 01:13:52PM +0200, Andreas Grünbacher wrote:
> Hi,
>
> I'm wondering if there's a way to apply a particular head in a bundle
> to a source tree, for example:
>
>   $ git bundle create v5.9-rc1.bundle v5.8..v5.9-rc1
>   $ cd linux-5.8
>   $ git bundle APPLY ../5.9-rc1.bundle v5.9-rc1

Sort of. You can specify a refspec when fetching from the bundle to
fetch only the objects you care about, like:

  cd linux-5.8
  git fetch /path/to/bundle 'refs/tags/v5.9-rc1:refs/tags/v5.9-rc1'

(or if you prefer, "git fetch /path/to/bundle 'tag v5.9-rc1'"). Then
once you have the objects locally, you can merge it into your HEAD. You
can do all of that in one step with:

  git pull /path/to/bundle 'refs/tags/v5.9-rc1'

There's no such thing as 'git bundle apply' though, although I suspect
'git pull' is what you wanted anyway.

Thanks,
Taylor
