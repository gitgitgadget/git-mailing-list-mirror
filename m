From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 22:45:55 -0400
Message-ID: <20070906024555.GJ18160@spearce.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:46:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7Nu-0002Km-Dz
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbXIFCqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbXIFCqJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:46:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36278 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbXIFCqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:46:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT7NJ-0006la-7A; Wed, 05 Sep 2007 22:45:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6911020FBAE; Wed,  5 Sep 2007 22:45:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57806>

Junio C Hamano <gitster@pobox.com> wrote:
> Implement git gc --auto
... 

Danger...  If the user sets `gc.auto` to a low enough value and
they are also unlucky enough to have a few truely unreachable (thus
pruneable) objects in .git/objects/17/ then this is going to run
a bunch of gc work on every commit they make.

I'm actually running into this problem in git-gui.  On Windows
it suggests a repack if there is one object in .git/objects/42/.
Some users have been unlucky enough to stage a file, have it
hash into that directory, then restage a different version of it.
The prior one is never considered reachable (it was never committed),
but will now *always* cause git-gui to suggest a repack on every
startup.  For all time.

Yea, I need to fix that.

But this suffers from the same fate if the user sets gc.auto too
small and doesn't realize that the reason Git is always repacking
is because over the last 6 months they have been unlucky enough to
stage the magic number of unreachable blobs into the 17 directory
and they have *never* run `git gc --prune` because the auto thing
is working just fine for them and they don't realize they need to
prune every once in a blue moon.

-- 
Shawn.
