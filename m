From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Compression and dictionaries
Date: Wed, 16 Aug 2006 02:55:15 -0400
Message-ID: <20060816065515.GB18778@spearce.org>
References: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com> <20060816003712.32000.qmail@science.horizon.com> <4b73d43f0608152243i15b37036x7aa50aa3afc2b02f@mail.gmail.com> <9e4733910608152250h1bcb8bf5qebb29ef84b971abd@mail.gmail.com> <Pine.LNX.4.63.0608160832320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, John Rigby <jcrigby@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 08:55:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDFJM-0004hl-Nm
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 08:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWHPGz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 02:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWHPGz3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 02:55:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56240 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750865AbWHPGz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 02:55:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GDFJ7-0005Hk-Fb; Wed, 16 Aug 2006 02:55:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9491220FB77; Wed, 16 Aug 2006 02:55:15 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608160832320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25504>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Wed, 16 Aug 2006, Jon Smirl wrote:
> 
> > On 8/16/06, John Rigby <jcrigby@gmail.com> wrote:
> > > Sorry if this is off topic, but could the dictionary be used to make
> > > git-grep alot faster?
> > 
> > It would be almost instant.
> 
> But only if you are not using a regular expression, but a single word.

Yes and no.  If the inverted index contains terms broken by some
known pattern (e.g. break on word-type boundaries) and the regex
in question has constant sections (it should, otherwise it might
as well just be '.') then you can reduce your search space to a
fraction of the overall data by looking at the inverted index to
select likely terms, select the related revisions containing those
possible terms, then run the regex only on those revisions.

Sure you would be possibly pulling out a number of false positives
but if the constant sequence(s) in the regex reduce your search
space to below 1/2 of the overall data that's probably a lot less
I/O and CPU required to complete the query, even if you have to
read the entire dictionary and apply each term in the dictionary
to the regex to look for those possible matches.

-- 
Shawn.
