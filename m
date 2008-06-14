From: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
Subject: Re: Document clone of clone ... bug??
Date: Sat, 14 Jun 2008 22:15:11 +0200 (CEST)
Message-ID: <20080614.221511.74741328.hanzl@noel.feld.cvut.cz>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
	<20080614143117.GA8640@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sat Jun 14 22:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7cFV-0000Hl-7f
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 22:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbYFNUU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbYFNUU0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 16:20:26 -0400
Received: from magi4.feld.cvut.cz ([147.32.198.214]:33547 "EHLO mepi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754114AbYFNUU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 16:20:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mepi (Postfix) with ESMTP id 569F3FD806;
	Sat, 14 Jun 2008 22:15:11 +0200 (CEST)
In-Reply-To: <20080614143117.GA8640@sigill.intra.peff.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85040>

> The clone of clone does not have dangling objects; either it sees a ref
> (because it is a branch in the clone) and it grabs the objects, or it
> does not see it, in which case it does not download those objects.

Yes, there should not be a dangling object, but I actually got one. I
was surprised, but I thought it is just an undocumented benign behavior
(optimization overkill - clone rather gets those objects instead of
thinking what it needs). Now I think it may be a bug.

Can someone with deeper knowledge and fresh git please try this:

 rm -rf A B C
 mkdir A B C
 (cd A; mkdir X; cd X; git init; echo x>x; git add x; git commit -m xxx;
  git checkout -b br; echo y>y; git add y; git commit -m yyy;
  git checkout master)
 (cd B; git clone ../A/X)
 (cd C; git clone ../B/X; cd X; git fsck --full)

With my 11 days old version of git, I get:

 dangling commit ...

and 'git show ...' reveals that this commit it that otherwise
(rightfully) lost branch 'br'.

SHA1 is changing when I repeat this (due to dates in reflogs??).

When I omit 'git checkout master', no dangling commit appears. Strange.

Is it my faulty thinking, benign undocumented thing, or a bug?

Vaclav Hanzl
