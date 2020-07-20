Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C2C433E4
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5152C22B4D
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 13:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlNzslZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgGTNrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGTNrN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 09:47:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF4C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 06:47:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w9so3964601ejc.8
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zdl1tvjweMHH5okLMv3k/VFKjc87ZRorLIKFrTmXBeY=;
        b=MlNzslZAJ0gSaBGIxf5+o4ZZt4B4hmmfr1NZCu8d1JytIXZcTI3yJ0dzMwXTWYHi7f
         /i06WEw4IGF+6dvCUdbPUTRpSa2hTxs/KXm9K74bptyztb8irKMphalai5HvGLGvMY6b
         9uxic+DBdHFwDTwBFOFEGGSNeKbxh7kWkH8iXN8OOwAZhg1cC1GWcHQ1L4/zQdaRcATz
         K+YM7q4PCnB7ZQtEl1J5BJ6FiifULTQM7Xt8/aiPgjYdStzvw+/aDmxsXxINgvpDyxZs
         QBBnsEhrxmtq2SxJ3Hjans8tkAB0Zwubv/Vo8jsoMD8NJEs3Wn0zdg5jSpGeZGh73p50
         50GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zdl1tvjweMHH5okLMv3k/VFKjc87ZRorLIKFrTmXBeY=;
        b=tba52qagRf2TDxpU1MD+qb27BP1NP8wVKvx8lRKbvXbWUPVeLpkiLXrE4RsfTB4IBj
         0q/G53nt7UFCDulqM/4OJtq9wUdo4thwb6ete2dY1oFHN2oMRkWiegBJxZCgEapaZzfn
         I2DBPDXhMQQX7wHl6wsLTY+2fbrhW6H5P5pV53CO73LpRQmf4AbAmRFhMJj8gnRdfETi
         2d6gfWX6pbnvFt2f7TK0fhcCodQtMzorLZ6bduF5lAOx2mHqF6qq4aT9NiogTxbPI4UW
         hsXhuakR3ra1xL3bzPq5MI4NgNyqsShAwyBIwScHcF8oMBl/gn04Aq1eGcjKL1aI8Uwg
         ywTw==
X-Gm-Message-State: AOAM532kCkFhAq6t+pyB0FfuBaRX4FU83YpAGlUttFlZJVH1HPmGrKG+
        SaQCz9MZ7AzvrkTlEF9b65k=
X-Google-Smtp-Source: ABdhPJzXAS54qKIInE2QaTRhZoNWoPW4sk2imJ/OMkZiAfAIt74UwWZhe6Gq95zr6sX8rW8oiR/lrQ==
X-Received: by 2002:a17:906:408c:: with SMTP id u12mr20206270ejj.162.1595252831844;
        Mon, 20 Jul 2020 06:47:11 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:410f:b6f6:852c:ec06? ([2a02:a210:ca2:9c00:410f:b6f6:852c:ec06])
        by smtp.gmail.com with ESMTPSA id j19sm15430900edt.44.2020.07.20.06.47.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 06:47:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: Pushing tag from a partial clone
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <3e68d3a1-01e6-4ce3-eee1-bc9fb07a1825@gmail.com>
Date:   Mon, 20 Jul 2020 15:47:10 +0200
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <439C1CC1-50BB-4EA1-A8F0-04D66CA430AE@gmail.com>
References: <0DEFACA7-9D30-4DB1-9FDF-3E63945FAAB3@gmail.com>
 <3e68d3a1-01e6-4ce3-eee1-bc9fb07a1825@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> On Jul 20, 2020, at 14:18, Derrick Stolee <stolee@gmail.com> wrote:
>=20
> On 7/20/2020 7:44 AM, Son Luong Ngoc wrote:
>> Hi folks,
>>=20
>> At $day_job, we are trying to push tags to a repo from a partial =
clone copy.
>> However it seems like this push would requires the partial clone copy =
to download more objects?
>> Is this intended?
>>=20
>> Reproduce:
>>=20
>> 	mkdir repo && cd repo
>> 	git init
>> 	git remote add origin git@domain.com:path/repo.git
>> 	git fetch --filter=3Dtree:0 --no-tags --prune origin <commit-id>
>> 	git sparse-checkout init --cone
>> 	git checkout --force <commit-id>
>> 	git tag -a sluongng-test -m "Test push from partial clone"
>> 	git push HEAD:refs/tags/sluongng-test
>> 	<git starts to download objects>
>>=20
>> Ideally we would like to be able to push tag from a shallow + partial =
clone repo without=20
>> having to download extra objects if possible.
>> We would like to keep the required repo to the absolute minimum.
>> 	git fetch --depth 1 --filter=3Dtree:0 --no-tags --prune origin =
<commit-id>
>>=20
>> Creating and pushing tags should not require local repo to have =
trees/blobs in it?
>>=20
>> Git version: 2.27.0
>=20
> Could you try this again with 2.28.0-rc1? I think Jonathan
> Tan added the "no-fetch" flag in more places since 2.27.0,
> and this might already be fixed.

I just freshly compiled from 'next' branch:

	> git version
	git version 2.28.0.rc1.139.gd6b33fda9d

And the problem still occurring:
	> mkdir scalar
	> cd scalar
	> git init
	Initialized empty Git repository in =
/Users/sluongngoc/work/booking/core/scalar/.git/
	# use my own fork here so that i have push permission
	> git remote add origin git@github.com:sluongng/scalar.git
	> git sparse-checkout init --cone
	> git fetch --filter=3Dtree:0 --no-tags --prune origin =
4ba6c1c090e6e5a413e3ac2fc094205bd78f761e
	remote: Enumerating objects: 2553, done.
	remote: Total 2553 (delta 0), reused 0 (delta 0), pack-reused =
2553
	Receiving objects: 100% (2553/2553), 957.85 KiB | 1.06 MiB/s, =
done.
	Resolving deltas: 100% (74/74), done.
	=46rom github.com:sluongng/scalar
	 * branch            4ba6c1c090e6e5a413e3ac2fc094205bd78f761e -> =
FETCH_HEAD
	> git tag -a test-tag -m 'test tag message' =
4ba6c1c090e6e5a413e3ac2fc094205bd78f761e
	> git push origin refs/tags/test-tag:refs/tags/test-tag
	...<download start>

>=20
> Thanks,
> -Stolee
>=20

Thanks,
Son Luong.=
