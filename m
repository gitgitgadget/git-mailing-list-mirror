From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] lock_ref_sha1_basic does not remove empty directories on BSD
Date: Mon, 02 Oct 2006 21:14:46 -0700
Message-ID: <7vu02mt4qx.fsf@assigned-by-dhcp.cox.net>
References: <20061002172353.G44b12bbc@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 06:15:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUbgB-0005Vz-DV
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 06:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWJCEOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 00:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWJCEOt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 00:14:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:8632 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965082AbWJCEOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 00:14:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003041447.FXCG6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 00:14:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VgEp1V00s1kojtg0000000
	Tue, 03 Oct 2006 00:14:50 -0400
To: Dennis Stosberg <dennis@stosberg.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28244>

Dennis Stosberg <dennis@stosberg.net> writes:

> lock_ref_sha1_basic relies on errno beeing set to EISDIR by the
> call to read() in resolve_ref() to detect directories.  But calling
> read() on a directory under NetBSD returns EPERM, and even succeeds
> for local filesystems on FreeBSD.
>
> Signed-off-by: Dennis Stosberg <dennis@stosberg.net>

Thanks.

I've always wondered about the code that follows where you
patched.  It relies on either open() on a directory to fail, or
read() from a file descriptor to return something other than
what starts with 40-byte hexadecimal (or "ref: blah") to skip
directories.

You might probably meant the patch primarily to fix the leftover
empty directories issue in "next", but it is also the right
thing to do for "master" (and even for "maint"), I think.

I'll apply it to "master" and then merge it into "next".
