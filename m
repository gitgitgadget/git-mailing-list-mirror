From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git pull --rebase and losing commits
Date: Mon, 2 Nov 2009 16:04:22 +0100
Message-ID: <200911021604.24066.trast@student.ethz.ch>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4yTr-0007OU-Ig
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbZKBPFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 10:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439AbZKBPFn
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:05:43 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:48931 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762AbZKBPFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:05:43 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 2 Nov
 2009 16:05:28 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 2 Nov
 2009 16:05:06 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131910>

Peter Krefting wrote:
>   # Update tree (--strategy=ours avoids merge conflicts)
>   git pull --rebase --strategy=ours origin master
[...]
> However, this seems to lose commits. When I ran it today, it commited an 
> automatic change, and then pulled a tree that did not contain that change, 
> making the changed file just disappear.

Not very surprising if you use the 'ours' strategy, which doesn't
merge at all but instead takes the 'ours' side (IIRC that's the
upstream for a rebase, but I always have these mixed up).  It is *not*
the often requested (but ill-defined and hence never implemented)
"resolve all conflict hunks in favour of ours" strategy.

So what happens is that git-rebase rebuilds some commit C from your
side on some base B from the remote, but the 'ours' strategy turns the
*tree* for C' into that of B.  Then git-rebase sees that the trees
haven't changed, and concludes that C has already been applied and
drops it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
