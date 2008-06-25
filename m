From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Keep some git-* programs in $(bindir)
Date: Wed, 25 Jun 2008 00:37:41 -0400
Message-ID: <20080625043741.GD11793@spearce.org>
References: <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org> <20080624233236.GI29404@genesis.frugalware.org> <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806250015580.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMmr-0002G1-HB
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYFYEiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbYFYEiA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:38:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42485 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168AbYFYEh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:37:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBMlL-0006VW-CM; Wed, 25 Jun 2008 00:37:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B1ADD20FBAE; Wed, 25 Jun 2008 00:37:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0806250015580.19665@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86223>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 24 Jun 2008, Junio C Hamano wrote:
> 
> > Otherwise remote executions directly over ssh won't find them as they used
> > to.  --upload-pack and --receive-pack options _could_ be used on the
> > client side, but things should keep working out-of-box for older clients.
> > 
> > Later versions of clients (fetch-pack and send-pack) probably could start
> > asking for these programs with dashless form, but that is a different
> > topic.
> 
> Should they use "git upload-pack" or should they look for their helper 
> programs in a libexec dir? I don't think that either of these programs is 
> useful to run independantly, but I don't know if finding a program that 
> doesn't go in $PATH on a remote machine is going to be any fun.

IMHO they should in the future use "git upload-pack".

But this may not work with all servers, especially those that
use $SSH_ORIGINAL_COMMAND to dispatch to the correct command,
or abort if the user tries to request something dangerous.
Gitosis comes to mind.

I'm not sure we can get away with doing this in 1.6.0 as it is
effectively a network protocol breakage.  We have thus far never
caused a newer client to fail talking to an older server.  I'm
not sure we should start doing that in 1.6.0.

My vote is we keep the dashed form of these 3 commands in the
$PATH during 1.6 and remove them in 1.7, but when we do it we
must ensure there is a way to still request dashed form found
through $PATH when passing --upload-pack as an argument.

-- 
Shawn.
