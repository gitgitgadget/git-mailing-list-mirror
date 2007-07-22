From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Sun, 22 Jul 2007 21:47:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707222139400.15705@fbirervta.pbzchgretzou.qr>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChOX-0001Mr-Ir
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758758AbXGVTrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbXGVTrG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:47:06 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:46165 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958AbXGVTrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:47:05 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 8981118094B4A; Sun, 22 Jul 2007 21:47:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 80B421CD7ADBC;
	Sun, 22 Jul 2007 21:47:02 +0200 (CEST)
In-Reply-To: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53307>


On Jul 22 2007 14:48, Jon Smirl wrote:
>
> It would really be useful if git diff had an option for suppressing
> diffs caused by CVS keyword expansion. I run into this problem over
> and over when trying to recover stuff out of old kernel sources that
> people checked into CVS and then posted CVS diffs to fulfill their GPL
> obligations. I sometimes wonder if vendors are doing this on purpose
> to make it more difficult to recover the changes they made to the
> code.
>
> To prevent this in the future, I'd love to see a patch removing all
> CVS keywords from the kernel sources.

I say: yes please. Even svn (which Linus dislikes very much) has cvs
keywords disabled by default. And at the same time, a patch to
CodingStyle not to include CVS tags, and a patch to checkpatch.pl
to enforce it :)

> Quick grep of kernel shows 1,535 $Id, 197 $Log, 441 $Revision, 144 $Date. I
> guestimate that this would remove about 5,000 lines form the kernel source
> and touch 1,700 files. Would this be accept or do those expansions contain
> useful info?

Common argument for $Id$ tags has been, that upon a problem, a user
can look into dmesg (or whatever log is appropraite - it's not
limited to the kernel) for the version string instead of figuring it
out himself (by means or rpm -q, or whatever hides it).

For the Linux kernel however, I do not think it is important, since:

- the code of a module changes faster than you can think (e.g.
  a change in the network code touched a network filesystem). Result:
  same $Id$ tag in the vendor's version AND the mainline version.
  So the tag is useless.

- you know what version you are running, mingetty usually prints it
  for you; uname -a also shows it.

- if you have a problem, people kindly ask you to bisect anyway, in
  which case $Id$ numbers become irrelevant anyway, because you got
  the git SHA1 ids.

Yep, that's pretty much it from my side. Conclusion: Remove CVS
tags from kernel.



	Jan
-- 
