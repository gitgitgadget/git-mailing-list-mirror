From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 18:52:43 +0300
Message-ID: <20080512155243.GA3592@mithlond.arda.local>
References: <20080512122900.GA13050@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 17:53:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvaLH-0000rM-NG
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYELPwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbYELPwq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:52:46 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:38267 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752989AbYELPwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:52:45 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.5.014)
        id 482329DB002C098D for git@vger.kernel.org; Mon, 12 May 2008 18:52:44 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JvaKR-0000wA-Ve
	for git@vger.kernel.org; Mon, 12 May 2008 18:52:43 +0300
Content-Disposition: inline
In-Reply-To: <20080512122900.GA13050@mithlond.arda.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81878>

Teemu Likonen wrote (2008-05-12 15:29 +0300):

> For testing purposes I deleted objects/pack/*.keep file(s) and ran
> "git gc" again. The repo resulted in small again, just like after the
> initial clone.

After playing with test repo a while it seems that "git gc" never
touches pack files which have accompanying .keep file around. (And it's
common to have a .keep file after "git clone".) This makes gc perform
faster. A side effect seems to be that objects which later become
unreferenced in those pack-files-with-.keep are never pruned. *.keep
files also seem to prevent from really aggressively optimizing the
repository's size.

Probably a crazy idea: What if "gc --aggressive" first removed *.keep
files and after packing and garbage-collecting and whatever it does it
would add a .keep file for the newly created pack?
