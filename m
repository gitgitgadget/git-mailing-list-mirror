Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A10C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiB1PUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiB1PUC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:20:02 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F980927
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:19:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cm8so18103451edb.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/7HQdGx+58YO5jF0Ux75tafMBw10R0H3HE4+YIgq+gc=;
        b=JkMZP9S5B3GU4eGRbluxuAKa3Qdy2sgpwjixjyDQSEK2vlVTKWBVIXy+8BVo/IQyp2
         mDL/kFq9eVh3s09N8VBACIuCIjp0hXiYh+ZuMf3D7x0u5LqhNWQcf9B8a1PAmaClArhP
         YwJgaxgD6EzfPWToUEzwJAv8YICjhKLyRaTRN+dszC+Nf09mTqSUO57tVobcwmRhE2CT
         /9GYXwSTuH0f2XpXf3VbGY0rau7fuiQH8aS8WAyLsM/Q08K7Lup4L364+16UVSkbmNEM
         4RFWUOkgT2lXhxYC4hANpQCgf1NWpV5eB2oVBL77aSf2jyNtUp4N8Wevopaz3psycNWU
         uoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/7HQdGx+58YO5jF0Ux75tafMBw10R0H3HE4+YIgq+gc=;
        b=wZhPHfIr7KyIqNpdwvr3gmL0wbKTbKGpyxHugWnsYYIEC4cZHTmyLwmA71DLvQ3jd0
         PVMTiylPacxNIPaufp7wvWQQBm3fpsnfWZlJgMeMh/mf4xIUWJRTZ+pSbbDqlQEEDQT7
         EcvjhP/oJH6pZLvbY8PilI7e/szqBu9OY9BJM+7epYyXNbfveMVcPJdNdgWMXEQ2zuzR
         nZgjtHz8DAsLUIYD0cRCbTEe1DhIDySlxHniC1+oT8nn9HkMB+uwEmuSgFiEw5EEvrTL
         yymM8A5CpGpVlqfkKEhzkrGmBOrE1m00PeFcuA86p6CEdf+y2nKrWXCZ7z7+DFjEIYNY
         rFaQ==
X-Gm-Message-State: AOAM530eJ33lapLLu7Oms/ZOPjWA3HzAX6jAyuSqiFEIsMvny2zryaVV
        DDht1ba7sPTprr+CsGIv3fk=
X-Google-Smtp-Source: ABdhPJyryvO85KBZ54FwkSF6FRh6ycCPh3a1kM/ozayeGtQSmnoFXiwcVY1Uc5hPmAfHDFXLlJSldQ==
X-Received: by 2002:a05:6402:d08:b0:412:a33e:24fe with SMTP id eb8-20020a0564020d0800b00412a33e24femr20573045edb.281.1646061559150;
        Mon, 28 Feb 2022 07:19:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906780500b006d0b99162casm4465680ejm.114.2022.02.28.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 07:19:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOhnx-001QLH-Oq;
        Mon, 28 Feb 2022 16:19:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Date:   Mon, 28 Feb 2022 15:27:49 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
 <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
 <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
Message-ID: <220228.86pmn73toq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Derrick Stolee wrote:

> On 2/25/2022 5:31 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Feb 24 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
> ...
>>>    Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
>>>      * This list of 4-byte values store corrected commit date offsets f=
or the
>>> @@ -103,6 +112,9 @@ CHUNK DATA:
>>>      * Generation Data chunk is present only when commit-graph file is =
written
>>>        by compatible versions of Git and in case of split commit-graph =
chains,
>>>        the topmost layer also has Generation Data chunk.
>>> +    * This chunk does not exist if the commit-graph file format versio=
n is 2,
>>> +      because the corrected commit date offset data is stored in the C=
ommit
>>> +      Data chunk.
>>>=20=20
>>>    Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
>>>      * This list of 8-byte values stores the corrected commit date offs=
ets
>>=20
>> We talked a while ago now about how we do commit-graph format changes
>> and this is partially echoing those earlier questions[1] from 2019.
>>=20
>> I fully understand why we're writing this amended CDAT chunk in a
>> different layout. By not having the GDAT side-chunk to look up in the
>> data is more local, that part of the file is more compact etc.
>>=20
>> What I don't understand is why getting those performance improvements
>> requires the breaking version change & the writing of the incompatible
>> version number.
>>=20
>> I.e. couldn't the differently formatted CDAT chunk be written instead to=
 a new
