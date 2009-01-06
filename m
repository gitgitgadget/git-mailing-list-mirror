From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Tue, 06 Jan 2009 17:31:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901061709510.26118@xanadu.home>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_zFZ7w3u3oJjEz6nxVXssDQ)"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=D8yvind_Harboe?= <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 23:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKKUR-0002GU-7r
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 23:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820AbZAFWcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 17:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760580AbZAFWcI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 17:32:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32947 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760582AbZAFWcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 17:32:05 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD200ANUMLA5540@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Jan 2009 17:31:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.0901061731110.26118@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104731>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_zFZ7w3u3oJjEz6nxVXssDQ)
Content-id: <alpine.LFD.2.00.0901061731111.26118@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Tue, 6 Jan 2009, Øyvind Harboe wrote:

> Q1: How can I figure out what it is in .git that takes so much space?
> 
> Q2: Where can I read more about what to do after running git-filter-branch to
> removing the offending objects?
> 
> 
> 
> 1. I ran this command to get rid of the offending files and that appears to
> have worked. I can't find any traces of them anymore...
> 
> git filter-branch --tree-filter 'find . -regex ".*toolchain\..*" -exec
> rm -f {} \;' HEAD
> 
> 2. Running "git gc" takes a few seconds. The repository is still
> huge(it should be
> perhaps 10-20mByte).
> 
> du -skh .git/
> 187M    .git/
> 
> 3. I tried "git reflog expire --all" + lots of other tricks in the
> link below, but no luck.

OK, try this:

	cd ..
	mv my_repo my_repo.orig
	mkdir my_repo
	cd my_repo
	git init
	git pull file://$(pwd)/../my_repo.orig

This is the easiest way to ensure you have only the necessary objects in 
the new repo, without all the extra stuff tied to reflogs, etc.

Then, if your repo is still seemingly too big, you can get a bit dirty 
with the sequence Johannes just posted.


Nicolas

--Boundary_(ID_zFZ7w3u3oJjEz6nxVXssDQ)--
