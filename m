Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27964C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhLTTqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhLTTqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:46:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5103C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:46:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so14256605edd.8
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JXU24KStW+7wp1TNoWbqUWBHDGGjEU3yfBwShhGuGmg=;
        b=ejOjXeO9J1At1fGvXOD8dwCK5w/rOku9iEKGLthaW9Q62qhDRkqlpZLNOYV6BBHXKW
         bZKvvQ7zmwEYFZdsx1gGF7wp6YYTbwhvQElg/hRMlOMcyy3bWw4TTRlt1DUie6WnOsl1
         rvcgVLV2BCZDuV5AW1t9ZBa9krfmWGvxhTJI6HP20yGebAEOWq+ftXMMIIEnyBwTcFSp
         mcz7WrGQG/O1asgxRM/q6WSD0EuYnX+UrcDr6v8MBzEIVEXWUS3V7zOAqven/cahApVk
         90CRYd64PkTQ4UqKzfks4vyazNt9cu/FIXPaLErURNwQ9neXHvHMoCbUX4ympfE0wejw
         OOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JXU24KStW+7wp1TNoWbqUWBHDGGjEU3yfBwShhGuGmg=;
        b=Z236xqFiTK9+s7Ojsk/J2536045lkPricVeRob5pemTA2ta/QKNHveWC/JvruTQe4e
         /QYIECJKZM3gQQM4oK2CkCOvG6V/ft3qQVLmpc7usCOwZy1y6A9QzmpVU89popFk3iF3
         uc96TvROgAQa19tinv7IMPN8qse/OhjMCZE1Z2I9xxReCSyqGSXPhJCPQVNhrbfWNDa+
         f41tiKavxADNDkkx0omQ23F4hnPsocUNenJtUm9u+03GHm2+tUU2nZwDFhsiWNIml7QE
         V7Bym4fiTc8MPI4mT0qzF7xLrvIOP+zKWhPSqkGuQqo2SharYZIX1xg2JQ99ik0kmTam
         WENw==
X-Gm-Message-State: AOAM532ajDbwQotnzoU99EJLBw/AH0Ozlisal842mOeMKEBiEMBAHvb7
        pb2fqA7aviQmiU0gmRlOOBc=
X-Google-Smtp-Source: ABdhPJxghaUj6qT2o0jvFJ66G0vsrI2pnXf4i6eSnYhvtx6F/Izs4LkrzNsft3/tIxAOjjcaHHX9Pw==
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr13365371ejc.765.1640029600142;
        Mon, 20 Dec 2021 11:46:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a3sm5717867ejd.16.2021.12.20.11.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:46:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzOcJ-000Xww-4O;
        Mon, 20 Dec 2021 20:46:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
Date:   Mon, 20 Dec 2021 20:35:43 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
 <211220.86pmprutbz.gmgdl@evledraar.gmail.com>
 <289f525b-93b8-6f33-e0fc-3b24fa8a54ea@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <289f525b-93b8-6f33-e0fc-3b24fa8a54ea@jeffhostetler.com>
Message-ID: <211220.86ilvjt5y8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Jeff Hostetler wrote:

