From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 11:25:16 -0800
Message-ID: <7v7jb7uler.fsf@assigned-by-dhcp.cox.net>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
	<200511171644.48438.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 20:28:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpNr-0004NK-Rr
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVKQTZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVKQTZU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:25:20 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:7052 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964787AbVKQTZS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:25:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117192404.DCMO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 14:24:04 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12139>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> [*] Junio: This should be done before Git 1.0 - it is needed to be able
> to change the repository format in the future without taking the risk
> that old git commands possibly corrupt a repo in the new format. This
> has nothing to do with backwards compatibility. Without a version, we
> are forced to be forwards compatible ;-)
> Needed in init-db.c is a "echo 1 >.git/version"; and the mentioned check
> in the tools against this version.

I agree with the general direction.

 - Futureproofing is good.

 - We want repository-format-version but that may be too
   long. Just saying version is a bit confusing.  Abbreviating
   it to repository-version makes it sound as if somebody took a
   snapshot (i.e. tar-tree $commit).  Whatever name we choose,
   let's pick a one not so confusing.

 - Not having .git/version (or whatever name) signals the tools
   our repository is in the original format.  This will keep the
   existing repositories happy.  What this means is that the
   tools need to check for the absense of .git/version in this
   round.  When we change the repository format, we will have
   .git/version file that records it.

 - You can run git-init-db on an existing repository.  This is
   sometimes handy if you added a new hook in the template suite
   and want to copy it over (it never overwrites but happily
   copies what you do not have).  This mechanism needs to be
   told about the version file -- specifically, it should check
   version in the template area and refuse to do use that
   template if it does not match the repository.  Similarly,
   when creating a repository from scratch, it should not copy
   the version file from templates.
