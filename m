Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC8C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiB1J2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiB1J2K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:28:10 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872911A24
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:27:29 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a23so23450765eju.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=23mJoZoqvYJE+Ohq19MnbUotOXYeJoffWZhZujxCPUc=;
        b=Ox69ZNQ9UYqYTHHa198+euoVHP95d24qRFe+K8IHl/0Rn3Y9XNJQiy+igyfhEImIBe
         ejQuYAnB0G8scsPu15iaNoWJD8UsouwXJqeMBC5RcrYCUlEG57LVuTQ5BRvXK21AXnGO
         KulfB6gFjW2uQQJCNOIEcr8Csp5QOsrWaIKaq7Pva2uV7snflljOGtd9Nd1A4R0AVloC
         8NxPtHGem98aoOG7nnHKdvqHGkrUyj6755h+BfOzsTuWLsuL/ntXTKOGW66JfrwlE1TN
         CjqTLGLZC5xin4Ek7b33hOMcvgPaPkiVzVYmoD76NE7TuAqDqc7wz9qqdV7Y8K8yYKRr
         6quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=23mJoZoqvYJE+Ohq19MnbUotOXYeJoffWZhZujxCPUc=;
        b=wx42NI9d2A5R8vgYEoJTrBviivZ++cEbH2IXYNjOBnqWcuw1ucJXGLrZzk9HBCqQby
         eXNLGdLJdLcUESL0Q0aK5qy5jk6+xMO2oGsvJ+OEelgmVvmCBfSO1sHyB20sz1+hNvMN
         hgWm44cjWWd19JwwfbrKT4C08ACk2R0mna9emldvSwzq78bYojjbM8xKvQO4SaM4cRMr
         eboxohTKH42db7dT8JfZQCtLEuEJi8sY7UYVcfvXj9mItqKWPkwt47sEF2XwrES6PFZk
         HUXcBGYg8/0YnYWhhByUJqP66nsqhVc5p79332bBCAE2oUh2RZrdzaDC3+B7QelzfOUQ
         JNgg==
X-Gm-Message-State: AOAM5334sdWoFcKM9ioJF6WAPTtVk7zPmjPn93rz0+kH2QyWMkRUJ9la
        bFs1V00f+ArRP5InqYrQKvk=
X-Google-Smtp-Source: ABdhPJzR9PZz3aGPXRSskicjHAg/RmAwyzVyosrb3Rd6ik530jvqfMLM3F9wNZQtjjBfASfosk9c2g==
X-Received: by 2002:a17:906:4e83:b0:6d6:d5c8:1335 with SMTP id v3-20020a1709064e8300b006d6d5c81335mr443811eju.438.1646040447066;
        Mon, 28 Feb 2022 01:27:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w10-20020a17090652ca00b006c605703245sm4196395ejn.43.2022.02.28.01.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:27:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOcJQ-001G7X-DU;
        Mon, 28 Feb 2022 10:27:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: machine-parsable git-merge-tree messages (was: [PATCH 08/12]
 merge-ort: provide a merge_get_conflicted_files() helper function)
Date:   Mon, 28 Feb 2022 09:50:08 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
        <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
        <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org>
        <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
        <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
        <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
        <220221.86y224b80b.gmgdl@evledraar.gmail.com>
        <CABPp-BFc=hcWz1BMW7fAR=Zp3fQ3vxvBtnSYESreYwef_v1K5g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BFc=hcWz1BMW7fAR=Zp3fQ3vxvBtnSYESreYwef_v1K5g@mail.gmail.com>
Message-ID: <220228.86sfs35ojn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Elijah Newren wrote:

> On Mon, Feb 21, 2022 at 6:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Feb 21 2022, Johannes Schindelin wrote:
>>
>> [I sent out an empty reply to this earlier by mistake, sorry about that]
>>
>> > [...]
>> > Which brings me to the next concern: since `merge-tree` is a low-level
>> > tool meant to be called by programs rather than humans, we need to make
>> > sure that those messages remain machine-parseable, even if they contain
>> > file names.
>> >
>> > Concretely: while I am not currently aware of any web UI that allows to
>> > resolve simple rename/rename conflicts, it is easily conceivable how to
>> > implement such a thing. When that happens, we will need to be able to
>> > teach the server-side code to discern between the cases that can be
>> > handled in the web UI (trivial merge conflicts, trivial rename/rename
>> > conflicts) as compared to scenarios where the conflicts are just too
>> > complex.
>> >
>> > Here's an excerpt from t4301:
>> >
>> > -- snip --
>> > Auto-merging greeting
>> > CONFLICT (content): Merge conflict in greeting
>> > Auto-merging numbers
>> > CONFLICT (file/directory): directory in the way of whatever from side1=
; moving it to whatever~side1 instead.
>> > CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified=
 in side1.  Version side1 of whatever~side1 left in tree.
