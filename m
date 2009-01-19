From: Johan Herland <johan@herland.net>
Subject: Re: Syncing with CVS
Date: Mon, 19 Jan 2009 11:28:21 +0100
Message-ID: <200901191128.21230.johan@herland.net>
References: <f31e50960901190139w65b69fd1k752973a23c40f384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Christian von Kietzell" <cuboci@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 11:30:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOrOL-0005np-JS
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 11:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbZASK2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 05:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbZASK2g
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 05:28:36 -0500
Received: from sam.opera.com ([213.236.208.81]:42540 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbZASK2f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 05:28:35 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n0JASLmp023258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Jan 2009 10:28:26 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <f31e50960901190139w65b69fd1k752973a23c40f384@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106342>

On Monday 19 January 2009, Christian von Kietzell wrote:
> Hi,
>
> I have a project I started in git. After a while I exported that to
> CVS via git cvsexportcommit which worked quite nicely. Now, a
> colleague made changes to the project - in CVS. What's the best way
> to get those back into my git repository so that I'll be able to sync
> back and forth between git and CVS? I had a quick look at the wiki
> but couldn't find anything appropriate.
>
> I know of git cvsimport, of course, but that doesn't work on my
> original repository. Or does it? I didn't find anything on how to
> limit what to import. After all, some of the commits are already in
> my repository (the ones I exported).
>
> Hope any of you can help. Thanks in advance.

Unfortunately bidirectional syncing between CVS and Git is pretty much 
impossible in the general case, because CVS's structure is so different 
from Git's. For one, it is very easy to (re)move tags and branches in 
CVS, with no record of where it was moved from. (Also, as anybody 
involved in proper CVS-to-Git converters ("git cvsimport" does _not_ 
fall into this category) will tell you, recreating history from CVS is 
a highly non-trivial task in itself.) This means that even if you have 
imported some CVS state into Git, you cannot guarantee that the CVS 
state has not changed the next time you try to import. Therefore, it is 
very hard to determine whether you're importing a whole new branch from 
CVS, or whether you are just incrementally importing patches on top of 
a previously imported branch.

I have a similar situation at $dayjob, where we have a central CVS 
server with the official version, and I use Git for working locally. In 
this case, I use "git cvsexportcommit" to propagate my local changes to 
the CVS server. I only use this approach on branches where nobody else 
is allowed to commit (of course CVS does not enforce this rule, so I 
have to manually make sure that does not happen). If someone else were 
to commit to my branch in CVS, I would have to redo a full CVS-to-Git 
conversion, in order to get a new Git repo that is in sync with CVS. I 
can then resume "git cvsexportcommit" to propagate my changes from Git 
to CVS.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
