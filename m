From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: rerere fails to record resolution if file doesn't exist in merge
	base
Date: Mon, 9 Jul 2007 09:07:25 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070709070725.GA4445@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 09:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7nLJ-0004YP-Ek
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 09:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXGIHHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Jul 2007 03:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbXGIHHb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 03:07:31 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:35539 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124AbXGIHHa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 03:07:30 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I7nLE-00054C-UN
	for git@vger.kernel.org; Mon, 09 Jul 2007 09:07:29 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6977R3A004890
	for <git@vger.kernel.org>; Mon, 9 Jul 2007 09:07:27 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6977QOo004889
	for git@vger.kernel.org; Mon, 9 Jul 2007 09:07:26 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51965>

Hello,

Some time ago, I sent a test for that[1], but the patch doesn't apply
anymore.

Anyhow, the failure still exists, even though the original report was
sent when rerere was still a perl script ...

	zeisberg@cassiopeia:/tmp/rerere$ git init
	Initialized empty Git repository in .git/
	zeisberg@cassiopeia:/tmp/rerere$ mkdir .git/rerere
	zeisberg@cassiopeia:/tmp/rerere$ echo just something to commit > file
	zeisberg@cassiopeia:/tmp/rerere$ git add file
	zeisberg@cassiopeia:/tmp/rerere$ git commit -m 1
	Created initial commit 51384cb: 1
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 file
	zeisberg@cassiopeia:/tmp/rerere$ git branch b
	zeisberg@cassiopeia:/tmp/rerere$ echo lala > lolo
	zeisberg@cassiopeia:/tmp/rerere$ git add lolo
	zeisberg@cassiopeia:/tmp/rerere$ git commit -m 2
	Created commit 98b91cc: 2
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 lolo
	zeisberg@cassiopeia:/tmp/rerere$ git checkout b
	Switched to branch "b"
	zeisberg@cassiopeia:/tmp/rerere$ echo lali > lolo
	zeisberg@cassiopeia:/tmp/rerere$ git add lolo
	zeisberg@cassiopeia:/tmp/rerere$ git commit -m 2a
	Created commit bb900f3: 2a
	 1 files changed, 1 insertions(+), 0 deletions(-)
	 create mode 100644 lolo
	zeisberg@cassiopeia:/tmp/rerere$ git pull . master
	Auto-merged lolo
	CONFLICT (add/add): Merge conflict in lolo
	Automatic merge failed; fix conflicts and then commit the result.
	zeisberg@cassiopeia:/tmp/rerere$ perl -n -i -e "print if /^l/" lolo
	zeisberg@cassiopeia:/tmp/rerere$ cat lolo
	lali
	lala
	zeisberg@cassiopeia:/tmp/rerere$ git rerere
	zeisberg@cassiopeia:/tmp/rerere$=20

In my eyes the last command should have recorded the resolution for
lolo, shouldn't it?

Best regards
Uwe

[1] http://article.gmane.org/gmane.comp.version-control.git/19267

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+stone%3D
