Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD7BC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B970613E7
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJMGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:06:41 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:36549 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJMGl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 08:06:41 -0400
Received: by mail-ej1-f42.google.com with SMTP id a11so43064266ejf.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=C/cTkt1/e5PWurSqWftpBR3fWpp9oOmSI5r6UmyKZD0=;
        b=WkoKXTwBIlyyaMfJ4IYnFFwfzRVLVhZgTTBx1YpxRy+LqrnQQQUjAzSjwkqnrMmxV1
         z/HN6HtgtX/5FvEAQljqtVsHZ2wU7NrbKko6ox2iqpwDrhtb8u4/Dojo+SxLmwA1TpgD
         tI5IUqD8QI8x8+fuCfKhq6lsxH0fQTj90yeOdg44MXToI/oXreN7M0sZwEdpBMx02bHc
         snDNZC4NLtxyg12f7T+b0WUxLxf3XJJyf8d3YNlImXYODdumdcY1VLJvupcw9Q5VGV5h
         TlCrX2OBqqasb8vxeDZBTg5tejJmQTmLLF5Y2ZFRgfjYbitq5kimdf1TfQ/AuTlyT3yX
         YHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=C/cTkt1/e5PWurSqWftpBR3fWpp9oOmSI5r6UmyKZD0=;
        b=jQhgez5M5/WhbG/K/oYw1JK6YQ9zSaYiEklhrNlST+W1mtivXEyvX0OjV5Njecl8+p
         /ZiSqsKu0HAS6NsHDkBZCee1bHXSYLWdm3IuaE5LAMweR0+/RxDePDsXnoovollQZ2cy
         AFVhTNuS8/EUPr4JorylG8MXkUxx+qLGIO+2joBdluKw+8mHMi9pehLhfsKaqwYisk47
         EWPf9MO+dl20NJfkyWwHgN1yRuXSSJG6XmqB5UKikDXc6intOb57Cwxzn7++uoAOZGvt
         1vrJi/uqEwsKAQpOvMHXfTYEk2TS6qoKkMw7/aeVPhwjNNLWnPR6n0M8M04U5Exw5Av0
         nx2A==
X-Gm-Message-State: AOAM533x57H8jil/6XJt8QlGago7x/1dIulK+7+8F9vra1SKeS8whueG
        rP/TaE5fFA7uBpv5NMNvlds=
X-Google-Smtp-Source: ABdhPJw6h588PWTpWi7nstf5ali+kJzfJZFTVYj+oRCsnEkIrb0tLFxSXjYjPgazW5N9K2SrI4Km/Q==
X-Received: by 2002:a17:906:dbc2:: with SMTP id yc2mr4198056ejb.390.1623326623987;
        Thu, 10 Jun 2021 05:03:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n2sm1264210edi.32.2021.06.10.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:03:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: UNLEAK(), leak checking in the default tests etc.
Date:   Thu, 10 Jun 2021 12:56:55 +0200
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
Message-ID: <87y2bi0vvl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 09 2021, Andrzej Hunt wrote:

> On 09/06/2021 16:38, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [In-Reply-To
>> <a74bbcae7363df03bf8e93167d9274d16dc807f3.1615747662.git.gitgitgadget@gm=
ail.com>,
>> but intentionally breaking threading for a new topic]
>> On Sun, Mar 14 2021, Andrzej Hunt via GitGitGadget wrote:
>>=20
>>> Most of these pointers can safely be freed when cmd_clone() completes,
>>> therefore we make sure to free them. The one exception is that we
>>> have to UNLEAK(repo) because it can point either to argv[0], or a
>>> malloc'd string returned by absolute_pathdup().
>> I ran into this when manually checking with valgrind and discovered
>> that
>> you need SANITIZERS for -DSUPPRESS_ANNOTATED_LEAKS to squash it.
>> I wonder if that shouldn't be in DEVOPTS (or even a default under
>> DEVELOPER=3D1). I.e. you don't need any other special compile flags, just
>> a compiled git that you then run under valgrind to spot this.
>
> I'm not familiar with git's development conventions/philosophy, but my
> 2c is that it's better not to enable it by default in order to
> minimise divergence from the code that users are running. OTOH it's
> not a major difference in behaviour so perhaps that's not a concern
> here.
>
> More significantly: I get the impression it's easier to do leak
> checking using LSAN, which requires recompiling git anyway - at which
> point you get the flag for free - so how often will people actually
> perform leak checking with Valgrind in the first place?

