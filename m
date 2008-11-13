From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 23:23:38 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0811132317100.3965@reaper.quantumfyre.co.uk>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 00:25:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lZA-0000Rg-TY
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbYKMXYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYKMXYW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:24:22 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:48204 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751374AbYKMXYV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 18:24:21 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 2147B1A9F60
	for <git@vger.kernel.org>; Thu, 13 Nov 2008 23:24:20 +0000 (GMT)
Received: (qmail 24960 invoked by uid 103); 13 Nov 2008 23:23:38 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.94/8623. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.028953 secs); 13 Nov 2008 23:23:38 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 13 Nov 2008 23:23:38 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100926>

On Thu, 13 Nov 2008, Linus Torvalds wrote:

> Before:
>
> 	[torvalds@nehalem linux]$ /usr/bin/time git diff > /dev/null
> 	0.03user 0.04system 0:00.07elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
>
> After:
>
> 	0.02user 0.07system 0:00.04elapsed 243%CPU (0avgtext+0avgdata 0maxresident)k
> 	0inputs+0outputs (0major+2241minor)pagefaults 0swaps
>
> ie it actually did cut elapsed time from 7 hundredths of a second to just
> 4. And the CPU usage went from 100% to 243%. Ooooh. Magic.
>
> But it's still hacky as hell. Who has NFS? Can you do the same thing over
> NFS and test it? I'm not going to set up NFS to test this, and as I
> suspected, on a local disk, the cold-cache case makes no difference
> what-so-ever, because whatever seek optimizations can be done are still
> totally irrelevant.

The timings seem to vary quite a bit (not really a surprise with a network 
involved ;), but the patch definately makes things faster:

master:

jp3@kaos: linux-2.6(master)>/usr/bin/time ~/bin/git diff > /dev/null
0.01user 0.19system 0:02.50elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+1766minor)pagefaults 0swaps

master + patch:

jp3@kaos: linux-2.6(master)>/usr/bin/time ~/bin/git diff > /dev/null
0.02user 0.88system 0:00.96elapsed 93%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+1783minor)pagefaults 0swaps

seems to be approximately twice as fast?

-- 
Julian

  ---
<nelchael> "XML is like violence, if it doesn't solve the problem, just
  use more."
* nelchael hides
