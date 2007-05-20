From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [RFC] Implementing git config handling in Git.pm
Date: Mon, 21 May 2007 00:59:54 +0200
Message-ID: <20070520225953.GK4085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 01:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuNh-0002xC-JE
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868AbXETW77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757967AbXETW77
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:59:59 -0400
Received: from planck.djpig.de ([85.10.192.180]:2442 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757868AbXETW76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:59:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 1DC9688060;
	Mon, 21 May 2007 00:59:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJrooy+qQ7eG; Mon, 21 May 2007 00:59:54 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 28F5088105; Mon, 21 May 2007 00:59:54 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47946>

Hi.

A week ago or so when I presented my GITCVS::config patch I mentioned
that we should better implement most of it in Git.pm. I would like to
do so but get a bit of input first on how to implement it.

Targets:
 1) We should offer to parse the config only once since that is
   a huge performance gain if the caller wants to use several
   values from it.
 2) The parsing should be complete and safe.
 3) If at all possible, we should not have to implement a
   complete parser in Perl, since that is just needless
   code to maintain.

Possible Solutions:
 1) Call git-config.
   Pro: Easy to implement
   Contra: Violates at least target 2. Neither git-config --get nor
   git-config --list offer a complete and safe view on the config
   file. Just try including = in a subsection name (--list) or newlines in
   a value (both) to see what I mean.
 2) Extend git-config to give a machine parsable output and then
    proceed with solution 1
   Pro: Still reasonably easy to implement (?). Would benefit
    other scripts, too.
   Contra: Neither the fastest nor the most flexible
    solution.
 3) Try to use the C code from config.c directly.
   Pro: Probably the fastest solution due to avoiding the
    forks.
   Contra: Probably a bit more complex (any XS experts here?),
    both to implement and to maintain.
 4) Implement an own git config parser in Perl
   Pro: Might be actually easier than 3 and faster than 2
   Contra: See target 3

I would go for solution 2. Any reason to prefer one of the
others (or one I didn't even think of)?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
