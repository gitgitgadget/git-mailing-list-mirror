Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F63C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 11:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjC1LDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjC1LDv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 07:03:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5543580
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 04:03:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so47875665edb.11
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 04:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680001423;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOUyOiF/0ZxUVzGKGEhjxxApWp4S6RjHKXqvuo5x6uE=;
        b=MFmxbXYdR1t+KD1X1Jdj5hcWC2p2Hpdg5TcEWH4ydWUx0k4joqPi1XB8J5mhRYrTpy
         cWSoXfskOBqPAUs4Kynm/D+7GFsWNCEV3a8AEVX0T5W6+SLaZW3Zljomsd986CNsHRwX
         u88N/OFQD6arjvZ/0GVLtLRFp/5+SxVAEqAZfOYHb3kmjdd+BsWUOJwEUgEJxpgs6Jtg
         PiPPWBziEjeO3icfQpifxqoKFFhnsgdVHXmX0ZO8HtHl14Kb3FxUsL36hd8JDyFs6Vv4
         ZuHlwwHBJuFphMNcMBvtgsoL3iaK1ODkmJTXFVyEG1qLN+DAnQCbjDcwSw+AUjf1wLWr
         k8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680001423;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOUyOiF/0ZxUVzGKGEhjxxApWp4S6RjHKXqvuo5x6uE=;
        b=r9UDL12HPLvPeCmbd2eQlK+7g5GM7pLtHbMij3SkCKwvEyGge8EvVoeVESiDoOYJet
         3X2/uh/09e5H399ZPUJkGpFw76uy/BKdsC6q7slIPn/9MoG2qh0y/WShUP9YbeNB3jMh
         U49gSztB1/2WCwPHgaCsi7rzeWlz5O0m34VbtzB4vtFkJA0TYicg0q/5K1UfgrIqHWGW
         Yz0I4RrW+EMfvMc1Mbdn12L4/76TKCpU+FUFKsQiPgGyoTUpnr3cBU9va1GFaYTOhHPz
         g6jpE4pL3YNUGYzdrYQGdDRALc/qNKOwADQgGg+EiW/xUJZY/PdfI6SmaO/6Mg/c7yeW
         kw0w==
X-Gm-Message-State: AAQBX9dRKu91LlrmEtFyUhymPNxYcqfywuLSU/2eai7kwszVVdAEV/iG
        rKPbmGTG/xEZ25GZoOpRiLs=
X-Google-Smtp-Source: AKy350YdYBdCrihVPmut2ZCoY+ocLj2ls3WoAGu+8tF70lhBPNa8cXXTrbFOcul5Rmy+mnhmIlEOEg==
X-Received: by 2002:a05:6402:618:b0:501:caae:7e92 with SMTP id n24-20020a056402061800b00501caae7e92mr15180312edv.31.1680001423375;
        Tue, 28 Mar 2023 04:03:43 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v15-20020a50c40f000000b004d8d2735251sm15885573edf.43.2023.03.28.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:03:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ph777-004Rn8-1d;
        Tue, 28 Mar 2023 13:03:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/17] libs: use "struct repository *" argument, not
 "the_repository"
Date:   Tue, 28 Mar 2023 12:53:24 +0200
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <patch-17.17-6f86a34bf8b-20230317T152725Z-avarab@gmail.com>
 <CABPp-BEdpTO=DRjLq_p+dgX68M0HUVB--3yQR4Sdp8rnFYeyfA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CABPp-BEdpTO=DRjLq_p+dgX68M0HUVB--3yQR4Sdp8rnFYeyfA@mail.gmail.com>
Message-ID: <230328.86a5zxw31u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 18 2023, Elijah Newren wrote:

