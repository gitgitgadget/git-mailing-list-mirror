From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Help cloning over http.
Date: Sat, 17 Sep 2005 13:37:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509171235330.23242@iabervon.org>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
 <7vhdckceas.fsf@assigned-by-dhcp.cox.net> <7vacicccxl.fsf@assigned-by-dhcp.cox.net>
 <7vvf10axia.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Sep 17 19:34:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGgYv-0007UM-Od
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 19:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVIQRdE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 13:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVIQRdD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 13:33:03 -0400
Received: from iabervon.org ([66.92.72.58]:55047 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751166AbVIQRdC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 13:33:02 -0400
Received: (qmail 30300 invoked by uid 1000); 17 Sep 2005 13:37:16 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Sep 2005 13:37:16 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf10axia.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8770>

On Sat, 17 Sep 2005, Junio C Hamano wrote:

> Even when repository is packed, the new "we trust only the refs
> we already have" code wasted too much time verifying what are
> already in packs, walking down to the root commits.  Since we
> slurp all the necessary packs upfront and run verify pack on
> them, temporarily register their edge commits as "known to be
> good" before invoking git-http-fetch.

This is a somewhat special situation, because we're assuming that the 
packs are a complete set. When git-http-fetch downloads a pack, it still 
needs to know if that pack uses other stuff, in which case it probably 
needs to download it. The old code actually wouldn't have worked properly 
if the first pack didn't include any blobs that were still in the latest 
version, because it wouldn't track commits through the pack and only 
generally worked with multiple packs because it would need blobs from 
every pack to produce the current tree. 

I think that this gets particularly tricky with alternates, where the 
necessary packs for ancient history may not actually be in the list of 
packs in the repository we're looking at.

	-Daniel
*This .sig left intentionally blank*
