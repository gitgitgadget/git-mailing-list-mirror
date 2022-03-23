Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A042C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 10:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiCWKxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiCWKxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 06:53:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC730762AB
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 03:52:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p15so1996603ejc.7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=A2+Eb9WG5HW/PzIBizEpxqS4buJQ9TVjSrohIjYMeJE=;
        b=cqj9mS6sH2UdvNeddmpreuAxpIyU6yZGzgyxa+YEqRMt//vxEa/Lec/5n3Q0M8h9Ac
         FPMUZLsw04Bucf/lDBwufHferH+ehb3uAFAws8BQj9lhRUWK4ABf4IdJoULGPcT+XuYM
         1WBvdhIdQV4us2ctYQ/TyP07g8sRQGoAKXK88pd/p2LIHZYCoMy4sAnv3tNIPzIyMaO0
         ZedA5zp76ceMCkkNKx1gqfj4MZZbWK9caC+0+hGaNI/c0g2SDxvhKCArq2cAxqKcpAem
         QhP4JuDlDvUl4XC5vciGiOi6eKijbJ4pzKhW3aTbEwMeHIyR8LrAA4Bhdepl5pkZ06Zj
         7Xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=A2+Eb9WG5HW/PzIBizEpxqS4buJQ9TVjSrohIjYMeJE=;
        b=mKJZbd6QMlUVbfBG8ZZmnIOqWecF2Zb4MZL8PfeDhtjTgv3TVAM95XoRU1CUewv53R
         4K4LT4XKcEdQc+Tt6/RK/prCaTd58pQKMqTrvaJuVK3sEXQmoXhNRqaP60g4iIiXjSZS
         0LVzXZGv7f05sDrF12r9MzQIreV0jXn07IP/6g/afM+QXu4sMsLTb2SPZL20B27xlsQj
         e+E/m4j/mh3TMPD4MFQCyBlHrd0PVwdrjg9+evh/o5kAiqIODJRqAIDIAAHJiIE6Rw9b
         tYiEBLNGqHE8XenEJaP2rY/uHz9WvU5ceyFwTDTGZOV6Qi5oQLeN+ZBnV2Eb0Kp+tkcV
         ub1A==
X-Gm-Message-State: AOAM531j1tO713JZzQKke6MMUnHYJTZDfWVv3h/iKj0UFbt/IuYss37h
        Ur6zQxLBdnZbZ66TbXYOWC/7jyN/usQB2Q==
X-Google-Smtp-Source: ABdhPJytm3wUCvZiFgubP/3LJKICqrMUcX4CDOU5/1SQ1UJ2xLFOH7EHPASO6GyOaj8ezKdJ5lKz1Q==
X-Received: by 2002:a17:906:2bc5:b0:6cd:e676:3624 with SMTP id n5-20020a1709062bc500b006cde6763624mr31126691ejg.277.1648032721736;
        Wed, 23 Mar 2022 03:52:01 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hp11-20020a1709073e0b00b006dfd53a0e39sm5606309ejc.135.2022.03.23.03.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 03:52:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWyau-000iDP-7i;
        Wed, 23 Mar 2022 11:52:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [RFC PATCH 7/7] update-index: make use of
 HASH_N_OBJECTS{,_{FIRST,LAST}} flags
Date:   Wed, 23 Mar 2022 10:48:40 +0100
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com>
 <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
 <RFC-patch-7.7-481f1d771cb-20220323T033928Z-avarab@gmail.com>
 <CANQDOdcfoS-kLkaoXSKBhemDV13aWsoLSf=xUaU84B6_ajqbJA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CANQDOdcfoS-kLkaoXSKBhemDV13aWsoLSf=xUaU84B6_ajqbJA@mail.gmail.com>
Message-ID: <220323.86sfr9ndpr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Neeraj Singh wrote:

