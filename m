From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 4/4] Disallow working directory commands in a bare
 repository.
Date: Sun, 31 Dec 2006 16:13:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612311606330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
 <20061231043238.GD5823@spearce.org> <7virfsk4sd.fsf@assigned-by-dhcp.cox.net>
 <20061231061122.GB6106@spearce.org> <7vk608fq9u.fsf@assigned-by-dhcp.cox.net>
 <20061231124921.GA14286@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 16:13:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H12NC-00083H-0K
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 16:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183AbWLaPNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 10:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933184AbWLaPNN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 10:13:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:45339 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933183AbWLaPNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 10:13:12 -0500
Received: (qmail invoked by alias); 31 Dec 2006 15:13:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 31 Dec 2006 16:13:11 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20061231124921.GA14286@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35700>

Hi,

On Sun, 31 Dec 2006, Theodore Tso wrote:

> On Sun, Dec 31, 2006 at 12:01:01AM -0800, Junio C Hamano wrote:
> > > Why not just tell these users to setup the working directories with
> > > local .git directories and not use GIT_DIR?
> > 
> > suggest that we might want to bite the bullet and declare that
> > these things are not supported anymore in v1.5.0.
> 
> While we're talking about potentially deprecating GIT_DIR for users,
> out of curiosity, what valid workflows would cause users to want to
> use GIT_INDEX_FILE and GIT_OBJECT_DIRECTORY?  Seems like they would
> cause more confusion and support problems than anything else.  

Easy, guys.

It is a valid -- indeed, useful -- thing to be able to script nice 
helpers. For example, in one project I track tar balls. So, I wrote a 
script which will unpack the tar ball in a directory, build a new index 
from it, and commit the corresponding tree on top of the tracking branch. 
This setup relies _heavily_ on being able to redirect GIT_INDEX_FILE and 
GIT_DIR.

So, these things are _useful_. Please don't break them.

As for the presence of "index" in a bare repo: I think this is not a 
problem, _as long_ as things continue to work as before, i.e.

	$ GIT_DIR=$(pwd) git log

and

	$ git --bare log

do _not_ complain if "index" is there. Now, if somebody starts git in a 
bare repo, where "index" is present, it could die with a helpful message 
like

	It seems that this is a bare git repository, but there is an index 
	file present, which contradicts that assumption. If the repository
	is indeed bare, please remove the index file.

Ciao,
Dscho
