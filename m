Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2EFC433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiBLUnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:43:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiBLUnj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:43:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9125F8E9
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:43:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cf2so21304583edb.9
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zDzvBUAmyhAuAQNojDrnX0zsLxbgHsGEPIWDn2WipPk=;
        b=WXej3WDB4eT+nD0f6PEbwS1iFQ2fjK9fOijL/kJb942BIY+E9qUmtJHJdIDKbgreZV
         4dA41oDhLsme0npVsgsH0SSISBKkntkoF/oI+wqrqvEmWg2xBrcIWblis61uFeEgKAd2
         n4QKihq/ehGDzXFmzHq7CGZI5nQ4iXpppL1U4eeg84wwwuk8t4uyaUXh0jOOSOwzimMC
         0b5cy6kP/Ca8h8yjCr2elpiGOlTIqYasLi6Ss+YTyxEB1IhUUKpRu3mMC3/Wumu8C1LD
         JcSinoxlK4Q17/lBpSO1dMQAThEdG+yWxnBKKPkV4UCsUvpgtQeyZxckQdoNvOWjYdB2
         Phkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zDzvBUAmyhAuAQNojDrnX0zsLxbgHsGEPIWDn2WipPk=;
        b=MGMMF9IqV8nwF/eNWhuf/Lg7LcA7EnMRGKS7tkuEGQ94/f0eRN3QdFOX5quVuu8GZI
         I2dspjFL7BDT0h3HTof5eXsNOvKB9INAFzjKPyQMnmuin0dVXboVhqgREkW2y0ykdOBU
         eQdnrRTCFlOjYorIb0KpMt4RgUdAbRIPC3lidDYPA6erP8KyJ7rCxK1K3gDJdJ/kEWQ7
         8sMpfczwT2ohmRLUGbvNBrXwj+9U3/3rMgN2fDbmfSTf8WRBWgLSPoL3mVWqaC9peC0D
         ow3m2H+cjhC2GPiUnUWXC9R/Xyx4qGrluGZCpUe5RaASa0cVXqezLJRV8wDy/iF+kEj4
         rT6A==
X-Gm-Message-State: AOAM532q8cWcTd+vR2ztaLfLKv+Yg/fJTm3jRhuKIeeWbsAgTGpjyds2
        mOwZNPm1CmLtNyAjMo3GlreAk8z5fqZ3dg==
X-Google-Smtp-Source: ABdhPJz85j407SamVSgs0/4SYdEoy+21N5yWeekWc+UDu7Q5HG+bbmI53c4WJ87sxxF3XLFvGzU0DQ==
X-Received: by 2002:a05:6402:6d1:: with SMTP id n17mr8075960edy.321.1644698612625;
        Sat, 12 Feb 2022 12:43:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h7sm6471077ejb.40.2022.02.12.12.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:43:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nIzEx-000UV6-6U;
        Sat, 12 Feb 2022 21:43:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
Date:   Sat, 12 Feb 2022 21:35:48 +0100
References: <20211117005701.371808-1-emilyshaffer@google.com>
        <20220203215914.683922-1-emilyshaffer@google.com>
        <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
        <YgF5V2Y0Btr8B4cd@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YgF5V2Y0Btr8B4cd@google.com>
Message-ID: <220212.864k53yfws.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 07 2022, Jonathan Nieder wrote:

> Hi,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Feb 03 2022, Emily Shaffer wrote:
>
>>> To be honest, I'm not all that interested in performance
>>> - I want the config added for correctness, instead.
>>
>> And I'm honestly still at the point of not even being against this whole
>> thing, although it probably sounds like that. I'm really not.
>>
>> I just genuinely don't get where this is headed. I.e. for the last
>> iteration I did a demo patch on top that showed that there was no case
>> added by the series where the on-the-fly discovery wasn't equivalent to
>> the set-in-config value[4].
>
> Here's a few examples:

I've read the downthread, but it's probably best to reply to this...

> 1. Suppose I track my $HOME directory as a git repository.  Within my
>    home directory, I have a src/git/ subdirectory with a clone of
>    git.git, but I never intended to treat this as a submodule.
>
>    If I run "git rev-parse --show-superproject-working-tree", then it
>    will discover my home directory repository, run ls-files in there
>    to see if it has GITLINK entries, and either see one for src/git if
>    I had "git add"ed it by mistake or not see one.  In either case,
>    it would it would view my src/git/ directory as being a submodule
>    of my home directory even though I hadn't intended it to be so.
>
> 2. Suppose I have a copy of a repository such as
>    https://gerrit.googlesource.com/gerrit/, with all its submodules.
>    I am in the plugins/replication/ directory.
>
>    If I run "git rev-parse --show-superproject-working-tree", then it
>    will discover my gerrit repository, run ls-files in there to see if
>    it has GITLINK entries, and use the result to decide whether the
>    cwd is a submodule.  So for example, if I had run "git rm --cached
>    plugins/replication" to _prepare to_ remove the plugins/replication
>    submodule, then "git rev-parse --show-superproject-working-tree"
>    will produce the wrong result.

These both seem like valid edge cases, but they're still going to be the
same edge case on the "parent" side even with a proposed cache (whether
it's a boolean or a path).

I.e. the question here is really not one of caching, but of what it
means for Y to be a submodule of X.

I assumed that we'd prefer a 1=3D1 relationship between the parent
reporting that Y is a submodule of it, and Y reporting that it is a
submodule (of the parent at some <path>).

If that's the case we can walk up and ask parent .git's whether they
think the <path> is their submodule.

If it's not the case perhaps a config is needed, but then that surely
has wider implications. I.e. won't it be the case that we can't add the
config after-the-fact as this series proposes in those some ambiguous
cases?xo

> 3. Suppose I am not using submodules at all.  I have a clone of
>    mawk.git and I am working there.
>
>    If I run "git rev-parse --show-superproject-working-tree", then I'm
>    presumably interested in doing something submodule-specific;
>    nothing wrong with that.  But the series we're responding to is
>    meant to support a wider variety of operations --- for example,
>    suppose I am running a plain "git status" operation.
>
>    If "git status" runs "git rev-parse
>    --show-superproject-working-tree", then git would walk up the
>    filesystem above my mawk/ directory, looking for another .git dir.
>    We can reach an NFS automounter directory and just hang.  Even
>    without an NFS automounter, we'd expect this to take a while
>    because, unlike normal repository discovery, we have no reason to
>    believe that the walk is going to quickly discover a .git directory
>    and terminate.  So this would violate user expectations.

We have a /a/b/c/d.git mounted, but not a parent /a/b/, and walking
upwards causes it to be mounted?
