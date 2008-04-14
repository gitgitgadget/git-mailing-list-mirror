From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 07:43:49 -0700
Organization: Intel
Message-ID: <20080414074349.24fa90f8@laptopd505.fenrus.org>
References: <47FEADCB.7070104@rtr.ca>
	<20080413121831.d89dd424.akpm@linux-foundation.org>
	<20080413202118.GA29658@2ka.mipt.ru>
	<200804132233.50491.rjw@sisk.pl>
	<20080413205406.GA9190@2ka.mipt.ru>
	<48028830.6020703@earthlink.net>
	<alpine.DEB.1.10.0804131546370.9318@asgard>
	<20080414043939.GA6862@1wt.eu>
	<20080414053943.GU9785@ZenIV.linux.org.uk>
	<20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<20080414010412.c42dc560.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Willy Tarreau <w@1wt.eu>,
	david@lang.hm, Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 16:59:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlQ0p-0008Bw-9d
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 16:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761140AbYDNOtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 10:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758809AbYDNOtX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 10:49:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44762 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbYDNOtV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 10:49:21 -0400
Received: from c-71-193-193-226.hsd1.or.comcast.net ([71.193.193.226] helo=laptopd505.fenrus.org)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JlPzA-0003NU-93; Mon, 14 Apr 2008 14:48:45 +0000
In-Reply-To: <20080414010412.c42dc560.akpm@linux-foundation.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.12.5; i386-redhat-linux-gnu)
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79507>

On Mon, 14 Apr 2008 01:04:12 -0700
> 
> The steps to be taken are:
> 
> a) agree that we have a problem
> 


I for one do not agree that we have a problem.

Based on actual data on oopses (which very clearly excludes other kinds of bugs, so I know I only see part of the story)
we are doing reasonably well. Lets look at the 2.6.25 cycle. 
We got a total of roughly 2700 reports of oopses/warn_ons from users. (This may sound high to those of you only reading
lkml, but this includes automatically collected oopses from Fedora 9 beta testers).
Out of these 2700, the top 20 issues account for 75% of the total reports.

Out of these 20 issues, 9 were from still out of tree drivers (wireless.git and drm.git included in F9). These were
caught before they even got close to mainline.
The remaining 11 issues can be split in
1) The ones we caught and fixed
2) TCP/IP warnings that DaveM and co are chasing down hard (but have trouble finding reproducers)
3) An EXT3 bug that in theory can cause data corruption, but in practice seems to happen after you yank out a USB stick
  with an EXT3 filesystem on (so it can't corrupt the disk data). Ted is working on this
4) A bug (double free) that hits in the skb layer, probably caused by a bug in the ipv4 code
   (a first analysis + potential patch was mailed to netdev this weekend)
5) sysfs "existing file added" warning, mostly in the USB stack
   (gregkh claims he fixed this recently, I'm not entirely sure he got all cases)

And when I look beyond the first 20, the same pattern arises, we fixed the majority of the issues before -rc9.
At position 25 we have less than 20 reports per bug. At position 35 we have less than 10 reports per bug. 
At position 50 we have less than 5 reports per bug. Conclusion there: the bugs people actually hit fall of dramatically;
there's a core set of issues that gets hit a lot, the rest quickly gets reduced to noise levels.


To me this does not sound like we have a huge quality problem because
1) The distribution of the bugs is such that there is a relatively small set of core issues
   that are widely hit, and then there's a near exponential drop after that
2) We are fixing the important bugs by and large before they hit a release
   (important as defined by the number of people actually hitting the bug)


 
I'll be writing a report with more details about this soon with more analysis and statistics
(I'll be looking at more detail around the top 25 issues, when they got introduced, when they got fixed etc)







-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
