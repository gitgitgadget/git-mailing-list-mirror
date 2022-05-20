Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF3C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 16:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351507AbiETQR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351493AbiETQR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 12:17:57 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672F6D86A
        for <git@vger.kernel.org>; Fri, 20 May 2022 09:17:56 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id q136so4324838vke.10
        for <git@vger.kernel.org>; Fri, 20 May 2022 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8APOvX51O/r6CMgS3UB/fSDNRqUti30E5WUEbWI/RN0=;
        b=Z7J18E/7s8Cfqp5kcDCqdEWQnVUTRXiSJmTd+YqpBG77e3R9qpKCBS3EqVUZjvmZ+4
         rIsYWvLzAQFblKbvOnp8iytzjR1LT9r6/xsrWIKiRtgPa7veq84I9ZFePqWTn6zs3Ula
         cALggXMudvVVfQPJQSQD1hu5W/mC0E1An+F6fMbSd7Tz0MH5SLWcZWZ0IlZuGYjBU53i
         rrtokzhqWN0VL5Tzb8/pP2dQm8DWygo4jklqAs8w2/KCEWO+AOQxp2BSzUuSzUJ7VG47
         T4/B8SRrAZZJCRyqcMxQHSVBozwObJUb/LcqwVmfeA3pfIkVYSMgSrY6oVD+wGfoQ1kn
         KhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8APOvX51O/r6CMgS3UB/fSDNRqUti30E5WUEbWI/RN0=;
        b=7lAj8RiM/dMvlPvE2lDbrGQfwkHOuT1+IOmGQCapC3aJhA58psufRYCa4XgWKHUrSk
         av3Wqr18Vy/fUSzJ+yLAifqT5pzkOE2Td78wKZknCyHRtgyihv/x5j8LtP1ZZndR3XFs
         ktjw3yPgWQLIKD7mwgDqcMEdkZHX1VEDrS3wfu4o/ZsKbrlzlaKkYP3VdeCl3dDUJ7qG
         DK2HOgSebkSXU1AlPBnD1Uqqwh3VIfK8ZeMk+ZWuwKR38VK+KCgRKTRq4EpufVxHhBR4
         CUfZPJbZu+MyBJApeycT5KQ66X+c96ZucKhZa+6T6xU+ERU624ykcJw98GaLW46W+klF
         vvLQ==
X-Gm-Message-State: AOAM531X/8wlydJ7bNU2YC0zRpa8/JYwtz+d1c2ifCKCSRT9voCp4eKM
        6JxedozK4/jaN6Ny9rIEsXMr88+JgnNjYqCzMu7jiQ==
X-Google-Smtp-Source: ABdhPJyB/VxgRa8R+XCWHNm7jCa4LaTwb2B90zFzHsE9dxAOU4oCa7sepwo27HS4Y9sQpHeOozm/fg3ClZSKT2swPSg=
X-Received: by 2002:a1f:2fd6:0:b0:357:6498:8e48 with SMTP id
 v205-20020a1f2fd6000000b0035764988e48mr983362vkv.14.1653063475206; Fri, 20
 May 2022 09:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
 <Ynndk0L6r9O7jLVU@google.com> <CAJoAoZ=t=BEfsfHBay1K7CY2MYEwcvPYKYxvgv_BvLL3SMcf_A@mail.gmail.com>
 <YoEnsb2UpDwdjDpd@google.com> <CAJoAoZnP47PT9EQYkNib9+_a-Qg=HxhjowgUx7qJ1V7=KY5iiA@mail.gmail.com>
In-Reply-To: <CAJoAoZnP47PT9EQYkNib9+_a-Qg=HxhjowgUx7qJ1V7=KY5iiA@mail.gmail.com>
From:   Alice Merrick <amerrick@google.com>
Date:   Fri, 20 May 2022 09:17:42 -0700
Message-ID: <CA+Yb-VQx2CMixGh6GExce9n=QxR-esuhPuuHwzfDKYNow4Zyzw@mail.gmail.com>
Subject: Re: Let's have a user experience workshop
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>"3. Testing ideas
> with users" I would find it worrisome if getting user input would
> require reviews on a given patch stalling out until the next monthly
> meeting.  (Reviews are already slower than they should be as it is!)
> I don't know that that's what you meant to suggest; I'm just aiming to
> understand what you mean about the "all 4" above.

I agree, you wouldn't want to wait until something is in review to get
user feedback or testing. I think a Lean UX
(https://www.scaledagileframework.com/lean-ux/) approach would be more
appropriate especially when there is no designated UX person. You
might need to lean more heavily on design standards and
instrumentation for feedback, but sessions with users would still be
important for developing standards and could be used as needed if it's
not possible to do them on a regular basis.

> > > I'd envision it as something between a working group and a book club -
> > > we could learn different aspects of UX design and research, and apply
> > > them in various ways.

I like this idea. A working group could work on developing design
standards and work out what to measure and how to measure it.

-- 

Alice Merrick | UX Researcher | amerrick@google.com | 206-785-7532
