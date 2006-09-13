From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] connect.c: finish_connect(): allow null pid parameter
Date: Tue, 12 Sep 2006 21:48:28 -0700
Message-ID: <7vd5a0bcdf.fsf@assigned-by-dhcp.cox.net>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
	<45053BA2.6050502@innova-card.com>
	<7vzmd5eedk.fsf@assigned-by-dhcp.cox.net>
	<45066CFD.5040202@innova-card.com> <450673B7.8050704@innova-card.com>
	<4506771D.9040605@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 06:48:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNMfu-0004YC-9O
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 06:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWIMEsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 00:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWIMEsb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 00:48:31 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57540 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751540AbWIMEsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 00:48:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913044829.XUHX18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 00:48:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MgoJ1V00v1kojtg0000000
	Wed, 13 Sep 2006 00:48:19 -0400
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <4506771D.9040605@innova-card.com> (Franck Bui-Huu's message of
	"Tue, 12 Sep 2006 11:00:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26899>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> git_connect() can return 0 if we use git protocol for example.
> Users of this function don't know and don't care if a process
> had been created or not, and to avoid them to check it before
> calling finish_connect() this patch allows finish_connect() to
> take a null pid. And in that case return 0.
>
> Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
> ---
>
>  Found it when debugging 'git archive --remote=git://...'
>  command. I noticed that this command always exited with 1 as
>  status.

True.  This should affect existing users of finish_connect(), but
existing callers do not check its return value X-<.

I think the return type of git_connect() should be changed to
pid_t with a warning that says it returns negative on error, pid
of a process finish_connect() should wait for if the underlying
protocol driver forks, and 0 if we do not have to wait in
finish_connect().  Making finish_connect() to accept 0 as its
input is probably a good change.
