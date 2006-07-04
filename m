From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 14:15:18 -0700
Message-ID: <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
	<7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 23:15:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxsEu-0006Bt-6F
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 23:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWGDVPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWGDVPU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 17:15:20 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48321 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932209AbWGDVPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 17:15:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704211519.DUSM8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 17:15:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 4 Jul 2006 10:23:09 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23317>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We could introduce a time.maximumSkew variable, and just walk only 
> that much further when traversing the commits.

We could have had "commit generation number" in the commit
object header, and use that instead of commit timestamps for
these traversal purposes.  The generation number for a commit is
defined to be max(generation number of its parents)+1 and we
prime the recursive this definition by defining the generation
number for the root commit to be one.  A moral equivalent
alternative would be to notice that the commit timestamp we are
going to use to create for a new commit is smaller than one of
the commit timestamps of its parent commits and adjust the
commit timestamp in such a case by git-commit-tree, perhaps with
a warning.

These are pretty much water under the bridge by now, for two
reasons.  One is that I think it is better to make the tools
that use get_merge_bases() prepared for the case the function
includes suboptimal bases anyway, and the other is once we do
that this is not a strong enough justification to modify the
commit object format.
