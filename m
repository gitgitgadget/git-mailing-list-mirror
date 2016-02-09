From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Tue, 09 Feb 2016 12:37:32 -0800
Message-ID: <xmqqziv939ir.fsf@gitster.mtv.corp.google.com>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
	<alpine.DEB.2.20.1602061518220.2964@virtualbox>
	<25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
	<alpine.DEB.2.20.1602061708220.2964@virtualbox>
	<CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
	<32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
	<CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
	<20160208141552.GC27054@sigill.intra.peff.net>
	<20160208150709.GA13664@sigill.intra.peff.net>
	<xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
	<20160208195230.GA30693@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTF2a-0001I6-5T
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbcBIUhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:37:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932222AbcBIUhf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 15:37:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E6E54284E;
	Tue,  9 Feb 2016 15:37:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FZvBTxGk7YIxdo2PfaQp9wKjcfo=; b=fhyu2b
	9rsZqAN4YeY5bmP7w535kAH1XPsgV+Vq/AiRuJ5m+mA4FzeQpmrePfRol7ETKIzN
	ztN1p6w23AbFncLHXN2XHTHTNrqtq2JTSV/6m86+XaX5NSi3v9iQ4pVWAB9no+7I
	AdOUrGbkHgk+0KFkrdlQG43w89tfnZGaTVXUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VfG+m8P0aza6A/vbOoV6BKqNFcDFMxPi
	oSrr0USmuSbnMsicrF3dDhMl/Uk19l/bie4KlJ9Stcv1CnxSxUY56CYFmHgG2VY1
	VMQZvYpcPflht7UECxsWDfkkJgCgt2uPlFdANqTK+8eYyUmJ50DekxNiuIMO2o12
	JTmllaTWkV8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 565664284D;
	Tue,  9 Feb 2016 15:37:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB3F04284C;
	Tue,  9 Feb 2016 15:37:33 -0500 (EST)
In-Reply-To: <20160208195230.GA30693@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 8 Feb 2016 14:52:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F288F0E8-CF6C-11E5-91D5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285856>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] check_filename: tighten requirements for dwim-wildcards
>
> Commit 28fcc0b (pathspec: avoid the need of "--" when
> wildcard is used, 2015-05-02) introduced a convenience to
> our dwim-parsing: when "--" is not present, we guess that
> items with wildcard characters are probably pathspecs.
>
> This makes a lot of cases simpler (e.g., "git log '*.c'"),
> but makes others harder. While revision expressions do not
> typically have wildcard characters in them (because they are
> not valid in refnames), there are a few constructs where we
> take more arbitrary strings, such as:
>
>   - pathnames in tree:path syntax (or :0:path) for the
>     index)
>
>   - :/foo and ^{/foo} for searching commit messages;
>     likewise "^{}" is extensible and may learn new formats
>     in the future
>
>   - @{foo}, which can take arbitrary approxidate text (which
>     is not itself that likely to have wildcards, but @{} is
>     also a potential generic extension mechanism).
>
> When we see these constructs, they are almost certainly an
> attempt at a revision, and not a pathspec; we should not
> give them the magic "wildcard characters mean a pathspec"
> treatment.
>
> We can afford to be fairly slack in our parsing here. We are
> not making a real decision on "this is or is not definitely
> a revision" here, but rather just deciding whether or not
> the extra "wildcards mean pathspecs" magic kicks in.
>
> Note that we drop the tests in t2019 in favor of a more
> complete set in t6133. t2019 was not the right place for
> them (it's about refname ambiguity, not dwim parsing
> ambiguity), and the second test explicitly checked for the
> opposite result of the case we are fixing here (which didn't
> really make any sense; as show by the test_must_fail in the
> test, it would only serve to annoy people).
>
> Signed-off-by: Jeff King <peff@peff.net>

I was leaning towards merging this version, but I became unsure
while writing an entry for "What's cooking" (which will be used as a
merge summary message and then will appear in the Release Notes).

We would surely want

    $ git log ':/tighten.*'

to find this commit, not take it as a pathspec.  But running

    $ git log ':/*.c'

in a subdirectory to find commits that touched any .c file, taking
it as a pathspec, would equally be a sensible thing to want.

I would feel that we should require "--" for both cases; with or
without this patch, we already treat these as revs without "--",
making the latter fail without "--".  Also:

    $ git log "HEAD^{/tighten.*}"

is already dwimmed as a rev.

And a path with glob(3) metacharacters is an insane thing, be it
inside a treeish or in the working tree, and I think it is OK to
require users to explicitly say what they mean with "--".

And the patch does not leave much if we ignore that ":" bit.
With the patch, "HEAD@{now [or thereabouts]}" will be taken as a
rev without "--", which is an improvement, but to me that seems
to be the only improvement this change brings us.

And I do not think we want either glob(3) or fill_directory() to
slow things down, as this is merely a heuristic.

We may want to rethink the interface into check_filename().  The
callers of this function that try to help users who did not use "--"
want the function to say "It is likely that this was meant as a
pathname" and when this function says "No, the user did not mean it
as a filename." they will in turn ask the revision parser "Is this a
rev?".  At that point, if it is not a revision, these callers can
say "Not a file, not a rev" and die.

In order to allow "':/tighten.*' is a rev, ':/*.c' is a pathspec,
they are equally likely and you must disambiguate", the current
interface is inadequate.

 * check_filename() cannot say "No, it is not a filename"--a later
   call to get_sha1() will barf on ":/*.c" saying that it is not a
   rev, but the fault is in Git that initially guessed it would be a
   rev when the user meant it as a pathspec.

 * The function cannot say "Yes, it is a filename"--then get_sha1()
   will not be called for ":/tighten.*" and we would silently use it
   as pathspec, possibly producing an empty result.

There needs to be a way for it to say "I refuse to disambiguate".

I actually think that no_wildcard() check added in check_filename()
was the original mistake.  If we revert the check_filename() to a
simple "Is this a filename?" and move the "does this thing have a
wildcard" aka "can this be a pathspec even when check_filename()
says there is no file with that exact name?" to the code that tries
to allow users omit "--", i.e. the caller of check_filename(), would
that make the code structure and the semantics much cleaner, I
wonder...
