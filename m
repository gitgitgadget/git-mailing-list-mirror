Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B39C43460
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 22:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8E4613ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 22:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhDVWec (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 18:34:32 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38888 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhDVWea (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 18:34:30 -0400
Received: by mail-ed1-f47.google.com with SMTP id y3so19048904eds.5
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 15:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBGNQIQ/rkuCyHkb5PwNcsomZNDkXPAHJc2OkUIxB7g=;
        b=dhKCpmBzbLAj0lRVSRO/Spp9ICjPBtMQapQXt7VQPNvi6vhvh4SwNJ1WRiqscjpUjF
         jpZron6WQGkQSR7Rr/T9IH0gP8Qw1J8QOw4yFpJtlZ18ZErUSQWTUvzN8o+P5C7I9Y5u
         bsn35pamdqnLT0viEeBrdFPrmgNpd2KSLSTlm2xosUHyVtetf62OGaL24h6fdqXe8wDb
         0zd4DBrFme/NnTTJpLK0fZAvql8tzfOrfdH7BpuEp69Wp7C4IxPm5aIc9cIDWS/zU+pD
         TiliCDPKD7IvMKaCWqD5jvVyAqsKOBU4nKUMBM4TsnuIR1CDRsFyXS3KN3buuxn1A5ya
         07Bg==
X-Gm-Message-State: AOAM533L93fnuzC7t7+Ol1e2GEcQsd131m2cZtrWng6WiB0cnkKBVSHI
        KXaVJHAxt0N1Ukn7ts24kxI6bEfe6nt8qJ7jcbc=
X-Google-Smtp-Source: ABdhPJzJ0UwUQNCrHf8oke6i/zkRyhBgtXaTU538LHp5xlh84bDYi96felg/Kmam4sU5eN5PGL80bYnLaarjWETZMIk=
X-Received: by 2002:a05:6402:488:: with SMTP id k8mr789701edv.233.1619130834581;
 Thu, 22 Apr 2021 15:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKu1iLWfaAaKH4Uui4wfa0STFEaXqqtc304b5V0ZNtmBg78J+w@mail.gmail.com>
 <20210422050504.441-1-tzadik.vanderhoof@gmail.com> <20210422155047.3unltvv3mh5uq7wp@tb-raspi4>
 <CAPig+cQE0oHHY89D6fLyymduY3=zSe8y246cz1P2MjTZhrMHNQ@mail.gmail.com>
In-Reply-To: <CAPig+cQE0oHHY89D6fLyymduY3=zSe8y246cz1P2MjTZhrMHNQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Apr 2021 18:33:43 -0400
Message-ID: <CAPig+cQUaJq4Bu1NDSBnsQoR2HXhQ+s+4aQHeVP82DM_BuEL8Q@mail.gmail.com>
Subject: Re: [PATCH v3] add git-p4.fallbackEncoding config setting, to prevent
 git-p4 from crashing on non UTF-8 changeset descriptions
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 22, 2021 at 12:17 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> We normally want to avoid using bare single-quotes inside the body of
> the test since the body itself is a single-quoted string. These
> single-quotes make it harder for a reader to reason about what is
> going on; especially with the $2 in there, one has to spend extra
> cycles wondering if $2 is correctly expanded when the test runs or
> when it is first defined. So, an easier-to-understand rewrite might
> be:
>
>     desc=$(head -1 log | awk ''{print \$2}'') &&

Of course, the quotes surrounding the {print...} should be
double-quotes, not pairs of single-quotes:

    desc=$(head -1 log | awk "{print \$2}") &&

(I didn't notice the problem when originally composing the email since
the compose window wasn't using a fixed-width font, and only noticed
it later when re-reading it in a mail reader which does use
fixed-width. Sorry for any potential confusion.)

> Many existing tests in this project use `cut` for word-plucking, so an
> alternative would be:
>
>     desc=$(head -1 log | cut -d" " -f2) &&

At any rate, using `cut` would be a good option since there's plenty
of precedent in existing test scripts.
