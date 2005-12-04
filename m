From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-update-server-info crashes on hera.kernel.org:/pub/scm/libs/klibc/klibc.git
Date: Sat, 03 Dec 2005 23:00:25 -0800
Message-ID: <7v64q5tkhi.fsf@assigned-by-dhcp.cox.net>
References: <43921DAE.7060606@zytor.com>
	<7vzmnhtmi1.fsf@assigned-by-dhcp.cox.net> <43928C39.8050105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 08:01:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EinrT-0001Xy-Kr
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 08:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVLDHA2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 02:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVLDHA1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 02:00:27 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1158 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751320AbVLDHA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 02:00:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204065954.PWOI3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 01:59:54 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13183>

"H. Peter Anvin" <hpa@zytor.com> writes:

> FWIW, I invoked this as:
>
> hpa@hera:~(0)$ GIT_DIR=/pub/scm/libs/klibc/klibc.git git-update-server-info
> Segmentation fault

Trusting that I *won't* be able to write into that repository, I
tried to run that and after getting an error ("cannot update
info/refs file", which I wanted to see) I seem to be getting the
same segfault.  GDB session reveals the binary is heavily
optimized or inlined, so it is hard to see what it is doing
though.

But there is one thing that is mysterious about your repository,
and by mirroring that peculiarity with the copy in my home
directory, I managed to reproduce the problem with my copy.  Why
does the objects/info/alternates in that repository point at
itself?  I suspect if you remove that file you will be OK.

update-server-info simply dying, instead of complaining about
it, is a bug nevertheless, and removal of the
unnecessary/possibly wrong alternate is only a workaround, but I
hope that would unblock you in the meantime..
