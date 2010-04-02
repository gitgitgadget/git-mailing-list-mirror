From: Jeff King <peff@peff.net>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Fri, 2 Apr 2010 17:28:58 -0400
Message-ID: <20100402212858.GA28531@coredump.intra.peff.net>
References: <201004022154.14793.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Fri Apr 02 23:29:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxoQW-00062a-JE
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 23:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab0DBV3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 17:29:12 -0400
Received: from peff.net ([208.65.91.99]:55843 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab0DBV3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 17:29:11 -0400
Received: (qmail 18353 invoked by uid 107); 2 Apr 2010 21:29:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Apr 2010 17:29:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Apr 2010 17:28:58 -0400
Content-Disposition: inline
In-Reply-To: <201004022154.14793.elendil@planet.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143853>

On Fri, Apr 02, 2010 at 09:54:14PM +0200, Frans Pop wrote:

> I wanted to to a 'git gc' on my kernel repo, but that seemed to end in a 
> loop: loads of CPU usage, no output. Using 'ps' I found it's not 'git gc' 
> itself, but 'git reflog' that's causing the problem.
> 
> From the strace below it does seem like it still makes some progress, but 
> I've never had it take anywhere near this long before. Normally it starts 
> the count of objects almost immediately.
> 
> It's using hardly any memory at all but has one core going flat out.
> 
> I'm seeing this with both git 1.6.6.1 and 1.7.0.3 on the same repo.
> Environment:
> - Debian amd64/Lenny; Core Duo x86_64 2.6.34-rc3 -> 1.6.6.1
> - Debian i386/Sid; chroot on the same machine -> 1.7.0.3
> I've also tried with 2.6.33 to rule out a kernel issue.
> 
> Here's the tail end of an strace I ran. I broke it off after 9+ minutes, 
> but I had let it go for longer than that earlier. You can clearly see 
> where it starts to "stall" at 21:40:14.

FWIW, I have seen this, too, and managed to get an strace snippet that
looked similar to what you saw (mostly memory allocation, and otherwise
chewing on the CPU). I'm guessing there is some O(n^2) loop in there
somewhere. Unfortunately, mine actually completed after a few minutes
and I wasn't able to replicate.

Can you reproduce the problem on your repo? If so, can you possibly tar
it up and make it available (probably just the .git directory would be
enough)?

-Peff
