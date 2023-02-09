Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48945C636CC
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 01:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjBIBjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBIBjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 20:39:15 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4201F5E1
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 17:39:13 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hx15so2130191ejc.11
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 17:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xK4XU7XCkTkE6pF3wEvRwx2qYr9dACBRRTTw0kMVrCg=;
        b=nGy7ZjpXRlgZNFBJhJcc2606yA4+ex9JFd6dun7/+/wTLac/LfwXSQuucj3kCgeM6e
         KLuH64hBE5haGG24oWa0KPw+q7aHAu5PiVd/YX3FajXPh19IkstJBgHoF3PQr313xfHf
         ePbwxIwwdK16mgyWCybqyuw17g/qGCjYvwYhpxWEclqAlKEzzcsf7oLvi0n1UiR/53bZ
         qA3nwymf4SFw7qOU29wIBUH6gVev560t69FiaqRLRkiuHhJvRUVEzRx3Wo4ZmQn2kdxP
         Nd0Ly9I2DDONJ0Omwyt8LlzCJ7RG12S1gAH8C7dwQCQ9OreLL5sV32fGC1NE26C9bOwi
         yy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xK4XU7XCkTkE6pF3wEvRwx2qYr9dACBRRTTw0kMVrCg=;
        b=tqmkh6dHcI0W3O+VjlMjigKF/DzNKIxXs3f8fwOWybwzQO6MgGRRldNhMYImUW3Aql
         V0kjjdkvgmhspHF4eC/hY2xbT2ny3XtE2QJbDna6emFvCrSQcWRFDA52pJItQNnL15ny
         q1g9NxE0q9hUDX2P56qDClby0lxXdPU0QJ5ahqgSgpW+Kq57+Njejr3/f9hxceu3F2Tc
         WiW34oh0JqVauLbqV6K2mU7OybVKep+UdX9M6CXaBkyxE2XeQKe4AdbPolfDajzm9F7n
         mDyvIyXvf0yWlnLyQDCZcarCJqBK6dGS6jL7VuqUNRQZ5pRRFQ87JhgXjed4cn6H7n+q
         egYg==
X-Gm-Message-State: AO0yUKW9cl/o3OOLKS6hb/j+IUiG6O9FUleRxXSx/tTO+v7sc6G8si4h
        t/JlsGVnpCEW9CDdw299Dc8=
X-Google-Smtp-Source: AK7set+eja+WuQ6kLdx7X7MaZInB/GHHNUy1uhRIdktVH7QO99fP23EV23MOso3ouTdckcX06BFIIw==
X-Received: by 2002:a17:906:2dc1:b0:8a4:7fb9:5656 with SMTP id h1-20020a1709062dc100b008a47fb95656mr10687671eji.57.1675906751462;
        Wed, 08 Feb 2023 17:39:11 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id c25-20020a17090603d900b0087bd50f6986sm201954eja.42.2023.02.08.17.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 17:39:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPvu2-001aQd-0a;
        Thu, 09 Feb 2023 02:39:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/1] Document a fixed tar format for interoperability
Date:   Thu, 09 Feb 2023 01:35:15 +0100
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
        <20230205221728.4179674-2-sandals@crustytoothpaste.net>
        <230206.86lela4ebq.gmgdl@evledraar.gmail.com>
        <Y+LYQYMS7ruvRbNW@tapette.crustytoothpaste.net>
        <230208.86wn4sz8a3.gmgdl@evledraar.gmail.com>
        <Y+Q1v/PM6n93xvqu@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y+Q1v/PM6n93xvqu@tapette.crustytoothpaste.net>
Message-ID: <230209.86bkm3zkg1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2023-02-08 at 11:07:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Feb 07 2023, brian m. carlson wrote:
>>=20
>> > [[PGP Signed Part:Undecided]]
>> > On 2023-02-06 at 22:18:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
>> >> Maybe there are other changes in the proposed spec that put it at odds
>> >> with such a goal, it's unclear to me if this is the only difference.
>> >
>> > As mentioned in the description, that doesn't address trees, which have
>> > never been consistent traditionally.
>>=20
>> You mention "[...]it produces identical results for identical trees,
>> regardless of hash algorithm". I'm not familiar with how we encode trees
>> differently based on the hash algorithm. Do we stick the tree OID in
>> there somewhere, or is it something else?
>
> If you pass a commit or tag on the command line, you get the timestamp
> of the commit or tag.  If you pass a tree, you get the current
> timestamp.  Thus, whether the output is reproducible depends on the type
> of object you specify.

