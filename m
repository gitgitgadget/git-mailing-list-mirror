Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0678EC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 14:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiLTOTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiLTOSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 09:18:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C641C910
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:17:47 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id x22so29477133ejs.11
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NmWJH5ZTfUsxjaOnWwQzFO50TILf5G/crvo2iUbm5eY=;
        b=anpYkphHOjUTW1GwtrcEcI4AQE9ID3A3NfjVU/Binr68+FwXpwZaKUwEhNrB2lZoqo
         xTeK5hKLIosBgvLte3E4ee9sNocdZIsf1uAtUQdb6WAXROpBfMOT/g6a5k/UNXYAqpGS
         OZaoaZP7pKxO85EMai9SHPFt3XzRjjUSzMiJNGlxfyIq1CR2nZS1w/57vg++VQfheyZB
         K4GMw0Oi/HOTvzq83GjrVO0rjW5sxNTs2aIsY4qXVXndBikp7zV/IVU6k8sWZjU375eG
         pjwi7DkhX5qLME2kp7NVtJljtORQE1EV/d19lgL9nX+1rPAImXnX5f6h0iqiLWS+EE2p
         cOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmWJH5ZTfUsxjaOnWwQzFO50TILf5G/crvo2iUbm5eY=;
        b=zFhA7otwjCVs1XcOB+3tJcXSL6w/i+TeG/CWfPu3coKAK4KiEZ1EmCF6gh+dAHwnou
         ypZaQ8qLw+11Jpt8ZomE+GGXsBqPZnc/5gHYZVytx5qLKFhC3SVjpp/h45oabdIFJPPN
         AfZgvzTdLEQXzm33Up9B5+M7ClZ7GKj2v8dH0QEY/i3+kLzbP30J/bdyeoYd+o/UFdLp
         W2WTwN46xxWlxNVcExsqGFV31JAzjwITuAtPla4IuvL8LsAV+E0Mc9pkMKFqF+DKt0AU
         HIIZVj+eG8ZdcV0tTTDagNfJuqv0+0hTkkRhOdb3nShRLEQ4R1BuM5kcdX8qvx4hl4v7
         VsYg==
X-Gm-Message-State: ANoB5pmirRZbq0sSEBVLqVEwoO187jb47rHBL8OYBxj8zK00gHT6G5Jo
        1SYgXGF4JXelHtketO9RYrI=
