Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84245CA0FFD
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 06:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbjIBGHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 02:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbjIBGHO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 02:07:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C310F5
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 23:07:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so2387536b3a.2
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693634824; x=1694239624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fRqEqNcLc/hg+DOXyDMj6TS3vWkwfINQF5Er/jV90Tw=;
        b=QvHOtQ6tOOVcCIKPO1JyXuT6Xy3G7d/7UY8hv1g6sL1IlPzko9HRSOr2s7UdPA+gXo
         NSzlfjHAKHP19+Pyrf8vwxN49UK4ReRrpINORRDv7QAtjHmhY6HnUhEVLLNtQ60fu4G7
         lXjuVL7xcQ/eJ7eeCnA36qciBgwpDFDiOGQNww7m8wIR8bnXhQH+NManaH8fLGZtSu7O
         0bQXbSqEL/mZRbUfJzIrozOLrw9+a2lpvdyUMFLmKCh7tGpP//JJKSZlYs2CqTuqWfsW
         7jQcWomCxrKli33hQXx1CZM0Ccrpe/CER9/bIo/nihjgJf4cJlW9AuDALdiMzbjHYCfs
         9GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693634824; x=1694239624;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRqEqNcLc/hg+DOXyDMj6TS3vWkwfINQF5Er/jV90Tw=;
        b=DsxaOpqprq/s7IPW1pOM0DDNQHUjoHB+uDaE92MuSsaUr7Duiw3Wf+alZxounSTmNE
         7+R89fAE6WTNLPXlrmWjo63tgfu6Ofd4NEatDtqhFcTE1z4zN6FpOAj5iH0ihqUHNNiR
         jnh/M+2mpOkR8rpnL6Zqhr0gd0dZ2gQLCTTVsC49N7v4asjt9OGMTZqdDD/LEdd9t4ZC
         zsMV1OZx3OtL3BzfNl12fFOpi93SP367FbtGEFgDc323I31BGzArUJD/zdsmXHTGpqom
         2Qv8pW9NsuZd2GcgffgVmPGD3PgaQKpwmWp7JmlTFCeBOGz4kf9s7hEluScrsr7iPgWO
         KmXw==
X-Gm-Message-State: AOJu0YztB11+IsgvmyTD/gYOY9nDjv44Fn422TO+b1LyM+YeN5NLwCya
        gR1dMXONk0HNjk12nqGEuoU=
X-Google-Smtp-Source: AGHT+IHyCisDSOkKwYsWWPnqKVf+oob2SmKhfV4Hbx6HIjmpXKx8jJYBaTwkVjXQcLRV0l5ck9v/Dg==
X-Received: by 2002:a05:6a00:2303:b0:68a:4d66:ca1 with SMTP id h3-20020a056a00230300b0068a4d660ca1mr5894613pfh.6.1693634824311;
        Fri, 01 Sep 2023 23:07:04 -0700 (PDT)
Received: from ?IPv6:::1? ([2401:4900:4dd9:8e02:8f26:4c57:3627:3630])
        by smtp.gmail.com with ESMTPSA id fm19-20020a056a002f9300b0068c1ac1784csm3846785pfb.59.2023.09.01.23.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 23:07:03 -0700 (PDT)
Date:   Sat, 02 Sep 2023 11:36:59 +0530
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
CC:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: Git in Outreachy? (December, 2023)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP8UFD2CGf8efBHquS=LJP8uQ5ivuDryqGz96PZ81oDtrNgNXw@mail.gmail.com>
References: <ZNwhVOggObU7aVTr@nand.local> <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com> <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com> <ZOZSo7vJztHcvb4W@nand.local> <435a2aa3-59f8-d2bc-f653-4f93d86b9c31@gmail.com> <ZO4wxU1ilpa6/3EW@nand.local> <CAP8UFD2CGf8efBHquS=LJP8uQ5ivuDryqGz96PZ81oDtrNgNXw@mail.gmail.com>
Message-ID: <90CB8070-62AC-42A0-B686-1CE5415EA0FB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30 August 2023 2:08:45 am IST, Christian Couder <christian=2Ecouder@gma=
il=2Ecom> wrote:
>On Tue, Aug 29, 2023 at 7:54=E2=80=AFPM Taylor Blau <me@ttaylorr=2Ecom> w=
rote:
>>
>
>It will take some time before I can confirm whether or not GitLab is
>willing to sponsor one Outreachy intern=2E
>
>> If you (or others) are interested in mentoring but don't have a way to
>> pay Outreachy, we could certainly discuss allocating some of the
>> project's funds to support one or two students=2E
>
>I clicked on the "Community will participate" button, but this leads
>to a page saying "Outreachy internship funding is required" and where
>we have to list the sponsors we have, the amount of funds they are
>willing to sponsor, if the funding is secured and the funding decision
>date=2E I think I will fill this out saying that we have 3 (potential)
>sponsors: the Git project, GitHub and GitLab=2E I will not check the
>"funding is secured" checkbox and say that the decision date is
>October 5 (so just one day before the deadline for "Project list
>finalized")=2E This will leave time to find out if we can indeed sponsor
>at least one intern=2E
>
>Let me know if that works for both of you=2E
>

Great=2E Thanks for signing Git up for the program, Christian!

>By the way, Kaartic, do you still want to be an org admin? And Taylor
>are you Ok with Kaartic being an org admin?
>
>It seems that I received an email asking me to confirm Kaartic as an
>org admin, but I couldn't confirm then and later when clicked to the
>link to confirm it looked like it wasn't possible anymore to confirm
>that=2E So not sure what happened, but maybe we could try again to
>register you as an org admin=2E
>

I actually hit that button to become a community coordinator without confi=
rming here about the need=2E

I would be able to help as a community coordinator for this round=2E I'm n=
ot sure about being able to mentor, yet=2E

That said, I believe both of you would do a great job as coordinators for =
the Git community=2E So, if you feel like you both could manage without hel=
p, that's totally fine=2E I'll check on the project list once it's availabl=
e and explore the feasibility of mentoring :-)

Thanks,
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
