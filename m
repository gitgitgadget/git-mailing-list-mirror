From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Splitting up a changeset
Date: Mon, 20 Aug 2007 21:31:28 +0200
Message-ID: <20070820193128.GC5544@steel.home>
References: <e1bf234c0708200632g3a2282bfr76863555493d513@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Showman <fshowman@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INCyx-0001ho-Iv
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 21:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761491AbXHTTbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 15:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760603AbXHTTbg
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 15:31:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:23116 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760171AbXHTTbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 15:31:35 -0400
Received: from tigra.home (Fab03.f.strato-dslnet.de [195.4.171.3])
	by post.webmailer.de (mrclete mo48) (RZmta 11.0)
	with ESMTP id R0121fj7KJEmcF ; Mon, 20 Aug 2007 21:31:29 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 72687277BD;
	Mon, 20 Aug 2007 21:31:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 06923BDFC; Mon, 20 Aug 2007 21:31:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e1bf234c0708200632g3a2282bfr76863555493d513@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJAI
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56242>

Frank Showman, Mon, Aug 20, 2007 15:32:11 +0200:
> What I really want to do is merge a couple of files from a changeset
> at a time. Given that GIT doesn't track files, the only sensible way
> to do that seems to split up the changeset (I want GIT to track the
> merges) and then merge (cherry pick) the split up stuff.
> 
> Is there some (reasonably simple) way to do that?

yes. This, for example, will make two commits out of one:

    $ git checkout -b split-the-change the-change^
    $ git checkout the-change -- files-you-want-in-commit1...
    $ git commit -c the-change
    $ git checkout the-change -- files-you-want-in-commit2...
    $ git commit -c the-change

If you want also split the changes _in_ the files, you'll have to edit
them after that "git checkout the-change -- files...".

The result is in branch starting where the-change was at. You can
decide now what you want to do with the commits.

> What happens to remote repositories that already have the big
> original changeset (and possibly changes based on it)?

If someone (or something) has already fetched, pulled, cloned or
otherwise copied them, you basically can't do anything anymore.
It is a thing you fundamentally cannot do, unless you're prepared to
deal with consequences. Not hard, but can be unexpected for some.
