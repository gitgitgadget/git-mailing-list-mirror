Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF01C4167B
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 11:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLYL0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 06:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYL0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 06:26:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49FD62CD
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:26:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o2so3108163pjh.4
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3dBtrxoRykL5POt1yEzAvPYRQXBk4Paxj5W8nRj+HqU=;
        b=l7fhG2UjNJRYz4jjKi9gBjze77v73ph+f2F+BmkJkTmtdT1JFTdptAAEFyFeL1tN5f
         B4lKeAHQBX3rnF5Zj0qDWpt9n+aXwAVDc2sv8oZvFQmFvjABQ0qnQ1PzAM4McJw9swQR
         DJg8Lv9h7GzpTt7Qq2E1uAX8BJuWbVNtwkPOf9vWhMgxddDlW6jKrhv2SYXZupWUXgRM
         Wq4b94Xk7UFovDVxwnZz2TSlU89Rm7J+uLlj9gBZYc+RZtwozXwwhr1x3K7LzBPvQuPL
         2GHMgG2Ay4N59zsIQL98xf89m9lHW+9AAsHBJYA3wcJmQ+MVChmsJTEdwA6nrwUBsWnS
         Bomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dBtrxoRykL5POt1yEzAvPYRQXBk4Paxj5W8nRj+HqU=;
        b=2J/jWzYe2dzN6kwEmfBx9DHv0J41UlNDDQH6iQkhGaj5jVk2LO+OyDcTxoNHWurabc
         A97JH1zsgy3k5WkzSz5VEFjTZMJR3ZpTv13QEtd31rT57AG68cx5VJr4VW8Lqr2xwXsz
         1f7KZOvkvx6CTT3EeDUt24xXPuxWLX+sA2fK9MedkjKKwJC1d3yJYotIDxsRwdrUHvC8
         4mSuuvSzego2qGnmhO2Y41C7sMUA9xZQXdWC9zANplovfuW7S/5fZ/yCbPPJp8r3S8Fp
         fS61rYBtFsy1B02imeO5/3g2fWsGak4irPvjCTd2OzcQ7RgK6Wqev70vPnS1XDVC+Tko
         YWSQ==
X-Gm-Message-State: AFqh2krRXCLfjmdRbtwZkDeYN55QJEmfAW1ksCK/EO3Fhoow28H0ylHd
        A+SgI6brqQsFxE12Lywq0aIvQpyjuDKtzA==
X-Google-Smtp-Source: AMrXdXsIQ+yl9+aR3xFZTNuostOcBAoWxEeV48Y9FFANzo2lRrupcAIM43bTjyYG1dKBPCrvKJX2Sg==
X-Received: by 2002:a17:90a:854b:b0:219:ce72:f480 with SMTP id a11-20020a17090a854b00b00219ce72f480mr17175994pjw.13.1671967560314;
        Sun, 25 Dec 2022 03:26:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z3-20020a17090a6d0300b00225daca646csm1852398pjj.34.2022.12.25.03.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:25:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] refs: fix corruption by not correctly syncing
 packed-refs to disk
References: <8c8ecf8e3718cbca049ee7a283edd7b7887e464e.1671547905.git.ps@pks.im>
        <Y6HYTt58iecdBEdw@coredump.intra.peff.net>
Date:   Sun, 25 Dec 2022 20:25:59 +0900
Message-ID: <xmqqtu1johbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 20, 2022 at 03:52:14PM +0100, Patrick Steinhardt wrote:
>
>> And while we do the dance when writing the `packed-refs` file, there is
>> indeed one gotcha: we use a `FILE *` stream to write the temporary file,
>> but don't flush it before synchronizing it to disk. As a consequence any
>> data that is still buffered will not get synchronized and a crash of the
>> machine may cause corruption.
>
> The problem description makes sense, and so does your fix.
>
> Grepping for other uses of fsync_component(), this looks like the only
> buggy case (loose refs use write() directly, and most other files go via
> finalize_hashfile(), which does likewise).
> ...
> So given that this is the only affected site, it makes sense to just fix
> it for now and worry about a more generalized solution if we run into it
> again.

Sounds good.

This came from bc22d845 (core.fsync: new option to harden
references, 2022-03-11), before which we did not even fsync() the
file, so let me apply directly on top of that commit.  Those who are
stuck on older versions of Git can choose to merge the result, even
though I may probably not bother merging it down to anything older
than 2.39 maintenance track.

Thanks.


