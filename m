From: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: Tue, 26 Nov 2013 19:55:06 -0800
Message-ID: <9AB10474-6DEF-4FFD-B6B3-ED2AB21424AC@mac.com>
References: <2E636B58-47EB-4712-93CA-39E8D1BA3DB9@mac.com>
 <5294BB97.7010707@web.de> <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 04:55:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlWEH-0002Ih-IC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 04:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab3K0Dzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 22:55:47 -0500
Received: from nk11p03mm-asmtp001.mac.com ([17.158.232.236]:57138 "EHLO
	nk11p03mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751966Ab3K0Dzq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 22:55:46 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MWW008HILKMV520@nk11p03mm-asmtp001.mac.com> for
 git@vger.kernel.org; Wed, 27 Nov 2013 03:55:36 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-11-27_02:2013-11-26,2013-11-27,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1311260232
In-reply-to: <xmqqmwkqvmck.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238406>


On 26 Nov 2013, at 14:18, Junio C Hamano <gitster@pobox.com> wrote:

> Ren=E9 Scharfe <l.s.r@web.de> writes:
>=20
>> Thanks for the patches!  Please send only one per message (the secon=
d
>> one as a reply to the first one, or both as replies to a cover lette=
r),
>> though -- that makes commenting on them much easier.
>>=20
>> Side note: Documentation/SubmittingPatches doesn't mention that (yet=
),
>> AFAICS.
>=20
> OK, how about doing this then?
>=20
> Documentation/SubmittingPatches | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
> index 7055576..304b3c0 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -140,7 +140,12 @@ comment on the changes you are submitting.  It i=
s important for
> a developer to be able to "quote" your changes, using standard
> e-mail tools, so that they may comment on specific portions of
> your code.  For this reason, all patches should be submitted
> -"inline".  If your log message (including your name on the
> +"inline".  A patch series that consists of N commits is sent as N
> +separate e-mail messages, or a cover letter message (see below) with
> +N separate e-mail messages, each being a response to the cover
> +letter.
> +
> +If your log message (including your name on the
> Signed-off-by line) is not writable in ASCII, make sure that
> you send off a message in the correct encoding.
>=20
>=20
>>> The feature is disabled for remote repositories as
>>> the git_work_tree fails. This is a possible future
>>> enhancement.
>>=20
>> Hmm, curious.  Why does it fail?  I guess that happens with bare
>> repositories, only, right?  (Which are the most likely kind of remot=
e
>> repos to encounter, of course.)
>=20
> Yeah, I do not think of a reason why it should fail in a bare
> repository, either. "git archive" is about writing out the contents
> of an already recorded tree, so there shouldn't be a reason to even
> call get_git_work_tree() in the first place.
>=20
See below for a discussion of why I use the .git file in the work tree =
to=20
load the objects for the submodule. I also thought it should work in a
remote repository - but I ran it on a properly initialized remote repos=
itory and
it failed. Since I didn=92t need it for my immediate use-case I just de=
cided to disable=20
it with an error. I can look into this further, but we must decide abou=
t the question=20
below first=85

> Even if the code is run inside a repository with a working tree,
> when producing a tarball out of an ancient commit that had a
> submodule not at its current location, --recurse-submodules option
> should do the right thing, so asking for working tree location of
> that submodule to find its repository is wrong, I think.  It may
> happen to find one if the archived revision is close enough to what
> is currently checked out, but that may not necessarily be the case.
>=20
> At that point when the code discovers an S_ISGITLINK entry, it
> should have both a pathname to the submodule relative to the
> toplevel and the commit object name bound to that submodule
> location.  What it should do, when it does not find the repository
> at the given path (maybe because there is no working tree, or the
> sudmodule directory has moved over time) is roughly:
>=20
> - Read from .gitmodules at the top-level from the tree it is
>   creating the tarball out of;
>=20
> - Find "submodule.$name.path" entry that records that path to the
>   submodule; and then
>=20
> - Using that $name, find the stashed-away location of the submodule
>   repository in $GIT_DIR/modules/$name.
>=20
> or something like that.
>=20
> This is a related tangent, but when used in a repository that people
> often use as their remote, the repository discovery may have to
> interact with the relative URL.  People often ship .gitmodules with
>=20
> 	[submodule "bar"]
>        	URL =3D ../bar.git
> 		path =3D barDir
>=20
> for a top-level project "foo" that can be cloned thusly:
>=20
> 	git clone git://site.xz/foo.git
>=20
> and host bar.git to be clonable with
>=20
> 	git clone git://site.xz/bar.git barDir/
>=20
> inside the working tree of the foo project.  In such a case, when
> "archive --recurse-submodules" is running, it would find the
> repository for the "bar" submodule at "../bar.git", I would think.
>=20
> So this part needs a bit more thought, I am afraid.

I see that there is a lot of potential complexity around setting up a s=
ubmodule:
* The .gitmodules file can be dirty (easy to flag, but should we allow =
archive to proceed?)
* Users can mess with settings both prior to git submodule init and bef=
ore git submodule update.
* What if it=92s a raw clone and the user manually changes things betwe=
en init and update?
* I=92m not a git-internals expert but looking through the code I see t=
hat you can add additional object
directories and change paths as you show above.

=46or those reasons I deliberately decided not to reproduce the above l=
ogic all by myself.
On the other hand, what it *did* seem to me is that once you have the .=
git file
then you know you=92ve got all that covered. So I just used that. This =
restricts the function to
working only on a properly setup repository - but that is my use case!

If you think that doing this more extensive setup is even *viable* give=
n the space between
init and update then I=94m happy to try it. I didn=92t want to start of=
f on a fools errand.

>=20
>>> 'git archive' [--format=3D<fmt>] [--list] [--prefix=3D<prefix>/] [<=
extra>]
>>> 	      [-o <file> | --output=3D<file>] [--worktree-attributes]
>>> +	      [--recursive|--recurse-submodules]
>>=20
>> I'd expect git archive --recurse to add subdirectories and their
>> contents, which it does right now, and --no-recurse to only archive =
the
>> specified objects, which is not implemented.  IAW: I wouldn't normal=
ly
>> associate an option with that name with submodules.  Would
>> --recurse-submodules alone suffice?
>=20
> Jens already commented on this, and I agree that --recursive should
> be dropped from this patch.
I only put =97recursive because that is what git-clone has for it=92s b=
ehaviour wrt submodules.
If that flag is deprecated then I=92m fine with using only =97recurse-s=
ubmodules
Perhaps a deprecation flag or note in the code would help?


Overall I=92m impressed by the speed and quality of the responses (and =
the codebase!) so am glad to
move this forward. I look forward to your feedback.

Kind Regards
Nick
