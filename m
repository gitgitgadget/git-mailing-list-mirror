From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] feature request: git-mergetool --force
Date: Sun, 19 Oct 2008 00:16:37 +0100
Message-ID: <48FA6E55.9030101@hashpling.org>
References: <48F91E59.50202@gmail.com> <20081018154824.GA20185@coredump.intra.peff.net> <48FA2E9F.3090305@gmail.com> <20081018205443.GA29534@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: William Pursell <bill.pursell@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 01:18:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrL3W-0004UI-Lu
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 01:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYJRXQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbYJRXQo
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 19:16:44 -0400
Received: from pih-relay06.plus.net ([212.159.14.19]:48727 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbYJRXQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 19:16:42 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1KrL2E-0005df-Qq; Sun, 19 Oct 2008 00:16:38 +0100
Received: from [192.168.76.29] (heisenberg2.hashpling.org [192.168.76.29])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9INGbU6011511;
	Sun, 19 Oct 2008 00:16:38 +0100
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081018205443.GA29534@coredump.intra.peff.net>
X-Plusnet-Relay: 425e174729c85f2d238d733a24f1bbf0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98579>

Jeff King wrote:
> On Sat, Oct 18, 2008 at 07:44:47PM +0100, William Pursell wrote:
> 
>>> Something like --no-prompt makes more sense to me, though probably
>>> something a little easier to type would be nice (or maybe alias "-n").
>> Actually, perhaps an "interactive=no" configuration setting,
>> which might imply trustExitCode = true.
> 
> That sounds reasonable to me.
> 
> -Peff

I've recently been using git mergetool quite a bit and I'm currently
cooking a couple of patches. The first, by coincidence, was a "-n"
option which disabled the hit-return-to-actually-do-anything prompt. I,
also, used the variable "NOPROMPT" to describe this behaviour.

The other change that I am working was more of an issue for me. When I
have a fair number of files to merge I sometimes want to skip a merge.
Perhaps it's a tricky one and I want do the easy wins first.

The current behaviour of mergetool is a little annoying for this as the
first 'failed' merge aborts the process and if you restart it will
always pick up from where it left off. If you want to do some of the
later files, you have to specify the full paths to mergetool which can
be a lot more typing.

The change I am implementing just continues after a failed merge (no git
add or anything, so the file stays unmerged) and allows you to merge
subsequent files. I think that this will work reasonably well allowing
you to do your merges in a number of passes, picking off the easy merges
first and doing the tricky ones later. You can also do a quick pass
through all the merges, not actually resolving everything just to see if
there are any show stoppers.

The only gotcha is that this may interact less well with a --no-prompt
option. With the prompt you can always abort the mergetool process with
a SIGINT at the prompt, even if mergetool now wants to offer you the
opportunity to merge subsequent files after aborting one particular file
merge. Without the prompt mergetool is going to spawn your merge tool
for every conflict even if you've changed your mind and want to abort.

Thoughts?

Charles.
