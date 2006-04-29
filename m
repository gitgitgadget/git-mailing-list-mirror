From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: cg-clone not fetching all tags?
Date: Sun, 30 Apr 2006 00:54:31 +0200
Message-ID: <200604300054.31526.johannes.sixt@telecom.at>
References: <20060429221114.557FC35288F@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 30 00:55:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZyL2-0006xf-BO
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 00:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWD2Wyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 18:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWD2Wyh
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 18:54:37 -0400
Received: from mail.nextra.at ([195.170.70.100]:31104 "EHLO mail.nextra.at")
	by vger.kernel.org with ESMTP id S1750818AbWD2Wyh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 18:54:37 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by mail.nextra.at (8.13.6/8.13.6) with ESMTP id k3TMsVJv009237
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 00:54:33 +0200 (MEST)
X-Abuse-Info: Please report abuse to abuse@eunet.co.at, see http://www.eunet.at/support/service
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A752749D45
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 00:54:31 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <20060429221114.557FC35288F@atlas.denx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19324>

On Sunday 30 April 2006 00:11, Wolfgang Denk wrote:
> In message <200604292342.16306.johannes.sixt@telecom.at> you wrote:
> > There are two types of tags: They can point to
> > 1. a commit object
> > 2. a proper tag object (which in turn references the commit)
> >
> > git-update-server-info seems to generate info only for case 2, and so are
> > the only ones that http can fetch.
>
> And git-cvsimport (at least older versions of it)  imports  CVS  tags
> only as type 1 ?
>
> That would perfectly explain the situation. How can this be fixed?

Something like this tells you which one points to a commit or a tag:

for i in `find .git/refs/tags -type f`; do
  echo -n "$i "; git-cat-file -t $(cat $i);
done

Then for each commit-type $tag you do

git-tag -m ' ' $tag-new $tag
mv .git/refs/tags/$tag-new .git/refs/tags/$tag

(git-tag does not accept an empty tag message - if you dislike the 
single-blank-message, you have to manufacture your tags with git-mktag 
manually.)

-- Hannes
