Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33527C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0751020722
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 12:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdOoFuLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCSMwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:52:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35821 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCSMwW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 08:52:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id m15so1533578lfp.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lFPlgW5jmb6BBtB0M1vDaXBKUlhmdZTmPwGEiLJJTc8=;
        b=sdOoFuLW/k4L46bYZoXODzvkQ/k3s3lFd5PKyofjV06vBJGnX4p4ZeY0A5Wg+wdKAg
         cWdEmi6KS9CsPp0/4D8GlxeyUK0Pfjx8IvtFF02K54vwk+C36i9JhZ9eoU1B9X0gu2Fr
         TSS/Z+R9DXyuk3+FGcc3jDIwZAiQYYEYM3uhWui3r/U7BpI0mmDsFWkBkN0iEe0t5vs6
         JK7+9upegw+d4bw6wO/MPokvDWHE10hzvBO6WdYm7JOxJRTn7V9nbGs40TXno9VoV1AV
         p2KYfHgKMp967J6+qPuddP342FUyq9FUyUuV/1RAPwdHigfwghk6DohipVthFG6UK8tb
         ckaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=lFPlgW5jmb6BBtB0M1vDaXBKUlhmdZTmPwGEiLJJTc8=;
        b=EHVmcMmC4M7lFoQs2YvDYwzNgK4PXlrETrt2SMa3po6Mz97q9OK+Hy9yfBmXaeJq4K
         bDHo1eFmB+tfChe4YrND0Mmt3iE8+nZxr7sY3DYtFPdzcmEMwl9d5j1B50YnfB9QFuhF
         Hnn/CuOOdRte+DJAowchv3wnpYbi8j2Zy9eKr85bsJjLkHMXZ6Ak3IEQ1xzbQFH+OTb2
         pyAFjOglFCr5cTQOcraDVUUZcQgdoWSDKRQYV3FgQK1UVw4hfckHTxZEEnP8SHo19Nfx
         g0UjtHvJVCgi4sUjwOk5sEV8rryETHcBSwCisTpwS3ISK2SXMESuFT2Dsdaa3y1UTDpp
         6+Ow==
X-Gm-Message-State: ANhLgQ1ndWvTk1hb9xMDtRr2CTkSd0/egzmHLxOxqOE6Vf4fA2WKJLbS
        PGLyqQH/PafsX2g9Pb1YS3s=
X-Google-Smtp-Source: ADFU+vsDqOOHjEmKqXt2WozIkmnqZdy5etJ5dApaW4+eVJW5cox3178D3kFiihh5HucHMDDuOcb+5A==
X-Received: by 2002:a19:4350:: with SMTP id m16mr2045759lfj.67.1584622340788;
        Thu, 19 Mar 2020 05:52:20 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id w3sm1677653lfe.9.2020.03.19.05.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 05:52:20 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
References: <86mu8o8dsf.fsf@gmail.com>
        <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com>
        <86d09b7jx6.fsf@gmail.com>
        <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
        <867dzj6p4y.fsf@gmail.com>
        <CAP8UFD1ihR1PtM2y24HTKa2woGXMVFq9MoVSj1cHVZCNWSH7EA@mail.gmail.com>
        <86mu8d6a39.fsf@gmail.com>
        <4c063495-0b01-dd0d-eb87-61e31a774cde@gmail.com>
Date:   Thu, 19 Mar 2020 13:52:18 +0100
In-Reply-To: <4c063495-0b01-dd0d-eb87-61e31a774cde@gmail.com> (Derrick
        Stolee's message of "Wed, 18 Mar 2020 11:25:42 -0400")
Message-ID: <868sjw5wxp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 3/18/2020 9:55 AM, Jakub Narebski wrote:

>> I have added 'Generation number v2' as one of alternative ways of
>> working on the more generic "Commit graph labeling for speeding up git
>> commands" idea -- as first task, because it fit better the narrative:
>> https://github.com/git/git.github.io/commit/a6d59820709417081c334a512034=
2987ff046f1a
>>=20
>> Could you (or Stolee) check current proposal, so that it can be merged
>> in?  Thanks in advance.
>>=20
>>   https://github.com/git/git.github.io/blob/soc-2020-idea-jnareb/SoC-202=
0-Ideas.md
>
> Thanks for the updated write-up. I think the narrative is helpful, descri=
bing how
> we landed on the definition of "generation number v2" before going into t=
he interval
> methods.
>
> The only comment I have is about this statement at the end, which seems t=
o be a
> carry-over from your perspective of wanting intervals instead of v2:
>
> 	Before starting on this task, at the beginning of the GSoC, it might be
> 	[a (sic)] good idea to check that interval labels would provide signific=
ant
> 	performance improvements at least in some cases (and if it is not the ca=
se,
> 	switch to working on generation numbers v2).
>
> The final parenthetical (switch to working on...) is a bit presumptive. I=
nstead,
> please recommend an exploration period to determine which methods have wh=
ich
> performance improvements using prototypes and/or the Python notebook. I'm=
 usually
> of the opinion that a prototype is more informative as it compares the re=
sults in
> context, and the student would learn about the code that needs to change =
before
> creating review-quality patches.

Thanks, I took it into account in the final version

  https://git.github.io/SoC-2020-Ideas/

Best,
--=20
Jakub Nar=C4=99bski
