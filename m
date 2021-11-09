Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C350C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 09:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140F96103C
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 09:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbhKIJS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhKIJS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 04:18:58 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C382C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 01:16:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o8so73849760edc.3
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 01:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QAJL8AulIY6lqSHxon+bqzz1HYt24fTLJuJsGof68eU=;
        b=gyJl0aGzssH2p5XgowWURQqzOiHwsf1s8cstE/inMaE6mQ8zuOZKT+rxVzi2ZxFEmQ
         RtVsaFaoL1L5Fg5FH9A0F1TBEUPhAOAoNBUtfpir56/oqfRzBTcDt6u659D43zrHNIWs
         7eYomjLIWBT1QSoHPhNbydGT1zsYBAd6JwORtUFJ+Tfdpow3MJ3WmA5Hj+qDZ0nnSH4o
         uRJMzkc//B5Dc+o/QOKnh0ULII2LFc4nGtFMG6e/yfTToChG1fID+Pn278Ueqk/qT5+4
         LWNCcjuy78naPmazbrF1A2DB+Z8Pqt5NVvMbLPCdpgLHBYStBzs6ADyL8A6TD+k/WRqF
         IxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QAJL8AulIY6lqSHxon+bqzz1HYt24fTLJuJsGof68eU=;
        b=LyuOXk3JNM6Caj1OOH3dJFXiyj9GJxGd0kauqNBP1Yp6HD1nh5acknBk1/90NmcnEa
         tDN+IkTUeq9DIVmoO20mtr2sdC5+NALd5ZlCftNUMfT92X3WfvByx0vrhQBu4XzCDMat
         F6qbRHPzArDtRbE/4He7wfXNjoPSCYpfBMskDGuoOrcp1QY+ZZ1kGq4gYUkk4Uv2ZC5R
         U9mlsIBopSvmww65YXEomhKArEmOlz4HtPRsOVkpS/6hLMgAoywv1CLrXETaGfoCwWCf
         GkWylSgDx0ysYLWMD3MtQcUx9hbo/KN8auex5jbkcPr26YhfY3UKv9CvqXp3OhRwGh3t
         Lbrg==
X-Gm-Message-State: AOAM5332jRVA2eW1MUyMD+t6QQv1+ixsWncpFg7CmRlvmbSLSOQQa4BD
        vhjFmpOcjWWDqaNlhGRaBCUKYr9q2qY=
X-Google-Smtp-Source: ABdhPJyZ4n5Skjz/A7xIw+qD6ldApeXF6uDhqQF0TFMZ0QJFS/WD1/a/pugQMkFjcxDBB5e6WIAolA==
X-Received: by 2002:a17:906:a10c:: with SMTP id t12mr7460489ejy.429.1636449370468;
        Tue, 09 Nov 2021 01:16:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gt18sm6315578ejc.88.2021.11.09.01.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 01:16:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkNEf-00038U-6c;
        Tue, 09 Nov 2021 10:16:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     samuelyvon9@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH] builtin-commit: re-read file index before launching editor
Date:   Tue, 09 Nov 2021 10:11:04 +0100
References: <211109.86wnlicaur.gmgdl@evledraar.gmail.com>
 <20211109030804.261493-1-samuelyvon9@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211109030804.261493-1-samuelyvon9@gmail.com>
Message-ID: <211109.868rxxvgdi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, samuelyvon9@gmail.com wrote:

> From: Samuel Yvon <samuelyvon9@gmail.com>
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> The code you're moving around has a comment which seems to suggest that
>> what you want *is* the desired behavior, i.e. we re-read it before
>> invoking the editor, so we should have the updated diff, but just don't?
>
> My understanding is that it was once the behaviour and has changed over t=
ime.
> I am saying this based on
> https://lore.kernel.org/git/xmqqk0yripca.fsf@gitster.c.googlers.com/t/#u
>
> Specifically,
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> Even before ec84bd00 (git-commit: Refactor creation of log message.,
>> 2008-02-05), the code anticipated that pre-commit may touch the index
>> and tried to cope with it.
>> However, ec84bd00 moved the place where we re-read the on-disk index
>> in the sequence, and updated a message that used to read:
>>=20
>> -    /*
>> -     * Re-read the index as pre-commit hook could have updated it,
>> -     * and write it out as a tree.
>> -     */
>>=20
>> to:
>>=20
>> +    /*
>> +     * Re-read the index as pre-commit hook could have updated it,
>> +     * and write it out as a tree.  We must do this before we invoke
>> +     * the editor and after we invoke run_status above.
>> +     */
>>=20
>> Unfortunately there is no mention of the reason why we "must" here.
>
> Looking at ec84bd00 (git-commit: Refactor creation of log message., 2008-=
02-05),
> we can see that the editor is launched after the cache has been reset. Th=
e only
> part that troubles me is the line in the comment that specifies that "we =
must do
> this ... after we invoke run_status above". I have tested (with my limite=
d knowledge
> of the internals of git) and it seems to be of no consequence of flushing=
 before
> the call to run_status, but I might be missing something.
>
>> The code you're moving around has a comment which seems to suggest that
>> what you want *is* the desired behavior, i.e. we re-read it before
>> invoking the editor, so we should have the updated diff, but just don't?
>
> I think this is the case (based on the previously linked conversation).

*nod*, the implicit suggestion here being: Let's put more of that
summary into the commit message. It helps when looking up/discovering
older behavior.

The comment was first added in 2888605c649 (builtin-commit: fix
partial-commit support, 2007-11-18), and quite suspicuous in timing is
f5bbc3225c4 (Port git commit to C., 2007-11-08) where we moved from
git-commit.sh.

It's a bit of a pain to build git that old, but my hunch is that perhaps
this was tested with git-commit.sh, where the reading of the index would
be another process.
