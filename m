From: Pete Wyckoff <pw@padd.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Thu, 19 Apr 2012 19:34:45 -0400
Message-ID: <20120419233445.GA20790@padd.com>
References: <4F893CD8.5020700@gmail.com>
 <20120414201446.GB29999@ecki>
 <4F8A0F96.5060408@gmail.com>
 <20120415011118.GA4123@ecki>
 <4F8A8211.2010908@gmail.com>
 <20120415105943.GD6263@ecki>
 <4F8AAE7C.1020507@gmail.com>
 <20120415114518.GB9338@ecki>
 <4F8AB7F1.1020705@gmail.com>
 <20120415125140.GA15933@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 01:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL0sI-00070M-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 01:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab2DSXeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 19:34:50 -0400
Received: from honk.padd.com ([74.3.171.149]:40721 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755562Ab2DSXet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 19:34:49 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id C02CE20CE;
	Thu, 19 Apr 2012 16:34:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C187531689; Thu, 19 Apr 2012 19:34:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120415125140.GA15933@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195977>

drizzd@aon.at wrote on Sun, 15 Apr 2012 14:51 +0200:
> The 'pushing to local repo' test of t5800 which pushes using
> git-remote-testgit.py results in a deadlock for Stefano. Invoking
> fast-export/fast-import manually seems to work, however. I don't know
> what else to try at this point.
> 
> I am pasting some relevant results below.
> 
> > expecting success:
> >         (cd localclone &&
> >         echo content >>file &&
> >         git commit -a -m three &&
> >         GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
> >         compare_refs localclone HEAD server HEAD

fast-export should say to fd 1 "feature done\nblob\n..."

fast-import is probably blocked on reading fd 0, hoping to find a
sequence of commands

I too cannot reproduce the problem.  Stefano, can you try this
bigger hammer?  We'll see if anything sticks out.

    GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 strace -vf -s 2000 -o /tmp/strace.out git push

Then "bzip2 /tmp/strace.out" and attach /tmp/strace.out.bz2, please.

		-- Pete
