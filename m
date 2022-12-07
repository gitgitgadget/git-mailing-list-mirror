Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF2C4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLGXhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLGXgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:36:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBB8B184
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:36:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk9so17681432ejc.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ab3eP7z8IFRNN5N/VYDFUtcs2M2vwsLyRZ9K+XJbW7I=;
        b=VL3V8hQUdluLpAAtonaUuEn9izHNMJtGa1V5bHCtRo9xzFP3qx1nSCZgjzVdM9BGm+
         Qr+XwIXUW36vyftzGD/0ooqdQN0YEK3wpC77ilwYCrH2TB5+dQ7HgKvyCqCHfuZjygxK
         g/D27ZCnmeP5bQ94a2OjfCRM/2MkiABrN4R+d2ShBl2tvkWlUZTr27a3vTOdMj2G/4Th
         0ap+69YwSpwq4p5USGjfstY7mS1u1MAuxoyQMTt+k+guhNyXgIwmfZMMmkQ2PeUQ1BFY
         QkSeyCH3+roqGpXQng/Ee1m/+jpNLXh2LlHCRzcbgHMHju2p7Ua+aPDl//hA+YtTKNAg
         4Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ab3eP7z8IFRNN5N/VYDFUtcs2M2vwsLyRZ9K+XJbW7I=;
        b=oJawptWLke1J+a+wxziM4wR1kcGtwV2mu7oYAG48ik9tUqmS8SFQQ1q3PY3cNtRyC/
         PYuzqxFzUar4/9LDJNIulKKMKCMtGrczUjOUOiG2YTs+en0r0DavcIMIfnapHWsbfomf
         EVHw+sDgqtH8SQvHZ0VwVmlDVIPF2vQCNRONTP7+lyRwNH524l9VCuAwCNdFesvzbPIz
         meA09GtcF9ctDdjs021wQxyW1MRKPJ7/m5T7/ku+JTrntzao4bKJkV6VbRxLEYe3wAGG
         FxGErXn6DqCPm/w9p134AEA0+z1ra0KtYFgocU05ic02l6Y0QRO1crqeNTzGXgDPVTI6
         Om2Q==
X-Gm-Message-State: ANoB5pncgoeZtvOEBDZFANeI/XnZIKwnpK0Y3kXZd+jLpbWszidAQOb4
        K9G/TyItx8tL9mgQelNuafL3N5YjHKBhZg==
X-Google-Smtp-Source: AA0mqf5UNX6Av1qOY3YFM+95nbWP9/d5+sWdomow+ss+apryrAKwxxnVF+kqgK3xe8cIjnHHQzScbA==
X-Received: by 2002:a17:906:4d95:b0:7c1:2980:7fd1 with SMTP id s21-20020a1709064d9500b007c129807fd1mr383718eju.76.1670456203313;
        Wed, 07 Dec 2022 15:36:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ku22-20020a170907789600b007a1d4944d45sm9132497ejc.142.2022.12.07.15.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:36:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p33xy-004hXw-0k;
        Thu, 08 Dec 2022 00:36:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
Date:   Thu, 08 Dec 2022 00:06:49 +0100
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
Message-ID: <221208.86mt7y946t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> While older Git versions will not recognize the null hash as a special
> case, the file format itself is still being met in terms of its
> structure. Using this null hash will still allow Git operations to
> function across older versions.

That's good news, but...

> The one exception is 'git fsck' which checks the hash of the index file.
> This used to be a check on every index read, but was split out to just
> the index in a33fc72fe91 (read-cache: force_verify_index_checksum,
> 2017-04-14).

...uh, what?

Is there an implied claim here that versions before v2.13.0 don't count
as "older versions"?

I.e. doesn't v2.12.0 hard fail the verification for all index writing?
It's only after v2.13.0 that we do it only for the fsck.

That seems like a rather significant caveat that we should be noting
prominently in the docs added in 4/4.

> As a quick comparison, I tested 'git update-index --force-write' with
> and without index.computeHash=3Dfalse on a copy of the Linux kernel
> repository.

It took me a bit to see why I was failing to reproduce this, before
finding that it's because you mention index.computeHash here, but it's
index.skipHash now.
>
> Benchmark 1: with hash
>   Time (mean =C2=B1 =CF=83):      46.3 ms =C2=B1  13.8 ms    [User: 34.3 =
ms, System: 11.9 ms]
>   Range (min =E2=80=A6 max):    34.3 ms =E2=80=A6  79.1 ms    82 runs
>
> Benchmark 2: without hash
>   Time (mean =C2=B1 =CF=83):      26.0 ms =C2=B1   7.9 ms    [User: 11.8 =
ms, System: 14.2 ms]
>   Range (min =E2=80=A6 max):    16.3 ms =E2=80=A6  42.0 ms    69 runs
>
> Summary
>   'without hash' ran
>     1.78 =C2=B1 0.76 times faster than 'with hash'

I suggested in
https://lore.kernel.org/git/221207.868rjiam86.gmgdl@evledraar.gmail.com/
earlier to benchmark this against not-sha1collisiondetection.

I don't think I get HW-accelerated SHA-1 on that box with OPENSSL (how
do I check...?). The results on my main development box are:
=09
	$ hyperfine -L g sha1dc,openssl -L v false,true -n '{g} with index.skipHas=
h=3D{v}' './git.{g} -c index.skipHash=3D{v} -C /dev/shm/linux-mem update-in=
dex --force-write' -w 5 -r 10
	Benchmark 1: sha1dc with index.skipHash=3Dfalse
	  Time (mean =C2=B1 =CF=83):      37.0 ms =C2=B1   2.3 ms    [User: 30.8 m=
s, System: 6.0 ms]
	  Range (min =E2=80=A6 max):    35.1 ms =E2=80=A6  41.4 ms    10 runs
=09=20
	Benchmark 2: openssl with index.skipHash=3Dfalse
	  Time (mean =C2=B1 =CF=83):      21.5 ms =C2=B1   0.4 ms    [User: 15.0 m=
s, System: 6.3 ms]
	  Range (min =E2=80=A6 max):    20.7 ms =E2=80=A6  22.0 ms    10 runs
=09=20
	Benchmark 3: sha1dc with index.skipHash=3Dtrue
	  Time (mean =C2=B1 =CF=83):      13.5 ms =C2=B1   0.4 ms    [User: 7.9 ms=
, System: 5.4 ms]
	  Range (min =E2=80=A6 max):    13.0 ms =E2=80=A6  14.2 ms    10 runs
=09=20
	Benchmark 4: openssl with index.skipHash=3Dtrue
	  Time (mean =C2=B1 =CF=83):      14.2 ms =C2=B1   0.3 ms    [User: 9.5 ms=
, System: 4.6 ms]
	  Range (min =E2=80=A6 max):    13.6 ms =E2=80=A6  14.6 ms    10 runs
=09=20
	Summary
	  'sha1dc with index.skipHash=3Dtrue' ran
	    1.05 =C2=B1 0.04 times faster than 'openssl with index.skipHash=3Dtrue'
	    1.60 =C2=B1 0.05 times faster than 'openssl with index.skipHash=3Dfals=
e'
	    2.75 =C2=B1 0.19 times faster than 'sha1dc with index.skipHash=3Dfalse'

So, curiously it's proportionally much slower for me with the hash
checking, and skipping it with openssl is on the order of the results
you see.
