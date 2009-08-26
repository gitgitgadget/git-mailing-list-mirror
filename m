From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Wed, 26 Aug 2009 01:22:56 -0700
Message-ID: <20090826082256.GO1033@spearce.org>
References: <alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org> <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org> <20090825151424.GJ1033@spearce.org> <20090826021057.GL1033@spearce.org> <4A94DF84.4050906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 10:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgDmd-0006wK-7O
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 10:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbZHZIW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 04:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbZHZIW4
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 04:22:56 -0400
Received: from george.spearce.org ([209.20.77.23]:42087 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZHZIWz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 04:22:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EF2F7381FD; Wed, 26 Aug 2009 08:22:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A94DF84.4050906@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127068>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> >  static void upload_pack(void)
> >  {
> >  	reset_timeout();
> > -	head_ref(send_ref, NULL);
> > -	for_each_ref(send_ref, NULL);
> > -	packet_flush(1);
> > +	head_ref(scan_ref, NULL);
> > +	for_each_ref(scan_ref, NULL);
> > +
> > +	push_advertise("HEAD");
> > +	push_advertise("refs/heads/*");
> > +	push_advertise("refs/tags/*");
> > +	send_refs();
> > +
> 
> How will this mesh with 'git clone --mirror'?

Not well.

> Is the client expected to
> ask with 'expand refs/*'?

If the client is new enough to understand the "expand" extension,
yes, it would ask for "expand refs/*" and get everthing, allowing
it to complete a full mirror.

If the client is older and doesn't know this extension, then it
is hopeless.  The server isn't advertising refs/*, doesn't know
that the client can't ask for refs/*, and the client doesn't know
it is missing refs when it makes the mirror.

This backwards incompatible breakage is something I have no real
solution for.  :-|

-- 
Shawn.
