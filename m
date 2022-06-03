Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F71C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 10:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiFCKrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbiFCKrK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 06:47:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256BAE65
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 03:47:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so9593009edf.11
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0StBg+tEmDov/dPcAAnSTYho4JaIkwDWmhqwjo6+m1o=;
        b=YPFAHoXf1tuk8l7TDyqsP2LoEfVjzypkm+nz9KE7ABPfBFAxfCT7oN8MMqgL9XGcnN
         HTETiMGiNCiCN2pRF9V2TBF7TsEAx6p1DchuXvRBoq8kuw+rH7OJQe8xPpQF86y+ix9M
         M/RuxrrQ8NQ6goQzgpwS2jQmvGq81kqbJAJMSL5G9ykWvmZFNSoJQ752OhTNZPdtRS8A
         VB+NZQCa1338AE0K3TXMrrUmfTLslczFOv4IAXlJeGaZzywXqfhkA3Z4ShFSoD8BDsym
         TuUZlC3K7ls0YkNhddbZZpA95OlhtqKD/p467dF0zs7MJCkIySQbqWvd/KrTW9FMy8BL
         xeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0StBg+tEmDov/dPcAAnSTYho4JaIkwDWmhqwjo6+m1o=;
        b=pZnCmJvPM9c3hrN/dVtibLwhK9oIIF7hobcUfe3uvnmpSUKwsuI6jsRCfni28An+fp
         p2DM5SjEfP9tzof/89yCnPCb+sVIBmpVKVoULaPX++mJlqOwSvANAAmdiTmmdVt8qf4x
         H9ME1u1wP4FxdFx+JVJoorY+4g+N0EJ/KCbfy3y/Q3vnyVDupXp/OcKnYpbNG+ENT04z
         agbe1LEGsd4CriwWTyEPqcbPJnwVWERzkB6mWVQcY7LpN/vCws7LLL7s0WgOgbk/yuMh
         3L2qFjLgIrZmKztzfZNkHBfSBwwl0EzIYvuocMWurQ6qhEytT0M8uoAxhsAmRYjGfklU
         0LTA==
X-Gm-Message-State: AOAM532abz7bUBxRzzoaxMTAZJLtq78YI6eiFHXklErZRPPLwVo3kuNH
        Em8ec9uOXVEv9OhsqIiNxb0=
X-Google-Smtp-Source: ABdhPJxS6nkKELPHSh5GwTzLYAWugpuw8giSHWgi+rU0SAvEBsDQHRLymgRI6kLSkDIbsLPLv9Pbbg==
X-Received: by 2002:a05:6402:2925:b0:42d:d019:1716 with SMTP id ee37-20020a056402292500b0042dd0191716mr10118539edb.110.1654253224405;
        Fri, 03 Jun 2022 03:47:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o7-20020a50fd87000000b0042dc25fdf5bsm3707934edt.29.2022.06.03.03.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 03:47:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nx4pb-001clM-3t;
        Fri, 03 Jun 2022 12:47:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Integrate Scalar into the CI builds
Date:   Fri, 03 Jun 2022 12:36:42 +0200
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
 <d0448d28-b33c-3f42-901d-3cd7f4201c78@github.com>
 <220602.865yljywtf.gmgdl@evledraar.gmail.com>
 <d59b51fb-029f-8232-9dd8-2f7f1b410aa7@github.com>
 <nycvar.QRO.7.76.6.2206031147220.349@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2206031147220.349@tvgsbejvaqbjf.bet>
Message-ID: <220603.86bkvaxbvc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 03 2022, Johannes Schindelin wrote:

> Hi Stolee,
>
> On Thu, 2 Jun 2022, Derrick Stolee wrote:
>
>> On 6/2/2022 10:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >
>> > On Thu, Jun 02 2022, Derrick Stolee wrote:
>> >
>> >> On 6/2/2022 5:05 AM, Johannes Schindelin via GitGitGadget wrote:
>> >>> Note that the changes to the GitHub workflow are somewhat transient =
in
>> >>> nature: Based on the feedback I received on the Git mailing list, I =
see some
>> >>> appetite for turning Scalar into a full-fledged top-level command in=
 Git,
