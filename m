From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: bug with gitweb on kernel.org
Date: Sun, 22 Apr 2007 17:09:03 -0700
Message-ID: <1177286943.24896.14.camel@localhost.localdomain>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 02:09:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfm7X-0007Lk-1D
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 02:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXDWAJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 20:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbXDWAJ0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 20:09:26 -0400
Received: from shards.monkeyblade.net ([192.83.249.58]:40710 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976AbXDWAJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 20:09:26 -0400
Received: from [172.19.0.252] (c-76-21-106-12.hsd1.ca.comcast.net [76.21.106.12])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.8) with ESMTP id l3N09Bie014020
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 22 Apr 2007 17:09:12 -0700
In-Reply-To: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: ClamAV 0.88.7/3147/Sun Apr 22 08:09:35 2007 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45290>

On Thu, 2007-04-19 at 23:02 -0400, Nicolas Pitre wrote:
> Almost 2 months ago we discussed about gitweb not properly detecting the 
> client's ability to deal with application/xhtml+xml, something to do 
> with the caching of a previous request from a client which did support 
> it and serving the same content to a subsequent client which does not.

I apparently missed that entire conversation, my apologies.

> 
> Right now www.kernel.org/git is unusable for me with lynx as it keeps 
> prompting:
> 
> 	application/xhtml+xml  D)ownload, or C)ancel
> 
> Is there any plan to have that fixed?
> 

Well there are a couple of quick thoughts, so far (in my quick testing)
lynx and IE are the only two browsers that have issues with this
particular bit of code.  Links, konqueror, safari, firefox, mozilla, etc
all seem to handle the pages without issue.  Taking a quick glance at
the code it seems IE claims to be xhtml+xml compliant but apparently
isn't really (any real surprise?) and lynx just doesn't seem to support
that mime type.

The simplest fix would be to eliminate the distinction between
applicatoin/xhtml+xml and application/html in the gitweb code (or at
least in the caching gitweb code) and have everything claim a mimetype
of application/html and let the browser sort out if it's using xhtml or
html from the doctype.  This would solve both the problem your seeing on
lynx and would make the caching gitweb usable by more IE users.

Some quick testing on my part seems to indicate this doesn't break
behavior for any of the clients I have access to, but I thought I'd
check and see if anyone had any concerns over this particular change
before I barrel ahead with it in the caching gitweb code.

- John 'Warthog9' Hawley
