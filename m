Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F18CCA480
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 17:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiF2RVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiF2RVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 13:21:20 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A13DA5D
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:21:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k20so12587952qkj.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=omXn/IdrD76Cw09tTNXp3D97vYGKUobi9113AIav7gY=;
        b=ZyUE+0s+DcXli/bDTBJKZgdfvZ2XnOAL2Iu80FSp8zbnmKIhwO0FA9OZughKLjt+3a
         iZU6NG5x3ghyx8uj8UP+hLQBfx9ReuX3YVM3hN24BpjNDhuRAr4jhbRUZzSenkBGePek
         +vMy1ybSP02BcEvxcyWqoQNKQrPv298b5bRBVxYOhRMF02s4yWwWkstanzmCNIyJbuof
         1DGkJfiwjQH6Q11/3/RC4ih8KVr6eo2iBseSeQqNjexUdVjvzAydU5Dw50Q8rQdpWOkx
         bN2cVHZXYjYBxEb3VEKRXTPGIVZieEe/M4n4JTvtblR6p+tVYEc6x9Wg6c38Ry0C+ixD
         NR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omXn/IdrD76Cw09tTNXp3D97vYGKUobi9113AIav7gY=;
        b=Rf26g8NU/QWxXsSX0R8DmBBEoSYxK5p9lk1XQFUuiK4vvrI+MJ5Jojcp0yShDbtxXd
         Exm3TNs/BLHIZDdt+Vmr9hiP6uMgZiBwP971l55H0lEsBoQ3d10OjuYjppW1j9tWHCsA
         wUK7kABYbRJVmhyz3ihgCZ3znToT4YJJm+v7dWNUgM++K70dQEFvM5lqpUiiKr4tyfE6
         RrU4/LN6AKxXxIjUo0nPQ2ga3ub85fACf0F846jDR61LwGQPDGBCofzd6CLn4ibJRXts
         Oc7EBg+7+ojnkM0sfZtWRYkEekIPaKdiKE0y1X90rY+mAVzsp3if5Y3qLrCBjO1A03Ii
         0jOA==
X-Gm-Message-State: AJIora9Okw3YAqcekasxjfbCRwDU3jxJR7DubvGb2ny7L71iSnQWn0xb
        iGcPWaU8AsIy0ozgz0Zn5fqpvA==
X-Google-Smtp-Source: AGRyM1sXtRqLh23afXtCpGQmJ/rs6zbRxS6xLuShxmGtZE4xu3H1qmkXwg+GY2Y7khVNMayVnEY37Q==
X-Received: by 2002:a37:bc8:0:b0:6af:5605:fa39 with SMTP id 191-20020a370bc8000000b006af5605fa39mr3003234qkl.336.1656523275602;
        Wed, 29 Jun 2022 10:21:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a44cb00b006a37eb728cfsm7939593qkp.1.2022.06.29.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:21:15 -0700 (PDT)
Date:   Wed, 29 Jun 2022 13:21:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: Race condition between repack and loose-objects maintenance task
Message-ID: <YryKCl5J1Em89d3e@nand.local>
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
 <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 10:16:38AM -0700, Gregory Szorc wrote:
> > In either case, my recommendation would be to keep those unreachable
> > objects which haven't yet aged out of the repository around for longer,
> > which will decrease the likelihood of seeing the race.
>
> We had to lower gc.pruneExpire from its default of 1 hour because
> otherwise this would result in the creation of thousands of loose
> objects. This is normally acceptable. However, on NFS, the churn from
> lots of file creation and deletion resulted in acceptable performance
> degradation. We had to lower gc.pruneExpire to minimize the damage.

Makes sense. Having a shorter gc.pruneExpire makes the race much more
likely to occur in practice, so I'm glad that we have a plausible
confirmation that that's what's going on in your repository.

> > See Documentation/technical/cruft-packs.txt for more information about
> > cruft packs.
>
> Yes, I saw this new feature in the Git release this week and am hoping
> to roll it out to better mitigate this general problem! With cruft
> packs, I anticipate being able to restore a longer gc.pruneExpire
> value as they should mitigate the NFS performance badness we're
> working around. Thank you for confirming it should help with the
> problem.

That should definitely help. Let me know if you have any questions, and
thanks for trying it out!

Thanks,
Taylor
