Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647DBC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjBAWQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjBAWQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:16:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA425EF9A
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:16:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n13so4439871plf.11
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0ADKgPdR0O7MfHYsdPOe9BscYtN/HJagwPfmfrS+eU=;
        b=G33WNiLHpd0yO0cupN06SJYVajXMuSNm/xEcoQmZMVJyvP4Ic8r7UT2o2nzLc3y6RU
         A7rfgekq79Vi+KpxjFJpQUI8zcu9K/kJ2dGUjji26cRVuuUV09CEvqIOrK+YVmS0ZLBY
         tmvo8u6lDKI/Aw0pjhFTmtLdofBcq/zAr7wv8lo4a8flu3Xe8otYABSiC5hacUjDn0/8
         koEPKzmdBC8+BTYbbvgIhhtn0lzlBMkNkHHWROS69a4J7ny3lAbpntKZXT4cJXUTqinj
         v2aVud9IawPTg699yghdUsf9en1sKaCEtDsP58CxcKn3RleT3Et25iNITYfneSBKSjuI
         HocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k0ADKgPdR0O7MfHYsdPOe9BscYtN/HJagwPfmfrS+eU=;
        b=F+CXq2fISyG0mhivOqwri6ZdjQaD9XJ4HFUw+ixaI9j6f0XKQZ3AAyJgQaOIWbiCcf
         YdIqNHcrHdw9HYrn+cnucwwAKGnixwLNVgDH8hJveRE75zQLcTR0+BFkuzZdhCG06ZHw
         gztUiQ2GrRC/xRh7b7K2cY+PyfJroR59/CHVNzim/AkSROIipqeIO/I10PeJJkIhMfXD
         5aasXD99G0HVSyamZNR/ep346N9OKQ3ila4LnBdN5jM5ItFP93fWzt7RRUlyWnyUxK5M
         KxB2KfaoedKFEkwl7VfI8M0IGEPCpfZyjmpDNv2fsZ2suBXSACKyQk8+K1szwSKWLZjt
         YVGg==
X-Gm-Message-State: AO0yUKWtloudgmmpDQ6OpjBdRKNb2NFw+LGtlFGOtTYxQGAxIx/N3ZnR
        hWNg7gUVLBsl7KJl0FjzHYs=
X-Google-Smtp-Source: AK7set/QfmiYh4TW1mhAJUppYLnMKMCZcsgqUia0mfF+rCllVNw2Mopr6CpZXUOHFejAb3GEJwE+jQ==
X-Received: by 2002:a17:902:ca95:b0:196:8cbc:67e1 with SMTP id v21-20020a170902ca9500b001968cbc67e1mr2786253pld.51.1675289759561;
        Wed, 01 Feb 2023 14:15:59 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b00198ac2769b6sm2090945plb.83.2023.02.01.14.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:15:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "D. Ben Knoble" <ben.knoble@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        dds@aueb.gr
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
        <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
        <CALnO6CDCkuN2XU_AyO66hQSm2ztfpe8Rs_baw_J4uTQZmekREw@mail.gmail.com>
        <CANgJU+WZR56xG+KL3P053aD_qTh+rBhZ01mqNajg2qRt_+RNMA@mail.gmail.com>
        <xmqqsffpz05o.fsf@gitster.g>
        <CALnO6CAZ_RMirOwQqJyqJrq2dY1w09eV1h=0JFosYSb7XhyQVQ@mail.gmail.com>
Date:   Wed, 01 Feb 2023 14:15:58 -0800
In-Reply-To: <CALnO6CAZ_RMirOwQqJyqJrq2dY1w09eV1h=0JFosYSb7XhyQVQ@mail.gmail.com>
        (D. Ben Knoble's message of "Wed, 1 Feb 2023 16:33:52 -0500")
Message-ID: <xmqq7cx1yqu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Wed, Feb 1, 2023 at 1:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>> There was a discussion on BRE having and not having GNU-like
>> extension on macOS, in this thread
>>
>>   https://lore.kernel.org/git/26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de/
>>
>> The patch we ended up using avoids touching the behaviour with ERE,
>> as REG_ENHANCED on macOS affects REG_EXTENDED, but the issue we were
>> looking at in the thread was about BRE.
>>
>
> Are you suggesting that I try with `-P` and/or `-E`?

No.  I was just giving a concrete URL for what I think demerphq was
referring to as "saw some discussion recently".
