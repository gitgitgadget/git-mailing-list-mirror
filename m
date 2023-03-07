Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E4C678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 19:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjCGTOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjCGTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 14:13:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0651FB56F5
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:57:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ay14so52744888edb.11
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678215449;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JwbJ+HhSlcjwS0c2Flg1FcRdQd6wvgdNpfNdqdSlwnU=;
        b=LbzF5UCZ+DQXcdJ2f3/zpJ2Ilgg8gyzxYrjvJa20rpcQJRgf4IOaxAmpOAyjVnhad1
         OJPN+3svwXZW8A6FzmNPVikhEKsz8tCqnEmevl3hLmZ621lnz3ZO8x7Fl5vZICBbJZLy
         ue5KxW0bKnFH+yluThqorQW/7VEGt0N6kP+zVuCZx3gs7j+p3uCpiBzVGx/WnEwqTiRw
         rxhEB/PoAtdrNOcFvE9bCIOQ6rgpLWU7Mir0R6PmO4KdNH8Q/kTnWCNrE1IXhi0nJlEO
         qkF9yhXUH8RCL29wcJwdgML6Bf9DH/gCZEFTOnSlqLQjj3xNzxD3dmmhdWS8L9/e3fHr
         FRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678215449;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwbJ+HhSlcjwS0c2Flg1FcRdQd6wvgdNpfNdqdSlwnU=;
        b=E9b44Js7u2Co2SwqJGJWjQHy/kDUibNw6GaZdF4v+26CD+pq8BeSXUpvQVXUsb0ETb
         C2u43k5sRPbaoxPKWOv/XzBvDspa9z7uuJTx6pKfa+1sujR67hLyYgP0EuSSTil2rxMx
         FzbQAfMQgVLGuShmbEZMR6BA/nfqOWORynnIS6Wbpf6Qf+xHFfFX/Epef10v0ApfFsCO
         8W+xCWhz6QTchQYaCDlOnKYVt9vegOKkBKoeF9N6sNYBKa8xWrLHhi81zMcgUSpxgO6N
         yuyaw4pdWK5UukeI3h7SOUfWSyxSA5XqRTece4E1SpT6jRdkAMx3X67JBsLxLjNthL0t
         1caQ==
X-Gm-Message-State: AO0yUKXSQbn1ZjjXXfx9nz579rw7R37gawluQbybT9QnAmh1TmczaSOI
        0yEybBz82lLdZTMwg4O7+odHjTXTQlGq3w==
X-Google-Smtp-Source: AK7set/HzZi2k/yPJN+2gXjNHxji+3yXq9aYz4QcHsxDxSh0owJnj/CbC79nRO4ljgN2HF4IEqDb1w==
X-Received: by 2002:a05:6402:1345:b0:4af:6e95:85ec with SMTP id y5-20020a056402134500b004af6e9585ecmr13325430edw.4.1678215449328;
        Tue, 07 Mar 2023 10:57:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o22-20020a509b16000000b004c4eed3fe20sm7192723edi.5.2023.03.07.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:57:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pZcV6-000oJT-0F;
        Tue, 07 Mar 2023 19:57:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/6] [RFC] config.c: use struct for config reading state
Date:   Tue, 07 Mar 2023 19:36:58 +0100
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
 <230307.86wn3szrzu.gmgdl@evledraar.gmail.com>
 <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <kl6lfsagifpc.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <230307.86jzzsz8x3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 07 2023, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Mar 01 2023, Glen Choo via GitGitGadget wrote:
>>
>>> This series extracts the global config reading state into "struct
>>> config_reader" and plumbs it through the config reading machinery. It's=
 very
>>> similar to how we've plumbed "struct repository" and other 'context obj=
ects'
>>> in the past, except:
>>>
>>>  * The global state (named "the_reader") for the git process lives in a
>>>    config.c static variable, and not on "the_repository". See 3/6 for t=
he
>>>    rationale.
>>
>> I agree with the overall direction, but don't think that rationale in
>> 3/6 is sufficient to go in this "the_reader" direction, as opposed to
>> sticking with and extending "the_repository" approach.
>>
>> For orthagonal reasons (getting rid of some of the API duplication) I've
>> been carrying a patch to get rid of the "configset" part of the *public*
>> API, i.e. to have API users always use the "repo_config_*()" or
>> "git_config_*()" variants, that patch is at:
>> https://github.com/avar/git/commit/0233297a359bbda43a902dd0213aacdca82fa=
a34
>
> Those patches are probably worth sending, even if only as RFC. I found
> it pretty hard to draft a substantial response without effectively doing
> a full review of the patch.

