From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Sun, 03 Jul 2005 11:08:00 +0100
Message-ID: <1120385280.6845.12.camel@localhost.localdomain>
References: <1119994003.9631.6.camel@localhost.localdomain>
	 <m3ekagp9mk.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 03 12:08:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp1Oj-0008GI-Vb
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 12:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVGCKIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 06:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVGCKIK
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 06:08:10 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:35003 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261246AbVGCKID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 06:08:03 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050703100802.KMKW11649.mta09-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Sun, 3 Jul 2005 11:08:02 +0100
Received: from cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com ([81.104.193.212])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050703100802.TOAC5558.aamta09-winn.ispmail.ntl.com@cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com>;
          Sun, 3 Jul 2005 11:08:02 +0100
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3ekagp9mk.fsf@telia.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Peter,

Thanks for trying this tool.

On Sun, 2005-07-03 at 10:38 +0200, Peter Osterlund wrote:
> This is good stuff and the 3-way merge really simplifies things.
> However, if there is a merge conflict, you will basically be stuck
> with a 2-way merge when resolving manually. It's usually much easier
> if you can see all three version, so I think it's better to use -A
> instead of -E in the diff3 command.

I know that using -A gives a more detailed output in case of a conflict.
The problem is that you will get a conflict even if the changes are
identical, making it impossible to detect when a patch was merged
upstream.

For example:

ancestor:	aaa
branch1:	aaa
		bbb
branch2:	aaa
		bbb

diff3 -E:	aaa
		bbb
diff3 -A:	aaa
		<<<<<<< ancestor
		=======
		bbb
		>>>>>>> branch2

In version 0.3, in case of a conflict, StGIT leaves 3 files in the tree:
file.older, file.local and file.remote so that one can use a graphical
tool to do the merge. I think these names are a bit misleading, .remote
extension means the file in the patch and .local is the one in the tree
before pushing the patch. Anyway, it might be invoking a graphical tool
directly from gitmergeonefile.py.

Speaking of detecting upstream merges, the latest StGIT snapshot shows a
'0' in front of a patch if it is empty, when 'stg series' is invoked.
When pushing, if all the changes are the same, it notifies you that the
patch is empty so that it can be safely removed.

--
Catalin