> On Fri, Mar 17, 2023 at 8:55=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason
> <avarab@gmail.com> wrote:
>>
>> As can easily be seen from grepping in our sources, we had these uses
>> of "the_repository" in various library code in cases where the
>> function in question was already getting a "struct repository *"
>> argument. Let's use that argument instead.
>>
>> Out of these changes only the changes to "cache-tree.c",
>> "commit-reach.c", "shallow.c" and "upload-pack.c" would have cleanly
>> applied before the migration away from the "repo_*()" wrapper macros
>> in the preceding commits.
>>
>> The rest aren't new, as we'd previously implicitly refer to
>> "the_repository", but it's now more obvious that we were doing the
>> wrong thing all along, and should have used the parameter instead.
>
> YES!  I love seeing fixes like this.  I noticed some a while back in
> the merge code, and had some patches somewhere that I think I never
> got around to submitting, but which have been in the back of my mind
> bugging me.  Nice to see lots of these kinds of cases getting fixed.

Yeah, it will be nice to fix those...

>> The change to change "get_index_format_default(the_repository)" in
>> "read-cache.c" to use the "r" variable instead should arguably have
>> been part of [1], or in the subsequent cleanup in [2]. Let's do it
>> here, as can be seen from the initial code in [3] it's not important
>> that we use "the_repository" there, but would prefer to always use the
>> current repository.
>>
>> This change excludes the "the_repository" use in "upload-pack.c"'s
>> upload_pack_advertise(), as the in-flight [4] makes that change.
>>
>> 1. ee1f0c242ef (read-cache: add index.skipHash config option,
>>    2023-01-06)
>> 2. 6269f8eaad0 (treewide: always have a valid "index_state.repo"
>>    member, 2023-01-17)
>> 3. 7211b9e7534 (repo-settings: consolidate some config settings,
>>    2019-08-13)
>> 4. <Y/hbUsGPVNAxTdmS@coredump.intra.peff.net>
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  add-interactive.c |   2 +-
>>  branch.c          |   8 ++--
>>  builtin/replace.c |   2 +-
>>  cache-tree.c      |   4 +-
>>  combine-diff.c    |   2 +-
>>  commit-graph.c    |   2 +-
>>  commit-reach.c    |   2 +-
>>  merge-recursive.c |   2 +-
>
> Doh, doesn't fix up the ones I had.  I don't remember the exact issue
> and can't find the patches right now, but looking around a little I
> see a write_object_file() which should be a repo_write_object_file(),
> but it's in a function that doesn't take a repository argument.
> However, the caller has access to a repository argument, in the form
> of opt->repo, so we've got some low-hanging fruit that could be fixed
> up.  Doesn't need to be part of your series, but it's nice that your
> series has done some of the groundwork to make these issues more
> obvious.

...yeah, I do have a WIP follow-up based on this topic which addresses
the sort of issues you're rasing here, i.e. in many cases we have
"the_repository", no "struct repository *" function argument, but we
have a "x->repo", where "x" is the "struct" state object we have in play
in that API.

My messy WIP follow-up for starting to fix those is at :
https://github.com/avar/git/compare/6f86a34bf8b...2072d685a56

I didn't get to the merge/object code you mentioned, but we should do
these sorts of changes as a follow-up.

I didn't do them as part of this topic, because this series was already
quite long, and this 17/17 is arguably scope-creep, but I could argue
for it on the basis of it being almost entirely a post-cleanup for the
preceding changes.

> [...]
> I started looking through it closely, but after a bit I realized that
> the only kind of error you would likely to be make here would be the
> kind caught by the compiler, so then I started just skimming over it.
> But I think that's safe for this kind of change.  I'm a big fan of
> these kinds of cleanups and fixups, though.
>
> I'm not sure I can give a Reviewed-by since I just don't know cocci,
> but it all looked pretty logical.  You definitely have my Acked-by on
> the series, though.

I won't add your Reviewed-by to a re-roll given that caveat, but FWIW I
think in general those not familiar with cocci should be comfortable
reviewing topics that modify code using the tool.

Even if you don't grok the patch lanugage, you can review the resulting
diff, as you've done here.

I think the exception to that is if the change itself is proposing to
institute a new cocci rule, that we can expect to apply going
forward. In those cases really understanding the rule matters, e.g. the
contrib/coccinelle/unused.cocci rule I added relatively recently is one
such example.

But here the rules are just a one-off, and are just an aid to reproduce
the changes.
