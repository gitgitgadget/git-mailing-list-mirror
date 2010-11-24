From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Wed, 24 Nov 2010 23:06:17 +0100
Message-ID: <201011242306.17834.j6t@kdbg.org>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com> <4CED488A.2070507@workspacewhiz.com> <AANLkTi=X724OJgUvG0Ggu3OwxyaJprr9CLL+t+x=MbTO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Wilbert van Dolleweerd <wilbert@arentheym.com>,
	Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 23:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLNTv-0003Gt-Am
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 23:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab0KXWGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 17:06:22 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:63409 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752375Ab0KXWGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 17:06:21 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3E45E130049;
	Wed, 24 Nov 2010 23:06:18 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1F01019F5FD;
	Wed, 24 Nov 2010 23:06:18 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=X724OJgUvG0Ggu3OwxyaJprr9CLL+t+x=MbTO@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162090>

On Mittwoch, 24. November 2010, Dun Peal wrote:
> So my theory is that there's a cache that on the "fast" machines
> aggressively caches the entire tree on a regular `git status` run. On
> such a machine, it's enough to run `git status` once, and after that
> initial cold run, the rest will be warm... until you reboot the
> machine, rinse, repeat.
>
> On a slow machine, however, cache isn't so aggressive. It might be
> write-oriented. So when you write out a whole new working tree, that
> tree gets cached as it is written. And for the remainder of the
> lifetime of that cache, you get the fully-cached performance you see
> on the "fast" machines. But then you reboot the machine, and lose the
> cache. And since the caching process isn't aggressive, any number of
> `git status` runs won't get you back to the fully cached state. You
> will only get that on a newly written working copy.

You can test this theory on a slow machine: You have cloned a repository, 
rebooted, and you are now at 14s per 'git status'. Now:

 $ git rm -r .
 $ git reset --hard

erases the worktree and writes it out again (do this only on a clean 
checkout!). Are you now at 5s per 'git status'?

-- Hannes
