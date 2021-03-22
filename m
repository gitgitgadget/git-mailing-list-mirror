Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3955C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BA861990
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCVPjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhCVPjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 11:39:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FCBC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 08:39:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt15so12544714ejb.12
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KaWMfEiYDChxNFCXcVtGoW1d/zb72EWH/hdd1+zy5D0=;
        b=LjRh34XdIrinwR5BR0PBKJU8x3EG72VPr82PHM67ka29YzlwAnR3zIt1rFTdBzgaxh
         9Ly50IKGEwj9khR/j8z1jHzf/Q8OHThgsjtcBq72vsH+BEWXBNRs7Hc4uuzeexk+hO8q
         soeJBf6WqLrnJ9aViyFy8ZhMiXGDz0ut4xBO05UHLoWPnwnPUdUDsk9pWVIoZ8VEvrGT
         RYrmzVdJnSnTJ7g78TciGagW85+D7N4BjDs7tIUruoWWyX/lZRhTCufayvajzwmYnpMv
         1E/E6q/QCRqKzDVQbfs4DkMhPByJ+3yvmbxFB9jKvdBqoLCdik9Szv81szjbfBBHx5nT
         47kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KaWMfEiYDChxNFCXcVtGoW1d/zb72EWH/hdd1+zy5D0=;
        b=WbW7hrcYUBOrORvoicxyf9zkRXBIcjqPtkuJYIoQFXvmR7xb3YlfUyry2+XRE4MdLz
         NsCzsifqz8hztnbJYaq5AlPKw/ZxlUlzcVYYmc01V0M9SI//rK98y1dPrHnbBlRYKFa6
         aWnzE45CMwb2OgP2VK4wO7rjBvVLLKd0lqNkZKv5kj6o+86Z9w5LXMftBmtO0kv7Hpcb
         +Q1uKYY2KYHvx+sKEiunRbQVHJgD52x3tZFEy3dbYwb68tvHU5yFnm0f4DCZQXDDfIa9
         tjsVfYK4XfcF08IX8jTMyOYCCuJtOyiOOaVZuKXV3+OzK7VE3F61rSu5tcz0lc76yAsl
         VpqA==
X-Gm-Message-State: AOAM533jQWOeSsBX3IVyYhvxcy5I8pmQCDAkFnGQ3yCF2pOj4wsnmp/Q
        dUkwORsQikA7fCuRumQuFaI=
X-Google-Smtp-Source: ABdhPJxl6mccsAbGHVd6QbuPmSFy/0fchpEZQOyp6WxYx2pAUxVEbQUAVi4+QlxtlG2eV5li3CIgaA==
X-Received: by 2002:a17:906:7d7:: with SMTP id m23mr366201ejc.205.1616427541796;
        Mon, 22 Mar 2021 08:39:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id fi11sm9677570ejb.73.2021.03.22.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 08:39:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin Fick <mfick@codeaurora.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <87eeg7qpyr.fsf@evledraar.gmail.com>
 <CAFQ2z_NSh3XxjGx56r=xBP2WBk7ggUjh4rXSb5ivPtkS_r4iBQ@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_NSh3XxjGx56r=xBP2WBk7ggUjh4rXSb5ivPtkS_r4iBQ@mail.gmail.com>
Date:   Mon, 22 Mar 2021 16:39:00 +0100
Message-ID: <87blbbqju3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 22 2021, Han-Wen Nienhuys wrote:

> On Mon, Mar 22, 2021 at 2:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> > I'm working on some extensions to Gerrit for which it would be very
>> > beneficial if we could tell from the reflog if an update is a
>> > fast-forward or not: if we find a SHA1 in the reflog, and see there
>> > were only FF updates since, we can be sure that the SHA1 is reachable
>> > from the branch, without having to open packfiles and decode commits.
>> >
>> > For the reftable format, I think we could store this easily by
>> > introducing more record types. [snip].
>>
>> Aside from what others have mentioned here, you're talking about the
>> log_type field are you not? I.e.:
>> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/tech=
nical/reftable.md#log-block-format
>
> Correct.
>
>> Has that "log_type =3D 0x0" tombstone proven to be a worthwhile
>> optimization past the stash case mention there (which is presumably not
>> relevant to the vast majority of Google's use-cases).
>
> I've never really understood the log_type=3D0x0 use case. I think it was
> added solely to cater for a use case in CGit's stash command.
>
>> I.e. it's redundant to looking at the record and seeing if new_id =3D
>> ZERO_OID.
>>
>> Similarly can't ff v.s. non-ff be deduced unambiguously by looking ahead
>> to the next record, and seeing if the current record's "old_id" matches
>> that of the last record's "new_id". If it does it's a FF, if not it's a
>> non-FF (or a create/delete).
>
> I don't see how that will tell you FF vs non-FF-ness.  Both an FF
> update and a non-FF  update look like 'new_oid =3D 20-random-bytes'.
> Barring further info, you have to lookup the commit object for those
> bytes, and then walk back to see if you pass old_oid.

Because both the next reflog format and reftable's have the update-ref
<newvalue> <oldvalue> for each update. So:

    $ cut -d ' ' -f1-2 .git/logs/refs/remotes/origin/master | head -n 2
    1c52ecf4ba0f4f7af72775695fee653f50737c71 ba2aa15129e59f248d8cdd30404bc7=
8b5178f61d
    ba2aa15129e59f248d8cdd30404bc78b5178f61d 6d3ef5b467eccd2769f1aa1c555d31=
7d3c8dc707

We can know with !strcmp(rows[0][1], rows[1][0]) whether the latest
update is a ff or non-ff (it is). As opposed to:

    $ cut -d ' ' -f1-2 .git/logs/refs/remotes/origin/seen | head -n 2
    8b26a41f4bf7e7c0f097cb91012d08fe8ae30e7f 0f3a981cbd5be5f97e9504ab770cd8=
8f988fe820
    0f3a981cbd5be5f97e9504ab770cd88f988fe820 fdd019edfe6bc60d0100d5751c41e4=
f6ad28a2ef

Where the rows[0][1] value is not the same as rows[1][0].

What you can't do is find whether any given commit(s) in those ranges
are part of the FF or not, since you just have the start/end points.

But I'm vaguely paranoid that we're talking past one another here and
I've misunderstood what you want...

> AFAICT, a correct sequence of ref updates (FF or not) always has
> prev.new_oid =3D current.old_oid.
>
>> > [=C3=86var: snipped from earlier] Today we have 0 =3D deletion, 1 =3D =
update,
>> > and we could add 2 =3D FF update, 3 =3D non-FF update.
>>
>> I've written log table implementations (a site table in a RDBMS) for git
>> (one table for refs) which had:
>>
>>     create, ff, non-ff, delete
>>
>> I wonder if that quad-state would be useful for reftable too, with this
>> proposed change you'd still need to unpack the record and see if the
>> old_id is ZERO_OID to check if it's a creation, would you not?
>
> Delete & create are handled with ZERO_OID.
>
> The reftable format makes it so that you have to decode a record in
> order to read past it (there is no size framing the table entry
> level), so there is no big performance advantage in encoding this
> information in the log_type. You merely use a log_type bit rather than
> a 20 byte raw ID. Since log records are zlib compressed anyway, it
> probably also makes no space difference.
>
>> I also wonder if it couldn't be:
>>
>>     0 =3D deletion, 1 =3D non-ff-update, 2 =3D ff-update, 4 =3D creation
>>
>> So the format wouldn't forever carry the historical wart of this not
>> having been considered from the beginning.
>
> If you do it like this, you will force that all implementations to
> have to compute whether a (forced) update is a FF or not. I don't know
> if that is a problem. A 'maybe non-FF' value would be useful. Perhaps
> we could even do simply
>
>      0 =3D deletion, 1 =3D maybe-ff-update, 2 =3D guaranteed-ff-update

The point is that nobody relies on this now, but also that you'd of
course want 1 =3D i-know-for-sure-non-ff-update, 2 =3D
i-know-for-sure-ff-update.

But since logs are transitory (aren't they also expired in reftable,
can't see that from skimming hte spec) and this is just a helpful
side-index I think a one-time migration for the tiny minority of
reftable users who'd care would be preferrable to the vast majority of
future reftable users (if it ever lands in git.git) having to deal with
this (albeit small) special-case forever.

>> It would mean that the few current reftable users (just Google?) would
>> have to look at the record to see if it's *really* a non-ff-update, but
>> presumably they need to do so now for ff v.s. non-ff, so they're no
>> worse off than they are now.
>
> At Google, we currently don't record log records in reftable yet. From
> our perspective, we could probably change the standard 'in place'.
> JGit has supported reftable since Nov 2019, but I'm unaware of users;
> I did hear about GerritForge wanting to try it out in production this
> year.

Ah, so not even Google's using it, the backcompat is just for good
measure...

>> Then when those users know they're on a version that distinguishes these
>> they can hard rely on 1 not being a "ff for sure", not a "maybe" status
>> for new updates. Presumably they either don't care about ancient reflog
>> records, or a one-off migration of rewriting the records for older
>> entries could be done.
>>
>> Also between my [1] and this proposal we have at least a reftable v1.01
>> in the wild (the filename locking behavior change discussed in [1]), and
>> this would make it v1.02, but the only up-to-date spec is for v1.00 (and
>> maybe JGit has other changes I haven't tracked).
>
> The file locking update has been added to the standard,
> https://github.com/git/git/pull/951.

Ah yes. Now I remember. I managed to miss/not recall that. Thanks.