> On Tue, Mar 22, 2022 at 8:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> As with unpack-objects in a preceding commit have update-index.c make
>> use of the HASH_N_OBJECTS{,_{FIRST,LAST}} flags. We now have a "batch"
>> mode again for "update-index".
>>
>> Adding the t/* directory from git.git on a Linux ramdisk is a bit
>> faster than with the tmp-objdir indirection:
>>
>>         git hyperfine -L rev ns/batched-fsync,HEAD -s 'make CFLAGS=3D-O3=
' -p 'rm -rf repo && git init repo && cp -R t repo/' 'git ls-files -- t | .=
/git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo updat=
e-index --add --stdin' --warmup 1 -r 10
>>         Benchmark 1: git ls-files -- t | ./git -c core.fsync=3Dloose-obj=
ect -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin' in 'ns/=
batched-fsync
>>           Time (mean =C2=B1 =CF=83):     289.8 ms =C2=B1   4.0 ms    [Us=
er: 186.3 ms, System: 103.2 ms]
>>           Range (min =E2=80=A6 max):   285.6 ms =E2=80=A6 297.0 ms    10=
 runs
>>
>>         Benchmark 2: git ls-files -- t | ./git -c core.fsync=3Dloose-obj=
ect -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin' in 'HEAD
>>           Time (mean =C2=B1 =CF=83):     273.9 ms =C2=B1   7.3 ms    [Us=
er: 189.3 ms, System: 84.1 ms]
>>           Range (min =E2=80=A6 max):   267.8 ms =E2=80=A6 291.3 ms    10=
 runs
>>
>>         Summary
>>           'git ls-files -- t | ./git -c core.fsync=3Dloose-object -c cor=
e.fsyncMethod=3Dbatch -C repo update-index --add --stdin' in 'HEAD' ran
>>             1.06 =C2=B1 0.03 times faster than 'git ls-files -- t | ./gi=
t -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-i=
ndex --add --stdin' in 'ns/batched-fsync'
>>
>> And as before running that with "strace --summary-only" slows things
>> down a bit (probably mimicking slower I/O a bit). I then get:
>>
>>         Summary
>>           'git ls-files -- t | strace --summary-only ./git -c core.fsync=
=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo update-index --add --st=
din' in 'HEAD' ran
>>             1.21 =C2=B1 0.02 times faster than 'git ls-files -- t | stra=
ce --summary-only ./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3D=
batch -C repo update-index --add --stdin' in 'ns/batched-fsync'
>>
>> We also go from ~51k syscalls to ~39k, with ~2x the number of link()
>> and unlink() in ns/batched-fsync.
>>
>> In the process of doing this conversion we lost the "bulk" mode for
>> files added on the command-line. I don't think it's useful to optimize
>> that, but we could if anyone cared.
>>
>> We've also converted this to a string_list, we could walk with
>> getline_fn() and get one line "ahead" to see what we have left, but I
>> found that state machine a bit painful, and at least in my testing
>> buffering this doesn't harm things. But we could also change this to
>> stream again, at the cost of some getline_fn() twiddling.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/update-index.c | 31 +++++++++++++++++++++++++++----
>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index af02ff39756..c7cbfe1123b 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -1194,15 +1194,38 @@ int cmd_update_index(int argc, const char **argv=
, const char *prefix)
>>         }
>>
>>         if (read_from_stdin) {
>> +               struct string_list list =3D STRING_LIST_INIT_NODUP;
>>                 struct strbuf line =3D STRBUF_INIT;
>>                 struct strbuf unquoted =3D STRBUF_INIT;
>> +               size_t i, nr;
>> +               unsigned oflags;
>>
>>                 setup_work_tree();
>> -               while (getline_fn(&line, stdin) !=3D EOF)
>> -                       line_from_stdin(&line, &unquoted, prefix, prefix=
_length,
>> -                                       nul_term_line, set_executable_bi=
t, 0);
>> +               while (getline_fn(&line, stdin) !=3D EOF) {
>> +                       size_t len =3D line.len;
>> +                       char *str =3D strbuf_detach(&line, NULL);
>> +
>> +                       string_list_append_nodup(&list, str)->util =3D (=
void *)len;
>> +               }
>> +
>> +               nr =3D list.nr;
>> +               oflags =3D nr > 1 ? HASH_N_OBJECTS : 0;
>> +               for (i =3D 0; i < nr; i++) {
>> +                       size_t nth =3D i + 1;
>> +                       unsigned f =3D i =3D=3D 0 ? HASH_N_OBJECTS_FIRST=
 :
>> +                                 nr =3D=3D nth ? HASH_N_OBJECTS_LAST : =
0;
>> +                       struct strbuf buf =3D STRBUF_INIT;
>> +                       struct string_list_item *item =3D list.items + i;
>> +                       const size_t len =3D (size_t)item->util;
>> +
>> +                       strbuf_attach(&buf, item->string, len, len);
>> +                       line_from_stdin(&buf, &unquoted, prefix, prefix_=
length,
>> +                                       nul_term_line, set_executable_bi=
t,
>> +                                       oflags | f);
>> +                       strbuf_release(&buf);
>> +               }
>>                 strbuf_release(&unquoted);
>> -               strbuf_release(&line);
>> +               string_list_clear(&list, 0);
>>         }
>>
>>         if (split_index > 0) {
>> --
>> 2.35.1.1428.g1c1a0152d61
>>
>
> This buffering introduces the same potential risk of the
> "stdin-feeder" process not being able to see objects right away as my
> version had. I'm planning to mitigate the issue by unplugging the bulk
> checkin when issuing a verbose report so that anyone who's using that
> output to synchronize can still see what they're expecting.

I was rather terse in the commit message, I meant (but forgot some
words) "doesn't harm thing for performance [in the above test]", but
converting this to a string_list is clearly & regression that shouldn't
be kept.

I just wanted to demonstrate method of doing this by passing down the
HASH_* flags, and found that writing the state-machine to "buffer ahead"
by one line so that we can eventually know in the loop if we're in the
"last" line or not was tedious, so I came up with this POC. But we
clearly shouldn't lose the "streaming" aspect.

But anyway, now that I look at this again the smart thing here (surely?)
is to keep the simple getline() loop and not ever issue a
HASH_N_OBJECTS_LAST for the Nth item, instead we should in this case do
the "checkpoint fsync" at the point that we write the actual index.

Because an existing redundancy in your series is that you'll do the
fsync() the same way for "git unpack-objects" as for "git
{update-index,add}".

I.e. in the former case adding the N objects is all we're doing, so the
"last object" is the point at which we need to flush the previous N to
disk.

But for "update-index/add" you'll do at least 2 fsync()'s in the bulk
mode, when it should be one. I.e. the equivalent of (leaving aside the
tmp-objdir migration part of it), if writing objects A && B:

    ## METHOD ONE
    # A
    write(objects/A.tmp)
    bulk_fsync(objects/A.tmp)
    rename(objects/A.tmp, objects/A)
    # B
    write(objects/B.tmp)
    bulk_fsync(objects/B.tmp)
    rename(objects/B.tmp, objects/B)
    # "cookie"
    write(bulk_fsync_XXXXXX)
    fsync(bulk_fsync_XXXXXX)
    # ref
    write(INDEX.tmp, $(git rev-parse B))
    fsync(INDEX.tmp)
    rename(INDEX.tmp, INDEX)

This series on top changes that so we know that we're doing N, so we
don't need the seperate "cookie", we can just use the B object as the
cookie, as we know it comes last;

    ## METHOD TWO
    # A -- SAME as above
    write(objects/A.tmp)
    bulk_fsync(objects/A.tmp)
    rename(objects/A.tmp, objects/A)
    # B -- SAME as above, with s/bulk_fsync/fsync/
    write(objects/B.tmp)
    fsync(objects/B.tmp)
    rename(objects/B.tmp, objects/B)
    # "cookie" -- GONE!
    # ref -- SAME
    write(INDEX.tmp, $(git rev-parse B))
    fsync(INDEX.tmp)
    rename(INDEX.tmp, INDEX)

But really, we should instead realize that we're not doing
"unpack-objects", but have a "ref update" at the end (whether that's a
ref, or an index etc.) and do:

    ## METHOD THREE
    # A -- SAME as above
    write(objects/A.tmp)
    bulk_fsync(objects/A.tmp)
    rename(objects/A.tmp, objects/A)
    # B -- SAME as the first
    write(objects/B.tmp)
    bulk_fsync(objects/B.tmp)
    rename(objects/B.tmp, objects/B)
    # ref -- SAME
    write(INDEX.tmp, $(git rev-parse B))
    fsync(INDEX.tmp)
    rename(INDEX.tmp, INDEX)

Which cuts our number of fsync() operations down from 2 to 1, ina
addition to removing the need for the "cookie", which is only there
because we didn't keep track of where we were in the sequence as in my
2/7 and 5/7.

And it would be the same for tmp-objdir, the rename dance is a bit
different, but we'd do the "full" fsync() while on the INDEX.tmp, then
migrate() the tmp-objdir, and once that's done do the final:

    rename(INDEX.tmp, INDEX)

I.e. we'd fsync() the content once, and only have the renme() or link()
operations left. For POSIX we'd need a few more fsync() for the
metadata, but this (i.e. your) series already makes the hard assumption
that we don't need to do that for rename().

> I think the code you've presented here is a lot of diff to accomplish
> the same thing that my series does, where this specific update-index
> caller has been roto-tilled to provide the needed
> begin/end-transaction points.

Any caller of these APIs will need the "unsigned oflags" sooner than
later anyway, as they need to pass down e.g. HASH_WRITE_OBJECT. We just
do it slightly earlier.

And because of that in the general case it's really not the same, I
think it's a better approach. You've already got the bug in yours of
needlessly setting up the bulk checkin for !HASH_WRITE_OBJECT in
update-index, which this neatly solves by deferring the "bulk" mechanism
until the codepath that's past that and into the "real" object writing.

We can also die() or error out in the object writing before ever getting
to writing the object, in which case we'd do some setup that we'd need
to tear down again, by deferring it until the last moment...

> And I think there will be a lot of
> complexity in supporting the same hints for command-line additions
> (which is roughly equivalent to the git-add workflow).

I left that out due to Junio's comment in
https://lore.kernel.org/git/xmqqzgljyz34.fsf@gitster.g/; i.e. I don't
see why we'd find it worthwhile to optimize that case, but we easily
could (especially per the "just sync the INDEX.tmp" above).

But even if we don't do "THREE" above I think it's still easy, for "TWO"
we already have as parse_options() state machine to parse argv as it
comes in. Doing the fsync() on the last object is just a matter of
"looking ahead" there).

> Every caller
> that wants batch treatment will have to either implement a state
> machine or implement a buffering mechanism in order to figure out the
> begin-end points. Having a separate plug/unplug call eliminates this
> complexity on each caller.

This is subjective, but I really think that's rather easy to do, and
much easier to reason about than the global state on the side via
singletons that your method of avoiding modifying these callers and
instead having them all consult global state via bulk-checkin.c and
cache.h demands.

That API also currently assumes single-threaded writers, if we start
writing some of this in parallel in e.g. "unpack-objects" we'd need
mutexes in bulk-object.[ch]. Isn't that a lot easier when the caller
would instead know something about the special nature of the transaction
they're interacting with, and that the 1st and last item are important
(for a "BEGIN" and "FLUSH").

> Btw, I'm planning in a future series to reduce the system calls
> involved in renaming a file by taking advantage of the renameat2
> system call and equivalents on other platforms.  There's a pretty
> strong motivation to do that on Windows.

What do you have in mind for renameat2() specifically?  I.e. which of
the 3x flags it implements will benefit us? RENAME_NOREPLACE to "move"
the tmp_OBJ to an eventual OBJ?

Generally: There's some low-hanging fruit there. E.g. for tmp-objdir we
slavishly go through the motion of writing an tmp_OBJ, writing (and
possibly syncing it), then renaming that tmp_OBJ to OBJ.

We could clearly just avoid that in some/all cases that use
tmp-objdir. I.e. we're writing to a temporary store anyway, so why the
tmp_OBJ files? We could just write to the final destinations instead,
they're not reachable (by ref or OID lookup) from anyone else yet.

But even then I don't see how you'd get away with reducing some classes
of syscalls past the 2x increase for some (leading an overall increase,
but not a ~2x overall increase as noted in:
https://lore.kernel.org/git/RFC-patch-7.7-481f1d771cb-20220323T033928Z-avar=
ab@gmail.com/)
as long as you use the tmp-objdir API. It's always going to have to
write tmpdir/OBJ and link()/rename() that to OBJ.

Now, I do think there's an easy way by extending the API use I've
introduced in this RFC to do it. I.e. we'd just do:

    ## METHOD FOUR
    # A -- SAME as THREE, except no rename()
    write(objects/A.tmp)
    bulk_fsync(objects/A.tmp)
    # B -- SAME as THREE, except no rename()
    write(objects/B.tmp)
    bulk_fsync(objects/B.tmp)
    # ref -- SAME
    write(INDEX.tmp, $(git rev-parse B))
    fsync(INDEX.tmp)
    # NEW: do all the renames at the end:
    rename(objects/A.tmp, objects/A)
    rename(objects/B.tmp, objects/B)
    rename(INDEX.tmp, INDEX)

That seems like an obvious win to me in any case. I.e. the tmp-objdir
API isn't really a close fit for what we *really* want to do in this
case.

I.e. the reason it does everything this way is because it was explicitly
designed for 722ff7f876c (receive-pack: quarantine objects until
pre-receive accepts, 2016-10-03), where it's the right trade-off,
because we'd like to cheaply "rm -rf" the whole thing if e.g. the
"pre-receive" hook rejects the push.

*AND* because it's made for the case of other things concurrently
needing access to those objects. So pedantically you would need it for
some modes of "git update-index", but not e.g. "git unpack-objects"
where we really are expecting to keep all of them.

> Thanks for the concrete code,

..but no thanks? I.e. it would be useful to explicitly know if you're
interested or open to running with some of the approach in this RFC.
