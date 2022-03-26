Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98203C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 00:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiCZBAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 21:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiCZBAk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 21:00:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580CA496BD
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:59:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h4so3202465edr.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yzJkCknHe42c51oePBS5RncL4GMvnudowfXY4nEGw8U=;
        b=oY8nMbkd4nhhLA/zhw8rM8wXbQfTPsXeqEOmmqgwKtqoakIqHPPZ71flujBkCMlKwq
         EcyS6MhxPUxg2vH4X2o5ApaX77lJeZwDpEh3tL6L0t4hWk895nD0zFf+mG1GCG7//JCj
         nBsNDZhFVl9Vzt2YFrwpsJFrMVQLRQoH5mSDahMqrcsbsCYwo8MIZGPBdfShcJEShe3p
         CGTM9Pk2L0dmYpdOBgvkQpqHlVIHUaO1UxjIQXVBJ6O5z0lsgFZFkbpaao3LWZ2i+EYK
         kzXt1O2zYDkH9QiL5eL2qc4L7bQ+Gm0b/qwMLgr/rJ5c1lTrD5F86R8krHY/Vptu2OcV
         hmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yzJkCknHe42c51oePBS5RncL4GMvnudowfXY4nEGw8U=;
        b=U2q4nk8rahxVS5uU35XuLm3ulpmn8cf6odfZnVT/m9HpsFC4vwnv9iKXmGPNrqp6Is
         7hIc/eZPYi3Gc9RY9oRJkzERqKUjZbBPltReN06rzPdyayG+d93u2CN9fYx8UlKrTxjd
         E8vdtR7rmVXNzVkXMK8CuPaL2Z9h6KS0FjBW74RyRvljuh+Lr3f6hX66Wq/PW2fTCaY/
         fGoZp758Gmq47Ii0XsK0gTmIouQUhclp4p2iE5Dm1xcTblSZhHjjLMrcEA4YhCu+3W+F
         Ihzen606rbSDwxHBWymstwnvK1AirRG03iXLfG+ya+5ETpUPHTIYHCRo5o31SXtWuHVu
         4iDA==
X-Gm-Message-State: AOAM530QvNQHzIiiOkmRerWdVNnm+4RLgzFgaQqIIhJrX6/DHpDQ90xZ
        RP9OqUPIYeUU1KJFZmAAeXM=
X-Google-Smtp-Source: ABdhPJzqpWywCchO5tQ4APQ6f23mnNL5Vgx2ox+d2eScZUkZRM4eUIy1wC3Xvw5NaWeyRTvTJOgP7Q==
X-Received: by 2002:a50:99cd:0:b0:418:d6c2:2405 with SMTP id n13-20020a5099cd000000b00418d6c22405mr1713975edb.342.1648256342712;
        Fri, 25 Mar 2022 17:59:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm24-20020a170906c05800b006d58518e55fsm2884173ejb.46.2022.03.25.17.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 17:59:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXulh-002KVC-F1;
        Sat, 26 Mar 2022 01:59:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Date:   Sat, 26 Mar 2022 01:52:42 +0100
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
 <d71fa968-be75-f4ad-ea6c-644f9d2b52d9@github.com>
 <220325.86r16qkodl.gmgdl@evledraar.gmail.com>
 <8d368240-dae5-7a66-6c0c-9e0a960ca34c@github.com>
 <220325.86mthdlx59.gmgdl@evledraar.gmail.com>
 <d90bb9c8-3155-ca5f-8363-154876a7ad0a@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <d90bb9c8-3155-ca5f-8363-154876a7ad0a@github.com>
Message-ID: <220326.865yo1leay.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Derrick Stolee wrote:

