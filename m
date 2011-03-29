From: Stephen Bash <bash@genarts.com>
Subject: Re: Merging split files
Date: Tue, 29 Mar 2011 12:33:17 -0400 (EDT)
Message-ID: <3752347.282743.1301416397164.JavaMail.root@mail.hq.genarts.com>
References: <20110329151623.GD10771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 18:33:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4brY-0000nZ-KQ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 18:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026Ab1C2Qdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 12:33:43 -0400
Received: from hq.genarts.com ([173.9.65.1]:10210 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750750Ab1C2Qdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 12:33:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C4F9AEA2431;
	Tue, 29 Mar 2011 12:33:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvYIlaBzsmT8; Tue, 29 Mar 2011 12:33:18 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 1644FEA242E;
	Tue, 29 Mar 2011 12:33:18 -0400 (EDT)
In-Reply-To: <20110329151623.GD10771@sigill.intra.peff.net>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170277>

Jeff-

Thanks for taking the time to think about this.  More inline...

----- Original Message -----
> From: "Jeff King" <peff@peff.net>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: git@vger.kernel.org
> Sent: Tuesday, March 29, 2011 11:16:23 AM
> Subject: Re: Merging split files
>
> On Fri, Mar 18, 2011 at 09:22:36AM -0400, Stephen Bash wrote:
> 
> > In our previous release foo.cxx contained both the base class and a
> > few subclasses. Since then the number of subclasses has grown, and
> > we've split foo.cxx (base and sub-classes) into foo-base.cxx (base
> > class) and foo-defs.cxx (sub-classes). Since the release, we've had
> > a
> > few bug fixes in foo.cxx on the maintenance branch, and need to
> > merge
> > those back to development. When I did the merge Git identified
> > foo.cxx as moved to foo-defs.cxx, which worked for most changes, but
> > a
> > few needed to be in foo-base.cxx. In this case it was a pretty
> > trivial manual resolution, but is there a method for handling merges
> > of split files?
> 
> I don't think there is currently a good way to do this automatically.
> 
> The problem is that the closest merge-recursive gets to understanding
> content movement is that it considers whole file renames. ...
> 
> So I think the most flexible thing is to forget file renames at all.

I agree that would be the best solution long term. ("Git doesn't track files, Git tracks content".  Think I heard that somewhere before...)

That being said, the back seat drivers in the office here (i.e. me and everyone else that knows almost nothing about the internals of merge recursive!) thought maybe a middle ground is teach merge recursive to do copy detection along with rename detection.  Then the algorithm would have a (relatively small?) list of candidate files to check for hunks.  You still have to deal with the similarity score in some corner cases, but hopefully since all we want is candidate files the process is relatively insensitive to the similarity threshold.

Am I way off the deep end now?  I'm not lying when I say I know *nothing* about the merge implementations.

> I definitely think it's an interesting area to work in, but I would
> have to give it a lot of thought.

It's a "corner case" that I seem to have run into a lot in my work experience, so if the Git community can actually make a good solution work it will be a major win in my book.

Thanks again!

Stephen
