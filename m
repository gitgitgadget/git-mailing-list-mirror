From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Wed, 06 Sep 2006 19:06:04 +0200
Organization: At home
Message-ID: <edmv57$lt7$1@sea.gmane.org>
References: <200609061504.40725.jnareb@gmail.com> <Pine.LNX.4.64.0609060847521.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 19:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL0r8-0002Vo-JJ
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 19:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWIFRG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWIFRG1
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 13:06:27 -0400
Received: from main.gmane.org ([80.91.229.2]:53453 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751729AbWIFRG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 13:06:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL0qr-0002TL-96
	for git@vger.kernel.org; Wed, 06 Sep 2006 19:06:13 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 19:06:13 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 19:06:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26541>

Linus Torvalds wrote:

> So the rule is:
> 
>  - using "--full-history" + "--parents" means that you want (surprise 
>    surprise) full history with parenthood, which means that you get all 
>    the connecting merges too. And since you asked for the _full_ history, 
>    that means EVERY SINGLE MERGE.

I just don't quite understand where <pathspec> filtering takes place 
in this case.

Every single merge is for parents to be connected, or what?
 
> So what you are asking for is pretty nonsensical. You ask for parenthood 
> info, but then you seem to not want to actually connect the dots. So why 
> do you ask for parents in the first place? If you don't want to connect 
> the commits to their parents, you shouldn't ask for it.

When I though about it, git_history needs not parents of a commit; from
parsed commit it needs only date, author and title/summary (and of course
commit sha1), so we can skip '--parents' option to git-rev-list, and have
nice _history of a file_, using only one call to git-rev-list to make it.

This means that parse_rev_list has to be changes, and that '--parents'
option must be specified explicitely as argument to parse_rev_list.

Besides [primitive] benchmarking shows that there we gain only a little:
1.53s user+sys vs 2.13s user+sys when run from command line, 
2.8s mean vs 3.6s mean when tested using ApacheBench...
that is _after_ paginating history output.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