> On 12/20/21 11:31 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Use a 'char *' to hold the thread name rather than a 'struct strbuf'.
>>> The thread name is set when the thread is created and should not be
>>> be modified afterwards.  Replace the strbuf with an allocated pointer
>>> to make that more clear.
>>>
>>> This was discussed in: https://lore.kernel.org/all/xmqqa6kdwo24.fsf@git=
ster.g/
>>>...
>>> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
>>> index 7da94aba522..cd8b9f2f0a0 100644
>>> --- a/trace2/tr2_tls.c
>>> +++ b/trace2/tr2_tls.c
>>> @@ -35,6 +35,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const ch=
ar *thread_name,
>>>   					     uint64_t us_thread_start)
>>>   {
>>>   	struct tr2tls_thread_ctx *ctx =3D xcalloc(1, sizeof(*ctx));
>>> +	struct strbuf buf_name =3D STRBUF_INIT;
>>>     	/*
>>>   	 * Implicitly "tr2tls_push_self()" to capture the thread's start
>>> @@ -47,12 +48,13 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const =
char *thread_name,
>>>     	ctx->thread_id =3D tr2tls_locked_increment(&tr2_next_thread_id);
>>>   -	strbuf_init(&ctx->thread_name, 0);
>>>   	if (ctx->thread_id)
>>> -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
>>> -	strbuf_addstr(&ctx->thread_name, thread_name);
>>> -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
>>> -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
>>> +		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
>>> +	strbuf_addstr(&buf_name, thread_name);
>>> +	if (buf_name.len > TR2_MAX_THREAD_NAME)
>>> +		strbuf_setlen(&buf_name, TR2_MAX_THREAD_NAME);
>>> +
>>> +	ctx->thread_name =3D strbuf_detach(&buf_name, NULL);
>>>     	pthread_setspecific(tr2tls_key, ctx);
>>>=20=20=20
>>>..
>>> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
>>> index a90bd639d48..d968da6a679 100644
>>> --- a/trace2/tr2_tls.h
>>> +++ b/trace2/tr2_tls.h
>>> @@ -9,7 +9,7 @@
>>>   #define TR2_MAX_THREAD_NAME (24)
>>>     struct tr2tls_thread_ctx {
>>> -	struct strbuf thread_name;
>>> +	char *thread_name;
>>>   	uint64_t *array_us_start;
>>>   	size_t alloc;
>>>   	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
>> Junio's suggestion in the linked E-Mail was to make this a "const
>> char *".
>
> Yes, it was.  To me a "const char *" in a structure means that
> the structure does not own the pointer and must not free it.
> Whereas as "char *" means that the structure might own it and
> should maybe free it when the structure is freed.  My usage here
> is that the structure does own it (because it took it from the
> temporary strbuf using strbuf_detach()) and so it must free it.
> Therefore it should not be "const".  This has nothing to do with
> whether or not we allow the thread name to be changed after the
> fact.  (We don't, but that is a different issue).

We use the pattern of having a "const char *" that's really a "char *"
with a cast to free() in many existing APIs for this scenario.

Maybe the cast for free would be more correct here, see my recent
9081a421a6d (checkout: fix "branch info" memory leaks, 2021-11-16) & the
discussion it referencese. I.e. in that case we didn't go for the
"free((char *)ptr)" cast as it was a private API.

>> Narrowly, I don't see why not just add a "const" to the "struct
>> strbuf
>> *" instead.
>
> Adding "const" to a strbuf would be wrong in this case, since the
> structure owns the strbuf and needs to strbuf_release the contained
> buffer and (now) free the strbuf pointer, right?
>
> This also makes things confusing -- all callers of tr2tls_create_self()
> would now be responsible for allocating a strbuf to pass in -- and who
> would own those.  This would also create opportunities for mistakes if
> they pass in the address of a stack-based strbuf, right?
>
> This is being used to initialize thread-based data, so the caller
> can't just use a "function local static" or a "global static" strbuf.

Right, I meant that in the context of who/where you'd have your casts.

>> But less narrowly if we're not going to change it why malloc a new
>> one
>> at all? Can't we just use the "const char *" passed into
>> tr2tls_create_self(), and for the "th%02d:" case have the code that's
>> formatting it handle that case?
>> I.e. have the things that use it as a "%s" now call a function that
>> formats things as a function of the "ctx->thread_id" (which may be 0)
>> and limit it by TR2_MAX_THREAD_NAME?
>>=20
>
> This would be less efficient, right?  That thread name is included in
> *EVERY* _perf and _event message emitted.  If we were to change the
> design to have basically a callback to get the formatted value based
> on the `ctx` or `cts->thread_id` and dynamically formatting the name,
> then we would have to hit that callback once (or twice) for every Trace2
> message, right?  That would be much slower than just having a fixed
> string (formatted when the thread is created) that we can just use.
> And even if we said that the callback could cache the result (like
> we do when we lookup env vars), where would it cache it?  It would have
> to cache it in the `ctx`, which is where it currently is and without
> any of the unnecessary overhead, right?

Aren't we per
https://lore.kernel.org/git/211220.86czlrurm6.gmgdl@evledraar.gmail.com/
doing a lot of that formatting (and sometimes allocation) anyway in a
way that's easily avoidable for the "perf" backend?

And for tr2_tgt_event.c we'll call jw_object_string(), which calls
append_quoted_string() for each event. That'll be re-quoting (presumably
always needlessly) the thread_name every time.

So just deferring a single strbuf_addf() doesn't seem like it would slow
things down.

> I think you're assuming that callers of `tr2tls_create_self()` always
> pass a literal string such that that string value is always safe to
> reference later.  Nothing would prevent a caller from passing the
> address of a stack buffer.  It is not safe to assume that that string
> pointer will always be valid, such as after the thread exits.  It is
> better for _create_self() to copy the given string (whether we format
> it immediately or not) than to assume that the pointer will always be
> valid, right?

Sure, if that's the API we can xstrdup() it, and/or xstrfmt() it etc. as
we're doing now.

> So I don't think we should deviate from the patch that I submitted.

I'm not saying anything needs to change here, these were really just
read-through suggestion, but I think per the above (about the casts &
optimization) that some of your assumptions here may not hold.
