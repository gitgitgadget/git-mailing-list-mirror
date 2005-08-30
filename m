From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Tue, 30 Aug 2005 22:41:14 +0100
Message-ID: <1125438074.6961.20.camel@localhost.localdomain>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
	 <20050819194832.GA8562@fanta>
	 <1124572356.7512.21.camel@localhost.localdomain>
	 <20050821094059.GA5453@fanta>
	 <Pine.LNX.4.63.0508221707520.23242@iabervon.org> <tnxvf1wd24m.fsf@arm.com>
	 <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Veldeman <jan.veldeman@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 23:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EADrc-0001am-MG
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 23:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVH3Vlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVH3Vlu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 17:41:50 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:28074 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932484AbVH3Vlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 17:41:49 -0400
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050830214148.OECP23002.mta08-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Tue, 30 Aug 2005 22:41:48 +0100
Received: from cpc3-cmbg5-3-0-cust69.cmbg.cable.ntl.com ([81.104.194.69])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20050830214148.KMKU3432.aamta10-winn.ispmail.ntl.com@cpc3-cmbg5-3-0-cust69.cmbg.cable.ntl.com>;
          Tue, 30 Aug 2005 22:41:48 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508231304130.23242@iabervon.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7964>

Back from holiday. Thanks to all who replied to this thread.

On Tue, 2005-08-23 at 14:05 -0400, Daniel Barkalow wrote:
> Having a useful diff isn't really a requirement for a parent; the diff in
> the case of a merge is going to be the total of everything that happened
> elsewhere. The point is to be able to reach some commits between which
> there are interesting diffs.
> 
> This also depends on how exactly freeze is used; if you use it before
> commiting a modification to the patch without rebasing, you get:
> 
> old-top -> new-top
>       ^    ^
>        \  /
>       bottom
> 
> bottom to old-top is the old patch
> bottom to new-top is the new patch
> old-top to new-top is the change to the patch
> 
> Then you want to keep new-top as a parent for rebasings until one of these
> is frozen. These links are not interesting to look at, but preserve the
> path to the old-top:new-top change, which is interesting.

This was my initial StGIT implementation (up to version 0.3), only that
there was no freeze command. Since I want an StGIT tree to be clean to
the outside world, I wouldn't keep multiple parents for the visible top
of a patch.

As I understand from Junio's and Linus' e-mails (on the 23rd of August),
there might be problems with merging the HEAD of an StGIT-managed tree
if the above method is accessible via HEAD.

> Ignoring the links to the corresponding bottoms, the development therefore
> looks like:
> 
> local1 -> local2 -> merge -> local3 -> merge
> ^                   ^                  ^
> mainline---->-->--------->------>-->----->
> 
> And this is how development is normally supposed to look. The trick is to
> only include a minimal number of merges.

A merge occurs every time a patch is rebased. Anyway, having the bottoms
in the graph (which is the main idea of StGIT) together with the old-top
(or frozen state) parents make the graph pretty complicated.

-- 
Catalin
