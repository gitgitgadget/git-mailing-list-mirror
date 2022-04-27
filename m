Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE99C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbiD0QDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiD0QCl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:41 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B54B1AB8ED
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 08:59:11 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id ay33so783830uab.9
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYmhw+rmsyIetR1B4zpjn8+MAtdLUXh6gPdVxvehxPQ=;
        b=fMUx87yJDo3uk+PACylyS04ITDkGs7Tg2F4gu1VJbso0Hl5neXRWmxxkV5ZXyMz4+J
         A9cejnKZUwOR1frBTnsdxyvSZOupVtlN02kKXIfeFqTXL4P95SD0M1C4SJrsXJgc+IoN
         GqqdxNzMkSyO7S651VtqK+3SxPEdZwUiQyC6O8qoo7gTYuzwpKKOTx3dzSRwsPLFdPCb
         5p6jIgcVd3PuYW5KUsrhsYlC357cCgCzG1FAm4tcA5KjAUjGouwHy3pPQn04gD4p7zch
         lAzXDxUxSdpWPmf0GfP3fap+XT3K4WJf4bkxcRTJDr2UpbLpveT0mdP+dO7Hom6q4xsK
         X0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYmhw+rmsyIetR1B4zpjn8+MAtdLUXh6gPdVxvehxPQ=;
        b=ijF6PgF2WK4lvfca3iO3gNCwp9V/TTLjIhGD6dK+y954flHV36xzVEMAg+FiH1ohtN
         B/xKhZps3Tjp3p19aG67zBs54lzFyb16V4KAscT1sILoVc4kKcDxAfPe8Brb5ASUu8oV
         5BUmpGbzVrmRx7FBfJnkrEJl4Msm5Yu6gHpVeDDFbWLLxbavx3N3ZWZK0l+GaMK+MFmO
         Vec8gDIGAS2CysujTxp1f3OZ42IPBUhsulcHf1VRMC3Je0QYiclQc0iS91+Dn+tEAYZW
         HjDVi765f6+hR+xxXyCZXY+HFMez3PulSTDmjwToaP2nwSItomUWxeuMpijeW6dyIWDd
         J7Gw==
X-Gm-Message-State: AOAM532A/bTCSPk7Ut+saNW4pycrBvIy5NQkJ0/f3bh1jCShGirShnFt
        fTm3PZ3xbkVRlkGoNjE+BuHSqgflzynMeY7+b8c=
X-Google-Smtp-Source: ABdhPJxfN5l6abVR+gjAuHEuveTThCWkl/qFaUE26CWC0pPhKk0jg1nN35UC9mlVxx0niVN9fCCbJlMOLQN/vsDL/e0=
X-Received: by 2002:ab0:654e:0:b0:360:303f:46c7 with SMTP id
 x14-20020ab0654e000000b00360303f46c7mr9115818uap.6.1651075148868; Wed, 27 Apr
 2022 08:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
In-Reply-To: <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 08:58:58 -0700
Message-ID: <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 5:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> You are ignoring any errors when parsing the environment variable - that
> is not a good idea in a security check.

which errors are you concerned about?, if anything in this code
worries me from a security point of view is the fact that we are
relying in getenv not being racy (as mentioned in the original RFC),
but there are no errors set there AFAIK.

not ignoring errno in strtol is an option, but as mentioned before I
decided instead to reject bogus values and therefore not the clobber a
previous errno, since I was using strtol as a wider version of atoi.

Carlo
