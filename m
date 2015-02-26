From: David Kastrup <dak@gnu.org>
Subject: Re: weird behaviour in git
Date: Thu, 26 Feb 2015 16:54:30 +0100
Message-ID: <87sidsbrd5.fsf@fencepost.gnu.org>
References: <20150226141234.GP19896@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Klausner <tk@giga.or.at>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:54:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR0ls-0008Lj-2L
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 16:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbbBZPye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2015 10:54:34 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:60583 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbBZPyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 10:54:33 -0500
Received: from localhost ([127.0.0.1]:59623 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YR0lj-0001Uy-Ob; Thu, 26 Feb 2015 10:54:31 -0500
Received: by lola (Postfix, from userid 1000)
	id F01A2DF676; Thu, 26 Feb 2015 16:54:30 +0100 (CET)
In-Reply-To: <20150226141234.GP19896@danbala.tuwien.ac.at> (Thomas Klausner's
	message of "Thu, 26 Feb 2015 15:12:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264449>

Thomas Klausner <tk@giga.or.at> writes:

> I've played around with git and found that 'git mv' does not honor
> what I tell it to do:
>
> wiz@yt:~> mkdir a
> wiz@yt:~> cd a
> wiz@yt:~/a> git init .
> Initialized empty Git repository in /home/wiz/a/.git/
> wiz@yt:~/a> touch a
> wiz@yt:~/a> git add a
> wiz@yt:~/a> git commit -m 'add a'
> [master (root-commit) 99d0ee7] add a
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 a
> wiz@yt:~/a> git mv a b
> wiz@yt:~/a> touch Makefile
> wiz@yt:~/a> git add Makefile
> wiz@yt:~/a> git commit
>
>
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be ignored, and an empty message aborts the commit.
> # On branch master
> # Changes to be committed:
> #       renamed:    a -> Makefile
> #       new file:   b
> #

git mv was tasked with removing file a and creating file b with the sam=
e
content and permissions.  It did so successfully.

"Changes to be committed" states an interpretation consistent with that=
=2E

Now it is entirely silly in my book to describe files as "renamed" that
are actually empty and thus do not contain a single common byte.
I=A0would call that change description a bug or at least a "misfeature"=
=2E

git mv, however, did exactly what it was tasked to do and could not
possibly do anything better since Git does, by design, not ever track
file operations.

> This is reproducible for me with "git version 2.3.0" on
> NetBSD-7.99.5/amd64.
>
> I guess this happens because the checksums of the files are the same
> and 'Makefile' is earlier when sorting, but since I explicitly told
> "git mv" old and new name, I think that's a bug nevertheless.

No.  Git mv is just a convenience command for deleting one file and
creating another one with the same contents.  Git has no concept of fil=
e
renames in its repository, so git mv cannot record anything there that
could not be interpreted exactly like the commit info interpreted it.

It's nonsensical and should in my opinion rather be stated as

# Changes to be committed:
#       removed:    a
#       new file:   Makefile
#       new file:   b

But that's not the fault of Git mv.

--=20
David Kastrup