>> >>> similar to gitk. Therefore my current plan is to do exactly that in =
the end
>> >>> (and I already have patches lined up to that end). This will essenti=
ally
>> >>> revert the ci/run-build-and-tests.sh change in this patch series.
>> >>
>> >> I expect that this won't be a full remote, since we will still want to
>> >> exclude Scalar from the build without INCLUDE_SCALAR enabled.
>
> We had this `INCLUDE_SCALAR` condition in microsoft/git for a while but
> since I got the sense that many regulars were in favor of treating
> `scalar` like a top-level command (similar to `gitk`), I've since changed
> the over-all course to compiling it unconditionally.
>
> The only remnant is the CMake definition, and only in the transitory phase
> while Scalar is still in `contrib/scalar/`, and only because I could not
> find a better way to encapsulate it.
>
> But yes, if we decide to go with the `INCLUDE_SCALAR` approach, it won't
> be a full remove/revert.
>
>> > Scalar (well, scalar.o, not scalar the binary) has been included in the
>> > default build (including CI) for a while now.
>>
>> I'm talking about scalar the binary being important. I'm glad that
>> scalar.o has been built already.
>
> These are the raw logs of the `linux-gcc` job of the most recent CI build
> of `seen`, as of time of writing:
>
> https://github.com/git/git/commit/7f1978ce8bfe41074df4fc96ff7f2a28e5807fd=
1/checks/6718714644/logs
>
> When I download those logs and then let my browser search for the term
> "scalar", it comes up empty, even if, say, "range-diff.o" is found. Which
> is exactly according to my plan: no part of Scalar is to be built unless
> explicitly asked for.
>
> The only job that touches it is the `static-analysis` job, which is a bit
> unfortunate. But I cannot justify the complexity of the patch it would
> take to address that.
>
> In other words: The statement that `scalar.o` is included in the default
> build, without any qualifying note about `static-analysis`, is quite
> misleading.

As the person making that claim: Yes that is really misleading, sorry.

I was under the false recollection that since we added it to $(OBJECTS)
we built it by default, as in "make" was building it.

It *is* of course built my "make objects" etc., but due to how our
dependency tree works not to create "git", or even "libgit.a" (the
dependency relationship there being the other way around).

But an you point out (and I'd missed this, but it make sense in
retrospect) I was (accidentally!) right in the "CI" part of that since
we're including it in "make sparse", which is because we create *.sp
files from everything we have a *.o for.

As an aside re the "justify the complexity" the patch to "fix" that
would be rather trivial:

	diff --git a/Makefile b/Makefile
	index 18ca6744a50..aae16d140a5 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -2966,7 +2966,7 @@ t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(G=
ITLIBS) $(REFTABLE_TEST_LIB)
	 check-sha1:: t/helper/test-tool$X
	 	t/helper/test-sha1.sh
=09=20
	-SP_OBJ =3D $(patsubst %.o,%.sp,$(C_OBJ))
	+SP_OBJ =3D $(patsubst %.o,%.sp,$(filter-out $(SCALAR_OBJECTS),$(C_OBJ)))
=09=20
	 $(SP_OBJ): %.sp: %.c %.o
	 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \

But (and I've noted this before) I think the better fix is to just
properly integrate scalar.

We (accidentally) have been building it by default, which the patches to
integrate it sought to explictly avoid to avoid bothering anyone.

But ... nobody's been bothered, so I think if anything this should be a
data point suggesting that we're being overly careful in this case.

I.e. that we don't need the many intermediate steps of adding
special-cases to various components, when there seems to be unanimous
agreement on the end-goal. Can't we just skip to that already?

:)
