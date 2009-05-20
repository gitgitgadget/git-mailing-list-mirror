From: Nicolas Pitre <nico@cam.org>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 14:04:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905201358000.3906@xanadu.home>
References: <4A136C40.6020808@workspacewhiz.com>
 <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
 <20090520032139.GB10212@coredump.intra.peff.net>
 <alpine.LFD.2.00.0905192328310.3906@xanadu.home>
 <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
 <alpine.LFD.2.00.0905200853010.3906@xanadu.home>
 <96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com>
 <alpine.LFD.2.00.0905201144040.3906@xanadu.home>
 <fabb9a1e0905200913u5252973aia9a20983b20243d3@mail.gmail.com>
 <20090520165854.GA23031@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 20:05:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qAN-0005li-2A
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZETSFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbZETSFO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:05:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13150 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZETSFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:05:13 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KJY007LVFKAOAY2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 20 May 2009 14:05:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090520165854.GA23031@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119624>

On Wed, 20 May 2009, Jeff King wrote:

> On Wed, May 20, 2009 at 06:13:55PM +0200, Sverre Rabbelier wrote:
> 
> > On that note, the usefulness of such a feature is dependant on the
> > support we have for actually restoring an entry from this new reflog.
> > The current reflog is so amazingly useful because git has
> > awesome-cherry-pick-and-the-like-commit-handling powers that make it
> > easy to restore the otherwise lost state. But as far as I know,
> > there's no nice 'n easy support for restoring state to the information
> > contained in this new reflog, is there?
> 
> I was envisioning a reflog of tree objects, so you could do:
> 
>   $ git reflog show TRASH ;# show the reflog message
>   $ git show TRASH@{1} ;# show what's in the tree
>   $ git show TRASH@{1}:path/to/file ;# see a file
>   $ git checkout TRASH@{1} path/to/file ;# restore a file
> 
> which should all work as-is.
> 
> I suspect "git log -g" might need some tweaking to get a tree rather
> than a commit (but in theory we should just show the "Reflog *:" headers
> and not the commit headers).

Even simpler (for the user) would be to create a full commit with a 
synthetic message.  The advantage is that the commit would have for 
parent the HEAD commit at the moment the operation leading to the reflog 
entry was made, with the date tag, etc.  The message could even contain 
information about what exactly was discarded by the operation.  This 
commit would be referenced only by the trash reflog and not be part of 
any branch. And all your examples above should still work of course.


Nicolas
