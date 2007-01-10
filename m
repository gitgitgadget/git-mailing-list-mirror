From: Fengguang Wu <fengguang.wu@gmail.com>
Subject: Re: How git affects kernel.org performance
Date: Wed, 10 Jan 2007 09:57:39 +0800
Message-ID: <368394226.19365@ustc.edu.cn>
References: <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org> <368329554.17014@ustc.edu.cn> <Pine.LNX.4.64.0701090821550.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Wed Jan 10 02:57:21 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4SiJ-0005Tb-LQ
	for gcfe-linux-ext4@gmane.org; Wed, 10 Jan 2007 02:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbXAJB5O (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Tue, 9 Jan 2007 20:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbXAJB5O
	(ORCPT <rfc822;linux-ext4-outgoing>); Tue, 9 Jan 2007 20:57:14 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:58522 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S932652AbXAJB5N (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Tue, 9 Jan 2007 20:57:13 -0500
Received: (eyou send program); Wed, 10 Jan 2007 09:57:06 +0800
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Received: from unknown (HELO localhost) (210.45.70.10)
 by 202.38.64.8 with SMTP; Wed, 10 Jan 2007 09:57:06 +0800
Received: from wfg by localhost with local (Exim 4.63)
	(envelope-from <wfg@localhost>)
	id 1H4Sih-0006ek-Hc; Wed, 10 Jan 2007 09:57:39 +0800
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <20070110015739.GA26978@mail.ustc.edu.cn>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701090821550.3661@woody.osdl.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 09, 2007 at 08:23:32AM -0800, Linus Torvalds wrote:
>
>
> On Tue, 9 Jan 2007, Fengguang Wu wrote:
> > >
> > > The fastest and probably most important thing to add is some readahead
> > > smarts to directories --- both to the htree and non-htree cases.  If
> >
> > Here's is a quick hack to practice the directory readahead idea.
> > Comments are welcome, it's a freshman's work :)
>
> Well, I'd probably have done it differently, but more important is whether
> this actually makes a difference performance-wise. Have you benchmarked it
> at all?

Yes, a trivial test shows a marginal improvement, on a minimal debian system:

# find / | wc -l
13641

# time find / > /dev/null

real    0m10.000s
user    0m0.210s
sys     0m4.370s

# time find / > /dev/null

real    0m9.890s
user    0m0.160s
sys     0m3.270s

> Doing an
>
> 	echo 3 > /proc/sys/vm/drop_caches
>
> is your friend for testing things like this, to force cold-cache
> behaviour..

Thanks, I'll work out numbers on large/concurrent dir accesses soon.

Regards,
Wu
