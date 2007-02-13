From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PU PATCH] Fix git fetch for very large ref counts
Date: Tue, 13 Feb 2007 10:39:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702131031180.6435@reaper.quantumfyre.co.uk>
References: <11713297014015-git-send-email-julian@quantumfyre.co.uk>
 <7vd54e4ufk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 11:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGv4f-0005dd-UQ
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 11:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbXBMKjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 05:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXBMKjq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 05:39:46 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:38739 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXBMKjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 05:39:43 -0500
Received: (qmail 2863 invoked by uid 103); 13 Feb 2007 10:39:42 +0000
Received: from 192.168.0.16 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2560. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.16):. 
 Processed in 0.031446 secs); 13 Feb 2007 10:39:42 -0000
Received: from unknown (HELO reaper.quantumfyre.co.uk) (192.168.0.16)
  by neutron.datavampyre.co.uk with SMTP; 13 Feb 2007 10:39:42 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7vd54e4ufk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39512>

On Mon, 12 Feb 2007, Junio C Hamano wrote:

> "Julian Phillips" <jp3@quantumfyre.co.uk> writes:
>
>> The updated git fetch in pu is vastly improved on repositories with very
>> large numbers of refs.  The time taken for a no-op fetch over ~9000 refs
>> drops from ~48m to ~0.5m.
>>
>> However, before git fetch will actually run on a repository with ~9000
>> refs the calling interface between fetch and fetch--tool needs to be
>> changed.  The existing version passes the entire reflist on the command
>> line, which means that it is subject to the maxiumum environment size
>> passed to a child process by execve.
>>
>> The following patches add a stdin based interface to fetch--tool allowing
>> the ~9000 refs to be passed without exceeding the environment limit.
>
> Thanks.
>
> But the ones in 'pu' were done primarily as demonstration of
> where the bottlenecks are, and not meant for real-world
> consumption.  I think the final shaving of 0.5m down to a few
> seconds needs to move the ls_remote_result string currently kept
> as a shell variable to a list of strings represented in a
> git-fetch largely rewritten in C, and at that point the
> interface from outside fetch--tool to throw 9000 refs at it
> would be an internal function call and the code you fixed along
> with new function you introduced would probably need to be
> discarded.

And there I was thinking 0.5m was fast ... given how long I've been 
reading this list I really should have know better. ;)

I only really made the changes so I could try your improvements to fetch 
out - if they aren't necessary because you're making it even faster then I 
really don't have much cause to complain.

-- 
Julian

  ---
To be a kind of moral Unix, he touched the hem of Nature's shift.
 		-- Shelley
