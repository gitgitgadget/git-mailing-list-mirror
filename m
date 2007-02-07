From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: git-fast-import
Date: Wed, 07 Feb 2007 10:58:00 +0000
Message-ID: <1170845880.29759.1132.camel@pmac.infradead.org>
References: <20070206023111.GB9222@spearce.org>
	 <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
	 <20070206054808.GA10508@spearce.org>
	 <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org>
	 <20070206165630.GB4949@spearce.org>
	 <Pine.LNX.4.64.0702060913220.8424@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0702061329090.19212@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 11:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEkVM-0003QN-1s
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 11:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbXBGK6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 05:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbXBGK6R
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 05:58:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46180 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161180AbXBGK6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 05:58:16 -0500
Received: from pmac.infradead.org ([81.187.2.168])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HEkUz-00021Y-SP; Wed, 07 Feb 2007 10:58:02 +0000
In-Reply-To: <Pine.LNX.4.64.0702061329090.19212@xanadu.home>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38910>

On Tue, 2007-02-06 at 13:53 -0500, Nicolas Pitre wrote:
> On Tue, 6 Feb 2007, Linus Torvalds wrote:
> 
> > I'm not so worried about the git date parsing routines (which are fairly 
> > solid) as about the fact that absolutely *tons* of people get rfc2822 
> > wrong.
> > 
> > They allow pretty much any half-way valid date, exactly because people 
> > don't do rfc2822 right anyway (and because they are also meant to work 
> > even if you write the date by hand, like "12:34 2005-06-07").
> > 
> > Sure, you can still mess up the program that actually generates the data 
> > for gfi, and have bugs like that *there*, but at least they'd have to 
> > think a bit about it.
> 
> Well, exactly because GIT already has fairly solid date parsing 
> routines, and the fact that we needed solid date parsing routines in the 
> first place, exactly because people don't do rfc2822 right anyway, 
> should be a hell of a big clue why we should parse date information for 
> the gfi frontend.  Because the date is for sure most likely in a screwed 
> up format already and it is counter productive to have to deal with that 
> in a duplicated piece of code.  And the bare reality is that people will 
> just not care to parse it right themselves. 

Nevertheless, they _should_. The principle is simple -- wherever there
is ambiguity, you should seek to resolve that as _close_ to the point of
origin as possible. Your 'best guess' gets worse and worse the further
you go from the source of the data.

If you're exporting from a legacy repository in one part of the world,
then transferring the raw data to a machine elsewhere to be imported
into git, you _really_ want to be making your guesses about timezones
and character sets in the _export_ stage; not the subsequent import.

So there's a lot to be said for nailing down gfi's intermediate format
and removing _all_ the ambiguity from it -- using git format dates
(which I did that way precisely for the lack of ambiguity), and using
UTF-8 (or some other _specified_ but not assumed character set).

-- 
dwmw2
