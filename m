Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15031FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 15:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiJaPhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiJaPg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 11:36:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9011A32
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 08:36:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z97so17970813ede.8
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WKvJNTQTkmd/aZZo341Kw0hyuFfO5gIfFtI2wLQWcVg=;
        b=MGJ2YtFR0YPd5cDKxsxY7raorJtjXiw8TAcsyyIkQZydYMxMgsvJ9GJBS1kvIKTUcL
         Kz7U1YmlYvLBBeKk4CZxH+Ow9qySwD0NJiCxNcZSgHheRiXHMLQulInQwdeqNA6I3Bc/
         e4Mazry5UazWk5k6RHkrz4mOgZnTQp4ZoUfPEKWBOGRutsKfrAo+NT+ynU7b18rwf9CW
         XEdVTTheMYkwuAth9YSRlxFeIuQOAko83IcXQD391xMRODI8qerGFPgkri5xaz61acn2
         Jpl52xUmAYL5/eLRMeviL2x5yKo8kOTb/QxdkK1tDf8nEu4+JNgtCQ5roT8Z/qNOYJhS
         9DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKvJNTQTkmd/aZZo341Kw0hyuFfO5gIfFtI2wLQWcVg=;
        b=5vh+XpHfish7eRRZcWu8PICIO7FH3aieUp4Ucw0dLRuhxZZdwv0PlojSgZIS3dVSvl
         XfVS/Py18t+oEwoOmJTHQ/ptqwZXPOVLDzy3J68P5tAb0ojFfdMr33ucgs2kUq8wus8O
         yYEKQmIts7D1ovtsEvR7LZCFszmNjVBb0DuaIDxnZ/cC1Uqv/o0LPavpxOTBBKDT6PF5
         u1hI/i8Vq8YbYSENyOcr1HT8mJDO6Xq2RKsDIKL5F0poBPSS3of5rtZIwccHATGn06zG
         g+EhGxgB5sRm9EuMkCeaewLAkz0k+fAzHfTSSmN8r4fWsAzSb/JLi8c52yDoWfEk4O2a
         if3Q==
X-Gm-Message-State: ACrzQf0XI/nbTQz0usUejLupyBCVWb5zzZ3HLLZnP4q5JdlHNMM84+Gn
        AxJXqAmi/bg5o9iJQsq2fJE1M15LBlk=
