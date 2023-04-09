Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D1C77B61
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 02:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDIC0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 22:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDIC0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 22:26:07 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61314EF9
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 19:26:05 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z9so1836013ybs.9
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 19:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681007165; x=1683599165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwxUc8rTRCGjPOIycrUgncdm533V0XEhqZ+Jl8PONVQ=;
        b=oz3rKS8y9kWwKcHggbRdb36p6SusQemiAluCaHKoJcR3WZ4ChoRoKPvduPh8U6gTXt
         /K0KMQPDhBXR+ikwlfWobyhWx9WUGOtTN0UX+6ae43gOjn2l+RFhrKDP77BcjvDBeR80
         yGYUC9qYTGAWuXh1lEUVAqch8/Sp7cK90t/DTgaBzbNlmP+09a2tM9ikGOBLe6gWMTz3
         ZAzGD5xM2SriLEPZ7+m5QBN1kVkCV0QPuCUwvsOHoo2aktgRz7Vnr/kYvOQnY3JIgFRB
         rNi4qgK2BMnHLwLUww8O37HZmT9jeHuy6W3SPVLAPa0QGspDujTKvKL0skQWE561K/3l
         8SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681007165; x=1683599165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwxUc8rTRCGjPOIycrUgncdm533V0XEhqZ+Jl8PONVQ=;
        b=A65Z9DQjQPR63nfWdKRI9TQlvOQP6wn9jIj6HbjQoKOW4/ToyimE7mYdPOC6hIPfXu
         fmC24fOkkS5Ks05yVSxBpuqFhMwefIG5d8vtFiiK+VUptSUwZj1Wq838N/TVxX9akNyr
         1Ay4kcukpphtMum41qvCR1zL5y0AEwkatca8jz5M0A8SBBTDP0kBR8xDl/lniH364B8Z
         sYRwrsqXzI0Bx/akgo/51M8Z3CcecOwO+zlbez3fAlFYeVgaMfjhdKmFYJX9NrhChsmP
         hYx1Fc7I4QFvbYO3ui7rAh43aEyTK+vF+aR8PtvRC9lTv8QK+5PJdr8ZClb+3LY2yLmW
         wDOw==
X-Gm-Message-State: AAQBX9dUesJV5kIT68fADxJ5+QTsibZVtbLrnWeGbzG5CJPjESkv1zTs
        famIFChersSISZsp6oiPjpEEtba3z5WfTul73rc+9A==
X-Google-Smtp-Source: AKy350ZFwYnBlPJMdXm0+qg+yZc02ahGHLlboa9nNOvsLiaNYIxDD8lqHZtImsgetrMrutwUs1JORg==
X-Received: by 2002:a25:1b05:0:b0:b6c:423d:ab18 with SMTP id b5-20020a251b05000000b00b6c423dab18mr5941975ybb.7.1681007164706;
        Sat, 08 Apr 2023 19:26:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u8-20020a25f808000000b00b8c31377e1bsm1512553ybd.54.2023.04.08.19.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 19:26:04 -0700 (PDT)
Date:   Sat, 8 Apr 2023 22:26:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <ZDIiO1HMjej+rnMk@nand.local>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
 <ZDIgyKDQ2rJT2YEI@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDIgyKDQ2rJT2YEI@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2023 at 10:19:52PM -0400, Taylor Blau wrote:
> On Sat, Apr 08, 2023 at 09:28:28PM -0400, Taylor Blau wrote:
> > > I don't think so. While `git rev-list` traverses objects and performs
> > > filtering within a revision, `git cat-file --batch-all-objects` traverses
> > > all loose and packed objects. It might be difficult to perfectly
> > > extract the filtering from `git rev-list` and apply it to `git cat-file`.
> >
> > `rev-list`'s `--all` option does exactly the former: it looks at all
> > loose and packed objects instead of doing a traditional object walk.
>
> Sorry, this isn't right: --all pretends as if you passed all references
> to it over argv, not to just look at the individual loose and packed
> objects.

The right thing to do here if you wanted to get a listing of all blobs
in your repository regardless of their reachability or whether they are
loose or packed is:

    git cat-file --batch-check='%(objectname)' --batch-all-objects |
    git rev-list --objects --stdin --no-walk --filter='object:type=blob'

Or, if your filter is as straightforward as "is this object a blob or
not", you could write something like:

    git cat-file --batch-check --batch-all-objects | awk '
      if ($2 == "blob") { print $0 }'

Or you could tighten up the AWK expression by doing something like:

    git cat-file --batch-check='%(objecttype) %(objectname)' \
      --batch-all-objects | awk '/^blob / { print $2 }'

Sorry for the brain fart.

Thanks,
Taylor
