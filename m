From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Tue, 25 Aug 2009 00:58:21 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908250018510.9656@GWPortableVCS>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS> <7vljlauxmk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231515020.29625@GWPortableVCS> <7vzl9qtev0.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908232044060.29625@GWPortableVCS> <7viqgdoikz.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0908240910120.29625@GWPortableVCS>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfp3K-0002xl-H1
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbZHYF6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 01:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZHYF6d
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 01:58:33 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:47216 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZHYF6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 01:58:32 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mfp3B-00031T-Ka; Tue, 25 Aug 2009 00:58:33 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <alpine.DEB.2.00.0908240910120.29625@GWPortableVCS>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127008>

Thell Fowler (git@tbfowler.name) wrote on Aug 24, 2009:

> Junio C Hamano (gitster@pobox.com) wrote on Aug 24, 2009:
> 
> > Thell Fowler <git@tbfowler.name> writes:
> > 
> > > It passed every test I threw at it, although it seemed to be a tad bit 
> > > slower than the previous revision on my sample data so I ran the following 
> > > command several times for both the previous and current version:
> > >
> > 
> > Do you mean by "previous version" the one that was broken, or the one I
> > sent as a "how about" patch?
> > 
> 
> A quick test shows the version merged to pu is the one that had the 
> fastest times.  I'll be away from a connection most of today, but will 
> test the different versions against the tests and some sample data and 
> post back.
> 

More extensive testing also shows the version currently in pu is the 
fastest on my sample data when applied to master.  I'm not sure why pu 
shows slower times than those same commits applied to master, but they 
are close enough together that I'm guessing no-one would really be 
concerned.

I was sitting in a waiting room and decided to have a little fun figuring 
out how to average the sys times...

for arg in "" -w -b --ignore-space-at-eol;do sum=0 && for i in {1..50}; \
do n="$(/usr/bin/time -f "%S" -o /dev/stdout sh -c 'git diff $arg dirty_first>/dev/null;')"; \
sum=$sum+$n; done; echo "scale=2; ($sum)/$i"|echo "$(bc) avg for diff $arg"; done;

pu
.28 avg for diff 
.29 avg for diff -w
.33 avg for diff -b
.29 avg for diff --ignore-space-at-eol

pu commits applied to master     <===  FASTEST
9c0d402 xutils: Fix xdl_recmatch() on incomplete lines
21245fd xutils: Fix hashing an incomplete line with whitespaces at the end
.26 avg for diff 
.25 avg for diff -w
.29 avg for diff -b
.31 avg for diff --ignore-space-at-eol 

'how about' patch applied to master
.26 avg for diff 
.32 avg for diff -w
.29 avg for diff -b
.32 avg for diff --ignore-space-at-eol

current master (in order to see the difference in the basic git diff 
-ignoring the fact that incomplete lines where broke since it only affects 
2 files in the test data)
.30 avg for diff 
.30 avg for diff -w
.29 avg for diff -b
.29 avg for diff --ignore-space-at-eol

-- Thell
