From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 11:59:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704181147330.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.a n  dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <4625B99D.9090409@dawes.za.net>
 <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org>
 <46263B8E.9080500@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCZB-0007fw-MQ
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbXDRP7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbXDRP7X
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:59:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14487 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbXDRP7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 11:59:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGP00JTBB2Y5Q70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 11:59:22 -0400 (EDT)
In-reply-to: <46263B8E.9080500@dawes.za.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44903>

On Wed, 18 Apr 2007, Rogan Dawes wrote:

> Right. I would imagine that the script would have to take care of setting
> timestamps in the filesystem appropriately, as well as passing them back to
> git when queried.
> 
> e.g. expanding test.odf/: (since we store it as a directory)
> 
> git calls "odf.sh checkout test.odf/ <sha1> <perms> <stat>"
> 
> odf checkout calls back into git to find out the details of the files under
> test.odf/, and creates a zip file containing the individual files, with
> appropriate timestamps.

Why would you need to store the document as multiple files into Git?

The only reasons I can see for external filters are:

 1) Normalization, e.g. the LF->CRLF thing.

    Some might want to do keyword expansion which would fall into this
    category as well.

 2) Better archiving with Git's deltas.

    That means storing files uncompressed into Git since Git will
    compress them anyway, after significant space reduction due to 
    deltas which cannot occur on already compressed data.

So if your .odf file is actually a zip with multiple files, then all you 
have to do is to convert that zip archive into a non compressed tar 
archive on checkins, and the reverse transformation on checkouts.  The 
non compressed tar content will delta well, the Git archive will be 
small, and no tricks with the index will be needed.

Or am I missing something?


Nicolas
