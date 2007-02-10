From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 11:40:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702101131070.1757@xanadu.home>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
 <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 17:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFvHg-0006bP-RR
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXBJQkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbXBJQkz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:40:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65063 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXBJQkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:40:55 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD900JB7AC5ZJB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Feb 2007 11:40:54 -0500 (EST)
In-reply-to: <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39240>

On Sat, 10 Feb 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Sat, 10 Feb 2007, Johannes Schindelin wrote:
> >
> >> So, what is the big problem about accepting that patching git-status for 
> >> one obscure use is wrong, wrong, wrong, when git-diff already does what is 
> >> needed???
> >
> > Because git-status itself is conceptually a read-only operation, and 
> > having it barf on a read-only file system is justifiably a bug.
> 
> I do not 100% agree that it is conceptually a read-only operation.

It is.  It's the technical issue that makes it not so.  But when a user 
asks for a status, he's clearly not expecting to _write_ anything, even 
less for the command to fail if the file system is read-only.  This is 
like if a file system driver refused to open a file when the file system 
is mounted read-only just because it cannot update the file's atime on 
disk.

Just like the atime example, we may refresh the index while at it when 
preparing the status results.  This is a valid technical concern.  But 
it for sure should not be mandatory for the command to succeed if the 
file system is read-only.


Nicolas
