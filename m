From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git merge FETCH_HEAD produced bad commit message
Date: Fri, 26 Jan 2007 16:24:20 +0200
Message-ID: <20070126142420.GO10812@mellanox.co.il>
References: <81b0412b0701260102j7d1c44d5nd5aa489cb8312722@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 15:24:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HARzi-0002sL-Tc
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbXAZOXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbXAZOXz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:23:55 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:54948 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030246AbXAZOXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:23:54 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.2-1)
	with ESMTP id afe0ab54.2699373488.11462.00-007.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 26 Jan 2007 07:23:54 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 26 Jan 2007 16:25:47 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri, 26 Jan 2007 16:23:04 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0701260102j7d1c44d5nd5aa489cb8312722@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 26 Jan 2007 14:25:47.0596 (UTC) FILETIME=[DF31D8C0:01C74155]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14958.003
X-TM-AS-Result: No--14.174400-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37858>

> Quoting Alex Riesen <raa.lkml@gmail.com>:
> Subject: Re: git merge FETCH_HEAD produced bad commit message
> 
> On 1/25/07, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> > Hi!
> > I like to do
> >         $git fetch <URL>
> >
> >         $git log FETCH_HEAD
> >
> >         $git merge FETCH_HEAD
> >
> > I would expect this to be equivalent to
> >
> >         git pull <URL>
> >
> > However, the message that git merge produces in this case
> > is less than informative:
> >
> > commit 3c11f564846227d80aa76b579c974913c3602862
> > Merge: 9871244... f5e6d63...
> > Author: Michael S. Tsirkin <mst@mellanox.co.il>
> > Date:   Thu Jan 25 16:46:51 2007 +0200
> >
> >     Merge commit 'FETCH_HEAD' into ofed_1_2
> >
> > I note that FETCH_HEAD actually has the information on where
> > the commit came from:
> > $cat .git/FETCH_HEAD
> > f5e6d63839970f4785c36b6be3835f037e74195c ssh://<hidden>/usr/src/ofed_1_2
> >
> > So can not git merge be enhanced to put this data in commit log?
> >
> 
> Does it need to?

FETCH_HEAD is not a real head name, so I think the message above is a bug.

> Is the below enough (could be line-wrapped):
> 
> git merge --no-commit FETCH_HEAD && \
> git commit -M "Merge $(cut -d ' ' -f 2- < $(git rev-parse
> --git-dir)/FETCH_HEAD) \
> into $(git name-rev HEAD | cut -d ' ' -f 2-)"

Or I can just commit --amend and edit it manually.
But that's not the point.

> In the long run you'll almost certainly find this commit message
> useless, though.

Isn't 'Merge ssh://<hidden>/usr/src/ofed_1_2 info ofed_1_2' much more
useful than Merge commit 'FETCH_HEAD'?

-- 
MST
