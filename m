From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: how to update a submodule?
Date: Sun, 02 Jan 2011 12:30:15 +0100
Message-ID: <4D2061C7.5050405@web.de>
References: <20101231222438.GA28199@cs-wsok.swansea.ac.uk> <201012312342.oBVNg1lx021930@no.baka.org> <20110101203957.GC26920@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sun Jan 02 12:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZM8o-0004Hy-74
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 12:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab1ABLaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 06:30:20 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:45322 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab1ABLaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 06:30:19 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 1F5BD192DD32B;
	Sun,  2 Jan 2011 12:30:18 +0100 (CET)
Received: from [93.240.108.214] (helo=[192.168.178.53])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PZM8g-00087o-00; Sun, 02 Jan 2011 12:30:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110101203957.GC26920@cs-wsok.swansea.ac.uk>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+g4diXMQ21PWeyPCuxYH4buJIsXlOQ13VaJzul
	QzIWYLSyR2gB9QJJC1n+RmEuWZ+9Qx+uppnkl4BQ08MfV0ggZd
	Mt7NyM5Ngzl9O5gyS0Ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164417>

Am 01.01.2011 21:39, schrieb Oliver Kullmann:
> On Fri, Dec 31, 2010 at 06:42:01PM -0500, Seth Robertson wrote:
> As far as I see that, this doesn't concern the problem how to I update
> one repository with submodules from another repository with "these" submodules
> (as the same paths)?

I'm not sure I completely understand your use case, but submodules are
repositories of their own, so they don't get updated by just pulling
a superproject into another containing the same submodule. The submodule
changes have to be pushed to its own parent repository and can then be
fetched from there into another superproject's submodule.

> Actually, even the simplest case of just cloning a repository with submodules
> doesn't work:
> After cloning, "git submodule status" shows "-", okay so I do "git submodule init",
> which already shows a false understanding --- it shows the URL of the old repository,
> from which the original submodule originated, which is long gone and no longer relevant.
> Then of course "git submodule update" fails, and in the submodule there is just nothing.

Then the URL of the submodule in the .gitmodules file is not up to
date. You can either fix it there or - if you only want to change it
locally - edit the .git/config after the "git submodule init" copied
it there.

> The problem seems to be that the information about the place where to update a
> submodule is in .gitmodules, which git actually has under version control (different
> from other configuration information), and thus copies it verbatimly.
> Okay, then apparently after a clone .gitmodules has to be updated (by hand).

No, the problem seems to be that the remote URL in the submodule has
been changed directly without updating it in the .gitmodules of the
superproject (the recommended way to do that is to change it in the
.gitmodules file and then use "git submodule sync" to activate it).

> So .gitmodules concerns only "git submodule update", not "git pull" from within
> the submodules? This would be good to know, to understand the role of the information
> in .gitmodules (where the task of "git submodule init" is apparently just to
> transport this information to .git/configure ?).
> 
> This has the disadvantage, that one has to publish this private
> information about the places where by chance one is pulling from?

Yes, the submodules URL must be available - at least for fetching -
to everyone who wants to clone your superproject (and all changes
made in the submodule which are committed in the superproject must
have been pushed there to be able to check them out in the clone).

> Perhaps I should then put .gitmodules into .gitignore? Or would that have
> bad consequences??

Yes, because then git won't know where the it can clone the submodules
from when you clone your superproject somewhere else.
