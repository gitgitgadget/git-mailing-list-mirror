From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to combine two clones in a collection
Date: Wed, 11 Jul 2007 19:37:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707111929120.4516@racer.site>
References: <20070711181301.GA26815@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8h3t-0004po-Pf
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbXGKShO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 14:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXGKShN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:37:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:52611 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751769AbXGKShN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:37:13 -0400
Received: (qmail invoked by alias); 11 Jul 2007 18:37:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 11 Jul 2007 20:37:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lXeUoYgjl1SAkxmUlGzRudu7luHjAaf8YsndnNj
	2Rpooe4nB/AzYb
X-X-Sender: gene099@racer.site
In-Reply-To: <20070711181301.GA26815@piper.oerlikon.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52185>

Hi,

On Wed, 11 Jul 2007, martin f krafft wrote:

> also sprach robin:
> > And the simplest way to create an new indpendent branch:
> 
> > echo ref: refs/heads/newbranch >.git/HEAD
> > Then prepare the content and commit like you used to do.
> 
> I am a little uneasy about touching files in .git with non-git
> tools, but everyone seems to be doing it, so I guess it's okay, and
> it make git a lot more powerful too.

You can achieve the same with

	git symbolic-ref HEAD refs/heads/newbranch

There.  No editing in .git/.

>   piper:~> echo ref: refs/heads/newbranch >| .git/HEAD
>   piper:~> git status
>   # On branch newbranch
>   #
>   # Initial commit
>   #
>   # Changes to be committed:
>   #   (use "git rm --cached <file>..." to unstage)
>   #
>   #       new file: date
>   #

However, this is much easier without Git commands:

	rm .git/index

Of course, you can remove all files one by one, but that is certainly not 
easier:

	git ls-files --cached -z | xargs -0 git rm --cached

But then, you really can learn from both examples: .git/index contains 
references to the objects which are staged (in Git speak: "in the index").  
Git plays nicely when that file is missing, and assumes the index to be 
empty.

With "git ls-files --cached", you can list the files which are in the 
index, and with "git rm --cached", you remove the file _only_ from the 
index, but keep it in the working tree (if it is there).  The options "-z" 
and "-0" are only to separate the names by NUL instead of newlines, to 
allow funny file names, too.

If a few more people ask for that feature, we could enhance the semantics 
of "git branch" and "git checkout" to interpret the empty string 
similar to "git push <repo> :<name>".

Ciao,
Dscho
