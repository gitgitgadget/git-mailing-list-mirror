From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] cleanups: Fix resource leak and buffer overrun in daemon.c
Date: Tue, 18 Apr 2006 12:32:12 -0700
Message-ID: <7vzmiiel37.fsf@assigned-by-dhcp.cox.net>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
	<20060417151447.D4FE619B90E@sergelap.hallyn.com>
	<7vu08rkhey.fsf@assigned-by-dhcp.cox.net>
	<20060418131106.GD7562@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 21:32:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVvwG-0007TS-Uf
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 21:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWDRTcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWDRTcP
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 15:32:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30891 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932282AbWDRTcN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 15:32:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418193213.MLIU24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 15:32:13 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <20060418131106.GD7562@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Tue, 18 Apr 2006 08:11:06 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18874>

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Argh, I had to pull out a sheet of paper, but you are right.  I
> misread, and the warning must be about the case where the
> snprint "[%ld] " prints out 1023 characters.

If snprintf(buf, sizeof(buf), "[%ld] ", (long) getpid()) is
judged to possibly overrun the buffer by your static analysis
tool, I think the tool is broken.  It at least should know how
big a printed long can be.  It would earn bonus points if it can
warn me when sizeof(buf) is sufficiently small, say 40 bytes,
with a message like "on future architectures with 128-bit long
this code might break" ;-).
