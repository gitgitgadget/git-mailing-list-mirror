From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v2 0/4] make open/unlink failures user friendly on
	windows using retry/abort
Date: Sun, 7 Nov 2010 18:06:38 +0100
Message-ID: <20101107170637.GA15123@book.hvoigt.net>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org> <cover.1289139299.git.hvoigt@hvoigt.net> <201011071649.20617.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 07 18:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF8ha-0007UD-M4
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 18:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab0KGRGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 12:06:41 -0500
Received: from darksea.de ([83.133.111.250]:57900 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751232Ab0KGRGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 12:06:40 -0500
Received: (qmail 21833 invoked from network); 7 Nov 2010 18:06:38 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2010 18:06:38 +0100
Content-Disposition: inline
In-Reply-To: <201011071649.20617.j6t@kdbg.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160888>

Hi,

On Sun, Nov 07, 2010 at 04:49:20PM +0100, Johannes Sixt wrote:
> On Sonntag, 7. November 2010, Heiko Voigt wrote:
> > j6t: I have not changed your error code in mingw_rename since you
> > explicitely compare with the windows error code ERROR_ACCESS_DENIED and
> > do not use the err_win_to_posix() function. Did you do this on purpose or
> > should I also refer to ERROR_SHARING_VIOLATION ?
> 
> IIRC, I dumped the error code before I implemented the retry logic, and the 
> error was ERROR_ACCESS_DENIED. Did you verify that the occasions where you 
> want to retry the operations indeed fail due to ERROR_SHARING_VIOLATION, or 
> do you trust the documentation?

I tested this for my use case which is described by the manual testing
script[1]. I ran it once to create the test structure and then from
inside the test repository

	./../block_read 5000 file

and manually checked out the other branch in parallel. In this situation
git will stop with the retry question. But I am not sure which use case you
where addressing. Do you have a script or some information to reproduce?

> In any case, it is better to check for the Windows error code (which ever you 
> finally choose) rather than errno, IMO.

I agree because that should give us more fine grained control and since in
err_win_to_posix() many codes are mapped to EACCES.

Cheers Heiko

[1] http://groups.google.com/group/msysgit/msg/fcad5f1455b263ca 
