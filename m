From: Max Kirillov <max@max630.net>
Subject: Re: [Feature Request] git blame showing only revisions from git
 rev-list --first-parent
Date: Sun, 18 Oct 2015 14:38:57 +0300
Message-ID: <20151018113857.GA5722@wheezy.local>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
 <20150911140133.GA14311@sigill.intra.peff.net>
 <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
 <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
 <20150912033054.GA30431@sigill.intra.peff.net>
 <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
 <20150913100728.GA26562@sigill.intra.peff.net>
 <CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
 <20150915100538.GA21831@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Connolly <stephen.alan.connolly@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 18 13:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnmJR-0002pl-75
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 13:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbbJRLjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 07:39:08 -0400
Received: from p3plsmtpa08-09.prod.phx3.secureserver.net ([173.201.193.110]:60324
	"EHLO p3plsmtpa08-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752382AbbJRLjH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2015 07:39:07 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-09.prod.phx3.secureserver.net with 
	id Wbez1r0025B68XE01bf438; Sun, 18 Oct 2015 04:39:06 -0700
Content-Disposition: inline
In-Reply-To: <20150915100538.GA21831@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279807>

On Tue, Sep 15, 2015 at 06:05:39AM -0400, Jeff King wrote:
> It seems like nobody is actually that interested in what "blame
> --first-parent --reverse" does in the first place, though, and there's
> no reason for its complexity to hold up vanilla --first-parent. So what
> do you think of:
...
> Combining "--reverse" with "--first-parent" is more
> complicated, and will probably involve cooperation from
> revision.c. Since the desired semantics are not even clear,
> let's punt on this for now, but explicitly disallow it to
> avoid confusing users (this is not really a regression,
> since it did something nonsensical before).

Hi.

I might be late for this discussion, but I seem to have
a case when blame --reverse --first-parent seems to work.

Consider the folowing history (from left ro right):

       +-----------------D1-+
      +--->C1------>C2-+     \
     /                  \     \
A0->A1-------->A2---..-->A3-->A4-->A5
 \            /
  +->B1-->B2-+

, and a line was removed in B2. Then, blame --reverse
returns D1 for this line, which is, while technically
correct, absolutely useless to find real place where the
line was removed. But blame --reverse --first-parent seems
to return A1, which is much more useful and actually what
I would expect to return. I tried it recently with
2.3-something and it seems to work as expected.

Was it the behavior you mentioned as nonsensical or you have
some other examples?

So please may I ask to not kill this completely. As about
the issue mentioned by Junio, it could fail loudly if the
requested range is not a first-parent chain.

-- 
Max
