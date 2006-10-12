From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: [RFC] separate .git from working directory
Date: Thu, 12 Oct 2006 14:15:02 +0200
Organization: University of Bologna
Message-ID: <200610121415.03086.scallegari@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 12 14:16:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXzTO-00020P-K4
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 14:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWJLMPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 08:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWJLMPe
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 08:15:34 -0400
Received: from arces.unibo.it ([137.204.143.6]:10885 "EHLO arces.unibo.it")
	by vger.kernel.org with ESMTP id S1751354AbWJLMPd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 08:15:33 -0400
Received: from [192.168.143.223] (mars-fw.arces.unibo.it [137.204.143.2])
	by arces.unibo.it (8.13.7/8.13.7) with ESMTP id k9CCFYoR019264
	for <git@vger.kernel.org>; Thu, 12 Oct 2006 14:15:34 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
X-Spam-Status: No, score=-98.0 required=5.5 tests=BAYES_80,USER_IN_WHITELIST 
	autolearn=no version=3.1.3-gr0
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on 
	mail.arces.unibo.it
X-Virus-Scanned: ClamAV 0.88.4/2026/Thu Oct 12 08:47:06 2006 on arces.unibo.it
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28776>

Possibly a bit different from the RFC, however,

Other than making find happy, I see other potential advantages in supporting 
the two options of having .git be either

- a directory containing all the git stuff
- a single file with a pointer to the real directory containing the objects, 
references, branches, etc.

1) It might make the life easier on platforms where symlinks are not the 
easiest thing to do (are there any?)

2) it might make it easier to work with syncronization tools (some of you 
might know that I got burnt with them recently). One of the issues of 
syncronizatoin tools is that they typically recognize renames as the 
non-atomical sequence of creation+deletion. Hence imagine the following 
scenario. I have ProjectFoo with the .git dir in. I tell the syncronization 
tool to ignore things called .git (not to get burned again!). I decide to 
rename ProjectFoo into ProjectBar. When I sync, I get with a ProjectBar with 
no .git directory since .git was meant to be ignored and is consequently lost 
in the creation+deletion sequence. All objects are then lost at one of the 
two hosts participating in the syncronization. If .git was only a file with a 
pointer, it would at least be possible to recreate it by hand without 
depending on the other syncronization host.

3) it might make it possible to have all the git archives in a single place, 
where it is easy to program a script to scan all the archives and repack all 
of them periodically or to scan all of them and backup them periodically, 
etc.

Sergio