>> chunk name (say "2DAT") instead? Per [1] we'd pay a small fixed cost for
>> a possibly empty chunk (I didn't re-do those numbers), but surely the
>> performance improvements will be about the same for that miniscule
>> overhead.
>
> CDAT is a required chunk. It is part of the v1 spec that CDAT exists
> and is correct. All other Git clients will error out when reading a
> "v1" graph without such a chunk, and in a way that is less helpful to
> users. Instead of clearly indicating "file version is too new" it will
> say "commit-graph is missing the Commit Data chunk" which is not
> helpful.

Yes. That would be the worst of both worlds.

I thought the reference to the 2019-era post made it clear (which is
explicit about this aspect), but I'm talking about writing one of:

 A. An empty chunk
 B. Keeping a "stale" chunk around (as we re-write the graph)
 C. Duplicate writes of new/old chunks.

And not simply omitting the CDAT chunk. As you point out would give you
all the drawbacks of a version number change, with none of the benefits.

I haven't re-tested this now, but at the time doing any of (A..C) would
work smoothly for older clients, while giving newer ones improved data.

>> It will give you something you can't have here, which is optional
>> compatibility with older clients by writing both versions. That'll be a
>> ~2x as large file on disk, but with the page cache & each client version
>> skipping to the data it needs caching characteristics & data locality
>> should work out to about the same thing.
>
> Writing both is the only way that this could work without incrementing
> the graph version number, but I'd rather just update the number and
> avoid wasting the effort to write that extra data.

...

> It seems you are hyper-focused on "we don't _need_ to update the version
> number" and you are willing to recommend wasteful approaches in order to
> support that stance.

I'd say less hyper-focused, and more clarifying an IMO major unstated
trade-off of the proposed format change.

> So: you're right. We don't _need_ to update the version number. But this
> is the best choice among the options available.

...

>> Or maybe they won't. I just found it surprising when reviewing this to
>> not find an answer to why that approach wasn't
>> considered.
>
> The point is to create a new format that can be chosen when deployed
> in an environment where older Git versions will not exist (such as
> a Git server). The new version is not chosen by default and instead
> is opt-in through the commitGraph.generationVersion config option.
>
> Perhaps in a year or two we would consider making this the new
> default, but there is no rush to do so.

Looking into this a bit more I think that in either case this is less of
a big deal after my 43d35618055 (commit-graph write: don't die if the
existing graph is corrupt, 2019-03-25), which came out of some of those
discussions at the time of [1].

I.e. now a client that only understands version N-1 will warn when
loading it, wheras it's only if a pre-v2.22.0 client (which has that
commit) reads the repository that we'd hard die on it, correct?

But speaking of hyper-focus. I think that arguably applies to you in
this case when considering the trade-offs of these sorts of format
changes :)

I.e. you're primarily considering cases of say a git server (presumably
running on GitHub) or another such deployment where it's easy to have
full control over all of your versions "in the wild".

And thus a three-phase rollout of something like a format change can be
done in a timely and predictable manner.

But git is used by *a lot* of people in a bunch of different
scenarios. E.g.:

 * A shared (hopefully read-only) NFS mounted by remote "unmanaged" clients.
 * A tarred-up directory including a .git, which may be transferred to
   a machine with a pre-v2.22.0 version.

Or even softer cases of failure, such as:

 * A cronjob causes an alert/incident somewhere because the server=20
   operator started writing a new version, but forgot about a set
   of machines that are still on the old version.

I think that even if it's less conceptually clean it's worth considering
being over backwards to be kinder to such use-cases, unless it's really
required for other reasons to break such in-the-wild use-cases.

Or in this case, if it's thought to be worth it to help reviewers decide
by separating the performance improvement aspect from the changed
interaction between new graphs and older clients.

As a further nit on the proposed end-state here: Do I understand it
correctly that commitGraph.generationVersion=3D[1|2] (i.e. on current
"master") will always result in a file that's compatible with older
versions, since the only thing "v2" there controls now is to write the
optional GDAT and GDOV chunks?

Whereas going from commitGraph.generationVersion=3D2 to
commitGraph.generationVersion=3D3 in this series will impact older clients
as noted above, since we're bumping the version (of the file, to 2 if
the config is 3, which as Junio noted is a bit confusing).

I think if you're set on going down the path of bumping the top-level
version that deserves to be made much clearer in the added
documentation. Right now the only hint to that is a passing mention that
for v3:

    [it] will be incompatible with some old versions of Git

Which if we're opting for breaking format changes really should note
some of the caveats above, that pre-v2.22.0 hard-dies, and probably
describe "some old versions of Git" a bit more clearly.

It actually means once this gets released "the git version that was the
latest one you could download yesterday". Which a reader of the docs
probably won't expect when starting to play with this in mixed-version
environment.

1. https://lore.kernel.org/git/87h8acivkh.fsf@evledraar.gmail.com/
