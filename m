From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sat, 19 May 2007 11:20:12 -0700
Message-ID: <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
References: <11795163053812-git-send-email-skimo@liacs.nl>
	<11795163061588-git-send-email-skimo@liacs.nl>
	<20070518215312.GB10475@steel.home>
	<20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 20:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpTXR-0001lk-Lp
	for gcvg-git@gmane.org; Sat, 19 May 2007 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364AbXESSUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 14:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758195AbXESSUP
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 14:20:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42613 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364AbXESSUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 14:20:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519182013.MBKW13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 14:20:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 16LC1X00J1kojtg0000000; Sat, 19 May 2007 14:20:13 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47764>

Sven Verdoolaege <skimo@kotnet.org> writes:

> Does everyone agree that we should fetch (possibly after asking
> for confirmation from the use) _during_ the checkout ?
> I now only fetch submodules during a fetch of the supermodule
> (actually, in my current patch set, I only fetch a submodule
> the first time I see it, but that's a bug), but if there is
> a consensus on this, I can switch to fetching during checkout.

I think fetching of subproject during fetch or clone of
superproject would not make much sense.  Making it part of
superproject checkout would probably be the way we will end up
going.  The detail of "which part of the checkout" would need to
be defined, and I tend to agree with Alex that checkout itself
would need to be multi-phased, but I think that is a minor
implementation detail we can discuss after how the overall flows
should look like.

> As to the key to use to lookup the URL in the config, right
> now I simply use the directory name where it is attached
> (which seems like a useful default to me).

> I'm not all that convinced that we should store a default URL
> in history, so AFAICS, the only thing we need to store is a
> mapping between directory names and subproject names.
> It has been suggested to do that in .gitattributes.
> Is that OK for everyone, or do we really need a separate .gitmodules ?

If your (super)repository is _the_ only repository that knows
about the aggregation it is doing, I do not think you need
anything, as .git/config in the subproject would know where to
get updates from.  Otherwise, Project wide suggestions need to
be there in some machine readable form if you were to allow such
superproject distributed, be it in .gitmodules or
.gitattributes, don't they?

And frankly, I think .gitattributes is a wrong place to store
it, as its semantics is to give attributes to paths that MATCH
the glob.  You can argue that a pattern in .gitattributes can be
written to match only one path, but it still feels conceptually
wrong.  Something more concrete and exact, like the second level
key of .git/config and .gitmodules file format, is preferable.
