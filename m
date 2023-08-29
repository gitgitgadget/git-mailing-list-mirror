Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5EDC71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbjH2Ryh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238154AbjH2RyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:54:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1C11B
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:54:15 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59234aaca15so53387947b3.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693331654; x=1693936454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Old8+ksV2LqzZERlaMWhlmcOrLPrF9dXi61gc2u+iEc=;
        b=RcNoaGKiRbjwWlZcyqrX/PcSYVR8lNcdTJnRkUYSt1eVimlIM8GckCTEsCfN2/ZdLY
         BfdwXt4Rn5CJ5hbI6G0WwT9kEPCBw+DmFHALjZiaIj2Dni7MU1pC/4V+xTwIETKiC9fP
         MjWBb0E5V5Y4OH9wCf3ZGpxu+BFq5kkye9vqlV7nhVOe56Vya+2I152f3qGikfY2zjwh
         d6sKUmD/n0P1yFhLQgIBom7L9KYAYdQURg3kEJTwIWfJAz0qJ88wNkiDhvfGVbRPhzN+
         kmyL3ZfjQ+HbFncFa+NKdZRpCsjxzdkQlfob7c9YvfZMEIAh8NcHUjpqMDYPkkzfn7j7
         NwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693331654; x=1693936454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Old8+ksV2LqzZERlaMWhlmcOrLPrF9dXi61gc2u+iEc=;
        b=WRBekmKdrEsUI+cxxOfjY5M6noyepVO+wt2/OqQRYPIOiE8vJDuKBqDlWLikWfZMYs
         0FwHHJP6tmhUkzNX5oZC6DiGYxOrbCeM+R5OcdTe5lerPdAkZKtrdT5aSmxnJLAFLNy8
         FEbJ7U8JcMWN2USVqNGuFu0JCpnnWRR6s34e4lHD9UE5+ApBHOl4qcLdMmN6Lp9Vhxaq
         EkiV0s6a/chdWClSd9X6Y0CxYehkpkn3PdjLkvPOSHGsMvLr3y0ZRWBAET9Wk7NzdHiE
         VrjnjdczinlkPxTDjEZuErKQolHCcGDaLJTfAxPPrrlbiYdwPJxFudTdygIYvCVr+GH3
         czSg==
X-Gm-Message-State: AOJu0Yw76e4OrbGM8FHaYCbZUKeORAhef+IOUajo4roRprInd5vp4wyf
        7i2/TKXg+nZCjd0kKE7SjU6rnw==
X-Google-Smtp-Source: AGHT+IGG/gFjRHYg6t5h/IZda/4aDFjKxbMpY6QaWL4fR0n9n5M50XJ4UrA/IquDKzE5axjy45ARSQ==
X-Received: by 2002:a0d:cc83:0:b0:578:5e60:dcc9 with SMTP id o125-20020a0dcc83000000b005785e60dcc9mr29302531ywd.10.1693331654315;
        Tue, 29 Aug 2023 10:54:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z15-20020a0dd70f000000b005832ca42ba6sm2888144ywd.3.2023.08.29.10.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:54:14 -0700 (PDT)
Date:   Tue, 29 Aug 2023 13:54:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: Git in Outreachy? (December, 2023)
Message-ID: <ZO4wxU1ilpa6/3EW@nand.local>
References: <ZNwhVOggObU7aVTr@nand.local>
 <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
 <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com>
 <ZOZSo7vJztHcvb4W@nand.local>
 <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 11:14:38PM +0530, Kaartic Sivaraam wrote:
> BTW, I think the deadline to sign up for Outreachy is approaching soon I
> believe. The community page [1] seems to indicate that we haven't signed up
> yet. Given that there was an interest in us participating in Outreachy, I
> just wanted to check whether we've signed up our community ?

Indeed. I was waiting to see if interested parties had the resources to
sponsor an Outreachy student, since we have to pay Outreachy for each
student we accept.

If you (or others) are interested in mentoring but don't have a way to
pay Outreachy, we could certainly discuss allocating some of the
project's funds to support one or two students.

Thanks,
Taylor
