From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Sat, 24 Feb 2007 00:14:55 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702240005270.29426@xanadu.home>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232046300.29426@xanadu.home>
 <Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232123110.29426@xanadu.home>
 <Pine.LNX.4.63.0702240336130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232141040.29426@xanadu.home>
 <7vbqjk17a8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 06:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKpFL-0002PF-NC
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 06:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbXBXFO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 00:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbXBXFO5
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 00:14:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932747AbXBXFO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 00:14:56 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDY00M3DBWV6J70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 24 Feb 2007 00:14:55 -0500 (EST)
In-reply-to: <7vbqjk17a8.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40503>

On Fri, 23 Feb 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > And it is not like if the whole thing was thrown away.  For example I 
> > think messages like
> >
> > 	remote: Writing 1234 objects.
> >
> > are good messages to have in a log file even when progress display is 
> > filtered out.  So the sideband demultiplexing is useful in that case as 
> > well.
> 
> In that case, maybe we should define a separate sideband for
> progress display?  Currently #1 (payload) and #3 (emergency
> exit) are distinct but #2 corresponds to stderr which has info
> messages and progress noise all mixed up.

And how would the remote end distinguish how to split the info from the 
progress noise?  Teaching pack-object about another file descriptor?
And what happen if pack-object is run locally in that case?

How does that solve the issue with servers (currently all of them) that 
don't know about the new sideband?

I think life might just be so much simpler if we just decide right now 
that progress noise is defined as a string ending witha '\r', and that 
we just toss it locally when we don't want progress noise.  As a bonus 
this is even fully backward compatible with all existing servers.


Nicolas
