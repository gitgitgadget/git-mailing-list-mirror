From: Russell King <rmk@arm.linux.org.uk>
Subject: Local cg-pull fails
Date: Thu, 14 Jul 2005 11:12:25 +0100
Message-ID: <20050714111224.B31383@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 14 12:14:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt0jH-0003G9-DH
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 12:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVGNKNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVGNKNi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 06:13:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56338 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262977AbVGNKM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 06:12:28 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Dt0he-0005fk-Cj
	for git@vger.kernel.org; Thu, 14 Jul 2005 11:12:26 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1Dt0hd-0000EU-7Z
	for git@vger.kernel.org; Thu, 14 Jul 2005 11:12:25 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think I posted about this before, but I can't find it in my git
mailbox...

rmk@dyn-67:[linux-2.6-arm] $ cg-update origin
l
`../linux-2.6/.git/refs/heads/master' -> `.git/refs/heads/origin'
cp: cannot create link `.git/objects/00/ae0c9f3bc24856e7c9fcdf690466f1bbe0a4df': File exists
cp: cannot create link `.git/objects/01/5bd2cf869f70ec708558f1d37980a8b4968604': File exists
cp: cannot create link `.git/objects/02/c7e335d3ef3998dfb49673654152fb10124d2f': File exists

Consider this flow of changes (which represents how I work):

        Linus' kernel.org tree --> Local pristine tree
                ^   ^                |            |
                |   |                v            v
                |   |        working tree 1   working tree 2
                |   |                |            |
                |   `----------------'            |
                `---------------------------------'

Changes are made in working tree 1, and made available to Linus.  Linus
merges them into his tree.  I pull them into the pristine tree.  Assume
other changes occurred. in Linus' tree.

The pristine tree is obviously a superset of the working tree.

What happens when I pull those changes back into working tree 1, given
that cogito uses "cp -va -ul".

The pristine tree now contains the GIT objects which I created in tree 1.
For whatever reason I don't understand, they are dated after the same
objects in tree 1.  Therefore, because of `-u', cp will want to update
them - by replacing the object with a link.  It refuses.

Last time this was discussed, someone suggested -f, which solved the
problem.  Can we please modify the cg-pull script to use -f ?

Secondly, can I suggest that cogito developers consider the above
usage scenario and construct a regression test for it to ensure that
future breakages of this nature are caught.  For me, cogito has been
extremely fragile, and I don't think the above usage is unreasonable.

-- 
Russell King
