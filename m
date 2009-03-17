From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Tue, 17 Mar 2009 15:39:55 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903171530160.19665@iabervon.org>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 20:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjfAG-0001Yd-QY
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 20:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZCQTj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 15:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbZCQTj6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 15:39:58 -0400
Received: from iabervon.org ([66.92.72.58]:50558 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbZCQTj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 15:39:58 -0400
Received: (qmail 340 invoked by uid 1000); 17 Mar 2009 19:39:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2009 19:39:55 -0000
In-Reply-To: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113520>

On Tue, 17 Mar 2009, Tom Preston-Werner wrote:

> I'm having some unexpected behavior when cloning a remote repo that
> has several branches at the same commit. On the remote side, the HEAD
> is 'trunk':
> 
> git@remote ~/repositories/akincisor/site.git $ cat HEAD
> ref: refs/heads/trunk
> 
> After cloning this with a standard `git clone`, the refs are:
> 
> [11:48][tom@solid:~/dev/sandbox/site(release)]$ git branch -r -v
>   origin/HEAD    a52528a Fixed some routing problems
>   origin/release a52528a Fixed some routing problems
>   origin/trunk   a52528a Fixed some routing problems
> 
> And the checked out branch is 'release' instead of 'trunk' as I would expect:
> 
> [11:48][tom@solid:~/dev/sandbox/site(release)]$ git branch
> * release
> 
> I'm guessing that the first branch that matches the remote HEAD
> revision is being checked out instead of the actual remote branch. I
> would expect the correct branch to be chosen regardless of where the
> branches are pointing.

Unfortunately, the current protocol version just sends:

a52528a HEAD
a52528a refs/heads/release
a52528a refs/heads/trunk

It doesn't transmit the fact that HEAD is a pointer to anything, or what 
it's a pointer to. One thing you can do is just change your local repo to 
point origin/HEAD where you want, and check out what you want; the 
defaults are just to get you started. Another thing is that it will guess 
"master" if there is one. I think there's also been discussion of a 
protocol extension to transmit the information, although I don't know 
where that ended up. (The protocol-agnostic transport infrastructure can 
represent the information, but doesn't receive it for the normal protocol)

	-Daniel
*This .sig left intentionally blank*
