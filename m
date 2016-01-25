From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Mon, 25 Jan 2016 09:26:31 -0800
Message-ID: <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
References: <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
	<20160120002606.GA9359@glandium.org>
	<xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
	<DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
	<20160122023359.GA686558@vauxhall.crustytoothpaste.net>
	<20160122055255.GA14657@sigill.intra.peff.net>
	<20160122060720.GA15681@sigill.intra.peff.net>
	<20160124143403.GL7100@hank>
	<xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
	<xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
	<20160125144250.GM7100@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 18:26:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNkum-0000Nl-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 18:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933951AbcAYR0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2016 12:26:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932812AbcAYR0f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2016 12:26:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7AE83E2B3;
	Mon, 25 Jan 2016 12:26:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NCzw7q84qupb
	lzRWjuNg6J0gN90=; b=XQ8UwKBnKE6Dks80g02gTcdufttMyJO6W2HzWK839Wjs
	XTlVBaltzi9h1jU58j5HHplme7HL/jy06f4uD9xEQhbTzi7qgAQzDg2syyo6fiHK
	U0JnxSr9m6/5ApQca6+hSmj5sTEHgWgiP7GxWi57i2MW0lj6Lw25aDDQJde+ido=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ExNc/M
	9kr+eLscnS+/BSvRh6s9eDCnUTflZMiak+hp9n5CmRql3K3BMAb+SNlHi4D+S99G
	ovn6ceNVpOW/sTKdt/kg1hb632Rq3Dcu0WTvENqtG44XdsTfj/t4wxb/jfUeG17r
	nw0vLLwLSAnWtRIBnbbXUfaERriOoOqIvnMB8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE8093E2B2;
	Mon, 25 Jan 2016 12:26:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CD2A3E2B0;
	Mon, 25 Jan 2016 12:26:33 -0500 (EST)
In-Reply-To: <20160125144250.GM7100@hank> (Thomas Gummerer's message of "Mon,
	25 Jan 2016 15:42:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C74D00EE-C388-11E5-8220-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284742>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 01/24, Junio C Hamano wrote:
>> To put it differently, if a blob stored at path has CRLF line
>> endings and .gitattributes is changed after the fact to say that it
>> must have LF line endings, we should treat it as a broken transitory
>> state.
>
> Right, I wasn't considering this as a broken state, because t0025 use=
s
> just this to transition between the states.
>
>> There may have to be a way to "fix" an already "wrong" blob
>> in the index that is milder than "rm --cached && add .", but I do
>> not think write_entry(), which is shared by all the normal codepaths
>> that writes out to the working tree, is the best place to do so, if
>> doing so forces the contents of the paths to be always re-checked,
>> just in case the user is in such a broken transitory state.
>
> Maybe I'm misunderstanding something, but the contents of the paths
> are only re-checked if we are in such a broken transition state, and

What I do not understand here is how the added check ensures that
"only if in such a broken transition state".  would_convert_to_git()
does not take the contents but is called only with the pathname to
key into the attributes, so in a typical cross platform project
where all the source files are "text" and the repository can set
core.eol to adjust the end of line convention for its working tree,
the added check has no way to differentiate the paths that are
recorded with CRLF line endings in the object database by mistake,
i.e. the ones in the broken transitory state, and all the other
paths that are following the "text" and storing their blobs with LF
line endings.  The added check would trigger "is it racy" check to
re-reads the contents that we have written out from the working tree
for the paths with "wrong" blobs, but how would it avoid doing so
for the paths whose blobs are already stored correctly?

The new code affects not just "reset --hard", but everybody who
writes out from the object database to the working tree and records
that these paths are checked out in the index.  How does the new
code avoid destroying the performance for all paths?

> the file stored in git has crlf line endings, and thus would be
> normalized.  In this case we currently re-check the contents of that
> file anyway, at least when the file and the index have the same mtime=
,
> and we actually show the correct output.

The right way to at that "correct output", I think, is that it
happens to be shown that way by accident.  It is questionable that
it is correct to report that such a path is modified.  Immediately
after you check out a path to the working tree out of the index, via
"reset --hard" and "checkout $path", by definition it ought to be
the same between the working tree file and the index.

Unless it is in this transititory broken state, that is.

The "by accident" happens only because racy-git avoidance is being
implemented in one particular way.  Is about protecting people from
making changes to the working tree files immediately after their
previous contents are registered to the index (and the index files
written to the disk), and immediately after we write things out of
the index and by definition the result and the indexed blob ought to
match there is no reason to re-read and recheck unless the working
tree files are further edited.

The current way the racy-git avoidance works by re-reading and
re-checking the contents when the timestamps match is merely one
possible implementation, and that is the only thing that produces
your "correct" output most of the time in this test.  We could have
waited after writing the index time for a second before giving the
control back to the user instead, which would have also allowed us
to implement the racy-git avoidance, and in that alternate world,
all these transitory broken paths would have been correctly reported
as unmodified.

IOW, I would think the test in question is insisting a single
outcome for an operation whose result is undefined, and it is
harmful to twist the system by pessimizing the common cases just
to cater to this transititory broken state.

I am not saying that we shouldn't have support for users to fix
their repository and get out of this transititory broken state.  A
recent work by Torsten B=C3=B6gershausen to have ls-files report the en=
d
of line convention used in the blob in the index and the settings
that affect conversion for each path (among other things) is a step
in the right direction.  With a support like that, those who noticed
that they by mistake added CRLF files to the index as-is when they
wanted their project to be cross platform can recover from it by
setting necessary attributes (i.e. mark them as "text") and then
find paths that are broken out of "ls-files --eol" output to see
which ones are not using lf end-of-line in the index.

I do not think there is a canned command to help dealing with these
broken paths right now.  You would have to check them out of the
index (you would get a CRLF file in the working tree in the example
we are discussing), fix the line endings (you would run dos2unix on
it in this example, as you would want "text=3Dtrue" attribute) and
"git add" them to recover manually, but I can imagine that Torsten's
work can be extended to do all of these, without molesting the
working tree files, with minimum work by the end user.  That is:

 * Reuse Torsten's "ls-files --eol" code to find paths that record
   the blob in the index that does not follow the eol convention
   specified for the path;

 * For each of these index entries, run convert_to_working_tree() on
   the indexed contents, and then on the result of it, run
   convert_to_git().  The result is the blob that the index ought to
   have had, if it were to be consistent with the attribute
   settings.  So add that to the index.

 * Write the index out.

 * Tell the user to commit or commit it automatically with a canned
   log message "fix broken encoding" or something.
