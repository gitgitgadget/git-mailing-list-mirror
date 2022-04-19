Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A13C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 13:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349875AbiDSNKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351828AbiDSNKB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 09:10:01 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0173A1B796
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 06:07:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q14so20409445ljc.12
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e2IKiBep5EcCRYARuVR/3QK3tRSsRX0o9/GycqIhfTw=;
        b=lHcTeLxs7DUIyW/BO4EPkbgupib9VnioYZ3zfhDKgV1JAci5IOqIvXJnEE4qRdgiwC
         6FcozyBs4EmaoepB1Khx6ETyDu7n/EwqV2YywQERwciY4i2UmUn447gjB2o9O09Licnk
         RSEHaecXWAAkGfJLU1wD4qyoQiVrsrUPyhxSK7Ru7wWoRgt1EcgwUss3Y4a+NSdlVk6K
         zjnf7C5FzHleqvwRYa1XQHhCwEWP0WXoa8ZLg+2Iv4DajTEtOXq9jhnkbFVi2fa4nklt
         utSm+XZ35NK7r2vunPndW01ead7jmdCJEv7Eib6xDMYhXeCvNEpXvNZ+l3PEO8FNGKkA
         O8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e2IKiBep5EcCRYARuVR/3QK3tRSsRX0o9/GycqIhfTw=;
        b=xWFnMY/K2ZshbeTIgQfZxqKUcDHpQebJKju9n0YhgsLMmB+MDfmTT/1wmNZAGX2cLI
         zoBE3ucFWzft5Imgzzze92EiJ8HQvCCmZDs/76iKlQ0kxOjmCmVBwgmdBJX/44yDUSLd
         091rZpcy8xY8snfTm+qPB8rZClSdYDq6VdCkkmrh7YQCkM+zA5tT32wNaeaVPOtOwTnl
         MbJVvrhqeIvCVj9mEnHniT+ZVbMWA9iBJTNaxvLpt005de4KzqgfI9ITz8dQc+Tq3Bkh
         UB4WodKtDdscEvBRp7914MrAlKQTayOmzLChrEYJCjedk2EwZDOrYHP3WsPusbMvp8sd
         LU3w==
X-Gm-Message-State: AOAM5310L98XJ1/+hC5JF0g/QM7snPQ0oB6RqA+lX87DslEeTFCfXluk
        WyGdXSPZYT3MhS1qBlF4AuF2qQsQH3krOVyJsHA=
X-Google-Smtp-Source: ABdhPJxpEa6wUbWoLK7aOO3dhyrZp5qcurH5M8FZf41YbHAVhUnzZMkDMNEkQ75rdmbz00VavImqkHLBpu9VEFA9qV0=
X-Received: by 2002:a2e:b88d:0:b0:249:86c0:fbd8 with SMTP id
 r13-20020a2eb88d000000b0024986c0fbd8mr10061994ljp.247.1650373630074; Tue, 19
 Apr 2022 06:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220410111852.2097418-1-kioplato@gmail.com> <df287d4f-e9da-4ce0-d7e9-1b1fe7671aab@gmail.com>
In-Reply-To: <df287d4f-e9da-4ce0-d7e9-1b1fe7671aab@gmail.com>
From:   Plato Kiorpelidis <kioplato@gmail.com>
Date:   Tue, 19 Apr 2022 16:06:44 +0300
Message-ID: <CAO2gv81bM2srW0jxFwYQQ6xbt3ZrExNjf7_Y2Dxyfydc71r27w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6][GSoC] iterate dirs before or after their contents
To:     phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        mhagger@alum.mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 4:37 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> Hi Plato

Hey Phillip,

Thanks for reviewing my patches, your input is welcomed! :)
I'll reply your reviews and =C3=86var's in the following days. I need some
time to read dir-iterator again in combination with your comments.

>
> I think this would be a useful addition to git, thanks for working on
> it. I've left some comments on the individual patches. In general I
> think this series would benefit from trying to work with the existing
> code and change one aspect at a time in stages rather than rewriting
> large chunks all at once.

Agreed, I'll change one aspect at a time. First, I'll include
suggested changes from this version and also convert entry.c to use
dir-iterator instead of opendir, readdir, closedir API and submit v2.
Then I'll spend some time understanding read_directory_recursive() and
search for possible parts that can be cleaned up using dir-iterator.
I'll compile a set of possible customer candidates for dir-iterator as
reference. This will take some time since I'll prepare for the
upcoming GSoC as a possible contributor.

Thanks,
Plato

>
> Best Wishes
>
> Phillip
>
> On 10/04/2022 12:18, Plato Kiorpelidis wrote:
> [...]
