From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] http: enable keepalive on TCP sockets
Date: Mon, 14 Oct 2013 23:38:39 +0000
Message-ID: <20131014233839.GA26323@dcvr.yhbt.net>
References: <20131012222939.GA24255@dcvr.yhbt.net>
 <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
 <20131014052739.GA16129@dcvr.yhbt.net>
 <20131014214035.GB7007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 01:38:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVrim-0002Wb-EY
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129Ab3JNXik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:38:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59089 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757158Ab3JNXik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 19:38:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2458A44C006;
	Mon, 14 Oct 2013 23:38:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131014214035.GB7007@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236151>

Jeff King <peff@peff.net> wrote:
> On Mon, Oct 14, 2013 at 05:27:39AM +0000, Eric Wong wrote:
> > Daniel Stenberg <daniel@haxx.se> wrote:
> > > On Sat, 12 Oct 2013, Eric Wong wrote:
> > > 
> > > >This is a follow up to commit
> > > >e47a8583a20256851e7fc882233e3bd5bf33dc6e (enable SO_KEEPALIVE for
> > > >connected TCP sockets).
> > > 
> > > Just keep in mind that TCP keep-alive is enabled in awkwardly many
> > > different ways on different systems and this patch only supports one
> > > of them. Feel free to take inspiration from libcurl's source code
> > > for doing this. See:
> > > 
> > >   https://github.com/bagder/curl/blob/master/lib/connect.c#L108
> > 
> > Thanks.  I think the Linux-specific TCP_KEEP* knobs are overkill for git.
> > (since this is mainly for non-interactive users, I went at least a day
> >  before realizing the process was stuck on my machine).
> > I cannot comment on the knobs for other OSes.
> 
> I don't think we should get into having a big compatibility layer that
> just reproduces what is in curl.
> 
> But is there any reason not to use CURLOPT_TCP_KEEPALIVE when it is
> available, falling back to CURLOPT_SOCKOPTFUNCTION, and then finally to
> nothing? That lets people on modern curl benefit from curl's more
> portable code, without punishing people on older versions.

I wanted it to work as older curl first (since I noticed this
on an old server).  But your patch on top of mine looks reasonable,
thanks.
