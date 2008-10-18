From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Archiving tags/branches?
Date: Sat, 18 Oct 2008 12:23:45 +0200
Message-ID: <20081018102345.GA3749@neumann>
References: <48F93F52.4070506@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 12:25:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr8zv-0007BT-Ev
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 12:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbYJRKXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 06:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbYJRKXw
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 06:23:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbYJRKXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 06:23:51 -0400
Received: from [127.0.1.1] (p5B132E70.dip0.t-ipconnect.de [91.19.46.112])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1Kr8yI08E0-0002gW; Sat, 18 Oct 2008 12:23:46 +0200
Content-Disposition: inline
In-Reply-To: <48F93F52.4070506@pcharlan.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/89iiXoE8nErmK0oVvMTkPrs+i5Htxsx8d/UR
 DLf9GGRUYEYYAwOzQ3SR0+muY/jl5fAsxVG735gEqV8F+aJDFE
 MXZJGGkp/jWF1FUuy8E2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98536>

Hi Pete,

On Fri, Oct 17, 2008 at 06:43:46PM -0700, Pete Harlan wrote:
>  If I wanted to archive those, it looks like this would work:
>=20
> mkdir .git/refs/archived-tags
> cp -a .git/refs/tags/* .git/refs/archived-tags
> git tag -d <tag-to-hide> # repeat as necessary
>=20
> I can then maintain a short list of tags that currently interest me, =
but
> am guaranteed not to lose old branches (say) referenced by those tags=
=2E
>=20
> Is there a reason this won't work?

Yes:

$ git --version
git version 1.6.0.2.574.g7d0e0
$ git init
Initialized empty Git repository in /home/szeder/tmp/git/archive/.git/
$ echo 1 >foo
$ git add foo
$ git commit -m bar
Created initial commit 0c92489: bar
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ git tag t
$ git update-ref refs/archived-tags/t t
$ git tag -d t
Deleted tag 't'
$ cat .git/refs/archived-tags/t
0c92489da6ec6dfd9875eb590d820fcceb01829b
$ git gc
Counting objects: 3, done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
$ cat .git/refs/archived-tags/t
cat: .git/refs/archived-tags/t: No such file or directory

So, if you put any tags or branches under refs/whatever-non-standard/,
then it gets deleted when you gc (or when gc is run automatically).

I don't know whether this behaviour is intentional or not, but I have
experienced this the hard way recently.

Regards,
G=E1bor
