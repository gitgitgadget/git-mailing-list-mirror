Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23136C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 16:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376539AbiCYQId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376771AbiCYQIa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 12:08:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10519AD134
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 09:06:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dr20so16288004ejc.6
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SkYcEF7F6wQmaUUBxprhVd8L2AP3USiX2IApBCqLSLg=;
        b=lk+zhu78F04yVuDYoelwFqN2qoXcaTrF0P1EvXFap/P4c/p2g4yaNamqrRt9ObMwHI
         KqUe9Fq2L+9tNq+8AQgnidUKqxnVw6+tIYjFo7cFVtmZNcWnqe6gX+wmn3aQ4z4e7gwb
         zRuiyBn7EheR48Os1TT/j59VlvR9I+TwfDJcKq0oGJ+7sYTRy4XFAPM8LjHzXxNqoh32
         8me4E3moJWdnqeyeaTUyb92Z+j5FkTOqnwJETtISOI6Meb+9amF2XlIRVmq1/mAQeeFL
         CCFi3m66u3LGbWNHt1YH5xXyAC1KK/v5FasZzjpPxbzA684rZ9I5f4U1YEqXPcKtX7RT
         muCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SkYcEF7F6wQmaUUBxprhVd8L2AP3USiX2IApBCqLSLg=;
        b=ksrDhyjHpgsLJIZ4hu3m6YSiQ21fRu2yFDYRYfBqEbmfUlYGsY7q0cc9XNtjswuOBh
         vvLxJdNkO2bb2D9+FHRj8xDWryrodS+mAPNr58d+AQlOBFeL5b7lrzPGtUWwHp9H8bYu
         yxkKmMcZYBv7V+VJUezqh05xxu9i71jld0Y+U4cQzeGVnRkWnh8OUAgrUEbk2xzwYvFr
         82h9HJALEZYhhh0QIZTc+TxZv+W7YHk+Nw9BdBm01UrQQ8KYlzj2NB7mXjFtvqyKzGnr
         jMtuJquH132O4eCm3HZA0AMLB+rOQnITZzyTRaJQbyGrgdzI5eMwBMWgLQ+enL8ZfX3/
         G8cQ==
X-Gm-Message-State: AOAM532xcDT+nDZdHMCzr049TWL+fPgONQXUaNSgEaj9JiL+zlWDjbSB
        lXU4EuCfepnhNvwxDi/CQ4Q=
X-Google-Smtp-Source: ABdhPJx4zf9RC9ns/IyjJWjG0zFx75Ub2BVRQ2USC8Dk2RPAYM4J+waLLLjyie/0yktA109qHEUjNg==
X-Received: by 2002:a17:907:a41f:b0:6d6:f925:1696 with SMTP id sg31-20020a170907a41f00b006d6f9251696mr12637393ejc.62.1648224408276;
        Fri, 25 Mar 2022 09:06:48 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a5-20020aa7cf05000000b0041919e52a38sm2961404edy.46.2022.03.25.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 09:06:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXmSc-0023uX-5A;
        Fri, 25 Mar 2022 17:06:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Date:   Fri, 25 Mar 2022 17:00:14 +0100
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
 <d71fa968-be75-f4ad-ea6c-644f9d2b52d9@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <d71fa968-be75-f4ad-ea6c-644f9d2b52d9@github.com>
Message-ID: <220325.86r16qkodl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Derrick Stolee wrote:

> On 3/25/2022 10:25 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> In the preceding [1] (pack-objects: move revs out of
>> get_object_list(), 2022-03-22) the "repo_init_revisions()" was moved
>> to cmd_pack_objects() so that it unconditionally took place for all
>> invocations of "git pack-objects".
>>=20
>> We'd thus start leaking memory, which is easily reproduced in
>> e.g. git.git by feeding e83c5163316 (Initial revision of "git", the
>> information manager from hell, 2005-04-07) to "git pack-objects";
>>=20
>>     $ echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects=
 initial
