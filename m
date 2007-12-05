From: Steven Grimm <koreth@midwinter.com>
Subject: Re: How to jump between two repositories ...
Date: Tue, 4 Dec 2007 22:57:53 -0800
Message-ID: <FE46507A-74FE-4EDE-AC28-96658B944182@midwinter.com>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com> <3DD4D3BA-67B3-4AFC-AD24-799384D54408@pp.inet.fi> <33CB0252-20C7-4AF2-AEB3-2EAC20ED830B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>,
	git@vger.kernel.org
To: g2 <gerald.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoCz-0007ib-Vj
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXLEG5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 01:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXLEG5y
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:57:54 -0500
Received: from tater.midwinter.com ([216.32.86.90]:33457 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751297AbXLEG5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 01:57:53 -0500
Received: (qmail 17374 invoked from network); 5 Dec 2007 06:57:53 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=kY04we4QJwR6CYHekGWrJMvUM7En0ZlmRe8TB7T7INGJ1qnVCGopFntM0Fhiu1d7  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 5 Dec 2007 06:57:53 -0000
In-Reply-To: <33CB0252-20C7-4AF2-AEB3-2EAC20ED830B@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67110>

On Dec 4, 2007, at 10:44 PM, g2 wrote:
> What I am gathering from this is that I can use git in two ways: 1)  
> as "just another svn" bare git repository, or 2) only pull and don't  
> push, because push causes confusion. I'd be happy to only ever use  
> pull, but I have one machine behind a firewall and can't pull. I can  
> push to a bare git repository like the svn model, but then I would  
> just use svn. What's the value of "push" then?

You can push. Just don't push to a checked-out branch. I do exactly  
what you're describing and it works fine. It looks something like this:

server% git checkout mybranch
server% edit somefile.c
server% git commit

laptop% git checkout mybranch
laptop% git pull
   (with a pull configuration that pulls server's mybranch into  
laptop's)
laptop% edit somefile.c
laptop% git commit
laptop% git push server mybranch:laptop/mybranch

server% git checkout mybranch
server% git rebase laptop/mybranch

Presto, ready to go. The trick is to push into a branch that's  
different from the one that's checked out, then rebase on top of that  
on the remote side after the push.

Yeah, it'd be nicer if you could just push to the checked-out branch  
directly (and there are hooks to let you do that) but this is only  
slightly awkward and it's easy once you've done it a few times.

-Steve
