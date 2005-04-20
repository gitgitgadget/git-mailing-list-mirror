From: Tomas Mraz <t8m@centrum.cz>
Subject: Re: [Gnu-arch-users] Re: [ANNOUNCEMENT] /Arch/
	embraces `git'
Date: Thu, 21 Apr 2005 00:51:49 +0200
Message-ID: <1114037509.5880.62.camel@perun.redhat.usu>
References: <200504201000.DAA04988@emf.net>  <877jixfjxw.fsf@star.lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gnu-arch-dev@lists.seyza.com, talli@museatech.net, git@vger.kernel.org,
	torvalds@osdi.org
X-From: gnu-arch-dev-bounces@lists.seyza.com Thu Apr 21 00:47:50 2005
Return-path: <gnu-arch-dev-bounces@lists.seyza.com>
Received: from [207.166.200.220] (helo=hera.museatech.net)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1DONyx-0002hB-2E
	for gcvad-gnu-arch-dev@gmane.org; Thu, 21 Apr 2005 00:47:43 +0200
Received: (qmail 9655 invoked by uid 110); 20 Apr 2005 22:52:00 -0000
Received: from gnu-arch-dev-bounces@lists.seyza.com by hera by uid 102 with qmail-scanner-1.20 
 (clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(127.0.0.1):. 
 Processed in 0.110575 secs); 20 Apr 2005 22:52:00 -0000
Received: from unknown (HELO hera.museatech.net) (127.0.0.1)
  by hera.museatech.net with SMTP; 20 Apr 2005 22:51:59 -0000
Delivered-To: list-gnu-arch-dev@lists.seyza.com
Received: (qmail 9612 invoked by uid 110); 20 Apr 2005 22:51:54 -0000
Received: from t8m@centrum.cz by hera by uid 102 with qmail-scanner-1.20 
	(clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(207.166.200.201):. 
	Processed in 0.131953 secs); 20 Apr 2005 22:51:54 -0000
Received: from unknown (HELO a1.mx.alal.us) (207.166.200.201)
	by hera.museatech.net with SMTP; 20 Apr 2005 22:51:54 -0000
Received: (qmail 27871 invoked from network); 21 Apr 2005 00:06:06 -0000
Received: from admin.kkcable.cz (213.29.14.23)
	by a1.mx.alal.us with SMTP; 21 Apr 2005 00:06:03 -0000
Received: by admin.kkcable.cz (Postfix, from userid 1007)
	id 4B41A6126D; Thu, 21 Apr 2005 00:51:52 +0200 (CEST)
Received: from admin.kkcable.cz (admin.kkcable.cz [213.29.14.23])
	by admin.kkcable.cz (Postfix) with SMTP id E6B7C61269;
	Thu, 21 Apr 2005 00:51:50 +0200 (CEST)
To: duchier@ps.uni-sb.de
In-Reply-To: <877jixfjxw.fsf@star.lifl.fr>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on dev.alal.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=9.0 tests=BAYES_00 autolearn=ham 
	version=3.0.2
X-BeenThere: gnu-arch-dev@lists.seyza.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: a mailing list for GNU Arch developers <gnu-arch-dev.lists.seyza.com>
List-Unsubscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=unsubscribe>
List-Archive: <http://lists.seyza.com/pipermail/gnu-arch-dev>
List-Post: <mailto:gnu-arch-dev@lists.seyza.com>
List-Help: <mailto:gnu-arch-dev-request@lists.seyza.com?subject=help>
List-Subscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=subscribe>
Sender: gnu-arch-dev-bounces@lists.seyza.com
Errors-To: gnu-arch-dev-bounces@lists.seyza.com
X-Broken-Reverse-DNS: no host name found for IP address 207.166.200.220

On Wed, 2005-04-20 at 19:15 +0200, duchier@ps.uni-sb.de wrote:
...
> As data, I used my /usr/src/linux which uses 301M and contains 20753 files and
> 1389 directories.  To compute the key for a directory, I considered that its
> contents were a mapping from names to keys.
I suppose if you used the blob archive for storing many revisions the
number of stored blobs would be much higher. However even then we can
estimate that the maximum number of stored blobs will be in the order of
milions.

> When constructing the indexed archive, I actually stored empty files instead of
> blobs because I am only interested in overhead.
> 
> Using your suggested indexing method that uses [0:4] as the 1st level key and
                                                 [0:3]
> [4:8] as the 2nd level key, I obtain an indexed archive that occupies 159M,
> where the top level contains 18665 1st level keys, the largest first level dir
> contains 5 entries, and all 2nd level dirs contain exactly 1 entry.
Yes, it really doesn't make much sense to have so big keys on the
directories. If we would assume that SHA1 is a really good hashing
function so the probability of any hash value is the same this would
allow storing 2^16 * 2^16 * 2^16 blobs with approximately same directory
usage.

> Using Linus suggested 1 level [0:2] indexing, I obtain an indexed archive that
                                [0:1] I suppose
> occupies 1.8M, where the top level contains 256 1st level keys, and where the
> largest 1st level dir contains 110 entries.
The question is how many entries in directory is optimal compromise
between space and the speed of access to it's files.

If we suppose the maximum number of stored blobs in the order of milions
probably the optimal indexing would be 1 level [0:2] indexing or 2
levels [0:1] [2:3]. However it would be necessary to do some
benchmarking first before setting this to stone.

-- 
Tomas Mraz <t8m@centrum.cz>
