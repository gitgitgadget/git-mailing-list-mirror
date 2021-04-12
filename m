Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A0C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 07:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCE36121F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 07:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhDLHxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbhDLHxo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 03:53:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB10C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 00:53:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s7so11730294wru.6
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=K+s10SFtbL1eE/Uv/u73oF1YNasPmgmAYon9+GdEnJw=;
        b=E8yZpDIYScSPAeebC/vowjd11G2pdVEH6gdcTBIGME4NJqjuZ23lEHK8HEQ27Ub7Py
         YmDWifG8G/gldgxptrpfAJozlDFQjtGCgguc0ILErSyChf0IO9XVSO3Exw55f0iDjL1t
         M4v9SVbUUxFSYNFdadxWtzd94NvVB2hxdSFztLUiZj9E2MMLqfvU51J858iSPPpDQsGK
         vUctbElHsKPXM9pMsjbfuJ4M9279fPFbpRKf78YQxSqNvjxi9ZDr+X3cX/5xfjnpJc9R
         xcPHwXcSwM9PrLLQ6YenHNnGTc0ZKPd79JWct7hk8YTIEwRn3Hp/drGeouWKY9VbJreC
         /idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=K+s10SFtbL1eE/Uv/u73oF1YNasPmgmAYon9+GdEnJw=;
        b=noLe4Mz2g+VdxdMsXc+yi6sV0mWcgkURbDn+DfZDesyB1Oyb0IFxr7d07BbwtKoZtZ
         ghvYsb4JAiHx3PuRiSndVipzJmX+aXm8N/a9PefrtpvmjfGJusblN7jW20g8FBPg1rFx
         XFkdG96NJpewGQz3T5MxO3cPlSUmZMX2WjyXpfj5gJbuXMz/3o8usYp2uhmnpGQlQbfF
         OoWanbUMRMpJTF8J50rdIosn3kBFMAMnIn4S6zR53T4zCAmvsu6CKjBbTnaU0VT1wTNi
         Vrgd3duU33qRvpUwvfEwIVDhJXG4HOGQ3iEzNMxyTR/jBR+xBVWf5orOA0WVT4PmtWvo
         aozQ==
X-Gm-Message-State: AOAM530bXIP/5d04/5Y7tUWftbAxfQj5FmgLthUT+6x+mM/3G3P/v8/8
        pTqRBDnoExGkJ3sxZKjuXFA7Ex5BFPTamw==
X-Google-Smtp-Source: ABdhPJzqMcbpSSfRcIZ4T274qGW82gUA5Xk2vTAE87G97u3RBzbjmEeincIfpLlSSz3+FFt5OpGhbw==
X-Received: by 2002:adf:e647:: with SMTP id b7mr20351166wrn.43.1618214004406;
        Mon, 12 Apr 2021 00:53:24 -0700 (PDT)
Received: from cpm12071.local ([79.140.122.112])
        by smtp.gmail.com with ESMTPSA id u2sm13610008wmc.22.2021.04.12.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 00:53:23 -0700 (PDT)
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <20210411105903.GG2947267@szeder.dev>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
In-reply-to: <20210411105903.GG2947267@szeder.dev>
Message-ID: <gohp6k4kgcdjm6.fsf@gmail.com>
Date:   Mon, 12 Apr 2021 09:53:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Mon, Apr 05, 2021 at 03:02:33AM +0200, Rafael Silva wrote:
>> > here are trace timings of running 'git gc' in a "normal" and in a
>> > 'blob:none' partial clone:
>> >
>> >   $ git clone --bare https://github.com/git/git git-full.git
>> >   $ GIT_TRACE_PERFORMANCE=3D2 /usr/bin/time --format=3D'elapsed: %E  m=
ax RSS: %Mk' git -C git-full.git/ gc
> [...]
>> >   elapsed: 0:09.51  max RSS: 358964k
>> >
>> >   $ git clone --bare --filter=3Dblob:none https://github.com/git/git g=
it-partial.git
>> >   $ GIT_TRACE_PERFORMANCE=3D2 /usr/bin/time --format=3D'elapsed: %E  m=
ax RSS: %Mk' git -C git-partial.git/ gc
>> >   10:35:47.637735 trace.c:487             performance: 0.000872539 s: =
git command: /usr/local/libexec/git-core/git pack-refs --all --prune
>> >   10:35:47.675498 trace.c:487             performance: 0.036246403 s: =
git command: /usr/local/libexec/git-core/git reflog expire --all
>> >   Enumerating objects: 188205, done.
>> >   Counting objects: 100% (188205/188205), done.
>> >   Delta compression using up to 4 threads
>> >   Compressing objects: 100% (66520/66520), done.
>> >   Writing objects: 100% (188205/188205), done.
>> >   Total 188205 (delta 119967), reused 188205 (delta 119967), pack-reus=
ed 0
>> >   10:35:50.081709 trace.c:487             performance: 2.402625839 s: =
git command: /usr/local/libexec/git-core/git pack-objects --local --delta-b=
ase-offset objects/pack/.tmp-2946990-pack
>> >   10:35:50.100131 read-cache.c:2315       performance: 0.000009979 s: =
 read cache ./index
>> >   10:37:04.973541 trace.c:487             performance: 74.885793630 s:=
 git command: /usr/local/libexec/git-core/git pack-objects --local --delta-=
