From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Sun, 10 Sep 2006 13:31:15 -0700
Message-ID: <7vr6yjqx9o.fsf@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
	<cda58cb80609101215h36b0f7d7m990ed3011cfda9d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 22:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMVwx-0008QT-Et
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 22:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWIJUaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 16:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWIJUae
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 16:30:34 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19871 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964886AbWIJUad (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 16:30:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910203033.QLVJ12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 10 Sep 2006 16:30:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LkWP1V00G1kojtg0000000
	Sun, 10 Sep 2006 16:30:24 -0400
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609101215h36b0f7d7m990ed3011cfda9d2@mail.gmail.com>
	(Franck Bui-Huu's message of "Sun, 10 Sep 2006 21:15:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26815>

"Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:

> We could use a new service flag to ask daemon.c to start the service
> with the sideband multiplexer process already setup and plugged with
> the sercive is going to start ? Hence others future services could use
> it.

We do not know how "future services" would look like, so I do
not think it is worth doing so at this moment.

Refactoring existing code after the requirements of the second
and subsequent users are identified would result in much nicer
outcome with less effort, just like I showed here with the two
patches, than overengineering things in advance without knowing
what those requirements are to be generic enough.

For example, moving that code to reusable piece (to daemon.c or
elsewhere -- it does not make a difference) does not even help a
similar code that already exists in upload-pack.c, which needs
to monitor multiple processes involved in a pipe and report
failure exit of any of them.  We would definitely want to have
something that can cover both of these existing cases when the
next user comes along, and if that next user fits in one of the
patterns (either have a pipeline with multiple processes like
upload-pack.c does and has to monitor all of them, or just one
process which is essentially an internal subroutine call and has
to monitor only that process) then refactoring this part right
now to cover both cases would make sense but we do not know what
that next user will look like.
