Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF863C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 08:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbiDNIVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbiDNIVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 04:21:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F27399
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:19:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso4975594pjf.5
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmH7dJmbu7OgXlOvV1zV5IUjlH4n2795w+J5ktt5upo=;
        b=EBriXoMdwLHemXEVB8/7QuzMFcqfDgTS5K4yr6/f8QnJ1q27l6v69OyH1r+byKweRm
         B2yPfh3H7/qCnqWrMizwqY7r4tqjVPcWdOyErUN0sqGhOEcO49JsmV1pEt+3zv/E6xBS
         IcbTUcTTTKGJYfB1M57P2NJZ6xlIs+Tjny3RI04kD+Ny3o68q6ULfesEsSyCWPMMsJhc
         SKMjao6aTOZ9WSzZe9BCSjMzAqb3Hy1n9vrbqApXGsWe9MxdY7uKiKojGJcOuYlblQf1
         NBqBwJva9mKs9axB6/PzmqmqSkQ2JpnPq6m41q1GWvUdi35WWIj46XNK/udjMBZ7VLWi
         RIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmH7dJmbu7OgXlOvV1zV5IUjlH4n2795w+J5ktt5upo=;
        b=SUqlS/pmT4e0H0Mje9DZj2sFCSaF9oBYBFKGEz0D6h7QRopSmhjMSb55YB4dlgxSwL
         9XkIccQ91zcqHkL4mzgs8ptX3YgkPHO5tvx09iIz59VGpQSxEMBnIgDTPjZBoJK/de1h
         UoJziqFC+V1KR0KnW/7zSzpEHK75syvNF9E+ywIC3ILeJr2fh2UEpAhKY80n7wcAbv1A
         G4PvLHiw8xK+yvUXSnc8MkA3mChBtY7xC7bBXm/Ad7D3/v4ygaapzIwiwUwslfz+Lusw
         zYM4PpKfdN+yP/jfzakojmWC54zdAXXiGHCXQ6JWoawHnjnikR4L7kJJ5hX/qo7gJbV1
         Mrqw==
X-Gm-Message-State: AOAM533drW1BXOmRWgprFas5GjDGm8b6bh5tokxlyFli8J6buBRoQkIw
        nqRKfjzcuIR62nkijeFr5j45vi3/6aegISZ3yPaIk5Zszrw=
X-Google-Smtp-Source: ABdhPJzWDnVRyWSKcF/FbE7y4CiimdmPZs5zHzFhlFMM/F0rRUKknHigYfKfI67bUGlQui9n+gVXNjYcPbxnSC5R9ZI=
X-Received: by 2002:a17:90b:3b50:b0:1ce:6254:2cb8 with SMTP id
 ot16-20020a17090b3b5000b001ce62542cb8mr580303pjb.239.1649924359437; Thu, 14
 Apr 2022 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1qy3igif.fsf@gitster.g> <20220412203722.10484-1-siddharthasthana31@gmail.com>
In-Reply-To: <20220412203722.10484-1-siddharthasthana31@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Apr 2022 10:19:07 +0200
Message-ID: <CAP8UFD3RtQecxOQWVeapH1CYsMiY2+MoHeugb9bvOsFVnozy=w@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v2] t1011: replace test -f with test_path_is_file
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 2:06 AM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> Use test_path_is_file() instead of 'test -f' for better debugging
> information.

Actually it looks like you are also using test_path_is_missing() now,
so you might want to update the commit message, and maybe also the
commit subject.

In the commit message it might be nice if there were some explanations
about why `test_path_is_missing PATH` should be used instead of `!
test_path_is_file PATH` or `test ! -f PATH` or `! test -f PATH`.

The diff part of the patch looks good to me. Thanks!
