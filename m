From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] filter-branch: support skipping of commits more easily
Date: Thu, 07 Jun 2007 17:42:36 -0700
Message-ID: <7v7iqfnuo3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706080058160.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 02:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwSZ0-000225-8m
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 02:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765666AbXFHAmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 20:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765839AbXFHAmi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 20:42:38 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42057 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765666AbXFHAmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 20:42:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608004237.PBAY7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 Jun 2007 20:42:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8oic1X00Z1kojtg0000000; Thu, 07 Jun 2007 20:42:37 -0400
In-Reply-To: <Pine.LNX.4.64.0706080058160.4046@racer.site> (Johannes
	Schindelin's message of "Fri, 8 Jun 2007 00:59:48 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49421>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When commit-filter echoes just "skip", just skip that commit by mapping 
> its object name to the same (possibly rewritten) object name(s) its 
> parent(s) are mapped to.
>
> IOW, given A-B-C, if commit-filter says "skip" upon B, the rewritten 
> branch will look like this: A'-C'.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Of course, if you think of "patchsets", this behaviour might
> 	be unexpected, since the children will still contain everything
> 	which was changed in the skipped revisions, and not changed in
> 	_them_.

I think that is fine; in effect, by saying "skip" B, you are
squashing B-C into C'.

Does this mean that, given

          C---D---E
         /   /
	A---B

and if commit-filter says "skip" on D, the written history would
look like this?

          C'------E'
         /       /
	A'--B'--'

The new commit E' would become an evil merge that has difference
between D and E in the original history?

I am not objecting; just trying to get a mental picture.
