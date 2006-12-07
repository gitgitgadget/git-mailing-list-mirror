X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] change the unpack limit treshold to a saner value
Date: Wed, 06 Dec 2006 22:24:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612062213500.2630@xanadu.home>
References: <Pine.LNX.4.64.0612061420410.2630@xanadu.home>
 <Pine.LNX.4.64.0612061700120.3542@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 7 Dec 2006 03:24:36 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0612061700120.3542@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33544>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs9s5-0001RW-Rc for gcvg-git@gmane.org; Thu, 07 Dec
 2006 04:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967835AbWLGDYR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 22:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967886AbWLGDYQ
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 22:24:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32431 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967835AbWLGDYP (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 22:24:15 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9V000FNW4EFQH0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 06 Dec 2006 22:24:15 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, 6 Dec 2006, Linus Torvalds wrote:

> We have a much easier time handling many loose packed objects than many 
> pack-files. For many reasons, but two really obvious ones:
> 
>  - pack-file indexes get read in on startup, and we maintain an explicit 
>    list of them. Having lots of pack-files adds overhead that doesn't 
>    exist for lots of loose objects.
> 
>  - loose files are spread out over 256 subdirectories to make lookup 
>    easier, packfiles are not (and always create an index file too).
> 
> So in general, as a trivial heuristic, you probably want about 512 times 
> as many loose objects as you want pack-files, i fonly because of the 
> latter issue, because you can much more easily handle lots of loose 
> objects than lots of pack-files. So it's _not_ a factor of 3. Or even 10.
> 
> But since there _is_ reason to do pack-files too, and since using too big 
> a value means that you never end up keeping a pack-file _at_all_ if you 
> pull often, I'd suggest that rather than use a limit of 512 you go for 
> something like 100-200 objects as the threshold (of course, the proper one 
> would depend on the distribution of the size of your pack-files, but I'll 
> just hand-wave and say that together with occasional re-packing, something 
> in that range is _generally_ going to be a good idea).

Note that this setting is currently observed for pushes not pulls.
On the pull side you currentli need to provide -k for not exploding 
packs.

So the question is what number of objects on average do pushes have?  If 
most pushes are below the treshold this is not going to be really 
useful.

And I think 5000 is definitely way too high.  10 might be too small 
indeed.  100 is maybe a good default to try out.


