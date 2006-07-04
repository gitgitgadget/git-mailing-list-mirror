From: Junio C Hamano <junkio@cox.net>
Subject: Re: qgit idea: interface for cherry-picking
Date: Mon, 03 Jul 2006 23:41:38 -0700
Message-ID: <7vk66tna71.fsf@assigned-by-dhcp.cox.net>
References: <e8954u$srh$1@sea.gmane.org>
	<e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
	<e89eqj$npu$1@sea.gmane.org>
	<e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	<e89iql$42a$1@sea.gmane.org>
	<e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	<7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
	<7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 08:41:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxebQ-0003dy-P6
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 08:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWGDGll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 02:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWGDGll
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 02:41:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2485 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbWGDGll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 02:41:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704064139.OVWW18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 02:41:39 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com>
	(Marco Costalba's message of "Tue, 4 Jul 2006 08:22:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23258>

"Marco Costalba" <mcostalba@gmail.com> writes:

>> The main question is what you would let your users do and how
>> you would guide them through the process, when the application
>> of an earlier patch in the series fails.  I think it is a
>> secondary implementation detail which of "git-am", "git-am
>> --fail" or "git-apply" to implement that process.
>
> QGit is not supposed to be a GUI replacement of git UI. QGit only let
> users quickly call some commonly used commands. The process of error
> recovering, conflicts resolve and any other complication that could
> involve more the one main flow of processing are outside the scope.
> QGit simply leaves the job to native git tools any time there
> something 'outside tha main flow'.

Yes, either you (1) need to make sure the user is aware what
underlying git commands QGit runs for them, so that the user
knows what workflow to follow when the procedure needs to go
manual, or (2) hide the underlying git commands QGit runs for
users, but then you need to make QGit aware of what workflow to
follow when the procedure needs to go manual, and guide the user
through that workflow.  I think either is fine approach;
personally I prefer transparent tools that does (1), which is
the impression I am getting from your description of QGit.

If you take route (1), using "am --fail" number of times
involves QGit runs "am --fail" once, guide user to fix things up
_and_ give control back to QGit, then you run the next "am
--fail", etc, which would be quite cumbersome to implement.  But
running multiple am and do reset soft to roll back needed number
of parents might be easier option to implement in QGit, but you
still have the same "you give the control to the user but then
you have to take the control away to proceed" problem when the
patch does not apply cleanly somewhere (you let the user to hand
resolve and say "am --resolved", but then when the series is
depleted, somebody has to run "reset --soft" to roll N commits
back to realize what you wanted to do, so at that point QGit
somehow needs to take control back).
