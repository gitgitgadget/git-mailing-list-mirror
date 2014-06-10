From: Dale Worley <worley@alum.mit.edu>
Subject: Re: Git reset --hard with staged changes
Date: Tue, 10 Jun 2014 01:03:09 +0000 (UTC)
Message-ID: <loom.20140610T025754-449@post.gmane.org>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com> <CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com> <87vbsayy9w.fsf@fencepost.gnu.org> <CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 03:15:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuAej-0005nW-KK
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 03:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbaFJBPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2014 21:15:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:34189 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbaFJBPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 21:15:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WuAeW-0005cj-Uc
	for git@vger.kernel.org; Tue, 10 Jun 2014 03:15:05 +0200
Received: from c-24-34-72-61.hsd1.ma.comcast.net ([24.34.72.61])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 03:15:04 +0200
Received: from worley by c-24-34-72-61.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 03:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.34.72.61 (Mozilla/5.0 (X11; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251151>

=46rom: Pierre-Fran=C3=A7ois CLEMENT <likeyn <at> gmail.com>
> You create a new (untracked) file.
> You use git-reset's hard mode to go one commit back, the new
> (untracked) file's still there.
> You add/stage that new file.
> You use git-reset's hard mode again to go one commit back, and the ne=
w
> untracked file you just staged gets deleted.
>=20
> Also, according to Git-scm
> (http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repos=
itory):
>=20
> "Tracked files are files that were in the last snapshot [...].
> Untracked files are everything else."
>=20
> So it seems to me like staged untracked files shouldn't be considered
> as tracked files, and thus shouldn't be removed. Or maybe, git-reset'=
s
> hard mode should always delete everything including untracked files?
> It would also make sense, given the numerous modes it has.

There's a core question that must be answered:  What, *exactly*, is a
"tracked file"?

If you look at that passage in the book, it continues:

"Tracked files are files that were in the last snapshot; they can be
unmodified, modified, or staged. Untracked files are everything else =E2=
=80=94 any
files in your working directory that were not in your last snapshot and=
 are
not in your staging area."

But if you look carefully, that passage gives two definitions of "untra=
cked
files", and *they don't agree*, specifically in the case of a file that=
 is
in the index but not in the base commit.  And that's the case we're con=
sidering.

To fix this, you've got to figure out what the definition of "tracked f=
ile"
is supposed to be, and then ensure that everything (code and documentat=
ion)
is consistent with that.

(As far as I can tell from Git's behavior, the definition of tracked fi=
le is
"any file that is in the base commit or in the index".  Based on that
definition, "git reset --hard" is working as documented.)

Dale
