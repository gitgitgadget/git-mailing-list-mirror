From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Branch relationships
Date: Mon, 15 May 2006 01:04:46 +0200
Message-ID: <200605150104.46762.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org> <200605150001.48548.Josef.Weidendorfer@gmx.de> <7v8xp4ntbf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:05:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfPeE-0003Fa-9m
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWENXFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWENXFH
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:05:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:1745 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751383AbWENXFG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 19:05:06 -0400
Received: (qmail invoked by alias); 14 May 2006 23:05:04 -0000
Received: from p54968B53.dip0.t-ipconnect.de (EHLO noname) [84.150.139.83]
  by mail.gmx.net (mp027) with SMTP; 15 May 2006 01:05:04 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7v8xp4ntbf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19988>

On Monday 15 May 2006 00:19, you wrote:
> > I suppose "branch.<branch name>.origin" is still the way to go for
> > specifying the upstream?
> 
> Probably "origin" is a better name for it; I was assuming
> "branch.<branch name>.remote = foo" refers to a [remote "foo"]
> section and means "when on this branch, pull from foo and merge
> from it".

Maybe.

But there is a misunderstanding. I wanted the branch attribute "origin"
to specify the upstream _branch_, not a remote.
After a "git clone", we would have

 [remote "origin"]
   url = ...
   fetch = master:origin

 [branch "master"]
   origin = "origin" ; upstream of master is local branch "origin"

 [branch "origin"]
   tracksremote ; bool

Now adding a further development branch for remote branch "topic", we would add

 [remote "origin"]
   ...
   fetch = topic:tracking-topic

 [branch "local-topic"]
   origin = "tracking-topic"

 [branch "tracking-topic"]
   tracksremote

Now, a "git pull" on branch "local-topic" does the right thing: it fetches
from remote "origin", as "tracking-topic" is given in a refspec there, and merges
"tracking-topic" to the current branch "local-topic", as given by the origin
attribute.

This also extends to local upstreams: a "git checkout -b topic2 master" would
append

 [branch "topic2"]
   origin = "master"

and a "git pull" on topic2 would merge the upstream "master".

Josef
