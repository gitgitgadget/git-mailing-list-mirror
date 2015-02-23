From: Mason <slash.tmp@free.fr>
Subject: Salvaging borked project history
Date: Mon, 23 Feb 2015 18:05:27 +0100
Message-ID: <54EB5DD7.7050202@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 18:05:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPwRt-0004UK-8V
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 18:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbbBWRFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 12:05:33 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:9481 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbbBWRFc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 12:05:32 -0500
Received: from [172.27.0.114] (unknown [83.142.147.193])
	(Authenticated sender: shill)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id A606D4B0293
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 18:05:16 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:35.0) Gecko/20100101 Firefox/35.0 SeaMonkey/2.32.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264274>

Hello everyone,

Here's the situation:

Back in 2012, we cloned a MIPS repo, which was itself a clone of
a 3.4.2 kernel with ~40 MIPS-specific patches applied.

Then the devs started pushing patches; and once in a while, the
maintainer would "sync" with the mainline kernel. I don't know
what tool he used to sync, but he discarded the original patches
doing so, and git blame now shows him as the author of every
mainline change since the clone.

Now that we are moving to a more recent kernel, I'm trying to
"fix" this situation, i.e. I'd like kernel code to have proper
attribution in git blame, while keeping intact the information
for "internal" commits.

While I'm at it, I want to minimize history by ignoring patches
that are now irrelevant:

1) we don't support MIPS anymore, I want to ignore any internal
change we made in the arch/mips directory

2) for some reason, there was a large amount of create/delete churn
in arch/arm/configs; so I want to ignore our changes, and I'll commit
an acceptable config when the process is complete.

3) ignore some internal platform-specific patches

(NB: All these "ignores" are for internal patches, not mainline patches)

Sooo, using git log and grep, I came up with a list of ~300 patches I'd
like to apply on top of the latest 3.14 kernel. For testing purposes,
I used git format-patch on the oldest of my 300 patches.

I then made a shiny new clone of linux-stable.git, and tried using git am
to apply that patch to the tip of linux-stable, expecting having to solve
a few dozens conflicts, and move on (hoping to automate it at some point).

But 'git am' just gave up. Small sample of errors:

error: patch failed: drivers/block/Kconfig:411
error: drivers/block/Kconfig: patch does not apply
error: drivers/tty/serial/8250/8250.c: does not exist in index
error: patch failed: drivers/tty/serial/8250/8250_early.c:121
error: drivers/tty/serial/8250/8250_early.c: patch does not apply
error: patch failed: drivers/video/Kconfig:101
error: drivers/video/Kconfig: patch does not apply
...
Patch failed at 0001 Commit for supporting Sigma Designs' SoCs.
The copy of the patch that failed is found in:
    .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

How do I "resolve this problem".

I suppose I am doing this the wrong way.
What is the correct way to do it?
(I'm using git 2.3)

Should I use git am -3 in the original repo?

Regards.
