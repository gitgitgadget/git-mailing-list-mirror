From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: t3701 fails if core.filemode disabled
Date: Sun, 18 May 2008 20:17:30 -0400
Message-ID: <4830C71A.60308@verizon.net>
References: <20080518152337.GB3058@steel.home>
 <20080518190839.GC15506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 02:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxt5b-0006aa-6C
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 02:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbYESARg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbYESARf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 20:17:35 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:61896 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbYESARf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 20:17:35 -0400
Received: from [192.168.1.117] ([71.126.133.203])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K1300595A579KTC@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 18 May 2008 19:17:31 -0500 (CDT)
In-reply-to: <20080518190839.GC15506@sigill.intra.peff.net>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82402>

Jeff King wrote:
> On Sun, May 18, 2008 at 05:23:37PM +0200, Alex Riesen wrote:
> 
>> This is on Cygwin, yes. I have the core.filemode disabled in
>> ~/.gitconfig. How about stopping the test before the failing portion
>> (only the last two fail, below)?
> 
> What's in your ~/.gitconfig shouldn't have any effect (the test scripts
> take care to avoid looking at anything outside of your git directory).
> But presumably this test is broken on Cygwin, anyway?
> 
On Cygwin, support for correctly interpreting the execute bit is governed by the 
operating system (WindowsNT/XP vs Windows9x), the file system (NTFS vs FAT), and 
the (NO)NTEA and (NO)NTSEC options via the CYGWIN environment variable. So, 
there is no simple answer... By default on WindowsNT/XP and running on NTFS, 
execute modes are supported and the git testsuite currently works.

Some other configurations will not support core.filemode=true, but Cygwin's 
stated goal is to emulate Linux and it does so by default using current common 
configurations. Thus, disabling the tests unconditionally on Cygwin would be wrong.

Perhaps the better path is to skip the tests if "$(uname -o)" = "Cygwin" and 
core.filemode=false, but enable them otherwise, allowing users who know their 
configuration will not support the execute bit to avoid the test failure.

Mark
