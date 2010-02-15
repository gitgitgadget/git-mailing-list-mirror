From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/4] Refactoring: remove duplicated code from transport.c
 and builtin-send-pack.c
Date: Mon, 15 Feb 2010 13:25:35 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002151250030.14365@iabervon.org>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com> <20100215052853.GJ3336@coredump.intra.peff.net> <7v7hqfknwz.fsf@alter.siamese.dyndns.org> <20100215075514.GB5347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Lukashov <michael.lukashov@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:25:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh5dd-0001vy-V1
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 19:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab0BOSZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 13:25:36 -0500
Received: from iabervon.org ([66.92.72.58]:36499 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755956Ab0BOSZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 13:25:36 -0500
Received: (qmail 11761 invoked by uid 1000); 15 Feb 2010 18:25:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Feb 2010 18:25:35 -0000
In-Reply-To: <20100215075514.GB5347@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140020>

On Mon, 15 Feb 2010, Jeff King wrote:

> On Sun, Feb 14, 2010 at 10:34:20PM -0800, Junio C Hamano wrote:
> 
> > > I can't remember the exact details of why the originals were not
> > > removed, though (I think I complained about it once before, and there
> > > was some technical reason, but I don't recall now). Daniel (cc'd) might
> > > remember more.
> > 
> > Also the names of these functions probably need to be made more specific
> > so that people not so familiar with the transport code can tell that they
> > are from "transport" family.  The names didn't matter much while they were
> > file scope static, but this series changes that.
> 
> Actually, I wonder if we can simply get rid of some of the calls in
> send-pack. I think that the code in send-pack isn't even called anymore
> via "git push"; it only gets called when you call send-pack directly.
> And arguably send-pack as plumbing shouldn't be generating all sorts of
> user-facing output. But it is a behavior change. I wonder if anybody
> actually calls send-pack directly anymore. It seems like even scripts
> use "git push" because of the transport agnosticism.

I think it would probably be better to get rid of send-pack as a separate 
command entirely, rather than changing any of its behavior, and make 
remote-curl use a private command that only has the desired behavior, 
which is stdio to a local proxy for the remote.

For that matter, it would likely be worthwhile abstracting the packet_line 
code such that send-pack (and fetch-pack) could be done in-process without 
the messages going over a classic packet_line connection to remote-curl 
before being sent over HTTP to the actual server.

	-Daniel
*This .sig left intentionally blank*
