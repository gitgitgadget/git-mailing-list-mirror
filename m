From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Tue, 13 Nov 2007 03:01:25 -0500
Message-ID: <20071113080125.GB14735@spearce.org>
References: <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org> <18221.14113.498416.396006@cargo.ozlabs.ibm.com> <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org> <7v1wauzomr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrqiY-0007lV-4x
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 09:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXKMIBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 03:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXKMIBi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 03:01:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56992 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXKMIBh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 03:01:37 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Irqi6-0004Vi-1j; Tue, 13 Nov 2007 03:01:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6D6A720FBAE; Tue, 13 Nov 2007 03:01:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1wauzomr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64765>

Junio C Hamano <gitster@pobox.com> wrote:
> I have to wonder what would happen if a much higher level caller
> caused the objects to get parsed before coming into the revision
> walking machinery, e.g. after the command line processing for
> A...B walked the ancestry chain until their common ancestors are
> found.  So these commits between A and B are parsed, but the
> revision limiting machinery hasn't done its operation to set
> TREECHANGE and/or UNINTERESTING in add_parents_to_list() on
> these commits yet.

That's one of the problems with the way the revision walking
machinery is built.  Its fast, but it can really only be used once.
My series about making the allocators able to free their nodes was
to allow resetting the entire machinary for another user, but as you
pointed out how do we decide when we can do a reset and invalidate
all prior struct commit*?

-- 
Shawn.
