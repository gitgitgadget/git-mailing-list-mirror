From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 18:11:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703011802130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070228151516.GC57456@codelabs.ru>
 <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
 <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <200703011040.35971.andyparkins@gmail.com>
 <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com>
 <20070301051323.GG57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
 <7vslcpux62.fsf@assigned-by-dhcp.cox.net> <20070301120042.GD63606@codelabs.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 01 18:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMooZ-0000af-9g
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 18:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965414AbXCARLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 12:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965413AbXCARLe
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 12:11:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:50725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965411AbXCARLd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 12:11:33 -0500
Received: (qmail invoked by alias); 01 Mar 2007 17:11:29 -0000
X-Provags-ID: V01U2FsdGVkX1/mRmEX1G7mwkeVZSCT9LBESAgo2LgjA04lEslExL
	A3hgSFTXqTMS5X
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070301120042.GD63606@codelabs.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41106>

Hi,

On Thu, 1 Mar 2007, Eygene Ryabinkin wrote:

> By the way, I am missing one thing: the Id keyword in the file. The 
> problem is that when some user is telling me: there is a bug in the 
> function a() that is inside the file b.c, then I can ask him to give me 
> the $Id$ tag of the file and I will have the full information about the 
> file version.

The problem is: Git does not track files, but rather trees. So, there is 
no sane way to add an Id.

But all is not lost! If your colleague sends you the offending file, you 
can calculate the object name from it by

	$ git-hash-object -t blob <filename>

If the file is too big, your colleague can run it herself and send you the 
object name (it is a 40 character hex string, but the first 8 or so should 
really be sufficient).

Then you can run

	$ git log -p HEAD <filename>

in your repository, and search for "index <object name>". You will find 
the commit which changed the file _from_ the state your colleague is 
seeing.

The idea is that the diff shows not only the names, but also a line "index 
<abbrev1>..<abbrev2>", where the abbrev's are the abbreviated object names 
of the old and new versions of that file.

BTW we had a similar discussion a while ago, which made me even write a 
patch for git-name-rev to name objects, too, but it was rejected as the 
workflow I outlined above is already sufficient for your use case.

Hth,
Dscho
