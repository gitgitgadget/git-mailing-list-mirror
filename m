From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Fri, 19 Aug 2005 10:53:11 +0100
Message-ID: <tnx64u2p81k.fsf@arm.com>
References: <20050818195753.GA9066@fanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 11:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E63ZY-0001N8-9v
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 11:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVHSJx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 05:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVHSJx5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 05:53:57 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49800 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932602AbVHSJx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 05:53:57 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7J9qpOU008207;
	Fri, 19 Aug 2005 10:52:51 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA12111;
	Fri, 19 Aug 2005 10:53:45 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 19 Aug 2005 10:53:44 +0100
To: Jan Veldeman <jan.veldeman@gmail.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 19 Aug 2005 09:53:44.0328 (UTC) FILETIME=[E2E61080:01C5A4A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jan Veldeman <jan.veldeman@gmail.com> wrote:
> I like stgit very much, but I feel there is still something missing:
> stgit is very handy when you use it for patches which should be pushed to
> mainline rather quickly. But for pacthes which won't be pushed immediately
> to mainline, it would be usefull to have a history of the patches
> itself.

The patch history feature was available in StGIT 0.1/0.2 releases
where you should have run a 'stg commit' before 'stg refresh'. The
commit was handling all the history changes, with separate commit
messages and refresh was updating the main commit with 2 parents. I
removed it in 0.3 after some people (I think it was Paul Jackson and
Daniel Barkalow) convinced me that this would make it yet another SCM
interface on top of GIT, which wasn't really my intention.

The main problem with having multiple parents for a commit object
corresponding to a patch is the upstream merging via 'git pull'. In
general you don't want a gatekeeper to pull the history of your patch
but the patch only.

> The patch below, together with the following script could be used to
> make snapshots of the patch stack (I call it freeze, as I thought snapshot
> was already going to be used for something else):

'snapshot' is not yet used for anything and I'm not sure how it is
best to be implemented. I thought about simply saving the current HEAD
into some .git/refs/heads/<file>, without preserving any history for
the patch. A gitk on this file would show the patches as they were on
the time of the snapshot creation. A new snapshot would remove this.

It might be best for a per-patch history to have a separate file in
<branch>/<patch>/, maybe called freeze, which keeps this history
information. The top one should remain unchanged. Its hash could be
accessed with the 'stg id /freeze' command (implemented
yesterday). This file would only be updated via the 'freeze' command
and its parent would be the previous freeze value.

Would this be close to what you need?

-- 
Catalin
