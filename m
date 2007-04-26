From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 0/2] bookmarks
Date: Thu, 26 Apr 2007 08:25:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk>
References: <200704252004.45112.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
 <200704252142.33756.andyparkins@gmail.com> <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
 <7vmz0vu1fc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 09:25:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgyLz-0001Os-4V
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 09:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933332AbXDZHZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 03:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933331AbXDZHZR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 03:25:17 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:41624 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933354AbXDZHZP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2007 03:25:15 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id BF801C6246
	for <git@vger.kernel.org>; Thu, 26 Apr 2007 08:25:13 +0100 (BST)
Received: (qmail 30104 invoked by uid 103); 26 Apr 2007 08:24:10 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3162. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.038355 secs); 26 Apr 2007 07:24:10 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 26 Apr 2007 08:24:10 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vmz0vu1fc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45615>

On Wed, 25 Apr 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> While I like the idea of private tags, I find the idea of them having
>> their own namespace to be much more attractive than simply having the
>> ability to not export lightweight tags.
>>
>> In particular it means that you can control which tags are exported
>> individually.
>
> I do not think this is limited to tags. Sometimes you may want
> to make some branches private.  It probably is also a good idea
> to hide StGIT patch base refs that live under $GIT_DIR/refs/.
>
> Here, I do not use the word "private" in the sense of being
> "secret", as most likely branches that share common root would
> have many trees and blobs in common, but in the sense of "less
> clutter".
>
> How would one find out about remote refs?  By running
> ls-remote.  And that happens to also be how git-fetch follows
> tags (the original issue Andy had).

Surely though, what you really want is to simply not put the private refs 
into a public repo.  So the thing to be controlling is push, not fetch.

That way you are not reliant on the user's tools following your rules.

I don't think it unreasonable to say that anything that is in a public 
repository is public, and that the way to keep things private is to not 
push them into a public repository. Or is it?

I understand that some people may wish to make their working repositories 
public, but then there isn't any way we can say for sure that things will 
remain private.  Even if ls-remote was updated, an older version would 
simply ignore the new "this is private" configuration.

>
> Over native git protocol, upload-pack is the program that runs
> in the repote repository and gives list of available refs and
> object names they point at (upload-pack.c::send_ref()).  To dumb
> clients, update-server-info creates the equivalent information
> in $GIT_DIR/info/refs and that is what the ls-remote sees.
>
> So I suspect that a more general solution would be to to teach
> these two programs to take notice of a new configuration
> variable you can set in the repository to limit the set of refs
> to give out.  Then you do not have to introduce a new namespace,
>
> Probably the configuration would be a glob pattern (for pathname
> like things, we tend to use shell glob, not regexp) to
> include/exclude.  E.g.
>
> 	refs.expose = refs/heads/*
>        refs.expose = refs/tags/*
>        refs.expose = !refs/heads/*/*
>        refs.expose = !refs/tags/v[0-9]*
>
> would let you say "I would want to expose all of refs/heads/
> (i.e. branches) and refs/tags (i.e. tags), but I do not want to
> show branches with '/' in their names, nor tags whose names do
> not begin with v[0-9]".

or simply expand the current push configuration to accept that syntax, so 
that you can finely control which refs get pushed to the public repo?

-- 
Julian

  ---
Only two of my personalities are schizophrenic, but one of them is
paranoid and the other one is out to get him.
