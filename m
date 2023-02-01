Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCEEC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBAXhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBAXhW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:37:22 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412AB3EFD5
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:37:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w20so18224pfn.4
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 15:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10w0ykO8dQh0A0sfGjsBuaPihOMCBWUgLAhfYllEgUA=;
        b=QlAJiSdpQ0El2Sg23aD7rBlauhW27DA+IiscOR8yqtIhAkLB05Y8ZN0rNW8vclb8YX
         RmEpWI8GFPXEnHjXyGx8nunxg0MDv9/PiC2cPLbHinwFJqCd+B9TQKx/JXYg2j8G/AF5
         3Dmtbwj9qCbg5nKEq1m6nj7r/8i1s5O6CYU91QjG5P9WPxFlMRFR17psucNJ+OYHG8VU
         SyN+bP9c3ktpfKrgWhQKmNAXVyoOouLW5yc7AJXj2b3gOW3u2//9/+fR/GzeeoT4Mk2N
         w4uv90Jl72KcpFrk6JICM+DrKZgexSk4/2SAP/eUxxcqqd8+9qjmynsRVCm3j0H50kyJ
         P3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=10w0ykO8dQh0A0sfGjsBuaPihOMCBWUgLAhfYllEgUA=;
        b=2icaij7DIyYMj3Cef1wIjdZchX/t9iu+CCUDcECgOdwP1ri1ZJ/eJULBRqyHuygLqO
         bgFYS/ASgHDi8kvUO7ZaeP3T5sVM92QnD5L/WHf16uPepU15bj4cGam1uOS9iwpIxapT
         fjoVYHbi7xF/B0mxy/xKMKWYCK0ywAH9z0reQFyMio+Xy0UhmrWlHmh/85vcjcm1npMT
         ZAzNcVsJoA2sE0WnbfvSvr6QvtJwCdSoPPT0SRbfOWplYzq0cMgeZPhIf5PNJUU5AzmB
         IkJ3tbJc8I8qinJvLqbeNUIkpmvnBZfxlc03a9NSQdjNOePAg5s1pWzY+j7SZHIflAdP
         wxog==
X-Gm-Message-State: AO0yUKWOgSVl6IjnMKAAlvd6h1cnVxbZu8dQlcApWxqcV6wBc7dhICUG
        DCP/6LAB9lFm9bPi6TtGrqo=
X-Google-Smtp-Source: AK7set+7pGUmqQ63pXiSVAG4DQuWNilLBe6XFf/0BrcQyFaTaXkLbpLUjkQxQLvF87GvpINKFd+joQ==
X-Received: by 2002:a05:6a00:2a6:b0:594:1f1c:3d3c with SMTP id q6-20020a056a0002a600b005941f1c3d3cmr391030pfs.17.1675294640596;
        Wed, 01 Feb 2023 15:37:20 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z189-20020a6265c6000000b0058da56167b7sm11972918pfb.127.2023.02.01.15.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:37:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
        <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
        <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
        <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
        <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
        <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net>
Date:   Wed, 01 Feb 2023 15:37:19 -0800
In-Reply-To: <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 1 Feb 2023 23:16:53 +0000")
Message-ID: <xmqqh6w5x8i8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't think a blurb is necessary, but you're basically underscoring
> the problem, which is that nobody is willing to promise that compression
> is consistent, but yet people want to rely on that fact.  I'm willing to
> write and implement a consistent tar spec and to guarantee compatibility
> with that, but the tension here is that people also want gzip to never
> change its byte format ever, which frankly seems unrealistic without
> explicit guarantees.  Maybe the authors will agree to promise that, but
> it seems unlikely.

Just to step back a bit, where does the distinction between
guaranteeing the tar format stability and gzip compressed bitstream
stability come from?  At both levels, the same thing can be
expressed in multiple different ways, I think, but spelling out how
exactly the compressor compresses is more involved than spelling out
how entries in a tar archive is ordered and each entry is expressed,
or something?

> That would probably break things, because gzip is GPLv3, and we'd need
> to ship a much older GPLv2 gzip, which would probably differ from the
> current behaviour, and might also have some security problems.

Yup, security issues may make bit-for-bit-stability unrealistic.
IIRC, the last time we had discussion on this topic, we settled
on stability across the same version of Git (i.e. deterministic
result)?