> On 3/25/2022 1:34 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Mar 25 2022, Derrick Stolee wrote:
>>=20
>>> On 3/25/2022 12:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>> +struct rev_info_maybe_empty {
>>>>> +	int has_revs;
>>>>> +	struct rev_info revs;
>>>>> +};
>>>
>>> Thinking about this a second time, perhaps it would be best to add
>>> an "unsigned initialized:1;" to struct rev_info so we can look at
>>> such a struct and know whether or not repo_init_revisions() has
>>> been run or not. Avoids the custom struct and unifies a few things.
>>>
>>> In particular, release_revisions() could choose to do nothing if
>>> revs->initialized is false.
>>=20
>> This plan won't work because that behavior is both undefined per the
>> standard, and something that's wildly undefined in practice.
>>=20
>> I.e. we initialize it on the stack, so it'll point to uninitialized
>> memory, sometimes that bit will be 0, sometimes 1...
>>=20
>> If you mean just initialize it to { 0 } or whatever that would work,
>> yes, but if we're going to refactor all the callers to do that we might
>> as well refactor the few missing bits that would be needed to initialize
>> it statically, and drop the dynamic by default initialization...
>
> Yes, I was assuming that we initialize all structs to all-zero,
> but the existing failure to do this will cause such a change too
> large for this issue.

I don't see how that wouldn't be a regression on the upthread patch in
the sense that yes, we could of course initialize it, but the whole
point of not doing so was to have our tooling detect if the downstream
code assumed it could start using a struct member we hadn't filled in.

By initializing it we'll never know.

But yes, if you consider that a non-goal then init to "{ 0 }" makes the
most sense.

>> But FWIW I think a much more obvious thing to do overall would be to
>> skip the whole "filter bust me in rev_info" refactoring part of your
>> series and just add a trivial list_objects_filter_copy_attach() method,
>> or do it inline with memcpy/memset.
>>=20
>> I.e. to not touch the "filter" etc. callback stuff at all, still pass it
>> to get_object_list(). Can't 2/5 and 3/5 in your series be replaced by
>> this simpler and smaller change?:
>
>> 	-	list_objects_filter_copy(&revs.filter, &filter_options);
>> 	+	/* attach our CLI --filter to rev_info's filter */
>> 	+	memcpy(&revs.filter, filter, sizeof(*filter));
>> 	+	memset(filter, 0, sizeof(*filter));
>
> Here, you are removing a deep copy with a shallow copy. After this,
> freeing the arrays within revs.filter would cause a double-free when
> freeing the arrays in the original filter_options.

Yes, and that's what we want, right? I.e. we don't want a copy, but to
use the &filter for parse_options(), then once that's populated we
shallow-copy that to "struct rev_info"'s "filter", and forget about our
own copy (i.e. the memset there is redundant, but just a "let's not use
this again) marker.

Of course this will leak now, but once merged with my
release_revisions() patch will work, and we'll free what we allocated
(once!).

> If you went this way, then you could do a s/&filter_options/filter/
> in the existing line.
>
>> 	 	/* make sure shallows are read */
>> 	 	is_repository_shallow(the_repository);
>> 	@@ -3872,6 +3873,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
>> 	 	int rev_list_index =3D 0;
>> 	 	int stdin_packs =3D 0;
>> 	 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
>> 	+	struct list_objects_filter_options filter_options =3D { 0 };
>> 	 	struct option pack_objects_options[] =3D {
>> 	 		OPT_SET_INT('q', "quiet", &progress,
>> 	 			    N_("do not show progress meter"), 0),
>> 	@@ -4154,7 +4156,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
>> 	 	} else if (!use_internal_rev_list) {
>> 	 		read_object_list_from_stdin();
>> 	 	} else {
>> 	-		get_object_list(rp.nr, rp.v);
>> 	+		get_object_list(rp.nr, rp.v, &filter_options);
>> 	 	}
>> 	 	cleanup_preferred_base();
>> 	 	if (include_tag && nr_result)
>>=20
>> And even most of that could be omitted by not removing the global
>> "static struct" since pack-objects is a one-off anyway ... :)
>
> Even if you fix the deep/shallow copy above, you still need to
> clean up the filter in two places.

If you "fix" the shallow copying you need to free it twice, but if you
don't you free it once.

I.e. this is conceptually the same as strbuf_detach() + strbuf_attach().

But maybe I'm missing something...

(If I am it's rather worrying that it passed all our tests, both in your
series + merged with the release_revisions() series).
