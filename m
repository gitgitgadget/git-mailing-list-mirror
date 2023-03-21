Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89FC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCURsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCURsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:48:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC82359B
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:47:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u5so16832970plq.7
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679420877;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzdcExcsmfBYyJgDQSzz8AK/nJz2f3AotgxZMeNFimw=;
        b=kD65azW3M6pyG6knZY0zmnz/geuu9I/VsIqVOqoeUNXlBOKYmvjqaaALB3DOv0ZyXJ
         tylzSwe1Mf9qunTYJUWI6xX/Aacu45TqTMqRF4BbHfq1hUzx096DaXgzXA3MvkjN3daB
         wzLZZNmdbo3ym+F2FaUdNygOjs+pRVTAWcHhYzVULilCBb7LFAsXc8aknwz8zTgxP8cH
         4VZ61l6+IlJPyJ53Jg40/xJoTxUjVhCdFWZ4XDP7pfuNfL8JqknQ9/HbeZscYyK7IPJR
         lNsa8ocrcFj034q+q0/VGiLtv1u+6psDflejMVRTG4LmpJMZfAF4XSJ6z/mRgeF+Hf9x
         xDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420877;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tzdcExcsmfBYyJgDQSzz8AK/nJz2f3AotgxZMeNFimw=;
        b=0g9DhL1DFI3VD+YGgYW4x6CjHA3/cMa2hEeGFQkskRhftJL875Hd4NlTas5TUKNq+A
         Ay/hRHkvNvXzF2WB+tJNVi77eDf4JXn5KbrvlSiM5Tkzhy2WXBw1fA7NRaDe/vSN2DVQ
         1Uqq4yEcG97qKvKwC0HRd8VmyTI+5ID50fVhGUG0RA3pO794EyKBb5hAPCkvDSbG7R20
         UjRGqYQwEnB30Sz/23mR6babJmvzMPTwavab7AjsLgRYsaOREXY7hvmIIw3nGs6Rsl6S
         Al4ev0lhHl874RTHNYF/QuQuvZTsirBl/jH1L2vy4khpbXq53VbLwp1Rrurb2wYsF55w
         0Wzw==
X-Gm-Message-State: AO0yUKXl/BDSDYYNNvJCx7RuobLkVQWiKcTNNPkYSQAUqfb6fE5im8z4
        z1hmcVk1j2QQtVqYwHGtqs1eWG0+iu8=
X-Google-Smtp-Source: AK7set9807qKNJA2XA6OgiI8sVDsKqhOwQIioAg80vxUuFv6D6hFYqrWwISfQ0qt+itUCApfQLOXzg==
X-Received: by 2002:a17:903:2442:b0:19d:e11:32de with SMTP id l2-20020a170903244200b0019d0e1132demr3774617pls.34.1679420876869;
        Tue, 21 Mar 2023 10:47:56 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id w12-20020a63f50c000000b0050bcf117643sm8076945pgh.17.2023.03.21.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:47:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: remove GNU troff workaround
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
        <20230321173206.GC3119834@coredump.intra.peff.net>
Date:   Tue, 21 Mar 2023 10:47:56 -0700
In-Reply-To: <20230321173206.GC3119834@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 21 Mar 2023 13:32:06 -0400")
Message-ID: <xmqqcz52hu7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd think 13 years is probably long enough, but I was curious about the
> versions. You referenced the fix here:
>
>> [6] https://github.com/docbook/xslt10-stylesheets/commit/fb553434265906ed81edc6d5f533d0b08d200046
>
> but the earliest tag in that repository that contains that commit is
> 1.79.1 from 2016. However, it seems like that repo is oddly missing
> older tags. You mentioned 1.76 earlier, and the changelog for the Debian
> package of docbook-xsl mentions the 1.76 release fixing it in 2010.

I wondered about the same thing, and did some digging myself
yesterday.  The commit seems to have been merged to their 'master'
branch with the commit 0418c172 (Merge branch 'master' of
../docbook-fixed, 2015-09-20), which is after a curious 5 year gap.

But ...

> So assuming the fix really was released in 2010, even long-running
> distros like CentOS probably would have picked it up within a few years,
> and our workaround should definitely be obsolete by now.

... even if the fixed release was done in 2016, I would say that it
shouldn't be too recent, especially for documentation where we still
give preformatted ones (which I think about dropping once every few
years).

