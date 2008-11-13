From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: [BUG] git ls-files -m --with-tree does double output
Date: Thu, 13 Nov 2008 22:53:48 +0100 (CET)
Message-ID: <37512.N1gUGH5fRhE=.1226613228.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 13 22:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0k9Y-0000P3-LE
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 22:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbYKMVxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 16:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbYKMVxt
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 16:53:49 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:57241 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYKMVxs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 16:53:48 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 0271814068;
	Thu, 13 Nov 2008 22:53:49 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id C9DC014062;
	Thu, 13 Nov 2008 22:53:48 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: N1gUGH5fRhE=
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100917>

Junio, I am resending this one because I am not sure whether you ignored
it on purpose, or it got lost during your vacation.

The combination of -m and --with-tree shows duplicate entries:

and@dylle:~$ mkdir repo ; cd repo
and@dylle:~/repo$ git init
Initialized empty Git repository in /home/and/repo/.git/
and@dylle:~/repo$ date >a ; git add a ; git commit -m'Add 1'
Created initial commit c027435: Add 1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
and@dylle:~/repo$ date >a
and@dylle:~/repo$ git ls-files -m --with-tree=HEAD
a
a


Jeff King added:

I have confirmed this, and it looks like it has always been that way. It
looks like overlay_tree_on_cache just does a read_tree to pull the tree
into the index, and then we end up with duplicate entries.

I'm not too familiar with the read_tree code, so I am cc'ing Junio (who
is out of touch for a little while) and Linus, who are much more clueful
in this area.

It isn't clear to me which code is _supposed_ to be pulling out such
duplicates here. That is, is read_tree broken, or is
overlay_tree_on_cache just calling it wrong?



Anders.
