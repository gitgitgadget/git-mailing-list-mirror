From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 00/23] Preliminary pack v4 support
Date: Tue, 27 Aug 2013 11:59:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271153370.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <xmqqioyrfa5m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELgN-00008N-1r
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab3H0P7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:59:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17355 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab3H0P7q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:59:46 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700AHU5RL4N20@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 11:59:45 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 593C12DA052D; Tue, 27 Aug 2013 11:59:45 -0400 (EDT)
In-reply-to: <xmqqioyrfa5m.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233108>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Subject says it all... at last !
> >
> > This can also be fetched here:
> >
> > 	git://git.linaro.org/people/nico/git
> >
> > Demonstration of what it does at the moment:
> >
> > 	http://article.gmane.org/gmane.comp.version-control.git/233038
> >
> > I'd like to preserve the author time stamps as they relate to where in
> > the world I was when the corresponding code was written.  You'll notice
> > I didn't work on the code in the same order as it is now presented.
> 
> We can also notice things like "From: user@machine.(none)" ;-)

Heh.

> > Still open question: what to do with a thin pack.  Should we really
> > complete it with local objects upon reception, or were we only over
> > paranoid at the time we imposed this rule?
> 
> I do not think paranoia had much to do with it.  I am afraid that
> allowing a delta in a pack to depend on a base in another pack means
> that the former pack becomes unusable without the latter, which
> would make object store management (e.g. partial repacking) a lot
> more cumbersome, no?

That's what I'm wondering.  We already end up with a broken repository 
if the commit graph is spread across multiple packs and one of those 
pack is removed.  Having a delta base in a separate pack is not much 
different in that regard.

So the rule could be that any kind of repacking must not carry over 
deltas with a non local base i.e. repack always produces delta 
references belonging to the same pack.


Nicolas
