From: Mike Gerwitz <mikegerwitz@gnu.org>
Subject: Re: git log --pretty="format:%H$t%aN$t%s$t%G?" --show-signature
Date: Sat, 06 Dec 2014 00:46:32 -0500
Message-ID: <87wq65z5xj.fsf@gnu.org>
References: <54809802.6030609@whonix.org> <871tofuw7h.fsf@gnu.org>
	<xmqqk327ruh8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Patrick Schleizer <patrick-mailinglists@whonix.org>,
	git@vger.kernel.org, Whonix-devel <whonix-devel@whonix.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 06:46:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx8Co-0005s1-9W
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 06:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbaLFFqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 00:46:54 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:47211 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbaLFFqx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 00:46:53 -0500
Received: from cpe-69-204-47-184.buffalo.res.rr.com ([69.204.47.184]:46171 helo=mikegerwitz-pc.gerwitz.local.gnu.org)
	by fencepost.gnu.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <mikegerwitz@gnu.org>)
	id 1Xx8Cf-0007Ou-QD; Sat, 06 Dec 2014 00:46:50 -0500
In-Reply-To: <xmqqk327ruh8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 04 Dec 2014 13:11:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260940>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for the input, Junio.

On Thu, Dec 04, 2014 at 13:11:15 -0800, Junio C Hamano wrote:
> I am however not quite sure what conclusion you are trying to drive
> at by contrasting approaches #2 and #3.  The perceived problem of
> approach #2, if I am reading you correctly, is that the merge is
> what you vouch for but the commits on the side branch are not signed
> so there is no way for you (as the merge creator) to point fingers
> to when the result of the merge turns out to be problematic.  The
> argument for approach #3 would be that it would give you (as the
> merge creator) somebody to point fingers to if you forced others who
> ask you to pull from them to sign their commits.

I had to take another look at the article to see if my opinions have
since changed.

My argument for Option #3 (signing each commit) was that it explicitly
denotes that a particular commit was reviewed; signing a merge commit
states that implicitly.

I personally sign any commit on master; usually, this is a merge
commit.  But this is because I have a high level of confidence in the
integrity of my system, my ability to notice commits that are not likely
to be my own, and because the auditing requirements of my software are,
well, non-existent.

My wife was recently watching Elf (the movie), which had an interesting
example, so I'll make use of it:  One of the characters works for a
publishing company.  A children's book was printed, but was missing
content on the last two pages.  The character was responsible for
signing off on the book.  His boss stormed in, and the character used
the excuse that something must have gone wrong during printing; but his
boss pulled out the proofs that went to press---each page had the
character's initials, including the blank ones.

Signing each commit is like initialing each page.  Of course, these
scenarios are drastically different---a page of a book is its own
finished result, whereas a commit is more likely to be a single
component of a larger feature.  But adapt it how you will.

Another possibility is that a malicious commit could be hidden within a
changeset by introducing another commit that later reverts the change;
there would be nothing in the diff between `topic' and `HEAD', but an
operation like `bisect' could check out the commit and run malicious
code.  So the question is then: does the signing of the merge commit
indicate review of the diff, or review of each commit?

If the review of each commit doesn't matter, does the history matter?
In which case, is squashing the better option?

> Does it absolve you from blame if you can say with certainty (thanks
> to GPG keys on them) that those commits on the side branch that adds
> unwanted (from 'maint' policy's point of view) new feature were made
> by somebody else, because the project used the approach #3?
>
> Not really.

You might be thinking that I'm suggesting that the merge commit carry a
different signature than the commits on the side branch.  That's
certainly an option, but wasn't what I was referring to, since the
GPG-signature of the author doesn't indicate that the code was reviewed
by the person responsible for doing so.  And no additional review data
(e.g. a Signed-off-by) can be added to the commit object without
invalidating the signature of the author (except by notes, or a similar
concept).  So in this case, if you truly do want to maintain the
signature of the author (I would!), you must sign the merge commit and
indicate the review of each commit in some other manner, or rely on the
implicit assumption that each commit has been reviewed.

And that may not be a problem.

Instead, Option #3 was stating that the person responsible for merging
would also be responsible for signing each individual commit, as a means
of stating "yep, this was reviewed".

> When you sign your merge with "merge -S", you are vouching for the
> contents of the whole tree, not just "I made this merge, but I don't
> have anything to do with what it pulled in."  It does not really
> matter to the end users where the changes came from.  You are
> certifying that "git diff HEAD^ HEAD" after making the merge is what
> you are pleased with by signing the merge.

And `git diff HEAD^ HEAD' may show nothing wrong, as I mentioned
above.  But otherwise, yes, you're correct.  The goal would not be to
absolve blame in this scenario.  The only goal of signing each commit
would be to provide confidence to those who may care about the depth of
the review process.

