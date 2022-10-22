Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A63C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 00:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJVALZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 20:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJVALW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 20:11:22 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2E26396A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:11:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r142so3602111iod.11
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTZpQ5vZiqag98O47XDMwIfrAUdpvQ6o4Oz9wamzP94=;
        b=lt8xqSwBCJfGX43bJX8ogus5erz9GeLspUeDvMpOm4C1VUEZGJcyuH9eFbCkiQpn+V
         GHh9Of/Y0eAzQk7M16dxOmrwuXdoFm1JBLOl/LUz+pnIMtSQ4+X48y/RtNhvoTop2oXc
         ShF+d7exOinE4TlFSZlWRYOcsXcH+4jZ234Yx4SMhtyBHEUb7OCPOdriyOlYSPqJ2yz0
         jYgb21c4dJZHQayRTIfZFg8sSM19Fdsn3/v0DaaRvfK/zinOpI6dlKFPiqAvYZ+1aNKw
         rWPdj8OZvcVGnELp1/d0PjZX9d/LJHlAcMHQfH87GqTUIPCPBNq+LQcktrXbT1Nl3ulf
         s8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTZpQ5vZiqag98O47XDMwIfrAUdpvQ6o4Oz9wamzP94=;
        b=ANasAkFEFjXOueroYjwrSNXaCn6okljJcgbtvZQJwV7Wyja0AaQ+OMvXxRTMvM2WWR
         vkSB0srHiYjqXXPAHa/i6Q0f2rcfeg6K023UfZ9i9yzN/53bjV/9szXCu+4LNzOfvBKi
         KOYdKsp0BTn2Gw+tdZHdOtZRZZPbpij6rhkSw0FDWUpHFkAHkjH+dMFCKUn3+iiE7dy5
         GDyiOXnT38q3WFMCVBWlH0oaara6m+wAkBj64m69zlyGLm+vMpMJXjY0qj/72P6njDz2
         M2gUxnBscCn+NKDHrjqvwf/bTSBeJq1uOG7XuYr/5SKE3nWAc0wEqkLix2LpMluw6YV7
         jEsw==
X-Gm-Message-State: ACrzQf20FRb3gezR1CzbXJQSzatlkp7qAWiniylPcG3d1DRtBfeLs1l6
        Vmd5Jjq7KYOgSDSKkcnDSCkFNQ==
X-Google-Smtp-Source: AMsMyM58tne1cIyJl6wHPKylPJh0FxUvHvNi/QttDfjqxRngOiCf0clWiygWtwS0jKaALz9yt9Tn5w==
X-Received: by 2002:a05:6638:3590:b0:364:21e:d0bf with SMTP id v16-20020a056638359000b00364021ed0bfmr14881124jal.124.1666397478444;
        Fri, 21 Oct 2022 17:11:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c2-20020a023b02000000b00363582c03dfsm4760223jaa.85.2022.10.21.17.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 17:11:17 -0700 (PDT)
Date:   Fri, 21 Oct 2022 20:11:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v3] embargoed releases: also describe the git-security
 list and the process
Message-ID: <Y1M1JGBzZqoPUy9I@nand.local>
References: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
 <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:41:49AM +0000, Julia Ramer via GitGitGadget wrote:
> ---
> .../howto/coordinate-embargoed-releases.txt   | 175 +++++++++++++++---
> 1 file changed, 147 insertions(+), 28 deletions(-)

This version looks great, thanks for your work polishing it up based on
mine and Junio's review. I agree with what Junio said downthread in [1],
and left a few minor nitpicks of my own.

So, I don't have much to add beyond what Junio wrote. I suspect that
between my feedback below and his in [1], that should be enough to get
v4 ready to be queued.

> +- The security-list members start a discussion to give an initial

s/security-list members/members of the git-security list/.

> +  assessment of the severity of the reported potential vulnerability.
> +  We aspire to do so within a few days.

Well put.

> +- Code review can take place in a variety of different locations,
> +  depending on context. These are: patches sent inline on the
> +  git-security list, a private fork on GitHub associated with the
> +  draft security advisory, or the git/cabal repository.
> +
> +  Contributors working on a fix should consider beginning by sending
> +  patches to the git-security list (inline with the original thread),
> +  since they are accessible to all subscribers, along with the original
> +  reporter.

There is some slightly odd wrapping between this and adjacent bullet
points. It looks like the width of these lines is slightly shorter than
the others.

> +- Once the review has settled and everyone involved in the review agrees that
> +  the patches are ready, the Git maintainer, and others determine a release date
> +  as well as the release trains that are serviced. The decision regarding which
> +  versions need a backported fix is based on input from the reporter, the
> +  contributor who worked on the patches, and from stakeholders.   Operators

There are a few extra spaces between "from stakeholders." and "Operators"

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqo7u5m8ku.fsf@gitster.g/
