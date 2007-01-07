From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default "tar" umask..
Date: Sun, 07 Jan 2007 13:28:30 -0800
Message-ID: <7v8xge1q81.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612301037570.4473@woody.osdl.org>
	<7vfyaxjiaj.fsf@assigned-by-dhcp.cox.net>
	<459EB78B.60000@lsrfire.ath.cx>
	<7vzm8xdw3t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701051336000.3661@woody.osdl.org>
	<7vmz4xdssh.fsf@assigned-by-dhcp.cox.net>
	<m3irfizwvv.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 22:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3fZD-0005UQ-4e
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 22:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbXAGV2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 16:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbXAGV2d
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 16:28:33 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34973 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965198AbXAGV2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 16:28:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107212831.IHUV20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 16:28:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8MTh1W00Z1kojtg0000000; Sun, 07 Jan 2007 16:27:42 -0500
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m3irfizwvv.fsf@defiant.localdomain> (Krzysztof Halasa's message
	of "Sun, 07 Jan 2007 16:20:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36199>

Krzysztof Halasa <khc@pm.waw.pl> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> If the archive is made with 022, that would
>> break expectation of users whose umask is 002 (a sane value in
>> modern "own" group setups).
>
> What exactly do they expect from 002? That root group will be able
> to write to the files?

It is more like "no suspicious individual would not be able to
write to them".  You could always tell tar to honor your umask
while extracting as root and have 022 or a tighter umask if you
have somebody untrustworthy in your 'root' group.

And in mordern setup, umask 002 makes tons of sense.  My primary
group is 'junio' in modern setup, but I belong to secondary
groups like 'git' and 'mix' that are shared with other people
who work on 'git' and 'mix' projects.  umask 002 is the natural
thing to use from log-in and never change.

My home directory is owned by junio.junio and has mode 2775.
Only I can create a new file or a directory there, and result of
doing so is owned by junio.junio and has 0664 or 0775 which
means only I can write to it.

A directory used by 'git' project is owned by <somebody>.git
where that <somebody> is from the git group and has mode 2775.
Only the project members of 'git', who shared the 'git' group
with me, can create a new file or a directory there, and result
of doing so is owned by <user>.git where <user> is the project
member who is doing so, and has 0664 or 0775 which means only
the project members of 'git' can write to it.
