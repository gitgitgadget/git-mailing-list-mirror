From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 13:09:58 +0000
Organization: Berlin University of Technology
Message-ID: <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 14:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSCCV-0004Hc-Jz
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 14:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbXCPNKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbXCPNKF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 09:10:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:36741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753209AbXCPNKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 09:10:03 -0400
Received: (qmail invoked by alias); 16 Mar 2007 13:10:01 -0000
X-Provags-ID: V01U2FsdGVkX184E3IH3CM4d+0rv4QNTXzolxdEdcL8VaZ8HgcYWc
	dycqeJmKweUfuh
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 0374120F37
	for <git@vger.kernel.org>; Fri, 16 Mar 2007 13:09:59 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-STABLE i386)
User-Agent: Mutt/1.5.14 (2007-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42359>

Hi,

* Johannes Schindelin [07-03-16 12:54:52 +0100] wrote:

[...]

>Isn't this an awfully long shot?

>I'd be happy if the libification project resulted

>- in a (static!) libgit.a which can be linked to qgit or similar (being 
>  reentrant, or at least optionally so, and not die()ing all the time), 
>  and

>- which does not fix the API yet (at least for the most parts).

>We _can_ -- once we agree on a stable API -- expose _some_ functions in a 
>libgit.so, but that does not have to be the goal for the first step!

First, I think that would be some cleanup "only" since that basically 
would mean to

   1) make all functions die()ing return some value and handle it and
   2) wrap all static vars into structures and pass them around

If you don't choose a design before wrapping things up in structures, 
you'll probably end up having one structure per source file (at least 
too many structures).

Porting things like qgit to it or writting proper perl/python bindings 
is wasted time since you'd have to rewrite all of it once you decided 
which functions to expose and which structures to use (calling the 
main() routines of builtin's doesn't count as real libifaction, it would 
rather be a performance improvement only).

I'd simply try to find a rough consensus on the data structures and the 
layer model before starting the project, solve 1), afterwards implement 
2) according to it. While 2) happens it would make sense to try to 
develop perl, python, C and C++ bindings in parallel to find out early 
enough whether the design details chosen are useful for real consumers 
outside the git-* tools.

You could put big fat warnings everywhere that parts of the API which 
are exposed are heavily unstable and likely subject to change and that 
programmers using them will have to frequently start over. Once it turns 
out that all the git-tools and all "reference consumers" work it, you 
can do some cleanup to get to the final first API version after the 
libification project is done.

   bye, Rocco
-- 
:wq!
