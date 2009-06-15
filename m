From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 07:26:48 -0700
Message-ID: <20090615142648.GV16497@spearce.org>
References: <87bpoqoavp.fsf@meyering.net> <81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com> <87fxe2lybr.fsf@meyering.net> <81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com> <87vdmxluj8.fsf@meyering.net> <81b0412b0906150439r755a7498ldddbca911b2fd36e@mail.gmail.com> <877hzdlnt6.fsf@meyering.net> <81b0412b0906150546p34ff53ceo81ea59785cf9d18a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 16:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGD9G-0006AK-1v
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 16:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbZFOO0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 10:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbZFOO0q
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 10:26:46 -0400
Received: from george.spearce.org ([209.20.77.23]:42569 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbZFOO0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 10:26:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E95F8381FD; Mon, 15 Jun 2009 14:26:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0906150546p34ff53ceo81ea59785cf9d18a@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121608>

Alex Riesen <raa.lkml@gmail.com> wrote:
> 2009/6/15 Jim Meyering <jim@meyering.net>:
> > Alex Riesen wrote:
> >> 2009/6/15 Jim Meyering <jim@meyering.net>:
> >>>
> >>> Exactly. ??This is why I think it's not worthwhile to invest in
> >>> a more precise diagnostic, here.

Sorry Alex, but I have to agree with Jim here.  Use xstrdup()
and its friends and move on with life.

> As much as I'd like to know as much as possible about why something
> failed, I can't make a failure handling automatically simple (given the tools).
> I do suggest using goto to handle this particular OOM (below), but it looks
> almost too ugly. Maybe I am just paranoid, and am overdoing this particular
> case.

Yes, this is horrible.  Its a huge amount of code for checking a
strdup failure that is unlikely to occur out of a configuration file.

Really, how big is that config file?  It can't be so large that a
strdup() is likely to run out of memory pulling a value from it.

And even if it does run out of memory, unless we can reclaim space
by shedding pack windows, we're doomed, we can't continue executing.
The official error is "out of memory", most likely due to too low
of a rlimit on our heap, and the only resolution is to boost the
rlimit higher, not something we can do in our process if we're
already hitting the hard limit.
 
> The "goto oom" patch:

NAK.  We don't do this anywhere else in git.  Please don't start now.
 
-- 
Shawn.