base-offset objects/pack/.tmp-2946990-pack --keep-true-parents --honor-pack=
-keep --non-empty --all --reflog --indexed-objects --exclude-promisor-objec=
ts --unpack-unreachable=3D2.weeks.ago
>> >   Removing duplicate objects: 100% (256/256), done.
>> >   10:37:07.482791 trace.c:487             performance: 79.804973525 s:=
 git command: /usr/local/libexec/git-core/git repack -d -l -A --unpack-unre=
achable=3D2.weeks.ago
>> >   10:37:07.549333 trace.c:487             performance: 0.008025426 s: =
git command: /usr/local/libexec/git-core/git prune --expire 2.weeks.ago --e=
xclude-promisor-objects
>> >   10:37:07.552499 trace.c:487             performance: 0.000362981 s: =
git command: /usr/local/libexec/git-core/git worktree prune --expire 3.mont=
hs.ago
>> >   10:37:07.554521 trace.c:487             performance: 0.000273834 s: =
git command: /usr/local/libexec/git-core/git rerere gc
>> >   10:37:10.168233 trace.c:487             performance: 82.533331484 s:=
 git command: git -C git-partial.git/ gc
>> >   elapsed: 1:22.54  max RSS: 1891832k
>> >
>> > Notice the ~9s vs. 82s runtime and ~350M vs. 1.9G memory consumption
>> > increase.  What's going on here?
>> >
>> > Also note that that second 'git pack-objects' invocation doesn't show
>> > any progress for ~75s.
>> >
>> > FWIW, doing the same in a 'tree:0' partial clone is fast.
>>=20
>> I'm not expert on the area - by "area": the entire git code base :).
>> However, I was intrigued by this performance numbers and decided to give
>> it a try on the investigation, mostly for learning.
>
> That's the spirit!
>

:)

>> While I'm not sure
>> about the solution of the problem, I decided to share it here with the
>> hope that at least I'll be saving someone else time.
>>=20
>> When I was digging into the code and adding trace2_region_*() calls, I
>> notice most of the time spent on the `git gc` (for the reported
>> situation) was in:
>>=20
>>        # In builtin/pack-objects.c
>>        static void get_object_list(int ac, const char **av)
>>        {
>>                ...
>>                if (unpack_unreachable)
>>                        loosen_unused_packed_objects();
>>                ...
>>        }
>>=20
>> The loosen_unused_packed_objects() will unpack unreachable objects as
>> loose objects, and given that the partial cloned .pack file is
>> incomplete, this result in writing a lot of loose objects in $GIT_DIR
>> increasing the execution time and memory consumption. This can be seen
>> by watching the $GIT_DIR/objects/ during the `git gc` execution on the
>> partial cloned repo.
>
> Indeed, that 'blob:none' partial clone grew in size temporarily to
> over 1.3GB during repacking, but luckily all those unnecessarily
> loosened objects were removed at the end.  I first noticed this issue
> while attempting to repack a considerably larger partial-cloned
> repository, which I aborted because it ate up all the memory...  I
> suppose that even if it didn't use that much memory, it would
> eventually run out of available disk space for all those loose objects
> anyway...
>
>
>> I'm not entirely sure about this (not this late in the day), but it seem=
s to
>> me that we should simply skip the "missing" (promisor) files when
>> operating on a partial clone.
>>=20
>> Perhaps something like:
>>=20
>> --- >8 ---
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 525c2d8552..fedf58323d 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -3468,6 +3468,8 @@ static int loosened_object_can_be_discarded(const =
struct object_id *oid,
>>  {
>>         if (!unpack_unreachable_expiration)
>>                 return 0;
>> +       if (exclude_promisor_objects && is_promisor_object(oid))
>> +               return 1;
>>         if (mtime > unpack_unreachable_expiration)
>>                 return 0;
>>         if (oid_array_lookup(&recent_objects, oid) >=3D 0)
>> --- >8 ---
>>=20
>> I'll try to prepare a patch for this change with proper testing, if this
>> turns out to be proper way to handle partial clone repository.
>>=20
>> A quick benchmark did show some promising result:
>>=20
>>     # built from: 2e36527f23 (The sixth batch, 2021-04-02)
>>     Benchmark #1: ./bin-wrappers/git -C git.git gc
>>           Time (mean =C2=B1 =CF=83):     135.669 s =C2=B1  0.665 s    [U=
ser: 42.789 s, System: 91.332 s]
>>           Range (min =E2=80=A6 max):   134.905 s =E2=80=A6 136.115 s    =
3 runs
>>=20
>>     # built from: 2e36527f23 + minor patch (from above)
>>     Benchmark #2: ./bin-wrappers/git -C git.git gc
>>           Time (mean =C2=B1 =CF=83):     12.586 s =C2=B1  0.031 s    [Us=
er: 11.462 s, System: 1.365 s]
>>           Range (min =E2=80=A6 max):   12.553 s =E2=80=A6 12.616 s    3 =
runs
>>=20
>>     Summary:
>>           'Benchmark #2' ran 10.78 =C2=B1 0.06 times faster than 'Benchm=
ark #1'
>
> I can confirm that you change speeds up repacking considerably and it
> completely eliminates that temporary repo size explision due to
> unpacked objects, but, alas, it doesn't seem to reduce the memory
> usage.
>
> Thanks,
> G=C3=A1bor

Thanks for confirming it. The memory usage, indeed, is almost the same
after the changes.  Nevertheless, Peff suggested a better approach to
addressing this issue, by realizing earlier that we should even
consider loosening the objects from the pack.

I'll try to work with that approach and see how this apply to memory
usage.

--=20
Thanks
Rafael