>> > -- snap --
>> >
>> > This is the complete set of messages provided in the `test conflict
>> > notices and such` test case.
>> >
>> > I immediately notice that every line contains at least one file name.
>> > Looking at https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1899, =
it
>> > does not seem as if the file names are quoted:
>> >
>> >               path_msg(opt, path, 1, _("Auto-merging %s"), path);
>> >
>> > (where `path` is used verbatim in a call to `merge_3way()` before that,
>> > i.e. it must not have been quoted)
>> >
>> > I would like to register a wish to ensure that file names with special
>> > characters (such as most notably line-feed characters) are quoted in t=
hese
>> > messages, so that a simple server-side parser can handle messages star=
ting
>> > with `Auto-merging` and with `CONFLICT (content): Merge conflict in `,=
 and
>> > "throw the hands up in the air" if any other message prefix is seen.
>> >
>> > Do you think we can switch to `sq_quote_buf_pretty()` for these messag=
es?
>> > For the `Auto-merging` one, it would be trivial, but I fear that we wi=
ll
>> > have to work a bit on the `path_msg()` function
>> > (https://github.com/git/git/blob/v2.35.1/merge-ort.c#L630-L649) becaus=
e it
>> > accepts a variable list of arguments without any clue whether the
>> > arguments refer to paths or not. (And I would be loathe to switch _all_
>> > callers to do the quoting themselves.)
>> >
>> > I see 28 calls to that function, and at least a couple that pass not o=
nly
>> > a path but also an OID (e.g.
>> > https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1611-L1613).
>> >
>> > We could of course be sloppy and pass even OIDs through
>> > `sq_quote_buf_pretty()` in `path_msg()`, knowing that there won't be a=
ny
>> > special characters in them, but it gets more complicated e.g. in
>> > https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1648-L1651, where=
 we
>> > pass an `strbuf` that contains a somewhat free-form commit message.
>> >
>> > I guess we could still pass those through `sq_quote_buf_pretty()`, eve=
n if
>> > they are not paths, to ensure that there are no special characters in =
the
>> > machine-parseable lines.
>> >
>> > What do you think?
>>
>> That sounds like a rather nasty hack, this is too, but demonstrates that
>> we can pretty easily extract this in a machine-readable format with just
>> a few lines now):
>>
>> diff --git a/merge-ort.c b/merge-ort.c
>> index 8a5f201d190..a906881f9b3 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -633,7 +633,7 @@ static void path_msg(struct merge_options *opt,
>>                      int omittable_hint, /* skippable under --remerge-di=
ff */
>>                      const char *fmt, ...)
>>  {
>> -       va_list ap;
>> +       va_list ap, cp;
>>         struct strbuf *sb, *dest;
>>         struct strbuf tmp =3D STRBUF_INIT;
>>
>> @@ -650,7 +650,9 @@ static void path_msg(struct merge_options *opt,
>>
>>         dest =3D (opt->record_conflict_msgs_as_headers ? &tmp : sb);
>>
>> +       va_copy(cp, ap);
>>         va_start(ap, fmt);
>> +
>>         if (opt->priv->call_depth) {
>>                 strbuf_addchars(dest, ' ', 2);
>>                 strbuf_addstr(dest, "From inner merge:");
>> @@ -659,6 +661,15 @@ static void path_msg(struct merge_options *opt,
>>         strbuf_vaddf(dest, fmt, ap);
>>         va_end(ap);
>>
>> +       va_start(cp, fmt);
>> +       trace2_region_enter_printf("merge", "conflict/path", opt->repo, =
"%s", path);
>> +       trace2_region_leave("merge", "conflict/path", opt->repo);
>> +       trace2_region_enter_printf("merge", "conflict/fmt", opt->repo, "=
%s", fmt);
>> +       trace2_region_leave("merge", "conflict/fmt", opt->repo);
>> +       trace2_region_enter_printf_va("merge", "conflict/msg", opt->repo=
, fmt, cp);
>> +       trace2_region_leave("merge", "conflict/msg", opt->repo);
>> +       va_end(cp);
>> +
>>         if (opt->record_conflict_msgs_as_headers) {
>>                 int i_sb =3D 0, i_tmp =3D 0;
>>
>> You can run that with one of the tests added in this series to get the
>> output as JSON, e.g.:
>>
>>      GIT_TRACE2_EVENT=3D/dev/stderr GIT_TRACE2_EVENT_NESTING=3D10 ~/g/gi=
t/git merge-tree --write-tree --no-messages --name-only --messages side1 si=
de2 2>&1|jq -r .| grep '"msg"'
>>       "msg": "whatever~side1"
>>       "msg": "CONFLICT (file/directory): directory in the way of %s from=
 %s; moving it to %s instead."
>>       "msg": "CONFLICT (file/directory): directory in the way of whateve=
r from side1; moving it to whatever~side1 instead."
>>       "msg": "whatever~side1"
>>       "msg": "CONFLICT (modify/delete): %s deleted in %s and modified in=
 %s.  Version %s of %s left in tree."
>>       "msg": "CONFLICT (modify/delete): whatever~side1 deleted in side2 =
and modified in side1.  Version side1 of whatever~side1 left in tree."
>>       "msg": "numbers"
>>       "msg": "Auto-merging %s"
>>       "msg": "Auto-merging numbers"
>>       "msg": "greeting"
>>       "msg": "Auto-merging %s"
>>       "msg": "Auto-merging greeting"
>>       "msg": "greeting"
>>       "msg": "CONFLICT (%s): Merge conflict in %s"
>>       "msg": "CONFLICT (content): Merge conflict in greeting"
>>
>> A "proper" fix for this doesn't sound too hard, we'd just instrument the
>> path_msg() function to pass along some "message category", see
>> e.g. unpack_plumbing_errors in unpack-trees.c for one example of such a
>> thing, or the "enum fsck_msg_id".
>>
>> Then we'd just allow you to emit any of the sprintf() format itself, or
>> the expanded version, the path, or an id like "CONFLICT:file/directory"
>> or "auto-merging" etc.
>
> I don't see how this helps solve the problem Dscho was bringing up at
> all.  Your reference to "the path" means you've missed his whole
> complaint -- that with more complex conflicts (renames, directory/file
> conflicts resolved via moving the file out of the way, mode conflicts
> resolved by moving both files out of the way, etc) there are multiple
> paths involved and he's trying to determine what those paths are.
> He's particularly focusing on rename/rename cases where a single path
> was renamed differently by the two sides of history (which results in
> a conflict message only being associated with the path from the merge
> base in order to avoid repeating the same message 2-3 times, but that
> one message has three distinct paths embedded in the string).
>
> Also, the additional paths is not part of the API to path_msg; it's
> merely embedded in a string.  (And, in case it bears repeating: as
> mentioned elsewhere, we cannot assume there will only be one
> path_msg() call per path, and we at least currently can't assume that
> each path_msg() call is for a separate logical conflict; there might
> be two for a single "conflict".)
>
> I agree that parsing these meant-for-human-consumption (and not
> promised to be stable) messages is not a good way to go, but
> pretending the current API has enough info to answer his questions
> isn't right either.

The intent here wasn't to present a complete solution, but to reply to
the part of Johannes's E-Mail that e.g. mention "and I would be loathe
to switch _all_ callers to do the quoting themselves.".

I.e. it's a POC for passing this data further up the stack. The issue
you mention with the renaming case could/should be handled by having
whatever handles the vargs accept those N arguments, the POC doesn't
handle it.

But in any case, needing to convert "28 calls to [path_msg()]" doesn't
seem like it's required.

But obviously we wouldn't want to use trace2 as a plumbing layer for
message passing, but could format the same data in a similar way,
especially in the context of a discussion about filenames with odd
characters in them (some of which JSON is inherently incapable of
encoding).

>> I think that would be particularly useful in conjuction with the
>> --format changes I was proposing for this (and hacked up a WIP patch
>> for). You could just have a similar --format-messages or whatever.
>>
>> Then you could pick \0\0 as a delimiter for your "main" --format, and
>> "\0" as the delimiter for your --format-messages, and thus be able to
>> parse N-nested \0-delimited content.
>
> To be honest, the --format stuff is sounding a little bit like a
> solution in search of a problem.

Opinions on this obviously differ, and I'm not going to pick this as my
particular hill to die on :)

But I do think it's the other way around, in that hardcoded output
formats are a problem requiring solutions.

Which e.g. is seen (to be fair, in rather small inconveniences) in this
series where you need to grep out the first OID line etc. in the tests,
instead of the command just being able to be asked for the exact thing
the user wants.

Now, perfect shouldn't be the enemy of the good, and I think this series
is definitely in good enough shape as it is. But as
e.g. "builtin/ls-tree.c" in "seen" currently shows using the
strbuf_expand() callback mechanism to emit output will result in less
code/special cases.

Now, in this case the problem is mostly orthagonal, i.e. that the
merge-ort.c API understandably isn't returning structured data in this
case, as the goal so far has been replacing the in-tree
merge-recursive.c use-case.

But if & when that happens I think e.g. returning those as a "struct
string_list" with some custom struct in the "util" member might be a
good idea, followed by a strbuf_expand() knowing how to format fields
from that struct.

The whole thing could then become e.g. (whitespace added for
convenience):

	--format=3D"\
		%(objectname)
		\0\0
		%(conflict:%(
			%(conflictmode)
                        \0
                        %(conflictobject)
                        \0
                        %(conflictstage)
                        \0
                        %(conflictfilename)
		)
	"

And it seems to me like the whole of --show-messages etc. could be
generalized as some (the "if" syntax would need to be extracted and
generalized from ref-filter.c:

    %(if:notequal=3D0)%(mergeresult)%(then)...%(end)

So again, I'm not saying it's needed now, just that I think the pattern
of preparing structured data and throwing it at a formatting engine is
worth considering sooner than later.

It we didn't have that for "git-for-each-ref" I think it would have N
number of "--only-this-but-not-that"-type options, which this new
command already requires.

And with a formatting engine things like "I want my output quoted for
consumption by programming language X" become much harder, but which
"git-for-each-ref" already supports using that formatting mechanism.
