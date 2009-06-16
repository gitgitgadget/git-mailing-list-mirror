From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Using git for code deployment on webservers?
Date: Tue, 16 Jun 2009 13:49:01 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906161332080.2147@iabervon.org>
References: <200906160111.47325.ioe-git@rameria.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ingo Oeser <ioe-git@rameria.de>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGcml-0004Y7-AR
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 19:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760963AbZFPRtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 13:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760932AbZFPRs7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 13:48:59 -0400
Received: from iabervon.org ([66.92.72.58]:51422 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758633AbZFPRs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 13:48:59 -0400
Received: (qmail 20724 invoked by uid 1000); 16 Jun 2009 17:49:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jun 2009 17:49:01 -0000
In-Reply-To: <200906160111.47325.ioe-git@rameria.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121696>

On Tue, 16 Jun 2009, Ingo Oeser wrote:

> [please CC me, as I'm not subscribed]
> 
> Hi there,
> 
> I try to use git in a quite unusual way.
> 
> I have a bunch of servers (hundreds), which get regular pulls of web developer code.
> The code consists of images, flash files, scripting language files, you name it.
> An exported repo (just the files, no SCM metadata) contains up to 4GB of files.
> 
> No I want to distribute changes the developers made in a tree like structure:
> 
> main server --> slave_1 --> webserver_0815
>             |-> slave_2 --> webserver_2342
>                         |-> webserver_4711
> 
> But with the following contraints:
> - Store as little as possible on the webservers.
>   One selected revision/tag is enough.
> - Transfer as little as possible data.
>   Cancel out addition and deletion on the fly.
> - Nearly atomic update of file tree (easy to implement outside git)
> 
> Nice to have:
> - Instead of copying the files to their proper names, 
>   hardlink them to their git objects.
> 
> At the moment I always get more data than I need and have to store
> the repository AND the checked out data.

You should be able to have the slave repositories store tags for tree 
objects (instead of commit objects), and have the webservers fetch those. 
You'll still have the object database, but it will only contain stuff 
that's been deployed to that webserver, not intermediate versions or 
historical versions. You'll still have to store both the repo and the 
checked out data (but git stores the content delta-compressed against each 
other in one big file, normally, so there really aren't files to hard link 
to.

Of course, the other possibility is to check out versions on the slaves, 
and rsync that to the webservers, which is probably the optimal method if 
you're not in a situation where you benefit from anything git does in 
transit.

	-Daniel
*This .sig left intentionally blank*
