From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 10:51:52 -0700
Message-ID: <20080414105152.9cc06fab.akpm@linux-foundation.org>
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
	<20080414074349.24fa90f8@laptopd505.fenrus.org>
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
To: Arjan van de Ven <arjan@infradead.org>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 20:13:26 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlSto-0002Y3-Oj
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 19:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762160AbYDNRy2 (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 13:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760869AbYDNRy2
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 13:54:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48303 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759349AbYDNRy0 (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 13:54:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3EHpuaj017087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Apr 2008 10:51:58 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3EHpqbo019011;
	Mon, 14 Apr 2008 10:51:52 -0700
In-Reply-To: <20080414074349.24fa90f8@laptopd505.fenrus.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.759 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79520>

On Mon, 14 Apr 2008 07:43:49 -0700 Arjan van de Ven <arjan@infradead.org> wrote:

> On Mon, 14 Apr 2008 01:04:12 -0700
> > 
> > The steps to be taken are:
> > 
> > a) agree that we have a problem
> > 
> 
> 
> I for one do not agree that we have a problem.
> 
> Based on actual data on oopses (which very clearly excludes other kinds of bugs, so I know I only see part of the story)
> we are doing reasonably well. Lets look at the 2.6.25 cycle. 
> We got a total of roughly 2700 reports of oopses/warn_ons from users. (This may sound high to those of you only reading
> lkml, but this includes automatically collected oopses from Fedora 9 beta testers).
> Out of these 2700, the top 20 issues account for 75% of the total reports.
> 
> Out of these 20 issues, 9 were from still out of tree drivers (wireless.git and drm.git included in F9). These were
> caught before they even got close to mainline.
> The remaining 11 issues can be split in
> 1) The ones we caught and fixed
> 2) TCP/IP warnings that DaveM and co are chasing down hard (but have trouble finding reproducers)
> 3) An EXT3 bug that in theory can cause data corruption, but in practice seems to happen after you yank out a USB stick
>   with an EXT3 filesystem on (so it can't corrupt the disk data). Ted is working on this
> 4) A bug (double free) that hits in the skb layer, probably caused by a bug in the ipv4 code
>    (a first analysis + potential patch was mailed to netdev this weekend)
> 5) sysfs "existing file added" warning, mostly in the USB stack
>    (gregkh claims he fixed this recently, I'm not entirely sure he got all cases)
> 
> And when I look beyond the first 20, the same pattern arises, we fixed the majority of the issues before -rc9.
> At position 25 we have less than 20 reports per bug. At position 35 we have less than 10 reports per bug. 
> At position 50 we have less than 5 reports per bug. Conclusion there: the bugs people actually hit fall of dramatically;
> there's a core set of issues that gets hit a lot, the rest quickly gets reduced to noise levels.
> 
> 
> To me this does not sound like we have a huge quality problem because
> 1) The distribution of the bugs is such that there is a relatively small set of core issues
>    that are widely hit, and then there's a near exponential drop after that
> 2) We are fixing the important bugs by and large before they hit a release
>    (important as defined by the number of people actually hitting the bug)
> 
> 
>  
> I'll be writing a report with more details about this soon with more analysis and statistics
> (I'll be looking at more detail around the top 25 issues, when they got introduced, when they got fixed etc)

Well OK.  But I don't think we can generalise from oops-causing bugs all
the way to all bugs.  Very few bugs actually cause oopses, and oopses tend
to be the thing which developers will zoom in on and pay attention to.

If we had metrics on "time goes backwards" or anything containing "ASUS",
things might be different.
