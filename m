From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
	pack memory
Date: Thu, 8 Jan 2009 07:34:10 -0800
Message-ID: <20090108153410.GB16840@spearce.org>
References: <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain> <20090108030115.GF10790@spearce.org> <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain> <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org> <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 16:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKwv1-0001Oa-I2
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 16:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760883AbZAHPeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 10:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760542AbZAHPeM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 10:34:12 -0500
Received: from george.spearce.org ([209.20.77.23]:47475 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859AbZAHPeL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 10:34:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 463E538210; Thu,  8 Jan 2009 15:34:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104926>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Let's do this (more complete) wrapping instead, ok?

Ack.
 
> This one _just_ wraps things, btw - it doesn't do the "retry on low memory 
> error" part, at least not yet. I think that's an independent issue from 
> the reporting.

I still think we should try to reduce pack memory usage when we get
oom from zlib and retry the current operation once.  We do it almost
everywhere else and it works relatively well.

We may also want to consider dropping (e.g. halving) the window
size and/or limit when we run out of memory.  We'll run slower but
if the OS has denied us further resources it may be a ulimit thing
on a shared system, and we should try harder to work with what we
have available to us.

-- 
Shawn.
