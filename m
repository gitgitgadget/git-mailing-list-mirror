From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to figure out what 'git push' would do?
Date: Mon, 6 Aug 2007 00:09:02 +0200
Message-ID: <20070805220902.GB3159@steel.home>
References: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de> <20070805173340.GA3159@steel.home> <515E28B6-85AF-4379-870A-CFECF19B74DE@zib.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 00:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHoHg-0003Qq-57
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 00:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbXHEWJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 18:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbXHEWJH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 18:09:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:30483 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbXHEWJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 18:09:06 -0400
Received: from tigra.home (Faab2.f.strato-dslnet.de [195.4.170.178])
	by post.webmailer.de (klopstock mo60) (RZmta 10.3)
	with ESMTP id x06369j75K80wh ; Mon, 6 Aug 2007 00:09:03 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3F46B277BD;
	Mon,  6 Aug 2007 00:09:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id AED04BDCE; Mon,  6 Aug 2007 00:09:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <515E28B6-85AF-4379-870A-CFECF19B74DE@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolCqWU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55074>

Steffen Prohaska, Sun, Aug 05, 2007 21:56:37 +0200:
> >
> >    $ git fetch
> >    $ gitk local..REPO/master
> >
> 
> That applies only for a single branch. If I prepared a couple of
> branches for pushing and somehow want to double check what I prepared,
> 'git push --dry-run' would be quite handy. I know how to handle the
> situation and could write a custom script that does all necessary
> checks. But I haven't found an out-of-the-box solution for double
> checking right before 'git push'

Well, you can do gitk local1..REPO/remote1 local2..REPO/remote2,
of course, but yes, there is not out-of-the-box solution.

And a straight-forward implementation of "git-push --dry-run" doesn't
look simple... The remote sides git-receive-pack still have to be
called for any useful information, like the references updated and the
SHA-1s they get. IOW, if you can update your system easily to support
--dry-run, it still does not mean the server admin will do that just
as readily. And AFAICS, receive-pack dies if given a parameter it
does not know (it dies on every command line argument which begins
with "-", as it looks). Maybe we should change that first for a very
slow start...

It is simplier to modify git-ls-remote of git-remote to just compare
reference on local and remote side.
