From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Mon, 10 Dec 2007 22:49:00 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 04:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1w7a-00033x-TX
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 04:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXLKDtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 22:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbXLKDtE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 22:49:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62579 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbXLKDtC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 22:49:02 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSV00IM399PE540@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Dec 2007 22:49:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67782>

On Mon, 10 Dec 2007, Jon Smirl wrote:

> New run using same configuration. With the addition of the more
> efficient load balancing patches and delta cache accounting.
> 
> Seconds are wall clock time. They are lower since the patch made
> threading better at using all four cores. I am stuck at 380-390% CPU
> utilization for the git process.
> 
> complete seconds RAM
> 10%   60    900M (includes counting)
> 20%   15    900M
> 30%   15    900M
> 40%   50    1.2G
> 50%   80    1.3G
> 60%   70    1.7G
> 70%   140  1.8G
> 80%   180  2.0G
> 90%   280  2.2G
> 95%   530  2.8G - 1,420 total to here, previous was 1,983
> 100% 1390 2.85G
> During the writing phase RAM fell to 1.6G
> What is being freed in the writing phase??

The cached delta results, but you put a cap of 256MB for them.

Could you try again with that cache disabled entirely, with 
pack.deltacachesize = 1 (don't use 0 as that means unbounded).

And then, while still keeping the delta cache disabled, could you try 
with pack.threads = 2, and pack.threads = 1 ?

I'm sorry to ask you to do this but I don't have enough ram to even 
complete a repack with threads=2 so I'm reattempting single threaded at 
the moment.  But I really wonder if the threading has such an effect on 
memory usage.



> 
> I have no explanation for the change in RAM usage. Two guesses come to
> mind. Memory fragmentation. Or the change in the way the work was
> split up altered RAM usage.
> 
> Total CPU time was 195 minutes in 70 minutes clock time. About 70%
> efficient. During the compress phase all four cores were active until
> the last 90 seconds. Writing the objects took over 23 minutes CPU
> bound on one core.
> 
> New pack file is: 270,594,853
> Old one was: 344,543,752
> It still has 828,660 objects

You mean the pack for the gcc repo is now less than 300MB?  Wow.


Nicolas
