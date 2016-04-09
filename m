From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Sat, 9 Apr 2016 20:17:49 +0300
Message-ID: <20160409201344-mutt-send-email-mst@redhat.com>
References: <1460041965-31526-1-git-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604071720160.2967@virtualbox>
 <20160407184026-mutt-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604081309150.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 09 19:18:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aowWI-0003ng-Kg
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 19:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbcDIRRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 13:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53314 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbcDIRRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 13:17:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD07A64375;
	Sat,  9 Apr 2016 17:17:51 +0000 (UTC)
Received: from redhat.com (vpn1-7-52.ams2.redhat.com [10.36.7.52])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u39HHncG014287;
	Sat, 9 Apr 2016 13:17:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604081309150.2967@virtualbox>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 09 Apr 2016 17:17:51 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291101>

On Fri, Apr 08, 2016 at 01:13:51PM +0200, Johannes Schindelin wrote:
> Hi Michael,
> 
> On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:
> 
> > On Thu, Apr 07, 2016 at 05:23:09PM +0200, Johannes Schindelin wrote:
> > > 
> > > On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:
> > > 
> > > > Reverts can typically be treated like squash.  Eliminating both the
> > > > original commit and the revert would be even nicer, but this seems a bit
> > > > harder to implement.
> > > 
> > > Whoa. This rings a lot of alarm bells, very loudly.
> > 
> > Whoa don't be alarmed. It's just a patch :).
> 
> It's just a patch. Like every major breakage would be. So: no, there is
> reason to be alarmed if it is likely to disrupt normal usage.
> 
> > > It seems you intend to introduce a *major* change in behavior,
> > 
> > Doing this automatically for all users might be a bit too drastic for
> > the upstream git.
> 
> That is a pretty safe thing to say, even without the subjunctive.
> 
> > If there's a commit later followed by a revert, history can be
> > simplified by squashing them, and if the result is empty, removing both.
> 
> True. But that is not what the user told Git to do. If the user's
> intention was to squash the reverting patch, she could have easily done
> this:
> 
> 	git revert -n deadbeef
> 	git commit --squash deadbeef
> 
> where "deadbeef" is the placeholder for the actual commit to revert.
> 
> And indeed, I use exactly this song and dance quite frequently, *iff* my
> intention is to drop a patch.

Well then you have to decide whether you want to drop it
when you commit.
If *I* want do drop the patch when I commit, I just do
git rebase.

> A much better idea than co-opting the "Revert" commit message would be to
> introduce a sibling to --fixup and --squash that you could call --drop.
> 
> Ciao,
> Johannes

Maybe but it's a different usecase.

What this addresses is a case where you first wanted to
avoid rebases, so you reverted.
But then you rebased after all.
Now finding what was reverted automatically is helpful.
