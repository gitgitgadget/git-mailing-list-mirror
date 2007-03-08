From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/5] Teach receive-pack to run pre-receive/post-receive hooks
Date: Wed, 7 Mar 2007 22:34:34 -0500
Message-ID: <20070308033434.GA29567@spearce.org>
References: <20070307215205.GE28649@spearce.org> <Pine.LNX.4.64.0703071522030.5963@woody.linux-foundation.org> <7vbqj4eh9h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 04:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP9Ox-0002ej-Se
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 04:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXCHDeo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 22:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbXCHDeo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 22:34:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34790 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXCHDen (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 22:34:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP9Od-00082c-Iq; Wed, 07 Mar 2007 22:34:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6F42620FBAE; Wed,  7 Mar 2007 22:34:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vbqj4eh9h.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41711>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Can you give a concise explanation of how "pre-receive" differ from the 
> > old "update", and how does "post-receive" differ from the old 
> > "post-update"?
> 
> They are somewhat redundant.  They get everything at once,
> unlike update hook.

Also unlike update hook, pre-receive rejects or accepts the entire
batch of refs and cannot reject an individual ref update.

I would have removed post-update, but users depend on it.  I would
have modified its argument structure to be like post-receive,
but again, users might depend on the current argument arrangement.

> The old interface is adequate to do the same thing if you
> arrange them so that update hook notes which refs (with what old
> sha1 value it had) were asked to be updated, and make your
> post-update hook (which gets the names of refs) notice if some
> of them failed and from what ref a successful update happened.
> But getting everything at once is sometimes easier to work
> with.

Except that doing that is horribly ugly, as there are no locks held
by receive-pack to help the hook author, so the hook author must dump
that data out to a temporary file and be sure the post-update hook
knows which file to look at, which it can't really know... a mess.

-- 
Shawn.
