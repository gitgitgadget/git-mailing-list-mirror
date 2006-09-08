From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 17:50:40 +0200
Organization: At home
Message-ID: <eds3fg$u30$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net> <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com> <7vac5ancvo.fsf@assigned-by-dhcp.cox.net> <9e4733910609080720s7a143d9bp5a1dd36869967c22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 08 17:52:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLidm-0005aM-RH
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 17:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWIHPvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 11:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWIHPvf
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 11:51:35 -0400
Received: from main.gmane.org ([80.91.229.2]:138 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750809AbWIHPve (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 11:51:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLidH-0005QS-BK
	for git@vger.kernel.org; Fri, 08 Sep 2006 17:51:07 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 17:51:07 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 17:51:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26700>

My idea for lazy clone/fetch (lazy = on-demand) is via remote alternatives
mechanism. We put URI for repository (repositories) that hosts the project,
and we would need at start to download at least heads and tags, and only
heads and tags.

When there is request for an object (commit, tree, blob or tag) which we
don't have locally, we ask remote repository if it have it, and download it
(and perhaps some related objects); this needs extension I guess for the
git downloader ('wantonly'), it should be fairly easy for dumb downloaders
if you don't mind getting whole pack i.e. perhaps more than intended.
Perhaps 'wantonly' for git protocol should work the same: one would get
ready pack (perhaps with limit on pack size: otherwise one would get only
the requested objects).

One thing that needs extending for lazy clone is git-fsck... otherwise you
would get whole repository when calling git-fsck. Simplest would be
fsck-ing only the local part, perhaps checking if the "missing" objects are
present in remote repository, but not downloading them and not checking
connectivity further... and of course notifying user that this is lazy
clone. Unless we run git-fsck-objects on the remote side, then pass results
to the local side.

There is probably bunch of problems with this idea...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