*Nod*, I didn't investigate the runtime penalty you and Jeff point
out. In any case, it seems that can also be done with valgrind exclusion
rules and/or manually ignoring these cases in the test wrapper.

>>=20
>>>   builtin/clone.c | 14 ++++++++++----
>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/builtin/clone.c b/builtin/clone.c
>>> index 51e844a2de0a..952fe3d8fc88 100644
>>> --- a/builtin/clone.c
>>> +++ b/builtin/clone.c
>>> @@ -964,10 +964,10 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
>>>   {
>>>   	int is_bundle =3D 0, is_local;
>>>   	const char *repo_name, *repo, *work_tree, *git_dir;
>>> -	char *path, *dir, *display_repo =3D NULL;
>>> +	char *path =3D NULL, *dir, *display_repo =3D NULL;
>>>   	int dest_exists, real_dest_exists =3D 0;
>>>   	const struct ref *refs, *remote_head;
>>> -	const struct ref *remote_head_points_at;
>>> +	struct ref *remote_head_points_at =3D NULL;
>>>   	const struct ref *our_head_points_at;
>>>   	struct ref *mapped_refs;
>>>   	const struct ref *ref;
>>> @@ -1017,9 +1017,10 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>>>   	repo_name =3D argv[0];
>>>     	path =3D get_repo_path(repo_name, &is_bundle);
>>> -	if (path)
>>> +	if (path) {
>>> +		FREE_AND_NULL(path);
>>>   		repo =3D absolute_pathdup(repo_name);
>>> -	else if (strchr(repo_name, ':')) {
>>> +	} else if (strchr(repo_name, ':')) {
>>>   		repo =3D repo_name;
>>>   		display_repo =3D transport_anonymize_url(repo);
>>>   	} else
>> In this case it seems better to just have a :
>>      int repo_heap =3D 0;
>>      Then set "repo_heap =3D 1" in that absolute_pathdup(repo_name)
>> branch,
>>      and...
>>=20
>>> @@ -1393,6 +1394,11 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>>>   	strbuf_release(&reflog_msg);
>>>   	strbuf_release(&branch_top);
>>>   	strbuf_release(&key);
>>> +	free_refs(mapped_refs);
>>> +	free_refs(remote_head_points_at);
>>> +	free(dir);
>>> +	free(path);
>>> +	UNLEAK(repo);
>> Here do:
>>      if (repo_heap)
>>          free(repo);
>>=20
>
> Although this is possible, I don't think it's worth it: if UNLEAK
> already exists, we might as well use it here to make the code
> simpler. And UNLEAK is unlikely to go away anytime soon
> because... (continued below)
>
>> But maybe there's some other out of the box way to make leak checking
>> Just Work without special flags in this case. I'm just noting this one
>> because it ended up being the only one that leaked unless I compiled
>> with -DSUPPRESS_ANNOTATED_LEAKS. I was fixing some leaks in the bundle
>> code.
>
> There are trickier examples where a cmd_* function has a complex
> struct on the stack, and correctly clearing all allocated memory
> pointed to by its members (or in turn further children with
> potentially multiple levels of indirection) is a lot of work - and
> that work doesn't actually benefit the user in any way. In other
> words, we either need to be able to use UNLEAK to suppress certain
> classes of uninteresting memory leaks - which allows us to focus on
> the interesting/real leaks - or someone has to spend a lot of time
> doing cleanup by hand (and/or someone has to implement a bunch of new
> cleanup functions)).
>
> In your example above, the UNLEAK can be avoided at the cost of one
> additional tracking variable - but in many other cases avoiding an=20
> UNLEAK is much more expensive. It's certainly valid to debate the
> merits of the UNLEAK here, but that won't remove the need for UNLEAK's=20
> existence in general.
>
> (The most common example that I remember is where cmd_* has a
> rev_info, and AFAICT there's no one-liner to clean that up. Using
> UNLEAK is honestly the best approach there. I don't think I've
> actually submitted any patches doing this, but I have a few in my
> local backlog.)

The thing I was patching happened to be making rev_info * not leak. I
probably didn't cover some more complex cases, but some simple cases
seem relatively easy.

I.e. it just doesn't have a release() function, and at least the things
I was looking at (bundle.c code) were relatively easy cases where we
were just missing a loop to free() data from some struct.

But yes, I agree that free()-ing just before we exit() is rather useless
in itself, the reason I wanted it is because it's a useful (although not
perfect) proxy for checking if the APIs the command uses as a one-off
leak when used as libraries, where we may be processing N items, later
doing other work etc.

