From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH 0/5] "best effort" checkout
Date: Thu, 29 May 2008 19:24:34 -0400
Message-ID: <483F3B32.9000907@verizon.net>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 01:25:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1rV1-0001Je-SN
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 01:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbYE2XYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 19:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbYE2XYo
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 19:24:44 -0400
Received: from main.gmane.org ([80.91.229.2]:51215 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbYE2XYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 19:24:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K1rUA-00028t-01
	for git@vger.kernel.org; Thu, 29 May 2008 23:24:42 +0000
Received: from pool-71-126-133-203.washdc.fios.verizon.net ([71.126.133.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 May 2008 23:24:41 +0000
Received: from mdl123 by pool-71-126-133-203.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 May 2008 23:24:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-126-133-203.washdc.fios.verizon.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <1212020246-26480-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83252>

Junio C Hamano wrote:
> 	
> [PATCH 1/5] "git checkout -- paths..." should error out when paths cannot be written
> [PATCH 2/5] checkout: make reset_clean_to_new() not die by itself
> [PATCH 3/5] checkout: consolidate reset_{to_new,clean_to_new|()
> [PATCH 4/5] unpack_trees(): allow callers to differentiate worktree errors from merge errors
> [PATCH 5/5] checkout: "best effort" checkout
> [PATCH 6/5] NUL hack to create_file()

This works! I've added these patches (pulled from pu) to my tree and rebuilt. 
The current results on Cygwin...

git>git checkout -f b71ce7f3f13ebd0e
Previous HEAD position was 952538f... checkout: "best effort" checkout
error: git-checkout-index: unable to create file t/t5100/nul (File exists)
HEAD is now at b71ce7f... Merge 1.5.5.3 in
git>git status
# Not currently on any branch.
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#   modified:   t/t5100/nul
#
no changes added to commit (use "git add" and/or "git commit -a")
git>git mv  t/t5100/nul t/t5100/nul-plain
fatal: renaming t/t5100/nul failed: Invalid argument
git>git rm -f  --cached t/t5100/nul
rm 't/t5100/nul'
git>git show HEAD:t/t5100/nul
 From nobody Mon Sep 17 00:00:00 2001

---
diff --git a/foo b/foo
^Some strange test^^
^@

So, for posterity, git-mv cannot rename the offending file in the index, but the 
file can be removed, and its contents piped into a file of non-offending name, 
so a reasonable solution for this case exists.

Many thanks to all, especially to Junio for actually creating the fix.

Mark