Rather, it is the _absence_ of a GPG-signed merge that would be the
problem, since you can't assert your identity in that case.  If you have
GPG-signed the merge, then you've avoided the problems in the "horror
story" part of the article, but you've introduced a whole new set of
them if you introduced bad changes, since you now can't deny it. ;)

> But ultimately, the responsibility lies on the person who creates
> the topmost merge and advances the tip of the history the users of
> the end product of the project considers the authoritative one.

Indeed.

I would like to take some time to catch up on all the changes that have
been made since I wrote that article, and look through the mailing list
to see your philosophy and others' regarding Git's signing
features.  The thought experiment that prompted my article was
considering what may happen if a coworker decided to commit as me, and
do so maliciously (ironically, we still don't sign commits at work, but
it'll be coming).  This would be an inside job---that coworker would
have access to the repository, and the only way I could assert my
identity is cryptographically or through server logs, the latter of
which could still be modified with root access.  By introducing signed
pushes, Git has actually solved that problem in a less invasive way that
is practical for internal use (though less so for a larger community
wanting to observe repository integrity on their own, but that's not
what it's for).

- -- 
Mike Gerwitz
Free Software Hacker | GNU Maintainer
http://mikegerwitz.com
FSF Member #5804 | GPG Key ID: 0x8EE30EAB
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJUgpg5AAoJEPIruBWO4w6rZ6IQALRiJOUeYNIJGVdbpJ9uynda
p7HuWkJyF6lSSyk8hPFCrGKde5YmwD6tsW9xxnwSCIw8qRvMPPRxDFH4P8KzzWMm
jwe/QWVRiobJ1uViSawpvfrrrK1ZnrScIGW9MuJtuURuZtazvf913OOwZKIm5Qnm
NWy3Xv9P1wqhOYnYSKUd6LbJFTT8MH6bG9U13rkZ7YXUDIygAAjCNAZmfmTJ+hv2
KUwYlHSQd0VtbI09cB9+oUVRFwK3Bmek6TgVb7MJlCNSKn2y+8EZWE9MYdKKl2tN
opgqTUjTIaqn50JtspvKYJpMkOA17+MtHXUG5Q0gMZjw69mueXl+MaSJSr8YDkSb
AAAsr0NYscK7iwDs8xCZCV6aROirL0XtuGazvFQ6Fma5bvl0xtVEowPsJK4Qb17c
mvn0Z8wKUQvMcM71iNQGg/uBJvFfmJG6PYujFJ1pOnt2b3w5b53sgL3Dq5Eo54Za
IJY7cqZOSWyKzkYWO3uL+FdkPq79BIQFalVBooaEyC8lno3BQH+zb45czYDhB/gr
D8eLnCDQTq/or118jYWmZw+UFXvYvwu6S5g4p9pVpTRKvnvA/VbDoNINeMRhVSdY
tw3pEhvp06IVQeoJwXAffvtBdC32ohcQCPHkMh8WQAHqbBw9FjKiA8Yk7ordrDyU
a73dxZuXMt1VxTBeLyjy
=ui4w
-----END PGP SIGNATURE-----
