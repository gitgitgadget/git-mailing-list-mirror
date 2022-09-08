Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC68C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 16:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIHQqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIHQqw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 12:46:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA39B4E9B
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 09:46:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t14so19845239wrx.8
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9ROKB/MMB4bNCqdKNONnUoD74wURW4Jz5cWg0JLfoSc=;
        b=cjq2GF4ItEeYLuFMovSJbspvmjVlZVSy2pmCK9Yn/MoYnkqG5l7Z8BWWTSHV0cks2q
         GOenpn5wgg4qSojKouqf/0mf6VW0XFUADJA4kxviJGI7ZJjVRYuyfnl5KnWqU5+Vq2JY
         6Ang1Az/em5wC895VjQzXKp3+yfi2nIOC96uKMbg4K6Y2M8BUlnfLH8lN2YMV9D8si4P
         5skPHgkXK9wSKgZDPW0LR1GLfrm7NpPp0q6S3HKACN1e5jxFbzJ7VAOA/2TL1Ck6Q7BS
         vfKCWPWyG4yi8YAP/PeNDfdzC4ymkY9pi4oYMlhiqSF0rXmz713d5t2i3qmEYq+ENoDv
         6FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9ROKB/MMB4bNCqdKNONnUoD74wURW4Jz5cWg0JLfoSc=;
        b=7jzW9Y37sZfCqQZfrJvCvvag4DmiyOnR4nz2I5RRakcEf1fRJM5Mg83CZX2WE9l+C/
         XjQCTB68VpoZJPAiCUzdwAxJneoiT785uWn+pNBcT+dPFSn66wglmhGgDkLx/UCd4aQJ
         Z9ZlWOu+Ck3h0lqrZFdCxQMjE/A0u4WxZaWUHA6QBTSEiZQE6tUr+MulHXfQt0bMFgpN
         ircn+u2DBqV1vewPJSZNMbg4M/fQ5hEz/oQ7Q8IYNk3XeEL96TQtzjUomorqSMN9CaFi
         vlitac5DhCnkz5HofGe9qN8o4PqI0D4k9Ctvdxu0EhdhEO8CfQG2ImoSDZIYJg7TQ/9/
         jdmA==
X-Gm-Message-State: ACgBeo17yxk+Qhrs7kBKwQ1T9naRT1LPqyGnlAVB/mvgU1NAIKWopSue
        9gl5LflWR4FFuXy/KfVR4Pfbm7wXMf1Ud8SPJIA=
X-Google-Smtp-Source: AA6agR76UYVx39ff+DNHAn0GUjsKJPvHSF/vt6WkqLrEQLYjzlbc3fXCRMe+gCLVgbm8YrD0ewPMzJnQcG71aYSC9vk=
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id
 r11-20020a5d6c6b000000b002250ddeab40mr5684069wrz.690.1662655610561; Thu, 08
 Sep 2022 09:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net> <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev> <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
 <YxjhQ8xVI4YtA7xb@coredump.intra.peff.net> <CA+4x=b9upd2uTihZK5hXDULkCz6y+CX-dS7p65Pfhn0zh0eMiA@mail.gmail.com>
 <YxkI2zqCheqTv/wc@coredump.intra.peff.net>
In-Reply-To: <YxkI2zqCheqTv/wc@coredump.intra.peff.net>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Thu, 8 Sep 2022 12:46:14 -0400
Message-ID: <CA+4x=b-SqzGfeTu4c8akk3quYF7ORZ5jYCpey5221H8=+_PfRg@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With an explicit -c protocol.version=0 on the 2.37.2 git command line,
the pull is successful.  For what it's worth, the server git is still
2.18.0 in all of these cases.  Only the client side is being tested so
far.  I will try to gather the packet traces and see if there's a
problem sharing them.  Will this mailing list allow attachments?

.. Lana (lana.deere@gmail.com)



On Wed, Sep 7, 2022 at 5:10 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Sep 07, 2022 at 02:53:37PM -0400, Lana Deere wrote:
>
> > OK, I tried the bisect again.  I used the bin-wrappers/git from my git
> > source each time I did a pull and each time I did a bisect.  This time
> > the final result was indeed different:
> >
> > $ ~/tmp/git/git/bin-wrappers/git bisect bad
> > eb049759fb6b739310af52ee0e13ce6cd0c86be7 is the first bad commit
> > commit eb049759fb6b739310af52ee0e13ce6cd0c86be7
> > Author: Jeff King <peff@peff.net>
>
> Drat, I shouldn't have helped you figure out I was the culprit. ;)
>
> >     protocol: re-enable v2 protocol by default
>
> OK, so this is definitely a plausible bisection result. Things shouldn't
> behave any different between the two protocols, but there could be a
> bug.
>
> The first thing I'd try is whether:
>
>   .../git/2.37.2/bin/git -c protocol.version=0 pull
>
> works like 2.18.0 does. If so, then that confirms that protocol v2 is
> the problem. At that point I might try capturing packet dumps with:
>
>   GIT_TRACE_PACKET=/tmp/v0.trace \
>   .../git/2.37.2/bin/git -c protocol.version=0 pull
>
>   GIT_TRACE_PACKET=/tmp/v2.trace \
>   .../git/2.37.2/bin/git -c protocol.version=2 pull
>
> They'll be sufficiently different that you can't just diff them, but if
> you're able to share them, one of us familiar with the protocol might be
> able to notice something.
>
> I don't _think_ there should be a problem with the server side of your
> connection speaking the v2 protocol. After all, you found that the
> ls-remote output was the same for both versions.
>
> -Peff