Yes, sorry. It's part of some changes on top of my outstanding config
API changes (just re-rolled at
https://lore.kernel.org/git/cover-v6-0.9-00000000000-20230307T180516Z-avara=
b@gmail.com/). Hopefully
those will land soon after the upcoming release, I'll try to submit this
(along with related changes) soon afterwards.

>> It's a bit distasteful, but that change argues that just mocking up a
>> "struct repository" with a "config" member pointing to a new
>> configset is better than maintaining an entirely different API just
>> for those cases where we need to parse a one-off file or whatever.
>>
>> I think that going in that direction neatly solves the issues you're
>> noting here and in your 3/6, i.e. we'd always have this in the "repo"
>> object, so we'd just stick the persistent "reader" variables in the
>> "struct repository"'s "config" member.
>
> If I understand your proposal correctly, we would move the config
> variables to the_repository. Then, any time a caller would like to work
> with an individual file, it would init a new "struct repository" with a
> clean set of config members (using repo_init_repo_blank_config() or
> something) and reuse the repo_config_* API?

It's certainly a hack, but so is introducing a new "the_reader"
singleton whose lifetime we need to manage seperately from
"the_repository" in the common case :)

I think a better argument for this is probably that if you try to change
repository.h so that we define "struct repository" thusly (The
"hash_algo" field being still there due to a very common macro):

	struct repository {
	        const struct git_hash_algo *hash_algo;
	        struct config_set *config;
	};

And then try to:

	make config.o

You'll get:
=09
	$ make config.o
	    CC config.o
	config.c: In function =E2=80=98include_by_branch=E2=80=99:
	config.c:311:46: error: =E2=80=98struct repository=E2=80=99 has no member =
named =E2=80=98gitdir=E2=80=99
	  311 |         const char *refname =3D !the_repository->gitdir ?
	      |                                              ^~
	config.c: In function =E2=80=98repo_read_config=E2=80=99:
	config.c:2523:30: error: =E2=80=98struct repository=E2=80=99 has no member=
 named =E2=80=98commondir=E2=80=99
	 2523 |         opts.commondir =3D repo->commondir;
	      |                              ^~
	config.c:2524:28: error: =E2=80=98struct repository=E2=80=99 has no member=
 named =E2=80=98gitdir=E2=80=99
	 2524 |         opts.git_dir =3D repo->gitdir;
	      |                            ^~
	make: *** [Makefile:2719: config.o] Error 1

I.e. almost all of the config code doesn't care about the repository at
all, it just needs the "struct config_set" that's in the repository
struct.

With the linked-to change I'm arguing that just mocking it up sucks less
than carrying a duplicate set of API functions just for those rare cases
where we need to one-off read a config file.

But...

> It is a workable solution, e.g. that approach would work around the
> failures in test-tool and scalar that I observed. In the spirit of
> libification, this feels like a kludge, though, since we'd be reverting
> to using "struct repository" for more things instead of using more
> well-scoped interfaces. IMO a better future for the config_set API would
> be to move it into configset.c or something, where only users who want
> the low level API would use it and everyone else would just pretend it
> doesn't exist. This would be a little like libgit2's organization, where
> 'general config', 'config parsing' and 'in-memory config value
> representations' are separate files, e.g.
>
>   https://github.com/libgit2/libgit2/blob/main/src/libgit2/config.h
>   https://github.com/libgit2/libgit2/blob/main/src/libgit2/config_parse.h
>   https://github.com/libgit2/libgit2/blob/main/src/libgit2/config_entries=
.h
>
> I also hesitate to put the config variables on the_repository, because
> in the long term, I think "struct config_reader" can and should be
> purely internal to config.c. But if we start advertising its existence
> via the_repository, that might be an invitation to (ab)use that API and
> make that transition harder.

...yes it's a kludge, but I'd think if you're interested in more
generally fixing it that a better use of time would be to narrowly focus
on those cases where we don't have a "repository" now, i.e. the
configset API users my linked-to patch shows & amends.

Everything else that uses git_config_get_*(), repo_config_get_*() will
either use an already set up "the_repository", or lazily init it, see
the git_config_check_init() API users.

Or, we could have repo_config() and friends not take a "struct
repository", but another config-specific object which has the subset of
the three fields from that struct which it actually needs (config,
gitdir & commondir).

The mocking function I added in the linked-to commit was just a way of
getting to that via the shortest means.

