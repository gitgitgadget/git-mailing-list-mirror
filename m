From: linux@horizon.com
Subject: Re: Embedded Linux development with GIT
Date: 5 Jul 2007 08:31:00 -0400
Message-ID: <20070705123100.14986.qmail@science.horizon.com>
Cc: git@vger.kernel.org
To: svk.sweng@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 05 15:19:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6RF8-0004rX-Dp
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 15:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759269AbXGENTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 09:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758235AbXGENTc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 09:19:32 -0400
Received: from science.horizon.com ([192.35.100.1]:12005 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758567AbXGENTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 09:19:31 -0400
Received: (qmail 14987 invoked by uid 1000); 5 Jul 2007 08:31:00 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51674>

> Is it possible then to see our 400 odd commits then in the Local
> branch on top of 2.6.17 so that we can see not only our history but
> also the history that came before?  Then as Master advances we can see
> about backporting and bringing our code close enough to mainline
> kernel to actually be able to contribute back to the community and
> submit patches.  Is this realistic approach.  I am unsure of the GIT
> commands that I need to do this?

Yes.  There are two ways to do this:

1) Use the grafts feature.  You can put a line in your repository's
   .git/info/grafts which lists your initial commit and the ancestors you
   want it to have.
   E.g. note that Linus's v2.6.17 is 427abfa28afedffadfca9dd8b067eb6d36bac53f, with
   parent ce221982e0bef039d7047b0f667bb414efece5af.  So you can just include
   <your initial checkin> ce221982e0bef039d7047b0f667bb414efece5af
   in git/info/grafts, and boom.

   The advantage is that you don't have to change anything.

   The disadvantge here is that this is NOT automatically propagated
   by pull operations (it would be a security breach if it were), so
   everyone pulling from you has to do the same thing manually.
   (If you're only sending out patches, it doesn't matter as much.)

2) Rebase your changes.

   Import a standard Linux kernel into the repository, and rebase your
   changes from your original root import onto Linus' 2.6.17.

   The advantage here is that the commit IDs will be preserved when you
   share your changes, so if you have your changes pulled into the kernel
   mainline, it'll be easier to merge them and for you to merge back.

   The disadvantage is that everyone who has cloned from you has to manually
   re-fetch once.

Basically, option 1 has less immediate pain, but has an ongoing cost.
Option 2 gets it out of the way all at once.
