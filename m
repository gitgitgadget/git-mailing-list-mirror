From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git describe weird behaviour
Date: Wed, 10 Nov 2010 09:52:34 +0100
Message-ID: <201011100952.34352.trast@student.ethz.ch>
References: <20101110010016.GC22105@genesis.frugalware.org> <20101110041428.GA8955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 10 09:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG6Q5-0000PS-IL
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 09:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab0KJIwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 03:52:37 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:48064 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026Ab0KJIwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 03:52:36 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 10 Nov
 2010 09:52:35 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 10 Nov
 2010 09:52:35 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101110041428.GA8955@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161140>

Jeff King wrote:
> The trick is in keeping track of how far we've gone. It looks like we
> keep the number of seen_commits, increment each time we traverse a
> commit, and then assign that to the "depth" field. But I don't see how
> that can be right. We are traversing in a breadth-first manner, so we
> may look at 1000 commits down one ancestry chain of a merge before
> following the first parent on another.

I haven't really spent more than about 3 minutes on this, but it seems
to use insert_by_date() (except for the start of the search) to walk,
so it would seem to be affected by date skew in some strange way that
I have yet to investigate.

So I merged your git-skew from pu and compiled, and ran

  frugalware-current(master u=)$ git skew --all
  182448414
  frugalware-current(master u=)$ python
  [...]
  >>> 182448414/86400/365.25
  5.7796030116358654

Unless I'm reading your commit message a2ffa6b96 wrong, that means the
repo has a worst-case clock skew of on the order of *six years*...  So
maybe it's once again an undocumented effect of clock skew on our
history walks?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
