From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 09 Feb 2007 12:27:55 -0800
Message-ID: <7vk5yrt6t0.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	<e5bfff550702091219n4df5531ek6be2cd04f00be650@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 21:28:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFcLh-0005ut-BR
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 21:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992804AbXBIU14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 15:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992805AbXBIU14
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 15:27:56 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43796 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992804AbXBIU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 15:27:56 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070209202756.TVWI21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 15:27:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MYTu1W00g1kojtg0000000; Fri, 09 Feb 2007 15:27:55 -0500
In-Reply-To: <e5bfff550702091219n4df5531ek6be2cd04f00be650@mail.gmail.com>
	(Marco Costalba's message of "Fri, 9 Feb 2007 21:19:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39196>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Sorry, perhaps it is a silly question, but why git index should be
> different after just touching a file?

It uses the information from lstat(2) that is stored in the
index and taken from the filesystem -- if they are different
(touch changes it as you know, but so does "vi that-file") they
are reported as "modified".

	git checkout -- Makefile
        git diff-files Makefile
	touch Makefile
	git diff-files Makefile

The 'refresh' operation is to update the lstat(2) information in
the index for paths whose contents actually match what is in the
index (and it does not do anything else -- most notably paths
whose contents are different between the working tree and the
index are left as-is).
