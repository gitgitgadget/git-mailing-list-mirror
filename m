Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33620C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 01:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjBABdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 20:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBABds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 20:33:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D4358287
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 17:33:43 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0289E5A210;
        Wed,  1 Feb 2023 01:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675215223;
        bh=IKAQk+K/3ciMOpQmgL8LioU4DkcOVE9EhFhIGzdZ3yI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LdmHXTv8GUrN8QYI7aq0UmQRlhxzrG+KQb/e1q4rmK/grUgKuT18Rkox30+Q9r34M
         mR1/RQzrG9M334PQKWeLoV0O7eX6wXWpc6qE8AkFMAVGMBC3bgD7OI0A9FHtJEMKao
         m3M5It9Lj7dG39Hpv5nFRKgp1R+qBLfbTfWKGdjfNe2dX2ObzrwX2qsBElGsnB9Wii
         S8L6aQqsCecRLdlZaZZaK49Z7ElEIyiJAN4sk04YON1Gd4wo4DGIqD+caHNKGnm71L
         jfwAM6QJetopBq6VC6lHb4oTrvIfARvbQqmhDgCa97WGAVTbzhwUfiTmyQ6Pze6On4
         obBsixMzeZgmGBjupmurLeOr3z4X0iwiJb57besP4Ck8XzkH1ufGzAJYVQOew54KST
         1T8tKSTGBE3csgUjn3rj8ao8Vzt9NRT+saB0+LCcRUVxI45COzjPdSLKWFCblIcG68
         FPntT4gnE1oQoplpW24ji1fk6AZGQEUQeD2x4yKYiHCWTc6KNgx
