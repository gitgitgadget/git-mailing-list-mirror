From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax
	mean.
Date: Mon, 20 Aug 2007 04:04:53 -0400
Message-ID: <20070820080453.GA13233@coredump.intra.peff.net>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <20070820055221.GA22993@coredump.intra.peff.net> <20070820060522.GA27913@spearce.org> <20070820061330.GB27913@spearce.org> <828x86ad8q.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Florian Weimer <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Mon Aug 20 10:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2Fz-00006b-Fm
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbXHTIE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXHTIE5
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:04:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3406 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbXHTIE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:04:56 -0400
Received: (qmail 18007 invoked by uid 111); 20 Aug 2007 08:05:06 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Aug 2007 04:05:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2007 04:04:53 -0400
Content-Disposition: inline
In-Reply-To: <828x86ad8q.fsf@mid.bfk.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56188>

On Mon, Aug 20, 2007 at 09:15:01AM +0200, Florian Weimer wrote:

> > Actually, what's wrong with the following:
> >
> > 	git show HEAD:foo.c
> > 	git show MERGE_HEAD:foo.c
> 
> I think that in the staged versions, the non-conflicting parts of the
> merge are in fact merged.  For the HEAD/MERGE_HEAD versions, this
> isn't the case, obviously.

No, the stage versions are not merged at all (but the working tree copy
has all non-conflicting parts merged).

Here's a script that creates a conflicted file with one easily resolved
part and one conflict. You can see the staged hashes at the end (and
check the working tree copy to see that only the one conflict is
marked).

-Peff

-- >8 --
mkdir repo && cd repo && git-init

head -n 100 </usr/share/dict/words >words
git-add words
git-commit -m words

sed '10d' <words >words.tmp
mv words.tmp words
git-commit -a -m 'remove 10'

git-checkout -b other HEAD^
sed '9d
     90d' <words >words.tmp
mv words.tmp words
git-commit -a -m 'remove 9 and 90'

git-merge master

echo "stage 2 `git-rev-parse :2:words`"
echo "HEAD    `git-rev-parse HEAD:words`"
echo "stage 3    `git-rev-parse :3:words`"
echo "MERGE_HEAD `git-rev-parse MERGE_HEAD:words`"
