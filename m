From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 18:17:45 +0200
Message-ID: <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
References: <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org> <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 18:19:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dac5n-0000cv-JQ
	for gcvg-git@gmane.org; Tue, 24 May 2005 18:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVEXQSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 12:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVEXQSr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 12:18:47 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:45808 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262125AbVEXQSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 12:18:09 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OGHjS8013386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 16:17:45 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OGHjGm013385;
	Tue, 24 May 2005 18:17:45 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Linus,
I tried cvs2git and have the following problem:

	---------------------
	PatchSet 26
	Date: 1998/06/20 03:53:44
	Author: roessler
	Branch: mutt-0-93
	Ancestor branch: HEAD
	Tag: (none)
	Log:
	documenting alias-path

	Members:
		doc/manual.sgml:1.2->1.2.2.1

	---------------------

And your script does that:

	export GIT_COMMITTER_NAME=roessler
	export GIT_COMMITTER_EMAIL=roessler
	export GIT_AUTHOR_NAME=roessler
	export GIT_AUTHOR_EMAIL=roessler
	export GIT_AUTHOR_DATE='1998/06/20 03:53:44'
	ln -sf refs/heads/'master' .git/HEAD
	git-read-tree -m HEAD
	git-checkout-cache -f -u -a
	mkdir -p doc
	co -p -r1.2.2.1 '/home/cip/adm/sithglan/work/mutt/cvsrepository/doc/Attic/manual.sgml,v' > 'doc/manual.sgml'
	git-update-cache --add -- 'doc/manual.sgml'
	tree=$(git-write-tree)
	cat > .cmitmsg <<EOFMSG
	documenting alias-path
	EOFMSG
	commit=$(cat .cmitmsg | git-commit-tree $tree -p HEAD)
	echo $commit > .git/HEAD

The problem might be that this is the first commit in the branch. But I thought
it should end up in refs/heads/mutt-0-93. The problem is that this ends
up a empty file and next time the script is working on it, it fails
because the branch is empty:

	+ export GIT_COMMITTER_NAME=roessler
	+ GIT_COMMITTER_NAME=roessler
	+ export GIT_COMMITTER_EMAIL=roessler
	+ GIT_COMMITTER_EMAIL=roessler
	+ export GIT_AUTHOR_NAME=roessler
	+ GIT_AUTHOR_NAME=roessler
	+ export GIT_AUTHOR_EMAIL=roessler
	+ GIT_AUTHOR_EMAIL=roessler
	+ export 'GIT_AUTHOR_DATE=1998/06/20 07:12:32'
	+ GIT_AUTHOR_DATE=1998/06/20 07:12:32
	+ ln -sf refs/heads/mutt-0-93 .git/HEAD
	+ git-read-tree -m HEAD
	usage: git-read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
	+ git-checkout-cache -f -u -a
	+ co -p -r1.1.1.1.2.2 /home/cip/adm/sithglan/work/mutt/cvsrepository/handler.c,v
	/home/cip/adm/sithglan/work/mutt/cvsrepository/handler.c,v  -->  standard output
	revision 1.1.1.1.2.2
	+ git-update-cache --add -- handler.c
	++ git-write-tree
	+ tree=9e4d085838e4e62a8c4236a6713a7dd8d7b07b4e
	+ cat
	++ cat .cmitmsg
	++ git-commit-tree 9e4d085838e4e62a8c4236a6713a7dd8d7b07b4e -p HEAD
	usage: git-commit-tree <sha1> [-p <sha1>]* < changelog
	+ commit=
	+ echo

	Thomas