Date:   Wed, 1 Feb 2023 01:33:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eli Schwartz <eschwartz93@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9nBdZZCRZgPzB/v@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6OI/8T1qYEvIefLD"
Content-Disposition: inline
In-Reply-To: <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6OI/8T1qYEvIefLD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-31 at 15:56:52, Eli Schwartz wrote:
> On 1/31/23 4:54 AM, brian m. carlson wrote:
> > Part of the reason I think this is valuable is that once SHA-1 and
> > SHA-256 interoperability is present, git archive will change the
> > contents of the archive format, since it will embed a SHA-256 hash into
> > the file instead of a SHA-1 hash, since that's what's in the repository.
> > Thus, we can't produce an archive that's deterministic in the face of
> > SHA-1/SHA-256 interoperability concerns, and we need to create a new
> > format that doesn't contain that data embedded in it.
>=20
>=20
> I assume that whatever the reason for originally embedding the OID into
> the file is still an applicable reason even if a new PAX format is
> established for the use of git-archive.
>=20
> It may not be a great reason -- I don't know. Perhaps there's an
> argument to remove it. But can't that be done irrespective of
> standardizing the PAX format?
>=20
> ...
>=20
> I'm not deeply knowledgeable about the SHA-256 transition work -- or
> knowledgeable at all about it, frankly. (Also my understanding was it
> seems to have stalled as discussed in https://lwn.net/Articles/898522/
> -- I understand that you're still enthusiastic about the work? But that
> doesn't really answer "is there a timeframe for that to ever happen".)

The timeframe is when my employer pays me to work on it.  Right now,
I've implemented functional SHA-256 repositories but am currently a bit
on the way to burnout and am very selective about what things I'm doing
outside of work.  My hope is that my employer will find time for me to
work on the interop stuff soon, but I'm not at liberty to discuss this
more in depth at the moment.

> But I sort of assumed that the transition work would already have to
> embed a fair bit of information into the repository about the whole
> process? Would it not be possible to determine whether a given tag
> started life as SHA-1 or SHA-256? Maybe even just a date when the
> repository was converted to work with both, and embed the OID based on
> whether the tag is tagging contents that were created after that conversi=
on?

It's designed such that the two objects are completely interoperable and
can be accessed by either name, depending on how the repository is
configured locally.  There may be a signature for one algorithm, both,
or neither, so it's hard to say definitively what version it's created
with.  That is completely intentional since the goal is to transition
seamlessly from one to another at any point depending on the preferences
of the owner of the local repository.

> > Having said that, I don't think this should be based on the timestamp of
> > the file, since that means that two otherwise identical archives
> > differing in timestamp aren't ever going to be the same, and we do see
> > people who import or vendor other projects.=20
>=20
>=20
> The timestamp of the output file? Surely not. But I only suggested the
> timestamp of the commit/tag metadata that git-archive is asked to
> produce output for. And we would need that in order to solve the problem
> that reproducible github API archive endpoints poses.

I think it would simply be easier to say, "This is the command-line
option that implements canonical tar version 1."  If you want a
reproducible archive, you use that command-line option, and your
uncompressed tar archive is reproducible.  Otherwise, you get the same
guarantees on reproducibility that we've always provided, which is
absolutely none.

Using commit and tag metadata doesn't solve the problem of trees, which
would use the current timestamp.  It's better to solve the problem in a
consistent way, which would mean embedding a fixed timestamp (probably
the Epoch) into those tree tarballs.

In my view, using the commit or tag timestamp is very risky, because it
changes the behaviour at some point in the future without notifying
people.  If we produce a tar archive that isn't readable by FooZip, say,
then nobody will realize that until we actually start producing them,
several months after the release.  And, I should point out, this still
poses problems for GitHub and other forges, because GitHub doesn't run
the latest release right away; we usually trail a version or two.  So
using the commit or tag timestamp might mean that on an upgrade,
suddenly the behaviour changes because the new version has a change
(which was scheduled to have occurred in the past) but the old version
doesn't.

In addition, the one guarantee we've given with archives in the past is
that the same version of Git with the same input (flags, repository,
etc.) will produce deterministic results (that is, the same output), and
I think we're likely to run afoul of that with a timestamp-based
approach.  I don't want the archive to suddenly be different because I
happened to do "git commit --amend" to update just a commit message and
we happened to cross that timestamp threshold.

> I'm not sure what the "import or vendor other projects" angle here
> means. Do you mean people who copy a directory of files into their
> project? Who expects this to be the same to begin with? And doesn't
> embedding the OID kill this idea, since the entire point of git commit
> sha's is that you shouldn't (it should be prohibitively unrealistic to)
> be able to produce the same one twice in different contexts?

We have people who import the entirety of Chromium into a project at
one time to work on a browser-based project.

> I have never said to myself "ah yes, I really would like to be able to
> download a git auto-generated tarball for project A, and compare its
> hash to the tarball for project B, and have them compare identical even
> though they are different projects with different commits". IMHO this
> isn't an interesting problem to solve -- the interesting problem to
> solve is that a single absolute URL to a downloadable file should be
> able to offer documented guarantees that it will always be the same
> file, even though it is generated on the fly.

I do think having identical output for identical contents is very
valuable.  If our goal is reproducible output, we should endeavour to
produce identical output for identical input.  What we're specifically
trying to move away from is varying output based on the same input.

> I do not think it is realistic or reasonable for people to implement
> compression using intentionally incompatible replacements for gzip and
> expect interoperability of any sort.

I disagree completely.  The gzip and zlib formats are documented in RFCs
and have been since 1996.  There are already at least a half-dozen
interoperable implementations, including zlib, gzip, pigz, Go's standard
library, miniz_oxide, and the Windows archiver.  I'm sure if I searched
I could find at least half a dozen more.

> I also don't think people *have* to implement compression in rust using
> zlib, but if they are going to make a git-alike that produces archives,
> it would be worth it for them to write whatever memory-safe rust is
> necessary to memory-safely produce the same output stream of bytes. It's
> no less feasible than making sure that busybox gzip and GNU gzip produce
> the same output, surely.

I don't agree at all.  The Go standard library couldn't achieve that,
because busybox and gzip are GPL and doing that would almost certainly
require looking at the code, which would require the Go standard library
to be GPL as well.  The same thing goes for zlib, which is permissively
licensed, and which is clearly the obvious choice if we had to settle on
a standard, since it's a shared library.

That also ignores tools like pigz which provide parallel compression and
can provide an order of magnitude performance increase, but which won't
provide an identical byte stream.  Why should we require people to use a
single core if they have a very large archive that could compress
several times as fast with a parallel operation?

My goal is to produce tar archives that are interoperable based on a
spec.  That spec would be implementable by Git, GNU tar, libarchive, or
anyone else, by reading the spec and following it.  That's very
different from saying, "Well, just make your program do exactly the same
thing as this other one without sharing any code."  If you want to write
a spec for canonical gzip, I'm interested in reading it, but I think
it's practically going to be difficult to achieve.

> > That may mean that it's important for people to actually decompress the
> > archive before checking hashes if they want deterministic behaviour, and
> > I'm okay with that.  You already have to do that if you're verifying the
> > signature on Git tarballs, since only the uncompressed tar archive is
> > signed, so I don't think this is out of the question.
>=20
>=20
> This is a very kernel.org-centric view of things, I think. I have rarely
> seen PGP signatures applied to the uncompressed tar except in that
> context. The vast majority of tarballs with signatures have signed a
> single compressed tarball and don't concern themselves with, say,
> providing a rotating backdated changeable list of compression formats
> with a single signature covering all of them.

Sure, and that's a valid approach if you have a consistent, persistent
tarball.  However, Git does not persist data forever in tarballs, and
people want to use different versions to get the same data, which is a
new guarantee that we'd be providing.  That is an easy guarantee to
provide with tar, but not an easy guarantee to provide with the gzip
format, as we've all just seen.

> >From experience, I can say that this needs to be selected on a
> per-tarball basis. Since signature files have filenames, we can match
> their stems and given foo.tar.asc and foo.tar.gz, check the signature of
> the output of gzip -dc < foo.tar.gz, but given foo.tar.gz.asc and
> foo.tar.gz, simply check the signature of the original foo.tar.gz.
>=20
> This doesn't really work for checksums, because you need to settle on
> one or the other everywhere or else embed decompression information into
> your checksum metadata field.

I don't think that's absolutely required.  You need to know how to
decompress the archive, and you can have a hash for the tarball before
decompression or after decompression, as well as possibly needing to
deal with multiple different hash algorithms.  I've implemented this
myself when I was a vendor of Git and lots of other software, and we
would take the hash of the compressed or decompressed archive as shipped
by the vendor and verify it, as long as the hash was sufficiently
strong.

> And for tarballs that are generated once and uploaded to ftp storage,
> not repeatedly generated on the fly, we know the checksum will never
> legitimately change, so we *want* to hash the compressed file.
> Decompressing kernel.org tarballs in order to run PGP on them is *slow*.
> Although at least one can verify the checksums first without
> decompression, which is virtually guaranteed to catch invalid source
> code releases, so if you ever progress to the PGP verification stage
> it's unlikely to be wasted effort -- that tarball is definitely getting
> used to build something.

Sure, and if you want to generate tarballs once and upload them to
storage, go ahead.  That's always an option.  Even GitHub provides you
the option to do that with release assets if you want.

My proposal is to provide deterministic archives in a functionally and
practically achievable way with nothing more than a version of Git,
which I think we can do with tar, but not gzip.  I'm happy to be proven
wrong if you can develop a spec for canonical gzip compression.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--6OI/8T1qYEvIefLD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9nBdQAKCRB8DEliiIei
gYlIAQCoiC/cBIBrdJa44E8mGClfVavh8p9sJt+1ziJYNaat1QEA6rlgC3oXjc66
ox8ZJcbR9WaIUFvS5el+rmm9nj25oAA=
=VRCv
-----END PGP SIGNATURE-----

--6OI/8T1qYEvIefLD--
