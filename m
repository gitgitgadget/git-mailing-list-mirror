From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 20:31:55 -0700
Message-ID: <20080803033155.GC27465@spearce.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <7v63qiydzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 05:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPUL3-0006AW-Hb
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 05:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbYHCDb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 23:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYHCDb4
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 23:31:56 -0400
Received: from george.spearce.org ([209.20.77.23]:35297 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYHCDb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 23:31:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8423638419; Sun,  3 Aug 2008 03:31:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v63qiydzg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91199>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Show Refs
> > ---------
> >
> > Obtains the available refs from the remote repository.  The response
> > is a sequence of git "packet lines", one per ref, and a final flush
> > packet line to indicate the end of stream.
> 
> As the initial protocol exchange request, I suspect that you would regret
> if you do not leave room for some "capability advertisement" in this
> exchange.
> 
> With the git native protocol, we luckily found space to do so after the
> ref payload (because pkt-line is "length + payload" format but the code
> that reads payload happened to ignore anything after NUL).  You would want
> to define how these are given by the server to the client over HTTP
> channel.  For example, putting them on extra HTTP headers is probably Ok.

Yea, I thought that the HTTP headers would be more than enough
space to add capability advertisements.  Most client libraries
will happily parse and store these for the application, and won't
make a fuss if the application doesn't read them.

Hence there's more than enough room in the protocol to extend it
in the future with additional capabilities.

We do have to be careful though.  Any cachable resource must only
rely upon the URI and the standard headers which compute into the
cache key for a request.  There aren't many, though I think the
Content-Type header may be among them.

-- 
Shawn.
