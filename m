Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE01C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9554F2074B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 15:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+OD0KoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgFHPVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgFHPVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 11:21:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC7AC08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 08:21:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so10457206lfh.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+VrOo5bpfwIEMKOTFfvXmn1N5jjXm5A+rmDAVsOJ90o=;
        b=h+OD0KoR2fw28VIRh/kL88BGd8o3HN14XDIn1OHGL7Y+Nnjx48gLsnIM509RM24dK8
         qi2RIeOQ6VJ2440Q5hvX7G8D6gcFU2iagOWYk4lX4u/iO7f7zbXCBMaTQ4VK/+IKPd+x
         Sk8+UF2iQKPWmFCmgIMq/Ga5G1k3QgabzUoJqRYM3FElgMzhKmhjBaEAIVl2x3vbfKWn
         kfnwuJ3ruBJ/eyYm+UHQDsGCEKP9z6w5+EDnxrwy/Ey2wa2Iizd7aMh92nG8Y8gjH35S
         bWfl0IeDPt/cJPKWdjNKkkSTUcr5oKrgJ3uFOOvbl1o/t+sjygiKf/yY3Ty1XolmL4hV
         Fsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=+VrOo5bpfwIEMKOTFfvXmn1N5jjXm5A+rmDAVsOJ90o=;
        b=szW4zbdCO0ZvS/tkoBPcagoQyCshHy+ot3S26SWI5I8dP2iIkwp0i/YdklepRPuf72
         icf6RjTFm17pceMb/c0+XevL47nf6oYNyFg9upKMrmIYbjyuRbYd1Ybxbol9k6DFP6P8
         ouou0tYfd6xEBmny9+nB/SBgIWVbGkgrJNxYhVpSyMzu57d2y1yuL0psjxEK5RIikn7+
         YO0vD0gmJQCT4cuUlOzHhMlPhe7aYl1wh4uIcQPhRXY4XBnwZHgP47yN1cNMmvrvHR3Q
         VxJgYMcoBbb0mFOSYOwnx/SN9drbtLn42oa39Zg2jokCcD762HhQGOB2gwfvTKxxptM0
         tisQ==
X-Gm-Message-State: AOAM532U6dz3l5w+dLbojPkZjSsB9nIi7o+uRMnCfDPDc0iSDHwSoPMU
        IKMZaVqWj4rifqssNc4fBeZwNPJnj/M=
X-Google-Smtp-Source: ABdhPJwGM261GbsAi55op9Raxin0amvoAMw4NesqFJhU2dTQV5jv3L1C+vi1S5XHcCiXnH+TYReNEg==
X-Received: by 2002:ac2:48a3:: with SMTP id u3mr13035826lfg.115.1591629703895;
        Mon, 08 Jun 2020 08:21:43 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id g24sm5095707lfh.90.2020.06.08.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:21:43 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
        <20200607195347.GA8232@szeder.dev> <20200608054827.GA2054@Abhishek-Arch>
        <20200608083615.GD8232@szeder.dev>
Date:   Mon, 08 Jun 2020 17:21:42 +0200
In-Reply-To: <20200608083615.GD8232@szeder.dev> ("SZEDER \=\?utf-8\?Q\?G\=C3\=A1\?\=
 \=\?utf-8\?Q\?bor\=22's\?\= message of
        "Mon, 8 Jun 2020 10:36:15 +0200")
Message-ID: <85o8pttwft.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> On Mon, Jun 08, 2020 at 11:18:27AM +0530, Abhishek Kumar wrote:
>> On Sun, Jun 07, 2020 at 09:53:47PM +0200, SZEDER G=C3=A1bor wrote:
>>> On Thu, Jun 04, 2020 at 10:22:27AM -0400, Derrick Stolee wrote:
>>>> On 6/4/2020 3:27 AM, Abhishek Kumar wrote:

>>>>> The struct commit is used in many contexts. However, members generati=
on
>>>>> and graph_pos are only used for commit-graph related operations and
>>>>> otherwise waste memory.
>>>>>=20
>>>>> This wastage would have been more pronounced as transistion to
>>>>> generation number v2, which uses 64-bit generation number instead of
>>>>> current 32-bits.
>>>>=20
>>>> Thanks! This is an important step, and will already improve
>>>> performance in subtle ways.
>>>=20
>>> While the reduced memory footprint of each commit object might improve
>>> performance, accessing graph position and generation numbers in a
>>> commit-slab is more expensive than direct field accesses in 'struct
>>> commit' instances.  Consequently, these patches increase the runtime
>>> of 'git merge-base --is-ancestor HEAD~50000 HEAD' in the linux
>>> repository from 0.630s to 0.940s.=20
>>=20
>> Thank you for checking performance. Performance penalty was something we
>> had discussed here [1].=20
>>=20
>> Caching the commit slab results in local variables helped wonderfully in=
 v2 [2].
>> For example, the runtime of 'git merge-base --is-ancestor HEAD~50000 HEA=
D'
>> in the linux repository increased from 0.762 to 0.767s. Since this is a
>> change of <1%, it is *no longer* a performance regression in my opinion.
>>
>> [1]: https://lore.kernel.org/git/9a15c7ba-8b55-099a-3c59-b5e7ff6124f6@gm=
ail.com/
>> [2]: https://lore.kernel.org/git/20200607193237.699335-5-abhishekkumar82=
22@gmail.com/
>
> Interesting, I measured 0.870s with v2, still a notable increase from
> 0.630s [a change of +38%].

I wonder what might be the cause for this difference.  Is it difference
in hardware (faster memory, larger CPU cache?), difference in operating
system, or difference in position of HEAD?

On one hand it is large relative difference.  On the other hand it is
almost unnoticeable absolute difference of 0.25s.


I also wonder how the performance changes (with moving commit-graph data
to the slab) for commands that do not use this data, like e.g.:

  $ git -o core.commitGraph=3Dfalse merge-base --is-ancestor HEAD~50000 HEAD

or

  $ git gc


Sidenote: I think the performance changes should be mentioned at least
in the cover letter for the series, if not in commit message(s).

Best,
--=20
Jakub Nar=C4=99bski
