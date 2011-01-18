From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 21:39:28 +0100
Message-ID: <201101182139.28808.trast@student.ethz.ch>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net> <201101181744.18139.trast@student.ethz.ch> <20110118185027.GA10562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Sebastian Hahn <mail@sebastianhahn.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 18 21:39:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfIL3-0005ZY-Bg
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 21:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1ARUjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 15:39:31 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:25066 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab1ARUjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 15:39:31 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 18 Jan
 2011 21:39:11 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 18 Jan
 2011 21:39:29 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110118185027.GA10562@sigill.intra.peff.net>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165215>

Jeff King wrote:
> commit() {
>   echo $1 >file && git add file && git commit -m $1
> }
> mkdir repo && cd repo && git init
> commit base
> commit master
> git checkout -b other HEAD^
> commit other
> git merge master
> commit resolved

Indeed, my history looks just like that.

> >   git log -Squux -c -p          # shows merge, but no diff
> 
> Weird.  Here I get a nice combined diff, which is what I expect.

True, I managed to confuse myself between looking for the resolution and
looking for one of the (deleted) merge sides.

So indeed

  git log -Squux -c -p

gives a combined diff.  But OTOH

  git log -Sbar -c -p

doesn't; it only gives a diff for the commit that introduced 'bar'.  I
guess this makes sense: -S notices that the number of 'bar's is
actually the same as in *one* merge parent, hence the merge cannot be
all that interesting.  OTOH it still shows the merge commit in the
history, which is a bit strange.  --pickaxe-all does not make a
difference either;

   git log -Sbar --cc -p --pickaxe-all

still shows the merge commit but no diff.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
