From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 19:18:18 +0400
Message-ID: <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com> <20101007141015.GB8162@sigill.intra.peff.net> <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com> <4CADE232.8030801@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 17:18:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3sEt-0007LS-0W
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 17:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760717Ab0JGPSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 11:18:23 -0400
Received: from mail.intellij.net ([213.182.181.98]:50071 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab0JGPSW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 11:18:22 -0400
Received: (qmail 24636 invoked by uid 89); 7 Oct 2010 15:18:19 -0000
Received: by simscan 1.1.0 ppid: 24581, pid: 24627, t: 0.2459s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 7 Oct 2010 15:18:19 -0000
In-Reply-To: <4CADE232.8030801@viscovery.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158408>


> With git rev-list, it also happens on Linux:
> 
> $ git log -1 --pretty=foo%x00bar HEAD | od -c
> 0000000   f   o   o  \0   b   a   r  \n
> 0000010
> $ git rev-list -1 --pretty=foo%x00bar HEAD | od -c
> 0000000   c   o   m   m   i   t       8   7   f   a   f   1   0   9   0
> 0000020   5   d   1   f   8   a   b   1   e   9   a   c   2   4   c   c
> 0000040   3   e   f   e   d   8   1   f   a   7   e   2   9   6   7  \n
> 0000060   f   o   o  \n
> 0000064
> $ git version
> git version 1.7.3.67.gcc234
> 


Hannes, 

Thanks for pointing that out.
I confirm that on Mac OS X that happens for rev-list as well. 

# git log --pretty=format:foo%x00bar HEAD -1 | od -c
0000000   f   o   o  \0   b   a   r
0000007

# git rev-list --pretty=format:foo%x00bar HEAD -1 | od -c
0000000   c   o   m   m   i   t       2   3   6   0   1   a   2   c   3
0000020   e   4   6   4   a   4   4   7   9   f   1   7   7   4   e   3
0000040   6   e   a   5   b   9   5   8   b   4   6   0   5   2   1  \n
0000060   f   o   o  \n
0000064

And it's not a new issue:

# git version
git version 1.7.1

So here's what we have now about this bug:
1. It happens since 1.7.1 for rev-list on all platforms (at least since 1.7.1 on Mac OS X and 1.7.3 on Linux).
2. It also happens at least since 1.7.2.3 for log on Windows.

Sorry for giving some confusion in my previous messages.
I probably tested 'rev-list' at the time when I've recovered the problem, but I reported it as a problem with 'log'.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