We should probably eventually have a s/free/end_free()/g and imitate
perl(1)'s PERL_DESTRUCT_LEVEL option. I.e. you can globally configure
perl to run in a mode that assumes a one-off command, in that case
you'll just let the OS handle the cleanup, or one where you care about
memory leaks because you're using it e.g. as an embedded library.

But maybe it's not even worth it. In Perl the main benefit is that it's
a programming language with DESTROY handlers etc., so destruction can
often be expensive; turning it off entirely can also be buggy, imagine
relying on destructors to free temporary files etc.

We have that issue in theory with the interaction of atexit() handlers
and e.g. things that would behave differently at a distance if certain
thing were free()'d already, but in practice we probably don't.

But maybe it's not even worth pursuing. Have you (or anyone else) tried
e.g. benchmarking git's tests or t/perf tests where free() is defined to
be some noop stub? I'd expect it not to matter, but maybe I'm wrong...

>> Anyway, getting to the "default tests" point. I fixed a memory leak, and
>> wanted to it tested that the specific command doesn't leak in git's
>> default tests.
>> Do we have such a thing, if not why not?
>> The closest I got to getting this was:
>>      GIT_VALGRIND_MODE=3Dmemcheck
>> GIT_VALGRIND_OPTIONS=3D"--leak-check=3Dfull
>> --errors-for-leak-kinds=3Ddefinite --error-exitcode=3D123" <SOME TEST>
>> --valgrind
>
> It's easy to perform leak-checking runs *if* you're OK recompiling
> with LSAN, instead of using valgrind. My usual recipe for running
> against a range of tests is something like:

I thought valgrind would be a better approach since we might rely on it
just being there, so we could run some known-good commands that don't
leak even in a "normal" test run, but...

>   make SANITIZE=3Daddress,leak
>   ASAN_OPTIONS=3D"detect_leaks=3D1:abort_on_error=3D1" CFLAGS=3D"-Og -g"=
=20
> T=3D"\$(wildcard t00[0-9][0-9]-*.sh)" test
>
> Additionally: I usually specify CC=3Dclang, although gcc+LSAN has mostly
> been stable enough in my experience so you might be able to skip that.
> (I've found ASAN+LSAN to be more stable than LSAN by itself, which is
> why I specify address+leak, but adding ASAN in turn requires
> overriding ASAN_OPTIONS to reenable leak checking.)
>
> I don't know whether or not Valgrind is more/less effective at finding
> leaks, so being able to run the test suite under valgrind would be
> nice for comparison purposes though.

I didn't know how to set that up, that seems easy enough.

This works for me:

    make CC=3Dclang SANITIZE=3Daddress,leak CFLAGS=3D"-00 -g"
    (cd t && make ASAN_OPTIONS=3D"<what you said>" [...])

I.e. it's just SANITIZE & flags that's important at compile-time. You
doubtless knew that, mainly for my own notes & others following along.

I ran it, noted the failing tests, produced a giant GIT_SKIP_TESTS list
and hacked ci/ to run that as a new linux-clang-SANITIZE job. That messy
WIP code is currently running at:
https://github.com/avar/git/runs/2793150092

Wouldn't it be a good idea to have such a job and slowly work on the
exclusion list?

E.g. I saw that t0004 failed, which was trivially fixed with a single
strbuf_release(), and we could guard against regressions.

Anyway, I can submit some cleaned-up patches for that. I was just
fishing for whether there was some good reason not to do it, since there
seemed to have been interest in leak fixes, but it hadn't made it into
CI / some "blessed" GIT_TEST_* mode or whatever. I.e. maybe the reports
were unstable or unreliable...

