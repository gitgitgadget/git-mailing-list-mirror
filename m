From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 03 Aug 2007 01:50:00 +0200
Message-ID: <46B26DA8.6010102@alum.mit.edu>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de> <46B2309E.3060804@fs.ei.tum.de> <6715F560-FE69-4F15-8C5F-B5B6071D97ED@zib.de> <46B25FC3.6000205@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 01:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGkR4-00049Q-7c
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 01:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756352AbXHBXuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 19:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbXHBXuI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 19:50:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:48832 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbXHBXuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 19:50:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.178.20] (p5B17FC13.dip.t-dialin.net [91.23.252.19])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l72No1uf014479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 3 Aug 2007 01:50:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <46B25FC3.6000205@fs.ei.tum.de>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54647>

Simon 'corecode' Schubert wrote:
> Steffen Prohaska wrote:
>> BTW, togit creates much more complex branching patterns than cvs2svn
>> does. The attached file branching.png displays a small view of a
>> branching pattern that extends downwards over a couple of screens.
>> I checked the cvs2svn history again. It doesn't contain anything
>> of similar complexity.
> 
> haha yea, there is still some issue with duplicate branch names and the
> branchpoint.  if it doesn't get the branch right, it will always "pull"
> files from the parent branch.

This sounds very much like the problem reported by Daniel Jacobowitz
[1].  The problem is that if you create a branch A on a file, then
create branch B from branch A before making a commit on branch A, then
CVS doesn't record that branch A was the source of branch B.  (It treats
B as if it sprouted directly from the revision that was the *source* of
branch A.)  The same problem exists if "B" is a tag.

The only way to determine the correct branch hierarchy is to consider
the branch hierarchy of multiple files at the same time.

cvs2svn 2.0 includes code to choose a "preferred parent" of each branch
and try to use that parent for every file that is on the branch.  It
helps simplify branch creation quite a bit.  The main limitation is that
it still doesn't consider the revision copied back to trunk from a
vendor branch as the possible parent of a branch whose nominal source
was on the vendor branch (a limitation that has come up elsewhere in
this thread).

Michael

[1] http://cvs2svn.tigris.org/servlets/ReadMsg?list=dev&msgNo=1441
