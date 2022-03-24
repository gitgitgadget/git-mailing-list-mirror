Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D9C433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352077AbiCXRBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352041AbiCXRBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:01:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A345F4EA
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:59:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h1so6368522edj.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iiO6eo/9gmxre92qT/i/WB0w8a39qWUMDhmt3eejazk=;
        b=a5pnWxCp8/r4dlp4UI6tdITetubjq1KZbtuoaJfINK+nVWcxiscnZJPF+ZEJgi3A+F
         Z/7ImV8YDAn+EV+skQTbsaHDrLul0Is7EJ7S4V//UUDYOu4j63N7z7PWKq7aJKopyIoW
         lCv+F53Ri0nxKm2Kpc0HBdRyuaFxIjlX1jvn7bbHho8E+DhA91r7YEW+Wc9n9N/vwpwF
         c9ImF2ogvY89S9UE0fKNTBFycXk4YTJ3hlKe1O68uosbt74Dtjbvme9hme6qmYqzQvVV
         DKRpIKdrYJQsXgzQAw20ff4XMeQJ+rf5/WqWQxenfbA0MFq4DPi5+b5wmnywFg5zPMb9
         F1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iiO6eo/9gmxre92qT/i/WB0w8a39qWUMDhmt3eejazk=;
        b=xJ1jgM+8jzvd4YL08CLZioKleIMN5JmyFdFmdCwev23r4tH254iSdzhYox0zSjPBVb
         XWcw+pAh+KRTr+R49/9ZAE1FNI+eJgJDXifvAIZScMc4ph0qrcmWp4JrH/j14XBpfORi
         1024ZGJUjIQSlwWLy10nvqKN9KzWQcAKOfyuhQOtP3gVdokmv5rs5y2TphZV5FlvkQ7n
         qrgLSdBMXMk/WgQLkD2ii1WRuhIzAu2vN4CvtRwUrC2fkZXfe6L6/f6Vd+5hbTQw4Dps
         T4ppQFyYIvtzyt7aVPUyFT0CisChQKhEzAi4uTV+FhMl6QxfBwkPQ4DOhtY/JqqBDBO4
         7LTg==
X-Gm-Message-State: AOAM530t2+XsWWb3kJmDsU/xG52CwYeh3hCySH/uPGhtR1yQBfJnug1c
        qlTLvRtghr3XC3Jxi99eHKI=
X-Google-Smtp-Source: ABdhPJzFmW67scB4mcoEo2/pUsUSI86adpwQLLJdBZKhcFQc/SJdS807M5t0bun2IG++Fsxsj4bEzA==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr7858767edt.186.1648141172593;
        Thu, 24 Mar 2022 09:59:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg22-20020a170907971600b006df9ff416ccsm1317523ejc.137.2022.03.24.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:59:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXQo7-001j9M-If;
        Thu, 24 Mar 2022 17:59:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/27] t/helper/test-fast-rebase.c: don't leak
 "struct strbuf"
Date:   Thu, 24 Mar 2022 17:57:39 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <patch-v2-01.27-8fbafe61053-20220323T203149Z-avarab@gmail.com>
 <xmqqr16sm1im.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqr16sm1im.fsf@gitster.g>
Message-ID: <220324.86pmmbmglo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix a memory leak that's been with us since f9500261e0a (fast-rebase:
>> write conflict state to working tree, index, and HEAD, 2021-05-20)
>> changed this code to move these strbuf_release() into an if/else
>> block.
>>
>> We'll also add to "reflog_msg" in the "else" arm of the "if" block
>> being modified here, and we'll append to "branch_msg" in both
>> cases. But after f9500261e0a only the "if" block would free these two
>> "struct strbuf".
>>
>> This change is needed so that a subsequent addition of a "goto
>> cleanup" pattern when adding release_revisions() doesn't solve this
>> unrelated bug while it's at it.
>
> With or without the goto-cleanup change, this fix alone is the right
> fix for these leaks.  I would not have written the last paragraph if
> I were working on this topic ;-)

To this and your 02/27 comment: Sure, I can remove that.

In general I think it's bad form for individual commits to discuss the
series they're in, they should be stand-alone.

But I'm pretty sure if I left this out I'd have gotten questions about
why these seemingly unrelated leak fixes are here as art of series
implementing release_revisions(), from either you or someone else :)
