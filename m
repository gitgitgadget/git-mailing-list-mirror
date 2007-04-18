From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 12:55:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
References: <20070417161720.GA3930@xp.machine.xx>
 <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
 <20070418055215.GA32634@xp.machine.xx> <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
 <20070418081122.GB32634@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:55:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He8kw-0005F3-4Q
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 13:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422919AbXDRLzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 07:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422916AbXDRLzV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 07:55:21 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:46980 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422908AbXDRLzT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 07:55:19 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id CFD6AC617A
	for <git@vger.kernel.org>; Wed, 18 Apr 2007 12:55:17 +0100 (BST)
Received: (qmail 31441 invoked by uid 103); 18 Apr 2007 12:54:32 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3112. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.042074 secs); 18 Apr 2007 11:54:32 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 18 Apr 2007 12:54:32 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070418081122.GB32634@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44892>

On Wed, 18 Apr 2007, Peter Baumann wrote:

> On Wed, Apr 18, 2007 at 12:40:10AM -0700, Junio C Hamano wrote:
>>
>> We can do one of two things.  I am not sure which one is better.
>>
>>  (0) The effect of 'git gc' by definition in the symlink-shared
>>      work tree should be the same as in the original repository
>>      as the former is to share all the refspace and object
>>      database.  So we _could_ declare that running 'git gc' in
>>      symlink-shared work tree is insane and educate people to
>>      run that in the original repository.  This is _not_ doing
>>      anything.
>>
>>  (1) We could by convention declare a worktree whose .git/refs
>>      is a symlink, and have git-gc and friends check for it, and
>>      either refuse to run or automatically chdir and run there.
>>
>>      If we were to do this, we probably should check more than
>>      just .git/refs but some other symlinks under .git/ as well.
>>
>>  (2) We could dereference .git/packed-refs, when it is a
>>      symlink, by hand, just like we dereference a symlink HEAD
>>      by hand (see resolve_ref() in refs.c), and run the
>>      creat-to-temp-and-then-rename sequence to update the real
>>      file that is pointed at by it.
>>
>
> Its not all the clear which one is the best, but (2) sounds as the most
> promosing aproach. Hopefully, I'll have time to cook up a patch this
> evening.

Personally I think (1) might be slightly better, in the refuse to run 
form.  gc is a repository operation, not a working directory one - and by 
refusing to run in a workdir this is made clear.  You could print out a 
message that includes the location of the actual repo to be more friendly 
though.

But whatever solution you go for, you can't use _any_ workdir that points 
at a repo that is having gc run on, either directly or indirectly, without 
risky odd behaviour.

-- 
Julian

  ---
Q:	How many supply-siders does it take to change a light bulb?
A:	None.  The darkness will cause the light bulb to change by itself.