X-Google-Smtp-Source: AMsMyM66IBBSgJdAu399b12GlM0XXQAOZz9/7wpEd0EU0KNiyjcE7FU1QvbA3NJg7TKNxzxdTC9nvQ==
X-Received: by 2002:a05:6402:1cb0:b0:463:5904:d0fd with SMTP id cz16-20020a0564021cb000b004635904d0fdmr6433620edb.302.1667230606683;
        Mon, 31 Oct 2022 08:36:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k22-20020aa7c396000000b004619c7183d3sm3391203edq.32.2022.10.31.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:36:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opWqD-00AgKJ-2Q;
        Mon, 31 Oct 2022 16:36:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Date:   Mon, 31 Oct 2022 16:36:09 +0100
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <221028.867d0k7yny.gmgdl@evledraar.gmail.com> <Y1/Z7q+56Mu+rmAX@ncase>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1/Z7q+56Mu+rmAX@ncase>
Message-ID: <221031.86h6zk6m42.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> On Fri, Oct 28, 2022 at 05:01:58PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> On Fri, Oct 28 2022, Patrick Steinhardt wrote:
> [sinp]
>> > Unfortunately, this change comes with a performance hit when refs are
>> > not hidden. Executed in the same repository:
>> >
>> >     Benchmark 1: main
>> >       Time (mean =C2=B1 =CF=83):     45.780 s =C2=B1  0.507 s    [User=
: 46.908 s, System: 4.838 s]
>> >       Range (min =E2=80=A6 max):   45.453 s =E2=80=A6 46.364 s    3 ru=
ns
>> >
>> >     Benchmark 2: pks-connectivity-check-hide-refs
>> >       Time (mean =C2=B1 =CF=83):     49.886 s =C2=B1  0.282 s    [User=
: 51.168 s, System: 5.015 s]
>> >       Range (min =E2=80=A6 max):   49.589 s =E2=80=A6 50.149 s    3 ru=
ns
>> >
>> >     Summary
>> >       'main' ran
>> >         1.09 =C2=B1 0.01 times faster than 'pks-connectivity-check-hid=
e-refs'
>> >
>> > This is probably caused by the overhead of reachable tips being passed
>> > in via git-rev-list(1)'s standard input, which seems to be slower than
>> > reading the references from disk.
>> >
>> > It is debatable what to do about this. If this were only about improvi=
ng
>> > performance then it would be trivial to make the new logic depend on
>> > whether or not `transfer.hideRefs` has been configured in the repo. But
>> > as explained this is also about correctness, even though this can be
>> > considered an edge case. Furthermore, this slowdown is really only
>> > noticeable in outliers like the above repository with an unreasonable
>> > amount of refs. The same benchmark in linux-stable.git with about
>> > 4500 references shows no measurable difference:
>>=20
>> Do we have a test that would start failing if we changed the behavior?
>> Perhaps such a test is peeking too much behind the curtain, but if it's
>> easy come up with one I think it would be most welcome to have it
>> alongside this.  to have exposes
>
> We have tests that verify that we indeed detect missing objects in
> t5504. But what we're lacking is tests that verify that we stop walking
> at the boundary of preexisting objects, and I honestly wouldn't quite
> know how to do that as there is no functional difference, but really
> only a performance issue if we overwalked.
>
>> > -static void write_head_info(void)
>> > +static void write_head_info(struct oidset *announced_objects)
>> >  {
>> > -	static struct oidset seen =3D OIDSET_INIT;
>> > -
>> > -	for_each_ref(show_ref_cb, &seen);
>> > -	for_each_alternate_ref(show_one_alternate_ref, &seen);
>> > -	oidset_clear(&seen);
>> > +	for_each_ref(show_ref_cb, announced_objects);
>> > +	for_each_alternate_ref(show_one_alternate_ref, announced_objects);
>> >  	if (!sent_capabilities)
>> >  		show_ref("capabilities^{}", null_oid());
>>=20
>> Nit: The variable rename stands out slightly,
>> i.e. s/&seen/announced_objects/ not s/&seen/seen/, especially as:
>>=20
>> >  static void execute_commands(struct command *commands,
>> >  			     const char *unpacker_error,
>> >  			     struct shallow_info *si,
>> > -			     const struct string_list *push_options)
>> > +			     const struct string_list *push_options,
>> > +			     struct oidset *announced_oids)
>>=20
>> Here we have the same variable, but now it's *_oids, not *objects.
>
> Hm. I think that `announced_oids` is easier to understand compared to
> `seen`, so I'd prefer to keep the rename. But I'll definitely make this
> consistent so we use `announced_oids` in both places.

Sounds good, we'll need to look at the diff lines in either case (as
we're converting it to a pointer), so changing the name while at it is
fine...

> [snip]
>> > +static const struct object_id *iterate_announced_oids(void *cb_data)
>> > +{
>> > +	struct oidset_iter *iter =3D cb_data;
>> > +	return oidset_iter_next(iter);
>> > +}
>> > +
>>=20
>> Is just used as (from 1/2):
>>=20
>> > +	if (opt->reachable_oids_fn) {
>> > +		const struct object_id *reachable_oid;
>> > +		while ((reachable_oid =3D opt->reachable_oids_fn(opt->reachable_oid=
s_data)) !=3D NULL)
>> > +			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(reachable_oid)) < 0)
>> > +				break;
>> > +	}
>>=20
>> After doing above:
>>=20
>> > +	if (oidset_size(announced_oids) !=3D 0) {
>> > +		oidset_iter_init(announced_oids, &announced_oids_iter);
>> > +		opt.reachable_oids_fn =3D iterate_announced_oids;
>> > +		opt.reachable_oids_data =3D &announced_oids_iter;
>> > +	}
>>=20
>> But I don't see the reason for the indirection, but maybe I'm missing
>> something obvious.
>>=20
>> Why not just pass the oidset itself and have connected.c iterate through
>> it, rather than going thorugh this callback / data indirection?
>
> This is done to stay consistent with the way new tips are passed in via
> the `oid_iterate_fn`. I'm happy to change callers to just directly pass
> a `struct oidset *` though.

*nod*, makes sense, no need to change it. Just wondering...
