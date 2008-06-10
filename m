From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH 0/4] remote show/prune improvement
Date: Tue, 10 Jun 2008 16:50:13 +0200
Message-ID: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
References: <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:51:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65Bg-0003en-LY
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYFJOuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:50:10 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbYFJOuK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:50:10 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:49356 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbYFJOuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:50:09 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 89C6012B6C6;
	Tue, 10 Jun 2008 16:50:07 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 125EB12B6A9;
	Tue, 10 Jun 2008 16:50:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.160.gd660c
In-Reply-To: <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84507>

=46rom: Olivier Marin <dkr@freesurf.fr>

Junio C Hamano a =C3=A9crit :
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
>> On Mon, 9 Jun 2008, Olivier Marin wrote:
>>
>>> diff --git a/builtin-remote.c b/builtin-remote.c
>>> index c49f00f..efe74c7 100644
>>> --- a/builtin-remote.c
>>> +++ b/builtin-remote.c
>>> @@ -421,10 +421,10 @@ static void show_list(const char *title, stru=
ct path_list *list)
>>> =20
>>>  static int show_or_prune(int argc, const char **argv, int prune)
>>>  {
>>> -	int dry_run =3D 0, result =3D 0;
>>> +	int no_query =3D 0, result =3D 0;
>> Just for the record (not that I think anybody will care): I do not l=
ike=20
>> this change.
>=20
> I do not think nobody cares ;-).
>=20
> At least I care enough to point out that I think you are wrong in thi=
s
> case.  "show -n" in the scripted version was never about "dry-run" bu=
t
> was about "no-query".
>=20
> The problem with the area of the code this patch touches is that comp=
ared
> to the scripted version, show and prune now share their codepaths a b=
it
> more, and it is less easy to keep -n disabled for prune (I think it i=
s a
> nonsense because you cannot "prune" sensibly without looking at what =
the
> remote has.  It was a bug in the scripted version and losing it in C
> rewrite was a "silent bugfix") while resurrecting -n for show (which =
is a
> quick way to view where the URL points at without bothering to see wh=
at
> remote branches there are).
>=20
> I think a sensible thing to do would be to:
>=20
>  - Agree that "-n" in the sense that "do not query" and "--dry-run" i=
n the
>    sense that "do not do anything but report what you would do" are
>    different options.
>=20
>  - Resurrect "show -n" as a quick way to view URLs without bothering =
to
>    contact the remote end that is needed to show "the tracked branche=
s"
>    information.
>=20
>  - Forbid "prune -n", which is nonsense.
>=20
>  - Make "prune --dry-run" truly useful --- contact the other end, and
>    report what will be pruned without really pruning them.
>=20
>  - Perhaps as an enhancement, "show -n" could show what tracking bran=
ches
>    we have from the remote, even though the information may be stale.
>    The scripted version did not do this, I think, and it would be an
>    improvement.

  [1/4] remote show: fix the -n option
  [2/4] builtin-remote: split show_or_prune() in two separate functions=
=2E
  [3/4] remote prune: print the list of pruned branches
  [4/4] remote show: list tracked remote branches with -n.

 Documentation/git-remote.txt |    9 +--
 builtin-remote.c             |  160 ++++++++++++++++++++++++++++++----=
--------
 t/t5505-remote.sh            |   36 ++++++++++
 3 files changed, 154 insertions(+), 51 deletions(-)

Olivier.
