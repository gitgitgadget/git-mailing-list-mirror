Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076F0CD8CAC
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 17:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjJJRi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjJJRi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 13:38:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3ACA
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:38:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f61a639b9so91070157b3.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696959535; x=1697564335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ghyzp8ZHjUzd/BvrMaZQUWek1ZtoiK+Kheyj14U+jF8=;
        b=vYB9Jrj+Mmya7Jf6P9df/lUDZI53DNszHTEJGMaE6xNPUNcbBCPt9NOwMQUSEbg292
         nQEkPKUD7sAX6bT1oqEj0/jNSX0aRWhKYx+eH5dI0j+Ri841BGvehqrC+tPPKHwj8ZTG
         VG6S9ZWg7ItArl17DymjG/3yJEl+CHje+Er8c/lU/xEgG2RPcZfqLDK12E0IV6WeYqhA
         SgDaiVaI2f3cmuFV36awPU8nqmi23YzJT1o4CXcIIbgzhxUeDj/cRUze3cO9CeLDi3Y5
         BgK4E4rBArz42vPvh4WrAJf7B6f8mRLE1nlSJupGdhceXHVZY2gUoreTrp6/tW4nyxaT
         u4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959535; x=1697564335;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghyzp8ZHjUzd/BvrMaZQUWek1ZtoiK+Kheyj14U+jF8=;
        b=a36f97I8ZMsAeqyJtQEMxx09WTn0/2wCFftaKdHnj9X6tsMv8sS7Dk3ag1C1EkOs/Y
         xRMYPjryJ5lbqfCY/q8Now4UbjOmX3mfkbfn3p/4rnMg7ftXTG8tFElQ78NXTrPdtK3R
         CD/9Ag86aHktGKfOrjn5XEBQdfy75E9dJ+cz95MW3YkrAcFnwK9mzG28CuD63y07uJHm
         7iZ5TGgRqtyZaGWisL84R1bB1llAiEScNIaZ+EuUhDPkoXjSBZXNj4t8rgyW+iQPeE/7
         +LNvwbvzh7mTzYuOY/Z69jxLZl9QuC8md4JJR3sLDke0xi+IEHd/kLEXftNuBUa0fvY6
         jL2w==
X-Gm-Message-State: AOJu0Yxc8bTu3dps0TY/7NIfSagfNI+f6kOVUKP3gdEZQlvhVlLUCEP/
        H3/XzYs93Tt4RGvlPZAgrTJpPCeAwcuxuAp5KW7u
X-Google-Smtp-Source: AGHT+IFJqZZJSe9jGQdujmzDfQ68VHLtZzhjJHE2zNihjwfq4ETDWhnVz0B5I4YfX/AQbcG1Z8UwkWKaHpN67BfhhvZG
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1002:fbcf:d571:5625])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b724:0:b0:5a7:bbdb:6b39 with
 SMTP id v36-20020a81b724000000b005a7bbdb6b39mr53545ywh.3.1696959535428; Tue,
 10 Oct 2023 10:38:55 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:38:53 -0700
In-Reply-To: <xmqqjzruv4k1.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010173853.2147774-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 2/4] wrapper: reduce scope of remove_or_warn()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, phillip.wood123@gmail.com,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> phillip.wood123@gmail.com writes:
> 
> > Hi Jonathan
> >
> > On 29/09/2023 22:20, Jonathan Tan wrote:
> >> From: Calvin Wan <calvinwan@google.com>
> >> remove_or_warn() is only used by entry.c and apply.c, but it is
> >> currently declared and defined in wrapper.{h,c}, so it has a scope much
> >> greater than it needs. This needlessly large scope also causes wrapper.c
> >> to need to include object.h, when this file is largely unconcerned with
> >> Git objects.
> >> Move remove_or_warn() to entry.{h,c}. The file apply.c still has
> >> access
> >> to it, since it already includes entry.h for another reason.
> >
> > This looks good. On a related note wrapper.c includes repository.h but
> > does use anything declared in that header.
> >
> > Best Wishes
> >
> > Phillip
> 
> Thanks for a review.  I just checked 'master', 'next', and 'seen'
> and in all '#include <repository.h>' can safely be dropped from
> there, it seems.  It may be too trivial even for a microproject,
> but nevertheless a nice clean-up.

Ah, Calvin fixed this in one of the subsequent patches, but I'll put it
into its own patch in my updated version.
