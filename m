Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92097C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 20:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiBZUTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 15:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZUTs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 15:19:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54A140EE
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 12:19:13 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id bc10so5651607qtb.5
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=496ABDP1cozVdsDh8xnrdxMBhOLe6ac+srXKbapJsDY=;
        b=hmOwD/k038plkyxAvKXAOjgkDI+LW/pw9seECPZQguZBXtBjYTcp6c/vjAEC/4LUqT
         /uQd5bAeDYFsZMb091UWlZDpg+b3a6ceOWS+EyApLnvDQ6SF9yH4k4xcDEWzLvb+WeVm
         tp3XZxPIyMguZaY14H8wrVLeHFIuK4vKSzAgeGeaG2bJyhiiXVJYOwdb76KHqYGZSxQJ
         SBQnDiByW8jiARv/Pi5wuYA/t8fOMeW93ZNRkgOew23BO+NeHTwe1qf9ppxaAqynubTR
         L11qqA94tZoKgSk1GQIICbxR1KwlpJNjH0XXnLrGGvlpxwMyAOjNuvVW9Drv4kyDVNPY
         16CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=496ABDP1cozVdsDh8xnrdxMBhOLe6ac+srXKbapJsDY=;
        b=pZCpOcylCCbOXY10ZuN28UF9J8ug04JlxzOj8b1wzPF0EeOiy9ViZhWXtzgO3fI8O5
         g2pkGxN+zbyDBiyyVMrygvZx9O+/lpsz05dlXzvrwh9TItoJirsROGTNOu1AmhWYmwkF
         UO091WcBmvtUej/qeRCEKxBJioOo92up4oNQ3GoT25tEo6SlCS0CcE/mFvQjeyUkuDXC
         VVrwsoelrW+Pvvg4pEP5l0Tz7lY9yAa7Uxr3wD3tVlSnpCUVXAczvJsvDgMjOz9l5q16
         rjTIduqB2RmuNhHTleU/k8tJYANJqaARnxNs9CjFlBzsrwOUu3cLbSfU3L37HH6VsAZQ
         q3Eg==
X-Gm-Message-State: AOAM531KSmm/SlntxEMNWOvHRadUR+fBMHjj+MACWlNyLJ6ain0byplV
        aSDyO99xIh4wfvQEzLcqM7s=
X-Google-Smtp-Source: ABdhPJwqZKIiJYywBtKvMNSLjby+NOG6YcC8qzsuDhTx7pH+T4T0xy4KjO2L0DBRyvNGINbDiMYJXQ==
X-Received: by 2002:a05:622a:1821:b0:2dc:eda4:682b with SMTP id t33-20020a05622a182100b002dceda4682bmr11377701qtc.637.1645906752125;
        Sat, 26 Feb 2022 12:19:12 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id i20-20020ac85c14000000b002de4b6004a7sm3762326qti.27.2022.02.26.12.19.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Feb 2022 12:19:11 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Date:   Sat, 26 Feb 2022 15:19:11 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <47AC2D8D-ADB2-4280-86F0-6B1E239C1EBE@gmail.com>
In-Reply-To: <YhpjbQeFaMNVnyP9@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
 <xmqqv8x5v0qc.fsf@gitster.g> <36CA51FE-8B7F-4D08-A91D-95D8F76606C9@gmail.com>
 <YhpjbQeFaMNVnyP9@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

(resending this because my email client misbehaved and set the mime type =
to html)

On 26 Feb 2022, at 12:29, Taylor Blau wrote:

> On Sat, Feb 26, 2022 at 11:01:46AM -0500, John Cai wrote:
>> let me try to summarize (perhaps over simplify) the main concern folks=

>> have with this feature, so please correct me if I'm wrong!
>>
>> As a user, if I apply a filter that ends up deleting objects that it
>> turns out do not exist anywhere else, then I have irrecoverably
>> corrupted my repository.
>>
>> Before git allows me to delete objects from my repository, it should
>> be pretty certain that I have path to recover those objects if I need
>> to.
>>
>> Is that correct? It seems to me that, put another way, we don't want
>> to give users too much rope to hang themselves.
>
> I wrote about my concerns in some more detail in [1], but the thing I
> was most unclear on was how your demo script[2] was supposed to work.
>
> Namely, I wasn't sure if you had intended to use two separate filters t=
o
> "re-filter" a repository, one to filter objects to be uploaded to a
> content store, and another to filter objects to be expunged from the
> repository. I have major concerns with that approach, namely that if
> each of the filters is not exactly the inverse of the other, then we
> will either upload too few objects, or delete too many.

Thanks for bringing this up again. I meant to write back regarding what y=
ou raised
in the other part of this thread. I think this is a valid concern. To att=
ain the
goal of offloading certain blobs onto another server(B) and saving space =
on a git
server(A), then there will essentially be two steps. One to upload object=
s to (B),
and one to remove objects from (A). As you said, these two need to be the=
 inverse of each
other or else you might end up with missing objects.

Thinking about it more, there is also an issue of timing. Even if the fil=
ters
are exact inverses of each other, let's say we have the following order o=
f
events:

- (A)'s large blobs get upload to (B)
- large blob (C) get added to (A)
- (A) gets repacked with a filter

In this case we could lose (C) forever. So it does seem like we need some=
 built in guarantee
that we only shed objects from the repo if we know we can retrieve them l=
ater on.

>
> My other concern was around what guarantees we currently provide for a
> promisor remote. My understanding is that we expect an object which was=

> received from the promisor remote to always be fetch-able later on. If
> that's the case, then I don't mind the idea of refiltering a repository=
,
> provided that you only need to specify a filter once.

Could you clarify what you mean by re-filtering a repository? By that I a=
ssumed
it meant specifying a filter eg: 100mb, and then narrowing it by specifyi=
ng a
50mb filter.
>
> So the suggestion about splitting a repository into two packs was a
> potential way to mediate the "two filter" problem, since the two packs
> you get exactly correspond to the set of objects that match the filter,=

> and the set of objects that _don't_ match the filter.
>
> In either case, I tried to use the patches in [1] and was able to
> corrupt my local repository (even when fetching from a remote that held=

> onto the objects I had pruned locally).
>
> Thanks,
> Taylor

Thanks!
John

>
> [1]: https://lore.kernel.org/git/YhUeUCIetu%2FaOu6k@nand.local/
> [2]: https://gitlab.com/chriscool/partial-clone-demo/-/blob/master/http=
-promisor/server_demo.txt#L47-52
