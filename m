From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 17:05:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqBw-0003Ou-E0
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbXDCVFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbXDCVFV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:05:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63921 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbXDCVFU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:05:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00I5RX8VWE50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 17:05:19 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43664>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> All that extra memory is just for SHA1 commit ID information. 

I don't see where that might be.  The only thing that the paranoia check 
triggers is:

	foo = read_sha1_file(blah);
	memcmp(foo with bar);
	free(foo);

So where is that commit ID information actually stored when using 
read_sha1_file()?

> Btw, even if we don't have any of the objects, if you have tons and tons 
> of objects and do a "git pull", just the *lookup* of the nonexistent 
> objects will be expensive: first we won't find it in any pack, then we'll 
> look at the loose objects, and then we'll look int he pack *again* due to 
> the race avoidance. So looking up nonexistent objects is actually pretty 
> expensive.

Not if you consider that it is performed _while_ receiving (and waiting 
for) the pack data over the net in the normal case.


Nicolas
