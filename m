Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D04C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 18:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDNS72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNS71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 14:59:27 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDFC213A
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:59:26 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id u18-20020a4ac992000000b005423ee7a8b2so619530ooq.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681498765; x=1684090765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MsdeguKTMaSPzhAmSqaDaPPB+RO279nJQf2LwWjuIQ=;
        b=G819674UZQ8rj5P8Qzaj+OeAj/Y2ca1JUGGp3fS+RAzwG4XZYb1Ap05eymHtsXnxU7
         E8crPA+jqukP/bLfVKSvKZxaq1Cqgy5h1Q62faJUqczkaarHMPKZqoxso7QNMj6l7HO5
         56o8ESIxDQhq/gNSRR55tG8uks+qbPe8wOhtjYOUuoSxSXwfifjYvkGHF2U7c7kn3VEb
         qOQ/qUFdKj2B3Oo1w3TI3yS3RighVfBkAJZ56xfwb0YWRLro+Fm/GflpXITUvievw3zt
         b5qWDAlnGan7HzvNdIyKPYcgMhCj3qOv4Xk1SgAncLBA3qAbSVxABwvxCn3G7nROhkB9
         mqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681498765; x=1684090765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/MsdeguKTMaSPzhAmSqaDaPPB+RO279nJQf2LwWjuIQ=;
        b=l2nZa/JxOdOtEzHUoOJ+x3tvZY+V2J1EKNWueRTtIAooVWd2GzRGMebAJCQHbY4LRB
         B5MFkLMsdHBkvSgkwg7/LLzZHHoOkmMEBTMd7VKs0N4GnDJtb2iDgwAn/0bauJM1pP7T
         cMXAI60qWIpBq6XyTwP9im4gelvJ80m+JR0HH1I4r9nG6b8XoYeRz0EO6v4zWDJMkOsA
         OyMArF2ZtvKIQFFkCf3fAInYQWV1BK4gDDmYHg6dGnyvpBVK9TYeFrkhoporGw0Es4fL
         CVZQUi6zd3e8rqXnIQjtqZHcMAefDa8a22puKrEV+Znbcml5cFIfHYeqTG8cRhQeARiq
         A5wQ==
X-Gm-Message-State: AAQBX9ettn7o9dT2xdR/+KRs7mgJS0yjdnOiiJqMxfN7xPEds7yjeZjG
        yQDUFcUJzAp1FYTP1PYDN50=
X-Google-Smtp-Source: AKy350aEkBJ1IZ9PIgI5hVM7Tvf7tmaJMMHDs8voLbeYZ0H3s563DqRkFg33dUpq9xt8XAKZpkApHw==
X-Received: by 2002:a4a:9529:0:b0:542:1a98:e98f with SMTP id m38-20020a4a9529000000b005421a98e98fmr2581332ooi.5.1681498765428;
        Fri, 14 Apr 2023 11:59:25 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a09c4000000b00525240c6149sm1992764ooa.31.2023.04.14.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:59:24 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:59:24 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <6439a28c34fe7_5f77329440@chronos.notmuch>
In-Reply-To: <xmqqv8hyqsc6.fsf@gitster.g>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
 <20230414070449.GA540206@coredump.intra.peff.net>
 <xmqq5y9yv601.fsf@gitster.g>
 <64397d3d67d21_5e3ce294a6@chronos.notmuch>
 <xmqqv8hyqsc6.fsf@gitster.g>
Subject: Re: [PATCH] doc: set actual revdate for manpages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> Are we sure historical GIT_VERSION strings never had a SP in it?
> >> I would be very surprised if we did, but the correctness of the
> >> approach depends on that assumption.
> >
> > Why would that matter?
> 
> Ah, that is true.  What I should have worried more about was the
> distribution package maintainers who may set their own version by
> writing it in the "version" file themselves.

In reality they don't do that. I checked Arch Linux, Fedora, and Debian,
and all of them leave the version alone.

It does make sense becasue for example in Arch Linux `2.40.0-1` means
version `2.40.0`, release `1`. I believe all packaging systems use the
same semantical distinction.

I asked ChatGPT, and this is what it said about `-1`:

  -1 is the package release number. This number is used by the package
  maintainers to indicate how many times the package has been built and
  released. This number is typically incremented each time a new build
  of the package is released, even if the underlying software has not
  changed.

So it makes sense for `git --version` to return the upstream version,
not the package release number, and that's why packagers don't mess with
that.

Either way, even though I don't think it matters in practice, I
generally prefer to separate fields with tabs, or even newlines. If you
consider this an issue, we could do:

  printf '%s\n' $(GIT_VERSION) $(GIT_DATE) >version

  read -d'' VN DN <version

Cheers.

-- 
Felipe Contreras
