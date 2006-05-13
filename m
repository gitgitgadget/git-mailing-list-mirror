From: Junio C Hamano <junkio@cox.net>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sat, 13 May 2006 14:22:41 -0700
Message-ID: <7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<7vzmhlsksm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 23:22:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff1ZX-0002q0-Ph
	for gcvg-git@gmane.org; Sat, 13 May 2006 23:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWEMVWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWEMVWn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 17:22:43 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47048 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751348AbWEMVWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 17:22:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060513212242.XIBX18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 17:22:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605131404391.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 13 May 2006 14:05:33 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19949>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 13 May 2006, Junio C Hamano wrote:
>>
>> Linus Torvalds <torvalds@osdl.org> writes:
>> 
>> > [ Maybe this can still hit 1.3.3? ]
>> 
>> Ah, we did not pass the diffopt to the function builtin_diff() in
>> 1.3.X series, so not really.
>
> Ahh, ok. Never mind. It's not like people have been clamoring for it, it 
> just seemed to be such a _silly_ thing.
>
> Might as well just go into the curren development tree, and then we'll 
> have it fixed eventually (1.4.0?)

No question about that part.  I've been meaning to start drawing
the line of what to have in 1.4 and what to leave out, but the
last week was shot so I haven't got around to.

A rough outline.

I'd like to have the following topics from "next":

 * cvsserver and cvsexportcommit updates (ml/cvs)

   Ready.

 * config syntax (lt/config)

   Ready.

 * built-in grep (jc/grep)

   Ready.

 * built-in format-patch (js/fmt-patch)

   Some features are still missing compared to the script
   version.

 * remotes/ information from .git/config (js/fetchconfig)

   This by itself is more or less ready, but I would like to
   further adjust it to the "per branch configuration"
   discussion before pushing it out.

   I'd like to eventually arrange things like this.

   [branch "master"]
	remote = "ko-private"
	; prevent "reset --hard" from rewinding past this.
        rewind-barrier = refs/heads/ko-master

   ; my private build areas on the kernel.org machines
   [remote "ko-private"]
   	url = "x86-64-build.kernel.org:git"
   	url = "i386-build.kernel.org:git"
        push = master:origin
        push = next:next
        push = +pu:pu
        push = maint:maint

   ; for publishing and keeping track of what I pushed there last time
   [remote "ko"]
   	url = "kernel.org:/pub/scm/git/git.git"
        push = master:master
        push = next:next
        push = +pu:pu
        push = maint:maint
	fetch = master:ko-master
	fetch = next:ko-next
        fetch = +pu:ko-pu
        fetch = maint:ko-maint
