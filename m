From: Michael Poole <mdpoole@troilus.org>
Subject: Re: After-the-fact submodule detection or creation
Date: Fri, 07 Dec 2007 16:35:43 -0500
Message-ID: <87abomp4r4.fsf@graviton.dyn.troilus.org>
References: <87ir3bp5sf.fsf@graviton.dyn.troilus.org>
	<20071207073728.GA2847@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:36:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0krk-0001m6-Kk
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061AbXLGVft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757083AbXLGVft
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:35:49 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:59574
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757022AbXLGVfr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 16:35:47 -0500
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 97FA889C12A; Fri,  7 Dec 2007 16:35:43 -0500 (EST)
In-Reply-To: <20071207073728.GA2847@steel.home> (Alex Riesen's message of "Fri\, 7 Dec 2007 08\:37\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67465>

Alex Riesen writes:

> Michael Poole, Fri, Dec 07, 2007 04:01:04 +0100:
>> It seems like using the current submodule code would mean that this
>> kind of import would need two passes over the foreign repository,
>> rather than one if the branch could be created after the parent tree
>> is initially imported.  I can live with that -- it is a rather unusual
>> case -- but maybe there is a better way.)
>
> Import the core module in a branch all by itself, and merge it in
> every support branch?
>
>
>     Supp1: o-o-o-----o-o-o-o-o-o-o
> 		    /
>     Core:  o-o-o-o-o
> 		    \
>     Supp2: o-o-------o-o-o-o

Yes, that's the obvious way to do it with submodules.  Teaching
git-svn to use that is the hard part.

Since the core code was first branched independently at r734 in the
existing repository, the import (either automated or manual) would
need to go through once to identify what subdirectories are actually
submodules in git terminology, and make a second pass to actually
perform the imports.  If the submodule creation could happen after the
fact, it would only need one pass.

Maybe the right question to ask is whether having a partial-tree
branch can be reasonably handled by git (in particular, detecting a
rename of the core subtree to the top-level tree in the new branch's
first commit).  If git understand that operation, then what I would
like to do would be reasonably straightforward.  If it does not make
sense, then I'll think about how to teach git-svn that certain
subdirectories should be promoted to submodules.

Michael Poole
