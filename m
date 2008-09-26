From: Tom Lanyon <tom@netspot.com.au>
Subject: Internal, corporate, shared hosting solutions
Date: Sat, 27 Sep 2008 00:43:48 +0930
Message-ID: <8B29890D-C03B-4ECE-9BEF-0A8E8EF7233E@netspot.com.au>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 17:36:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjFNA-0004ps-VB
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbYIZPfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbYIZPfj
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:35:39 -0400
Received: from kuat-e0.netspot.com.au ([203.30.161.145]:57907 "EHLO
	kuat.netspot.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYIZPfj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:35:39 -0400
X-Greylist: delayed 1309 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2008 11:35:38 EDT
Received: by kuat.netspot.com.au (Postfix, from userid 1004)
	id 587FD2800D8AA; Sat, 27 Sep 2008 00:43:48 +0930 (CST)
X-Spam-Checker-Version: SpamAssassin 3.1.8-gr1 (2007-02-13) on
	kuat.netspot.com.au
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8-gr1
Received: from white-chocolate.netspot.com.au (white-chocolate.netspot.com.au [10.2.2.10])
	(Authenticated sender: tom)
	by kuat.netspot.com.au (Postfix) with ESMTP id 2F4202800D8A8
	for <git@vger.kernel.org>; Sat, 27 Sep 2008 00:43:48 +0930 (CST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96870>

Hi list,

I'm struggling. There's been a recent adoption of git here by our  
development staff, which is great. However, from an administrative  
point of view, I'm having trouble finding a solution to provide some  
kind of easy, shared, secure and accessible hosting solution to our  
developers.

So that these repositories can be centrally tracked and backed up, we  
require a central git host for all of our projects from all our  
development teams.

We have some pretty basic requirements:
	- authentication and authorisation; some repos are only readable/ 
writable by specific people
	- accessible; many dev servers are on private subnets, ideally we  
need to be able to proxy git access
	- not too much messing with unix user accounts on the central git  
host (because they're tied to LDAP, for example)

Accessibility is easily addressed by providing access to the git  
repositories via WebDAV with which we can proxy HTTP traffic.  
Similarly, HTTP gives us great authentication and authorisation;  
fantastic, problem solved. Not so fast. We need git built with  
USE_CURL_MULTI to support push over HTTP, which requires curl >=  
7.16.0. The most recent RedHat Enterprise Linux has 7.15.5 so we'd  
need to build many custom packages and compatibility packages for any  
servers needing git access and this is plainly not acceptable from an  
administrative standpoint. Additionally, git over WebDAV is incredibly  
slow. Pushing git's git repostory to a new, empty repository over  
gigabit ethernet was ridiculously slow (I didn't bother to do it again  
and time it).

Looking at the git native protocol or git-over-ssh, then. We can  
tunnel these if need be, so forget about the accessibility issue.  
Authentication becomes a problem here; the git daemon doesn't have  
enough security controls to grant groupA r/w access to repoX, read  
access to repoY and no access to anything else. Is SSH a solution for  
my problems? Can we provide shared repositories to certain groups of  
people, while limiting access to others and is this going to require  
accounts for each developer on the server (the git-shell seems to not  
be flexible enough for this)?

Am I thinking about this conceptually wrong or am I missing something  
simple?

Thanks,
Tom

--
Tom Lanyon