>>     [...]
>> 	=3D=3D19130=3D=3DERROR: LeakSanitizer: detected memory leaks
>>=20
>> 	Direct leak of 7120 byte(s) in 1 object(s) allocated from:
>> 	    #0 0x455308 in __interceptor_malloc (/home/avar/g/git/git+0x455308)
>> 	    #1 0x75b399 in do_xmalloc /home/avar/g/git/wrapper.c:41:8
>> 	    #2 0x75b356 in xmalloc /home/avar/g/git/wrapper.c:62:9
>> 	    #3 0x5d7609 in prep_parse_options /home/avar/g/git/diff.c:5647:2
>> 	    #4 0x5d415a in repo_diff_setup /home/avar/g/git/diff.c:4621:2
>> 	    #5 0x6dffbb in repo_init_revisions /home/avar/g/git/revision.c:1853=
:2
>> 	    #6 0x4f599d in cmd_pack_objects /home/avar/g/git/builtin/pack-objec=
ts.c:3980:2
>> 	    #7 0x4592ca in run_builtin /home/avar/g/git/git.c:465:11
>> 	    #8 0x457d81 in handle_builtin /home/avar/g/git/git.c:718:3
>> 	    #9 0x458ca5 in run_argv /home/avar/g/git/git.c:785:4
>> 	    #10 0x457b40 in cmd_main /home/avar/g/git/git.c:916:19
>> 	    #11 0x562259 in main /home/avar/g/git/common-main.c:56:11
>> 	    #12 0x7fce792ac7ec in __libc_start_main csu/../csu/libc-start.c:332=
:16
>> 	    #13 0x4300f9 in _start (/home/avar/g/git/git+0x4300f9)
>>=20
>> 	SUMMARY: LeakSanitizer: 7120 byte(s) leaked in 1 allocation(s).
>> 	Aborted
>>=20
>> Narrowly fixing that commit would have been easy, just add call
>> repo_init_revisions() right before get_object_list(), which is
>> effectively what was done before that commit.
>>=20
>> But an unstated constraint when setting it up early is that it was
>> needed for the subsequent [2] (pack-objects: parse --filter directly
>> into revs.filter, 2022-03-22), i.e. we might have a --filter
>> command-line option, and need to either have the "struct rev_info"
>> setup when we encounter that option, or later.
>>=20
>> Let's just change the control flow so that we'll instead set up the
>> "struct rev_info" only when we need it. Doing so leads to a bit more
>> verbosity, but it's a lot clearer what we're doing and why.
>
> This makes sense.
>
>> We could furthermore combine the two get_object_list() invocations
>> here by having repo_init_revisions() invoked on &pfd.revs, but I think
>> clearly separating the two makes the flow clearer. Likewise
>> redundantly but explicitly (i.e. redundant v.s. a "{ 0 }") "0" to
>> "have_revs" early in cmd_pack_objects().
>
> I disagree, especially when you later want to make sure we free
> the data from revs using your release_revisions().

Because we'll need two release_revisions() instead of one?

>> This does add the future constraint to opt_parse_list_objects_filter()
>> that we'll need to adjust this wrapper code if it looks at any other
>> value of the "struct option" than the "value" member.
>
> So we are coupling ourselves to the implementation of this method.

Sure, but aren't all OPT_* where the macro is providing some custom
callback coupling themselves to how it's implemented?

>> But that regression should be relatively easy to spot. I'm
>> intentionally not initializing the "struct wrap" with e.g. "{ 0 }" so
>> that various memory sanity checkers would spot that, we just
>> initialize the "value" in po_filter_cb(). By doing this e.g. we'll die
>> on e.g. this test if we were to use another member of "opt" in
>> opt_parse_list_objects_filter()>
>
> So you are using uninitialized memory as a way to discover any
> necessary changes to that coupling. I'm not sure this is super-safe
> because we don't necessarily run memory checkers during CI builds.
>
> I'd rather have a consistently initialized chunk of data that would
> behave predictably (and hopefully we'd discover it is behaving
> incorrectly with that predictable behavior).

I'd like to keep this as-is, i.e. if you zero it out it might also
behave unpredictably or even in undefined ways (e.g. a NULL ptr
dereference). Likewise in my version, but it has the benefit of being
caught by some tooling we have.

