From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: tracking a tree that doesn't progress linearly
Date: Fri, 11 Nov 2005 10:40:25 +0000
Message-ID: <tnxwtjfxyau.fsf@arm.com>
References: <17268.3463.252020.591687@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 11:43:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaWL3-0007zh-BH
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 11:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVKKKkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 05:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVKKKkw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 05:40:52 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:6348 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932370AbVKKKkv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 05:40:51 -0500
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id jABAe8U3004817;
	Fri, 11 Nov 2005 10:40:08 GMT
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA28719;
	Fri, 11 Nov 2005 10:40:28 GMT
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 11 Nov 2005 10:40:27 +0000
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17268.3463.252020.591687@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Fri, 11 Nov 2005 14:18:31 +1100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 11 Nov 2005 10:40:27.0984 (UTC) FILETIME=[54B50500:01C5E6AC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11582>

Paul Mackerras <paulus@samba.org> wrote:
> I want to be able to publish a git tree for others to follow but I
> also want to be retain the freedom to remove commits and/or rebase
> commits in the tree.  For example, if someone sends me a patch and I
> put it in the tree, then they send me a revised version, I want to be
> able to roll back to just before I applied the older patch and start
> again from there.

I'm facing a similar problem. I use StGIT for my development branch
(usually with less than 20 patches) but I would like to export a HEAD
for others to pull from. When rebasing the patches with StGIT, the new
HEAD wouldn't be a descendant of the old one.

The partial solution I got to was to make the master branch available
to people and the devel branch private. Initially, the master branch
would pick the patches ('stg pick') from the devel branch which I want
to make public. When I'm happy with the patches on the master branch,
I run 'stg commit' and store them permanently (you won't be able to
modify them). After permanently storing the patches, I can use the
master branch in the normal way with GIT (merge, pull, push etc.).

When I get a patch in the devel branch updated, I just run 'stg pick
patchname@devel' in the master branch. Because of the nature of the
three-way merge, the new picked patch should only contain the
differences from the previous one. It might also cause conflicts which
need resolving if the new patch modifies lines which were present in
the old patch (i.e. not only additions or removals). At this point you
can change the patch description since the new picked patch only
represents an update to the old one and not the full feature.

The only little drawback I see with this approach is that merging in
the latest changes from the mainline kernel could produce identical
conflicts (if any) in both master and devel branches.

-- 
Catalin
