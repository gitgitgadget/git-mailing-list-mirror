Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C16C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 15:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbiCJPFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbiCJPDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 10:03:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19217F6A6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:55:31 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so12146710ejc.9
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Q6+qVhT7731QVgTE+YgDNDVuTtm3HqYrgjT4FsR548g=;
        b=UHuhXuJmhIEo54A3nP1PDsF55TTMSLwtkUSzBdqI6ByJnMiTDodOuwlmSOXJfIPwZa
         uozNnjHRTqlWVdmcPncIgycTAWi5oyE17G2icISjV4feDjn1fXpn+3c9dLch5eZxWSjq
         P3+zA3sBOKVsK91MKua99PJTyJEzKwbJPkOPUtE1Q+uk0DNrBmHTFL0ovokkpRL2acRO
         sTzQ3UtlP/cSXMzii1u2uIJymhKTmate5UAcFn2fLb/OD8FEEfX/zai7auueMHDO0CmP
         EZNrkZs8trej/ycmaZLBC9fFGfcebyijyz0SS+OzfrbB7aHUM7Bj5ljYzmeOFIZlnD2w
         4LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Q6+qVhT7731QVgTE+YgDNDVuTtm3HqYrgjT4FsR548g=;
        b=mcQPhCvHGmhtoZ8SFX6K28yGHlsZemfHMHzLlT4OG1ekchasqS3ruzThdz57VZbuw9
         kC6dsTe0jBKv29No5sxtQFh6EqvQI0x9bRceZphrCXupS2n+Pw2TIMLPUljCtmzdJLWj
         iDZZ4mhx850Vn9QG0yvWrawP5iCWZYb0nbqO3/Y002KSkue4QGM9hNvatrjoicBNh7/6
         I8UVXFEvuXjho4RCG6wqKw2Qe8UkJY4leLZvp6SGhGCLMJdU/cDP7ZiS3yT0Yl/hKyh3
         IjDVsGjQYJu0Djy7H/zGpBeMRyz31p6L+sKpUaWe9eZC5CiC7mSuzzRdXYewTZeu+WSS
         /ukg==
X-Gm-Message-State: AOAM533cYHqYXRc8wL6ht5ZHXUf6KcI+h5cHgJBx6HFIgEaWl+Dm6sUK
        QMjkrPaxHdhHKKy30MSQTv4=
X-Google-Smtp-Source: ABdhPJx499cy8u7Q4AqHPIFL2ZHGcArN47Ij7wFNWCE5BXDl+9W4cCNMCD5M1QS4rEjkDusdHOhbzQ==
X-Received: by 2002:a17:907:629a:b0:6d7:b33e:43f4 with SMTP id nd26-20020a170907629a00b006d7b33e43f4mr4649602ejc.149.1646924124749;
        Thu, 10 Mar 2022 06:55:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006db0a78bde8sm1884141ejy.87.2022.03.10.06.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:55:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSKCJ-000XUS-MZ;
        Thu, 10 Mar 2022 15:55:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 20/24] revisions API: clear "boundary_commits" in
 release_revisions()
Date:   Thu, 10 Mar 2022 15:55:10 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-20.24-fa53e81c7c0-20220309T123321Z-avarab@gmail.com>
 <625c3868-60c9-009b-b01b-f186710d4d08@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <625c3868-60c9-009b-b01b-f186710d4d08@github.com>
Message-ID: <220310.865yolkgbo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Derrick Stolee wrote:

> On 3/9/2022 8:16 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Clear the "boundary_commits" object_array in release_revisions(). This
>> makes a *lot* of tests pass under SANITIZE=3Dleak, including most of the
>> t/t[0-9]*git-svn*.sh tests.
>>=20
>> This includes the tests we had false-positive passes on before my
>> 6798b08e848 (perl Git.pm: don't ignore signalled failure in
>> _cmd_close(), 2022-02-01), now they pass for real.
>>=20
>> Since there are 66 tests matching t/t[0-9]*git-svn*.sh it's easier to
>> list those that don't pass than to touch most of those 66. So let's
>> introduce a "TEST_FAILS_SANITIZE_LEAK=3Dtrue", which if set in the tests
>> won't cause lib-git-svn.sh to set "TEST_PASSES_SANITIZE_LEAK=3Dtrue.
>
> This paragraph perhaps belongs a few patches earlier in "revisions
> API: have release_revisions() release "cmdline"", or else there was
> some swap of order here.

Indeed, this was a bad case of a commit message being duplicated, will
fix. Sorry!
