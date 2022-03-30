Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A48C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 17:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbiC3Rxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiC3RxU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:53:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416FDEA345
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:51:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so43032776ejc.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gsw0nEJJbwF629Q5heb0zLPNCGyoVmqrscnuximmE6U=;
        b=J+XBu1hzZDPSFzRbvg2t05OHXEy3BCfIzVneKaHfrgDhOnQ6OE3FLWzvmfTLMEf91l
         4LCAB5haxCW2xMwfgqgpjkadWY1wLQOm56M71hkaNRdfGC28fEHu7MGegCUwBPxjMGCc
         rIEEUs7shaT5vUDcb3viXBvp3szGDqV0mzXyAUFoSh0/56zrW805Z/PKuyjU0z4J2UWZ
         VpFqGluEcn0XyvB1u5ZtN23RRjwXrQtlmTy0B8+maD2zm8sG+aX6xr9hum5r1xIYWbyW
         WHB7qIk67vAgtQ2CnXO0FBnIDWzbLxKmr8EufF4hm/Rzqr+xutNHJXbIJD5yr/UI4AxT
         Vp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gsw0nEJJbwF629Q5heb0zLPNCGyoVmqrscnuximmE6U=;
        b=694hyIhUX502kFx530uSByfQiq2HY62BNLxSmb0EENXGPD8JLWdl258XkrDu8OZ3PS
         YW9MZHOQWgegrBiTmeXhVajfwe3N1j3jtCuOdoO38xx3VMhO20GVn4hFCeuWPf4UWqs9
         WvGDzOMq6/dRjCPyL463zyg8F1bUo83Sr/kziTeodp5wM1l62DtKp6xrhpHB4VrK6MLs
         E1KOzL0zpEHw4eCVoR3dWTPk9/7kEjWoOdNkSBpLUJ91llEg2qQkXOcmtYNyh4lLWKGv
         4P5O6yQ/p/x7ESCe/gh+m/YWmF+4P3XD7nEso1daxKZxiBtsDikSUuWItYydcIiFAzj9
         MoPg==
X-Gm-Message-State: AOAM5322CM0e6aFkQndJIKh3g+fuMQ52MtOeWGGOF2ovqizdroFa1C88
        owTDzrNgyAjVv//mgAUY0TY=
X-Google-Smtp-Source: ABdhPJyEzcwa8GPtljVZD8Tr4/OqDxZ+C0n4r+CY8zHHwCH/IqOO/RjFKGzBSC7vp4bk8RGtFzhLAA==
X-Received: by 2002:a17:906:e16:b0:6df:c796:25b5 with SMTP id l22-20020a1709060e1600b006dfc79625b5mr811055eji.302.1648662687549;
        Wed, 30 Mar 2022 10:51:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd7dee980sm8473586ejc.30.2022.03.30.10.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:51:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZcTd-004OUc-Kq;
        Wed, 30 Mar 2022 19:51:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        lessleydennington@gmail.com, gitster@pobox.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Date:   Wed, 30 Mar 2022 19:38:29 +0200
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
 <471ca70d-0da1-8c4f-16bc-3019706931bd@github.com>
 <Yjt6mLIfw0V3aVTO@nand.local>
 <220329.86h77h2ju3.gmgdl@evledraar.gmail.com>
 <YkPBnIt6K0crowpb@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YkPBnIt6K0crowpb@nand.local>
Message-ID: <220330.86ilrvnxb6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 29 2022, Taylor Blau wrote:

> On Tue, Mar 29, 2022 at 11:04:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Wed, Mar 23 2022, Taylor Blau wrote:
>>
>> > On Wed, Mar 23, 2022 at 03:22:13PM -0400, Derrick Stolee wrote:
>> >> On 3/23/2022 2:03 PM, Josh Steadmon wrote:
>> >> > prepare_repo_settings() initializes a `struct repository` with vari=
ous
>> >> > default config options and settings read from a repository-local co=
nfig
>> >> > file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings o=
nly
>> >> > in git repos), prepare_repo_settings was changed to issue a BUG() i=
f it
>> >> > is called by a process whose CWD is not a Git repository. This appr=
oach
>> >> > was suggested in [1].
>> >> >
>> >> > This breaks fuzz-commit-graph, which attempts to parse arbitrary
>> >> > fuzzing-engine-provided bytes as a commit graph file.
>> >> > commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), =
but
>> >> > since we run the fuzz tests without a valid repository, we are hitt=
ing
>> >> > the BUG() from 44c7e62 for every test case.
>> >> >
>> >> > Fix this by refactoring prepare_repo_settings() such that it sets
>> >> > default options unconditionally; if its process is in a Git reposit=
ory,
>> >> > it will also load settings from the local config. This eliminates t=
he
>> >> > need for a BUG() when not in a repository.
>> >>
>> >> I think you have the right idea and this can work.
>> >
>> > Hmmm. To me this feels like bending over backwards in
>> > `prepare_repo_settings()` to accommodate one particular caller. I'm not
>> > necessarily opposed to it, but it does feel strange to make
>> > `prepare_repo_settings()` a noop here, since I would expect that any
>> > callers who do want to call `prepare_repo_settings()` are likely
>> > convinced that they are inside of a repository, and it probably should
>> > be a BUG() if they aren't.
>>
>> I think adding that BUG() was overzelous in the first place, per
>> https://lore.kernel.org/git/211207.86r1apow9f.gmgdl@evledraar.gmail.com/;
>
> I think Junio raised a good point in
>
>     https://lore.kernel.org/git/xmqqcznh8913.fsf@gitster.g/
>
> , though some of the detail was lost in 44c7e62e51 (repo-settings:
> prepare_repo_settings only in git repos, 2021-12-06).
>
>> I have that in my local integration branch, because I ended up wanting
>> to add prepare_repo_settings() to usage.c, which may or may not run
>> inside a repo (and maybe we'll have that config, maybe not).
>
> I see what you're saying, though I think we would be equally OK to have
> a default value of the repo_settings struct that we could rely on. I
> said some of this back in
>
>     https://lore.kernel.org/git/Yjt6mLIfw0V3aVTO@nand.local/
>
> , namely the parts around "I would expect that any callers who do want
> to call `prepare_repo_settings()` are likely convinced that they are
> inside of a repository, and it probably should be a BUG() if they
> aren't."
>
> Thinking in terms of your message, though, I think the distinction (from
> my perspective, at least) is between (a) using something called
> _repo_-settings in a non-repo context, and (b) calling a function which
> is supposed to fill in its values from a repository (which the caller
> implicitly expects to exist).
>
> Neither feel _good_ to me, but (b) feels worse, since it is making it OK
> to operate in a likely-unexpected context with respect to the caller's
> expectations.

I agree that it's a bit iffy. I'm basically advocating for treating
"the_repository->settings" as though it's a new "the_config" or
whatever.

Maybe we'd be better off just making that move, or having
the_repository->settings contain only settings relevant to cases where
we only have a repository.

But I think predicating useful uses of it on that refactoring is
overdoing it a bit, especially as I think your "(b)" concern here is
already something we deal with when it comes to
initialize_the_repository() and checks for
"the_repository->gitdir".

Can't we just have callers that really care about the distinction check
"->gitdir" instead? As they're already doing in some cases already?

Or just:

    git mv {repo,global}-settings.c

Since that's what it seems to want to be anyway.

> Anyway, I think that we are pretty far into the weeds, and it's likely
> time to turn around. I don't have that strong a feeling either way, and
> in all honesty either approach is probably just fine.

*nod*