X-Google-Smtp-Source: AA0mqf6Oil5IeQaJR1PLT97E8BOIL8oiaZbw/acIxIHMMoWiweObdJ6lCJghNt8XFjeFH7jOHvXrFA==
X-Received: by 2002:a17:906:5053:b0:7c1:727f:7c70 with SMTP id e19-20020a170906505300b007c1727f7c70mr31081250ejk.46.1671545865904;
        Tue, 20 Dec 2022 06:17:45 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u4-20020a170906068400b007c0934db0e0sm5802569ejb.141.2022.12.20.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:17:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7dRA-007LLG-2g;
        Tue, 20 Dec 2022 15:17:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ds/omit-trailing-hash-in-index (was: What's cooking in git.git
 (Dec 2022, #06; Sun, 18))
Date:   Tue, 20 Dec 2022 14:45:51 +0100
References: <xmqqh6xtw4uw.fsf@gitster.g>
 <221219.86y1r3zmrv.gmgdl@evledraar.gmail.com>
 <0113fed3-5dca-6a31-9b9d-becd009c2fca@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <0113fed3-5dca-6a31-9b9d-becd009c2fca@github.com>
Message-ID: <221220.86wn6mw453.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Derrick Stolee wrote:

> On 12/19/22 5:49 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Sun, Dec 18 2022, Junio C Hamano wrote:
>>=20
>>> * ds/omit-trailing-hash-in-index (2022-12-17) 4 commits
>>>  - features: feature.manyFiles implies fast index writes
>>>  - test-lib-functions: add helper for trailing hash
>>>  - read-cache: add index.skipHash config option
>>>  - hashfile: allow skipping the hash function
>>>
>>>  Introduce an optional configuration to allow the trailing hash that
>>>  protects the index file from bit flipping.
>>>
>>>  Will merge to 'next'?
>>>  source: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
>>=20
>> I've been following this closely & reviewing it. I think the end-state
>> is probably good, but noted in [1] that the intermediate progression
>> equates bad config with "true", so:
>>=20
>> 	git -c index.skipHash=3Dblahblah status
>>=20
>> Enables it, fixing that is trivial, and probably worth a re-roll.
>
> Fixing it is trivial, but as you say it is correct in the final
> version so I don't think this triviality is worth a re-roll.

I won't insist on it, but I don't think changing behavior in commits
that don't note that the behavior is changing is "triviality". The
inter-state is conflating errors with "was set".

It also suggests that we have a test blind-spot, although in the
end-state that's probably not worth chasing, as we know it's using the
more trusted repo-settings.c code.

I noted in the feedback that I think this would be much easier to read,
review & reason about if it were squashed, as we really only care about
the end-state.

But if you're advocating for adding it piecemeal let's get that right,
and not add a bug in an earlier commit & then remove it in a later
rewrite/refactoring.

>> The "probably" above is then because the patches seemingly try to make
>> this compatible with different config for submodules, but there's no
>> tests for submodule interaction, so that may or may not work.
>>=20
>> Normally we could just trust the "struct repository *" parameter we get,
>> but in this case it's "istate->repo", which (as I showed in the v3
>> feedback[2]) is sometimes NULL.
>
> This, and other feedback you've given around 'struct repository *' values
> makes me think you are not aware of the current state of the submodule
> work.

For better or worse I'm *probably* one of the people most up-to-date on
it, see [1] (the --super-prefix patches currently queued are prep
patches for that).

> I'm also a bit out-of-date, but my understanding is that the
> conversion to stop using the_repository everywhere is only halfway
> complete, which makes it difficult to properly test things with multiple
> 'struct repository *' pointers. However, the best thing we can do is to
> use whatever local repository we have, so we don't contribute further to
> the problem.

...

> The fact that istate->repo is sometimes NULL is a separate issue, but is
> generally unrelated to the subject at hand and should be fixed by another
> topic, not used to block this one.

I noted as an aside that istate->repo is sometimes NULL when it
shouldn't be, and that sucks.

But the comment on your topic is that you are adding new behavior that
relies on the specifics of what "repo" we have in play, so shouldn't we
add tests for those interactions? Or if they're not needed let's note
that and why.

You can tease out those cases with e.g.:
=09
	diff --git a/read-cache.c b/read-cache.c
	index cf87ad70970..dc16167ff35 100644
	--- a/read-cache.c
	+++ b/read-cache.c
	@@ -2436,6 +2436,9 @@ int do_read_index(struct index_state *istate, const =
char *path, int must_exist)
	 	if (!istate->repo)
	 		istate->repo =3D the_repository;
=09=20
	+	if (istate->repo && istate->repo !=3D the_repository)
	+		BUG("read: got istate:%p and tr:%p", (void *)istate->repo, (void *)the_=
repository);
	+
	 	/*
	 	 * If the command explicitly requires a full index, force it
	 	 * to be full. Otherwise, correct the sparsity based on repository
	@@ -2930,6 +2933,9 @@ static int do_write_index(struct index_state *istate=
, struct tempfile *tempfile,
	 	int nr, nr_threads;
	 	struct repository *r =3D istate->repo ? istate->repo : the_repository;
=09=20
	+	if (istate->repo && istate->repo !=3D the_repository)
	+		BUG("write: got istate:%p and tr:%p", (void *)istate->repo, (void *)the=
_repository);
	+
	 	f =3D hashfd(tempfile->fd, tempfile->filename.buf);
=09=20
	 	prepare_repo_settings(r);

The former ("read") hunk will fail a lot of tests (e.g. "git grep
--recurse-submodules"), but I *think* that for "write" they're currently
always the same.

I was just prodding you to clarify that one way or the other, i.e. was
it just for good measure, or was it a change in behavior (in particular
before you re-rolled to have your earlier commit use the "istate->repo"
too).

Now, I *think* it's just for good measure, but then (and I didn't notice
this before) shouldn't the new code you added to do_write_index() to
prepare_repo_settings() also populate "istate->repo"? That's what we
already do in do_read_index(). I.e.:

	diff --git a/read-cache.c b/read-cache.c
	index cf87ad70970..1a622a52036 100644
	--- a/read-cache.c
	+++ b/read-cache.c
	@@ -2928,12 +2928,14 @@ static int do_write_index(struct index_state *ista=
te, struct tempfile *tempfile,
	 	int ieot_entries =3D 1;
	 	struct index_entry_offset_table *ieot =3D NULL;
	 	int nr, nr_threads;
	-	struct repository *r =3D istate->repo ? istate->repo : the_repository;
	+
	+	if (!istate->repo)
	+		istate->repo =3D the_repository;
=09=20
	 	f =3D hashfd(tempfile->fd, tempfile->filename.buf);
=09=20
	-	prepare_repo_settings(r);
	-	f->skip_hash =3D r->settings.index_skip_hash;
	+	prepare_repo_settings(istate->repo);
	+	f->skip_hash =3D istate->repo->settings.index_skip_hash;
=09=20
	 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
	 		if (cache[i]->ce_flags & CE_REMOVE)

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221017T115544Z-ava=
rab@gmail.com/
