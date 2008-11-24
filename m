From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How do I delete a git submodule?
Date: Mon, 24 Nov 2008 16:51:16 +0100
Message-ID: <492ACD74.30108@drmicha.warpmail.net>
References: <Pine.LNX.4.64.0811241537580.22925@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Nov 24 16:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4djp-0006P9-Bb
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 16:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYKXPvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 10:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbYKXPvV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 10:51:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57905 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752810AbYKXPvV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 10:51:21 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CE2AA1C770E;
	Mon, 24 Nov 2008 10:51:19 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 24 Nov 2008 10:51:19 -0500
X-Sasl-enc: IYRwqFLMGbie5HeTmwScu4/BpsRoQ5VJDhUGHCc66r46 1227541879
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3FC8FA81D;
	Mon, 24 Nov 2008 10:51:19 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <Pine.LNX.4.64.0811241537580.22925@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101610>

Peter Krefting venit, vidit, dixit 24.11.2008 15:44:
> Hi!
> 
> I am trying to remove a submodule from a project, but can't figure out
> how to do it. With "modules/aldc" as a submodule:
> 
>   $ cat .gitmodules
>   [submodule "modules/aldc"]
>           path = modules/aldc
>           url = [...cut...]
>   [...more entries here...]
>   $ git status
>   [...cut...]
>   nothing to commit (working directory clean)
> 
> Starting from a clean set-up.
> 
>   $ git submodule rm modules/aldc
>   -ff17d9e0e76d01e99d26aa16b28cf327c5abb48a modules/aldc
>   $ git status
>   [...cut...]
>   nothing to commit (working directory clean)
> 
> The obvious command didn't give any errors, but didn't do anything,
> either. (I notice that there is no mention of a "git submodule rm" on
> the git-submodule man page.)
> 
>   $ git rm modules/aldc
>   rm 'modules/aldc'
>   fatal: git rm: modules/aldc: Permission denied
>   $ git status
>   [...cut...]
>   nothing to commit (working directory clean)
> 
> Nope, that didn't work either.
> 
> What am I missing?

The last line of git help/man on git submodule status:

"This command is the default command for git-submodule."

git submodule ignores the "rm" (because it doesn't know that command)
and does a "status" on modules/aldc.

OTOH, git rm refuses to do its thing, as you noticed. The brute force
method seems to work:

rm -Rf modules/aldc
#remove module from .gitmodules
#remove module from .git/config
git add -u
git commit -m "get thee hence, modules/aldc"

I edited the two config files manually, but this can be scripted.
git log -p shows a perfect diff including removal of the subproject
commit, so I think the result of the above is fine. I think I'll work on
a patch if nobody stops or beats me...

Cheers,
Michael
