From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Mon, 25 Jun 2007 09:16:00 +0200
Organization: eudaptics software gmbh
Message-ID: <467F6BB0.4C7F041E@eudaptics.com>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com> <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 09:30:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2j1N-0001p5-Qb
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXFYH36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbXFYH35
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:29:57 -0400
Received: from main.gmane.org ([80.91.229.2]:49279 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbXFYH35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:29:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I2itF-0001jy-2r
	for git@vger.kernel.org; Mon, 25 Jun 2007 09:21:37 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 09:21:37 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 09:21:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50872>

Steffen Prohaska wrote:
> 
> On Jun 23, 2007, at 11:04 PM, Alex Riesen wrote:
> 
> >> git-transplant.sh <onto> <from> <to>
> >>
> >> transplant starts with the contents of <onto> and puts on top of
> >> it the contents of files if they are touched by the series of
> >> commits <from>..<to>.  If a commit touches a file the content of
> >> this file is taken as it is in the commit. No merging is
> >> performed. Original authors, commiters, and commit messages are
> >> preserved.
> >>
> > [...]
> > # detached head
> > git checkout $(git rev-parse onto) && git format-patch --stdout
> > --full-index from..to|git am -3
> 
> No. This one tries to apply the _changes_ between from..to. What I
> need is the resulting _content_ of files modified between from..to.

Install a graft that points the parent of "from" to "onto", then run
git-filter-branch. Like so:

 $ echo "$(git-rev-parse from^0) $(git-rev-parse onto^0)" \
        > .git/info/grafts
 $ git-filter-branch new-to onto..to

(no filters necessary).

-- Hannes
