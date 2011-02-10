From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Handle rename of case only, for Windows
Date: Thu, 10 Feb 2011 18:58:14 +0000
Message-ID: <4D543546.1030207@ramsay1.demon.co.uk>
References: <1296344717.25999.1417928123@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Tim Abell <tim@timwise.co.uk>
X-From: git-owner@vger.kernel.org Thu Feb 10 20:04:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnboL-0004hu-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 20:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab1BJTEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 14:04:08 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:36827 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752212Ab1BJTEH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 14:04:07 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PnboD-0007iB-WI; Thu, 10 Feb 2011 19:04:05 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1296344717.25999.1417928123@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166492>

[Sorry for the late reply to this... I'm somewhat backed-up!]

Tim Abell wrote:
>>From ddab003ede9f25d93f4e7eea833523a0aa29d16d Mon Sep 17 00:00:00 2001
> From: Tim Abell <tim@timwise.co.uk>
> Date: Thu, 27 Jan 2011 22:53:31 +0000
> Subject: [PATCH] Handle rename of case only, for Windows

This should not work with the MinGW or msvc build, since they *always* set
the st_ino to zero (see do_lstat() and mingw_fstat() in compat/mingw.c).
Also, *with default configuration*, it will also not work on cygwin... so
saying that this works on Windows may be overstating things a bit ... ;-)

[Hmm, I can't check, but it would probably work on Mac OS X ...]

> Added test to show rename failing in windows.

This fails for me. (er... just to be clear, test #30 fails with your patch
applied).

> Added test to show that this patch doesn't break protection against overwriting
> an existing file, and another to show that "mv --force" still works.
> 
> Altered mv.c to check whether the source and destination file are actually
> the same file based on inode number before failing.
> If the inode is zero then the data is no use so old behaviour is maintained.

With default configuration, the st_ino will always be zero on cygwin. (see for
example the "schizophrenic l/stat() functions" commits adbc0b6, 7faee6b and
7974843, along with the "force core.filemode" commit c869753).

So, you must have core.filemode or core.ignorecygwinfstricks set somewhere in
your environment (in the system or global (user) config files?).

[I *always* set core.filemode after git-init or git-clone, so this patch may
actually work for me *in practice* (I haven't tested it), but I may well not
be a typical user...]

>> Hmm, not so good. st_ino is always 0 on Windows, so this would make
>> false positives, no?
> 
> I tested this on windows 7 under cygwin (which is what I have available) and st_ino reports real numbers for me,

Again, you must have non-default configuration set...

ATB,
Ramsay Jones
