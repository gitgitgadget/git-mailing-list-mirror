From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Cherry picking instead of merges.
Date: Fri, 4 Jul 2008 02:10:03 +0200
Message-ID: <20080704001003.GA19053@atjola.homenet>
References: <20080703182650.GA11166@old.davidb.org> <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org> <20080703223949.GA23092@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:11:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYtF-00069I-UY
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbYGDAKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 20:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYGDAKI
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:10:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:37721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753332AbYGDAKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 20:10:07 -0400
Received: (qmail invoked by alias); 04 Jul 2008 00:10:05 -0000
Received: from i577B8FB6.versanet.de (EHLO atjola.local) [87.123.143.182]
  by mail.gmx.net (mp003) with SMTP; 04 Jul 2008 02:10:05 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/lSc5eoKflpRKOBig3YXR+ntCjfHaTBlEGkqs9Ht
	+fsRMtgftbBVPl
Content-Disposition: inline
In-Reply-To: <20080703223949.GA23092@old.davidb.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87343>

On 2008.07.03 15:39:49 -0700, David Brown wrote:
> On Thu, Jul 03, 2008 at 02:18:53PM -0700, Linus Torvalds wrote:
>
>> End result: you have a nice merge with nice history that actually
>> converges at a common point, but you effectively did the merge
>> resolution one commit at a time with cherry-picking (or "git rebase"=
,
>> which is obviously just a convenient shorthand for cherry-picking
>> everything).
>
> I'm still not clear how the one-commit-at-a-time resolution gets
> recorded anywhere (except in the cherry-picking branch).

They don't get recorded. Git does not store how merges happened in some
diffs or whatever, it just stores the end result. So what Linus
suggested was to reuse the end result that you already have to create
the merge commit.

Say you have 5 commits like this:

  A---B---C
   \
    D---E

Now there are two ways to get the changes from D and E ontop of C. The
first one is cherry-picking, which leads to:

  A---B---C---D'---E'
   \
    D---E

The other one is merging:

  A---B---C---M
   \         /
    D---E---/

Of course, you should end up with the same tree either way. It's just a
different way of getting towards that final state. So commit E' and
commit M, while different commits, would point to the same tree object.

Now if you want to create that merge commit M, and already have E' (lik=
e
you do, as you already did all those cherry-picks), you can use what
Linus suggested. You start the merge, ignore any conflicts and just tel=
l
git to use the tree that E' is pointing to instead.

Bj=F6rn