>> +struct po_filter_data {
>> +	unsigned have_revs:1;
>> +	struct rev_info revs;
>> +};
>> +
>> +static int po_filter_cb(const struct option *opt, const char *arg, int =
unset)
>> +{
>> +	struct po_filter_data *data =3D opt->value;
>> +	struct option wrap; /* don't initialize! */
>> +
>> +	repo_init_revisions(the_repository, &data->revs, NULL);
>> +	wrap.value =3D &data->revs.filter;
>> +	data->have_revs =3D 1;
>> +
>> +	return opt_parse_list_objects_filter(&wrap, arg, unset);
>> +}
>
> The coupling here is unfortunate, but unavoidable. The future-proof
> way to do it would be to modify opt->value and pass the rest of its
> members as-is, but it's marked const so that's not an option.

We could always cast it..., but that would probably be more nasty.

> One way to help make this coupling more obvious would be to move
> this method into list-filter-options.c so we can have their
> implementations adjacent and even refer to them.
>
> Here is a potential version that looks like that:
>
> --- >8 ---
>
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index f02d8df142..55c7131814 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -281,6 +281,10 @@ void parse_list_objects_filter(
>  		die("%s", errbuf.buf);
>  }
>=20=20
> +/*
> + * If you change this to use any member in 'opt' other than 'value',
> + * then be sure to update opt_parse_list_objects_filter_in_revs().
> + */
>  int opt_parse_list_objects_filter(const struct option *opt,
>  				  const char *arg, int unset)
>  {
> @@ -293,6 +297,18 @@ int opt_parse_list_objects_filter(const struct optio=
n *opt,
>  	return 0;
>  }
>=20=20
> +int opt_parse_list_objects_filter_in_revs(const struct option *opt,
> +					  const char *arg, int unset)
> +{
> +	struct rev_info_maybe_empty *ri =3D opt->value;
> +	struct option wrap =3D { .value =3D &ri->revs.filter };
> +
> +	repo_init_revisions(the_repository, &ri->revs, NULL);
> +	ri->has_revs =3D 1;
> +
> +	return opt_parse_list_objects_filter(&wrap, arg, unset);
> +}
> +
>  const char *list_objects_filter_spec(struct list_objects_filter_options =
*filter)
>  {
>  	if (!filter->filter_spec.nr)
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index 90e4bc9625..cf8b710a76 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -106,6 +106,8 @@ void parse_list_objects_filter(
>=20=20
>  int opt_parse_list_objects_filter(const struct option *opt,
>  				  const char *arg, int unset);
> +int opt_parse_list_objects_filter_in_revs(const struct option *opt,
> +					  const char *arg, int unset);
>=20=20
>  #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
>  	OPT_CALLBACK(0, "filter", fo, N_("args"), \
> diff --git a/revision.h b/revision.h
> index 5bc59c7bfe..95aa3ee891 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -329,6 +329,11 @@ struct rev_info {
>  	struct tmp_objdir *remerge_objdir;
>  };
>=20=20
> +struct rev_info_maybe_empty {
> +	int has_revs;
> +	struct rev_info revs;
> +};
> +
>  int ref_excluded(struct string_list *, const char *path);
>  void clear_ref_exclusion(struct string_list **);
>  void add_ref_exclusion(struct string_list **, const char *exclude);
>
> --- >8 ---
>
>
>> +	} else if (pfd.have_revs) {
>> +		get_object_list(&pfd.revs, rp.nr, rp.v);
>>  	} else {
>> +		struct rev_info revs;
>> +
>> +		repo_init_revisions(the_repository, &revs, NULL);
>>  		get_object_list(&revs, rp.nr, rp.v);
>>  	}
>
> Here, I think it would be better to have
>
> 	else {
> 		if (!pfd.have_revs) {
> 			repo_init_revisions(the_repository, &pfd.revs, NULL);
> 			pfd.have_revs =3D 1;
> 		}
> 		get_object_list(&pfd.revs, rp.nr, rp.v);
> 	}

Conceptually I think the saving of that one line isn't worth it to the
reader.

Then you'd need to read up and see exactly how pfd.revs gets mutated,
and its callback etc., only to see we're just doing this to save
ourselves a variable deceleration and a call to release_revisions().

> and then later you can add
>
> 	if (pfd.have_revs)
> 		release_revisions(&pfd.revs);
>
> to clear the memory in exactly one place.

Yeah, it would work. I'd just prefer control flow that's trivial to
reason about over saving a couple of lines here.
