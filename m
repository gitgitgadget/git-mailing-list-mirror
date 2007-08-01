From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during
 check-out
Date: Wed, 01 Aug 2007 16:05:32 +0200
Message-ID: <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
 <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 16:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGEpm-0007P5-9C
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 16:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbXHAOFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 10:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbXHAOFf
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 10:05:35 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:49941 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590AbXHAOFe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 10:05:34 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JM3004WPLT8PB@psmtp08.wxs.nl> for git@vger.kernel.org; Wed,
 01 Aug 2007 16:05:32 +0200 (MEST)
Received: (qmail 678 invoked by uid 500); Wed, 01 Aug 2007 14:05:32 +0000
In-reply-to: <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54438>

On Wed, Jul 18, 2007 at 12:29:52AM -0700, Junio C Hamano wrote:
> Passing of ce instead of path in the unpack-trees callchain
> looks like the right thing to do.  Good job.

Actually, my patch only fixes the tip of the iceberg.
If you have a submodule checked out and you go back (or forward)
to a revision of the supermodule that contains a different
revision of the submodule and then switch to another revision,
it will complain that the submodule is not uptodate, because
git simply didn't update the submodule in the first move.

Now, you may say that I simply need to run 'git submodule update'
after every such move, but this is very inconvenient, especially
if you're doing a bisect or a rebase.

How do other people deal with this problem?

How about just replacing the body of ce_compare_gitlink
with "return 0" until git actually (optionally) updates
the submodules during an update of the supermodule?

skimo
