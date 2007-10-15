From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 12:14:19 +0200
Message-ID: <86lka4ofb8.fsf@lola.quinscape.zz>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
	<20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp>
	<Pine.LNX.4.64.0710141751530.25221@racer.site>
	<Pine.LNX.4.64.0710141901450.25221@racer.site>
	<20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma>
	<Pine.LNX.4.64.0710142309010.25221@racer.site>
	<20071014224959.GA17828@untitled>
	<Pine.LNX.4.64.0710142359020.25221@racer.site>
	<05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 12:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhN8X-0002ZG-RN
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709AbXJOKZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbXJOKZO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:25:14 -0400
Received: from main.gmane.org ([80.91.229.2]:54772 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbXJOKZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:25:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IhN43-000362-8B
	for git@vger.kernel.org; Mon, 15 Oct 2007 10:20:47 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 10:20:47 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 10:20:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:OjgCr1pc5mMPUdFq/CbiUQs/MWk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60977>

Benoit SIGOURE <tsuna@lrde.epita.fr> writes:

> This week I'm probably going to start to dive in git-svn by
> implementing simpler things first:
>   - git svn create-ignore (to create one .gitignore per directory
> from the svn:ignore properties.  This has the disadvantage of
> committing the .gitignore during the next dcommit, but when you
> import a repo with tons of ignores (>1000), using git svn show-ignore
> to build .git/info/exclude is *not* a good idea, because things like
> git-status will end up doing >1000 fnmatch *per file* in the repo,
> which leads to git-status taking more than 4s on my Core2Duo 2Ghz 2G
> RAM)

Well, then this should be fixed in git general, by sorting the ignores
(wildcards in the first place where they can match), and then just
moving those patterns that can actually match according to sort order
to the list of fnmatch candidates (and moving those files that can't
match anymore die to the sort order out again).

I don't think that the final "solution" for avoiding a lousy global
O(n^2) algorithm is to replace it with lousy local O(n^2) algorithms
and just hope for smaller values of n.

-- 
David Kastrup
