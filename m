From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-upload-pack: the timeout gets corrupted?!
Date: Sat, 10 Mar 2007 21:56:40 -0800
Message-ID: <7vy7m4wcfb.fsf@assigned-by-dhcp.cox.net>
References: <45F35F38.1080206@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 06:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQH3B-0006HU-TR
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 06:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203AbXCKF4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 00:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933204AbXCKF4m
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 00:56:42 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36132 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203AbXCKF4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 00:56:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311055642.JGQC1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 00:56:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZHwh1W0031kojtg0000000; Sun, 11 Mar 2007 00:56:41 -0500
In-Reply-To: <45F35F38.1080206@zytor.com> (H. Peter Anvin's message of "Sat,
	10 Mar 2007 17:45:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41914>

"H. Peter Anvin" <hpa@zytor.com> writes:

> ...  Going in with gdb, it appears the "timeout"
> variable gets overwritten:
>
> (gdb) p timeout
> $1 = 608471321
>
> ... which should have been 600.

I do not see offhand what can cause this.  The only new code
since 1.4.4 series is "shallow clone" stuff,...

> The process spends effectively forever waiting in on the fflush() in
> show_commit() (in upload-pack.c); /proc/*/fd shows it is trying to
> write to a pipe, but I'm not sure what is at the other end of that
> same pipe.

The process forks and the one that runs show_commit() is running
rev-list internally while the other end is a pack-objects that
reads from it and sends its output back to the client.
