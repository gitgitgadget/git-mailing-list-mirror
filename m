From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git hang with corrupted .pack
Date: Wed, 14 Oct 2009 09:12:59 -0700
Message-ID: <20091014161259.GK9261@spearce.org>
References: <20091014042249.GA5250@hexapodia.org> <20091014142351.GI9261@spearce.org> <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Isaacson <adi@hexapodia.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 18:27:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My6gw-0001oP-Fn
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 18:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761924AbZJNQNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 12:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761947AbZJNQNh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 12:13:37 -0400
Received: from george.spearce.org ([209.20.77.23]:45075 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbZJNQNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 12:13:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 57C5D381FE; Wed, 14 Oct 2009 16:12:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130304>

Nicolas Pitre <nico@fluxnic.net> wrote:
> > Some types of corruption to a pack may confuse the deflate stream
> > which stores an object.  In Andy's reported case a 36 byte region
> > of the pack was overwritten, leading to what appeared to be a valid
> > deflate stream that was trying to produce a result larger than our
> > allocated output buffer could accept.
...
> This is unfortunate that making a test case for this isn't exactly 
> trivial.

Hmmm.  We could do something like manually create a pack file of
one non-delta blob whose pack header length is 16, but use a zlib
stream whose result body is 64.  Prior to this fix, we'd be stuck
in the infinite loop.  :-)

Its a PITA to create though, you have to hand-craft the test vector
and save it in the repository, we can't produce such a pack with
any real code we ship.

-- 
Shawn.
