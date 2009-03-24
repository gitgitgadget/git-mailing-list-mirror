From: Nicolas Pitre <nico@cam.org>
Subject: Re: large(25G) repository in git
Date: Mon, 23 Mar 2009 21:19:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903232056520.26337@xanadu.home>
References: <49C7FAB3.7080301@brainfood.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvKi-0000lg-2O
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbZCXBUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbZCXBUG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:20:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12456 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbZCXBUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:20:04 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGZ00E29L19HF40@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Mar 2009 21:19:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49C7FAB3.7080301@brainfood.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114384>

On Mon, 23 Mar 2009, Adam Heath wrote:

> Last friday, I was doing a checkin on the production server, and found
> 1.6G of new files.  git was quite able at committing that.  However,
> pushing was problematic.  I was pushing over ssh; so, a new ssh
> connection was open to the preview server.  After doing so, git tried
> to create a new pack file.  This took *ages*, and the ssh connection
> died.  So did git, when it finally got done with the new pack, and
> discovered the ssh connection was gone.

Strange.  You could instruct ssh to keep the connection up with the 
ServerAliveInterval option (see the ssh_config man page).

> So, to work around that, I ran git gc.  When done, I discovered that
> git repacked the *entire* repository.  While not something I care for,
> I can understand that, and live with it.  It just took *hours* to do so.
> 
> Then, what really annoys me, is that when I finally did the push, it
> tried sending the single 27G pack file, when the remote already had
> 25G of the repository in several different packs(the site was an
> hg->git conversion).  This part is just unacceptable.

This shouldn't happen either.  When pushing, git reconstruct a pack with 
only the necessary objects to transmit.  Are you sure it was really 
trying to send a 27G pack?

> So, here are my questions/observations:
> 
> 1: Handle the case of the ssh connection dying during git push(seems
> simple).

See above.

> 2: Is there an option to tell git to *not* be so thorough when trying
> to find similiar files.  videos/doc/pdf/etc aren't always very
> deltafiable, so I'd be happy to just do full content compares.

Look at the gitattribute documentation.  One thing that the doc appears 
to be missing is information about the "delta" attribute.  You can 
disable delta compression on a file pattern that way.

> 3: delta packs seem to be poorly done.  it seems that if one repo gets
> repacked completely, that the entire new pack gets sent, when the
> target has most of the objects already.

This is not supposed to happen.  Please provide more details if you can.


Nicolas