Ah, that's all. So just the case documented in the openign pargraphs of
the DESCRIPTION of git-archive.

I think it's probably a good thing to enforce the epoch:0 for the cases
where the time varies now, or maybe we'd say "if you want stable
archives, point to a commit or tag", but that's ultimately a UX issue.

But regardless of any other points we may differ on I think if that's
what you meant this section of the doc is really confusing:

	It serializes all timestamps as the Epoch, which produces
	identical results whether the tree is serialized as a tree,
	commit, or tag.

Because we do produce identical results now for commit or tag, so what's
epoch:0 for those solving?

>> IOW do these trees vary within the same hash algorithm, or is it another
>> special-case where we now produce a different tarball with SHA-1 and
>> SHA-256 with commits, but also with trees?
>
> When we write an archive, we embed a comment with the commit object ID
> (see next response).  That's using the hash algorithm in the repository.
> If we write an archive for a tree, no object ID is embedded.

Yeah, it was answered in the preceding. I.e. there's no special "tree"
magic here beyond the long-standing dynamic epoch behavior for the
"tree" case, thanks.

>> B.t.w. are there some options to tar(1) to make it dump these headers
>> you're describing? I coludn't find anything when looking, it looks like
>> libtar might support it, but I was hoping for something more compatible
>> with my lazyness :)
>
> I don't think so.  However, you can see them with `git archive --format=
=3Dtar HEAD | env -u LESSOPEN less -R`.
>
> The body of the global header looks like this (my indentation):
>
>   52 comment=3D7ff60001dae72ac39783ca536a4b673862b28587
>
> If you want to see what GNU tar produces, you can run `tar -cf - --posix =
--exclude .git . | env -u LESSOPEN less -R`:
>
>   30 mtime=3D1675633909.844009705
>   30 atime=3D1675895555.716075364
>   30 ctime=3D1675633909.844009705

*nod*, some variant of that is how I've been looking at this,
thanks.

>> I'm concerned that you're expanding the scope of a "stable" tar format
>> to necessarily include one-off fixing various things we've regretted
>> over the years.
>
> Well, yes, because if we're specifying a stable format, we should make it
> something we want to support long term.  Right now, we don't guarantee
> anything; if we find something unsatisfactory, we just fix it.

I won't repeat myself too much here, but we disagree on that.

If it's e.g. just the 666 permissions or whatever I don't see the value
of changing that just for the sake of asthetics. Or to satisfy some more
obscure use-cases (which must by definition be pretty obscure, as "git
archive" is in wide production use now with those warts).

But having said that...

>> Then a v1/v2 is just this pseudocode, isn't it?
>>=20
>>  	switch (version) {
>> 	case 1:
>> 		break; /* warts and all */
>> 	case 2:
>> 		include_oid =3D 0;
>> 		satanic_permissions =3D 0;
>> 		no_timestamps =3D 1;
>> 		break;
>> 	}
>
> As I mentioned in the doc, there are multiple ways to encode various
> things like lengths and the order of headers.  It's not immediately
> obvious from the code how our length encoding works, and that's the kind
> of code that could easily have a small refactor or bug fix break things
> really badly.

...I'm willing to be convinced otherwise.

So yes, if e.g. we find that to implement your proposed format we'd need
to change some tricky existing archiving code from 500 current lines of
tricky code, to either 100 neat lines in the new "stable" format, or 600
if we keep both, I'd be much less included to argue for this.

But I also think your proposal isn't doing itself any favors by pointing
out things that are clearly trivial to support without changes as the
things we should be "fixing" for a new stable format, e.g. modes and
epochs.

> Additionally, we, like most other pax implementations, just encode
> headers in whatever order we thought was most expedient when
> implementing, and sometimes they're emitted and sometimes they're not.
> That's a really great recipe for behaviour that is extremely hard to
> test and extremely hard to reproduce.  For example, we'd have to test
> the interaction with long paths and symlinks, long paths and large
> files, and several other sets of variants to make sure that a minor
> refactor doesn't change output.  The current logic of the code is very
> subtle.

Why do we need to exhaustively specify or test something we're not
testing or specifying now? Wouldn't something like this in some select
places in archive-tar.c be sufficient (the write_tar_entry2() being some
new format):

	diff --git a/archive-tar.c b/archive-tar.c
	index f8fad2946ef..4f8ca02a82a 100644
	--- a/archive-tar.c
	+++ b/archive-tar.c
	@@ -257,8 +257,17 @@ static int write_tar_entry(struct archiver_args *args,
	 	unsigned long size_in_header;
	 	int err =3D 0;
=09=20
	+	switch (args->version) {
	+	case 1: break;
	+	case 2: return write_tar_entry2(...);
	+	}
	+
	 	memset(&header, 0, sizeof(header));
=09=20
	+	/*
	+	 * This logic implements the tar v1 format, don't even change
	+	 * this, change write_tar_entry{2,3,...}() etc instead.
	+	 */
	 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
	 		*header.typeflag =3D TYPEFLAG_DIR;
	 		mode =3D (mode | 0777) & ~tar_umask;
	diff --git a/archive.h b/archive.h
	index 08bed3ed3af..a2f72bbea7e 100644
	--- a/archive.h
	+++ b/archive.h
	@@ -24,6 +24,7 @@ struct archiver_args {
	 	int compression_level;
	 	struct string_list extra_files;
	 	struct pretty_print_context *pretty_ctx;
	+	unsigned int tar_version;
	 };
=09=20
	 /* main api */

This is analogous to what we did for "git patch-id
[--unstable|--stable]", the latter is more specified, the former is
"we're keeping around whatever we did before".

But this is all under my ongoing assumption that the main target
audience for archive stability that cares about any of this someone with
existing archives who'd like to not go through some one-off migration if
they can help it.

>> Now that you've done the work to specify it, it turns out that a
>> proposed format you'd like going forward is almost identical to what we
>> currently emit, to the point that supporting that as a v1 seems rather
>> trivial (but again, I may still be missing something).
>
> It's relatively similar.  The format I'm proposing is much stricter and
> more regular than what we do now.
>
> I'm thinking that the changes will be limited to writing three or four
> functions.  It's not terribly invasive, but there will be some departure
> from the existing code.

Right, all of this sounds like mostly changes to write_tar_entry(),
prepare_header() and write_extended_header() in archive-tar.c

>> We have a huge long-tail of users in the wild, forcing those users to go
>> through a one-time breakage of their existing archives if we could avoid
>> that by making v1 the current format seems entirely unnecessary.
>
> Because right now, the current code is not amenable to producing or
> testing reproducible output.  Any significant refactor of the existing
> code will result in an output change unless the author is extremely
> careful, and I'm not comfortable guaranteeing the current format with
> that caveat.  The reason the data hasn't changed is because such a
> refactor hasn't happened yet.
>
> I'm specifically thinking about the length calculation in
> `strbuf_append_ext_header`, which is extremely magical, and the path
> splitting in `get_path_prefix`.  Those are both extremely subtle and
> logical places to perform a refactor or adjustment that might change
> output in a very minor way for a tiny subset of files.

Yeah, this sort of thing is all stuff I'm very much willing to be sold
on, and I think if the proposal had led with some of these things...

...but on the other hand the combined length of those two functions is
around 30 lines, and if we just "freeze" it (along with the existing
header writing code) doesn't look like something that would be much of a
hassle to just keep around, but maybe it all adds up.

>> When producing a release archive, or packing up a given commit that's
>> therefore going to be stable, even between SHA-1 and SHA-256, although
>> those two would differ if the OID is put in the header, but that's
>> another matter.
>>=20
>> If I understand you correctly here you seem to be in pursuit of another
>> goal entirely, which is that you'd like the same output for different
>> commits if they're TREESAME.
>>=20
>> Or, if you have a bunch of release archives a very nice attribute of
>> this is that with a bunch of similar archives on the same FS you could
>> e.g. benefit more from block-level deduplication.
>>=20

>> requirement in the design.
>
> I think it's valuable to have the same input data produce the same
> output.  That means that I can use Git to produce the archive, or some
> other tool implementing the same format, and it just works.  If GNU tar,
> libgit2, or libarchive implemented the same format with an option,
> people would also be able to produce an identical archive as long as
> they excluded the files in `.gitignore` and `.git`.  That approach is
> very valuable if you need to slightly modify the contents of the archive
> that Git produced in a way not supported by --add-file (and Junio used
> to do that himself for Git releases before --add-file).

They'd produce the same output if they just read the timestamp in the
commit envelope. GNU tar has a --mtime, so isn't this a matter of a
one-liner to "git show" that spews out the envelope time in a format it
groks?

>> But related to that is setting everything to epoch:0, doesn't that mean
>> that when you unpack say a release archive that in common filesystem
>> browsers all of the files will be dated in the 70s, as opposed to the
>> time of release as it is now?
>
> Yes.  That's also the case for current Rust crates and lots of other
> reproducible archives.  I've heard exactly zero complaints about that
> behaviour since I implemented it in Cargo.

I don't think someone unpacking a bunch of files from different
archives, doing "sort by date" in their file browser, and finding that
it's all from the 70s is something people would open bug reports about.

It's just a small fringe UX benefit, but it also seems like a small
matter to keep the non-zero epochs.

> Looking back at the history,
> apparently there's some broken behaviour with the actual Epoch and lldb
> (because 0 is a sentinel), but the change is just to switch to a
> timestamp of 1 instead of 0, which I can do in the next version of my
> patch.  No other problems seem to have come up with using a fixed
> timestamp.

Hah, I wonder if in 10 years some other system will discover that epoch
1 is used as a workaround for such issues, and hardcode that 1 is also a
meaningless sentinel value, so the next format will have epoch 2 etc.... :)

> The only place where I could imagine this being a problem is if you used
> Make in a directory after unpacking a new archive over the old one, but
> that is a terrible idea in the first place since that leaves now-removed
> files from the old version behind which will probably cause your build
> to fail at some point.

I hadn't thought of that, but that's another benefit to meaningful
timestamps.

I wouldn't call it a "terrible idea", it's a really well supported
pattern in "make", and this project with its messy Makefile infra even
supports it at least 95% of the time :)

(There's some messy picking up of old files logic with Documentation/*
in particular).

> in any event, because almost everyone uses
> `--prefix` with the version number for their archives, it's difficult to
> even perform that extraction over top anyway,[...]

There's going to be a lot of use cases on the edges, e.g. having
multiple prefix-unpacked archives, and wanting to use "find" with
"mtime" to run a meaningful search over them.

> and so it's unlikely that anyone actually does such a thing.

I think it's unlikely that we'll ever have more than a double-digit
number of people who'll implement any proposed archive format we come up
with, whereas the consumers will be a lot more digits :)

> Otherwise, there's typically no functional difference.

I think we're going to disagre on this point, but I think your propsal
would be improved if it clearly carved out this case, because it's
currently claiming to be in service reproducible archves, which isn't
really the case...

> [...]
>> I just don't see the target audience for that. As the issues that
>> prompted these on-list discussions show we have people in the wild who
>> deeply care about the current format.
>>=20
>> They probably care enough about that that we're likely to try to support
>> that forever, at least I don't see any currently proposed change to the
>> format that seems worth breaking things for those users.
>
> I don't think there's any purpose in guaranteeing the current format,
> given what I've said above about testability and the risk of breakage
> during a refactor with the current code, and I don't think the project
> should do that.  However, downstream users, including various forges, may
> wish to do so, and if so I wish them all the best.
>
>> If you're going to switch to some stable format surely that would either
>> need to involve massive one-off breakage, or you'd have some "flag day",
>> from today all new archives are produced with the new "stable" method.
>
> Nope.  There's simply a new option to produce v1 archives and people
> switch over as part of their normal build system maintenance, and
> eventually nobody cares about the ancient versions depending on the old
> format.

Or more likely they'll never make that switch, or even read the docs
about this. If they did in the first place that we'd have had nobody
rely on this implementation detail, but people do.

And once we change the "unstable" format we've now given ourselves
license to more freely change their systems break just as they did
before.

Maybe I'm just wrong here, and clearly in the long term your approach
will win out. If anyone's using these features in git in 10-20 years
we'll probably pat ourselves on the back in having gone through some
sort of transition here (although I think if it's not the default it
probably won't happen).

I just don't see why the problem at hand calls for a spec, a new format
to migrate to etc., as opposed to just adding comments or something like
that to the existing code saying "hey, people rely on this, consider
format changes carefully".

Then we kick the can down the road on any transition, which we can still
do if and when we find a really compelling reason for why we must change
the format.

So far the only "we must change it" that we have now AFAICT is the issue
of the OID in the comment, which for the reasons upthread I think is
pretty much a non-issue, and in any case for those that are willing to
migrate to a new format much more easily solved by a
--dont-add-the-oid-comment.

But if you're willing to work on all of this that's neat, although I do
reserve the right to bikeshed about some of these changes :)

It just seems rather orthogonal to the in-the-wild problem, is all.

Cheers.
