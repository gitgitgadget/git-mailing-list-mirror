From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Wed, 01 Feb 2006 12:27:29 -0800
Message-ID: <7vbqxqbz9q.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
	<7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602011528030.28923@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 21:27:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4OZq-0004X6-6P
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWBAU1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWBAU1c
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:27:32 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:20950 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161113AbWBAU1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 15:27:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201202503.EXLG26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 15:25:03 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15441>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Worse, you cannot pull from older servers into shallow repos.
>> 
>> "have X" means different thing if you do not have matching
>> grafts information, so I suspect that is fundamentally
>> unsolvable.
>
> If the shallow-capable client could realize that the server is not 
> shallow-capable *and* the local repo is shallow, and refuse to operate 
> (unless called with "-f", in which case the result may or may not be a 
> broken repo, which has to be fixed up manually by copying 
> over ORIG_HEAD to HEAD).

"If ... refuse to operate" then?  If "Then that is OK" is what
you meant to say I agree (I meant to code the client code that
way but I started only with the initial clone).  I said
"fundamentally unsolvable" because I thought you wanted it to do
something sensible without refusing even in such a case.

> Of course, the client has to know that the local repo is shallow, which it 
> must not determine by looking at the grafts file.

Sorry, I fail to understand this requirement.  Why is it "it must not"?

> If you introduce a different "have X" -- like "have-no-parent X" -- and 
> teach git-rev-list that "~A" means "traverse the tree of A, but not A's 
> parents", you'd basically have everything you need, right?

If you have such a modified rev-list, yes.  I was having doubts
about keeping an obvious correctness guarantee when doing such
"rev-list ~A".

> Yes, I agree. But again, the local repo has to know which grafts were 
> introduced by making the repo shallow.

I am not sure I understand.  grafts are grafts are grafts.  If
the other side has grafts to connect otherwise unrelated commit
objects, I suspect the cloner needs to know about them, all of
them, in order to use the resulting clone.  Also the upstream
side would need to know the altered world view the cloner has to
adjust the commit ancestry graph, at least during the cloning
and fetching, and I do not think it should be limited only to
cauterizign entries created by earlier shallow clone operations.
Manually created cauterizing entries should also count (for that
matter, grafts to stitch unrelated lines together), No?
