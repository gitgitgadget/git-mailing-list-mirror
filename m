From: Junio C Hamano <junkio@cox.net>
Subject: Re: recur status on linux-2.6
Date: Tue, 22 Aug 2006 01:27:55 -0700
Message-ID: <7virklp438.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060819104630.GA5213@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Aug 22 10:28:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFRc8-0000cg-Gj
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 10:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWHVI15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 04:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWHVI15
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 04:27:57 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62638 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751109AbWHVI15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 04:27:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822082756.PVAJ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 04:27:56 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25839>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> On Sun, Aug 13, 2006 at 03:54:19PM +0200, Johannes Schindelin wrote:
>> Hi,
>> 
>> I tested git-merge-recur vs. git-merge-recursive on the linux-2.6 
>> repository last night. It contains 2298 two-head merges. _All_ of them 
>> come out identically with -recur as compared to -recursive (looking at 
>> the resulting index only).
>
> After the latest updates to git-merge-recur it passes all the tests I
> have too.
>  
>> That was the good news. The bad news is: it _seems_, that -recur is only 
>> about 6x faster than -recursive, not 10x, and this number becomes smaller, 
>> the longer the merge takes. So I see a startup effect here, probably.
>
> That is a quite nice improvement anyway :)

Maybe we should welcome Linus back with a surprise change that
makes recur take over recursive ;-).

Well, maybe not *that* fast.

Here is what I have in mind.

 * Not in too distant future, like this weekend, we would:

   - remove "TEST" at toplevel;

   - merge the C merge-recur work in "master".

   At this stage, people still have to ask for "recur" by either
   explicitly saying "-s recur" or by exporting the environment
   variable GIT_USE_RECUR_FOR_RECURSIVE=YesPlease; git
   developers are encouraged to use this while running tests and
   production.

 * Before stabilization for 1.4.3, we would:

   - rename merge-recursive to merge-recursive-old and
     merge-recur to merge-recursive.

   - we remove GIT_USE_RECUR_FOR_RECURSIVE hack.

   - we make --no-python in t/ directory no-op and only test C
     recursive implementation by default.

   After this, people who would want to keep using the original
   recursive have to ask for it by "-s recursive-old".

 * We release 1.4.3 with C recursive as the default merge
   strategy.

I am not at this moment thinking about removing recursive in
Python altogether.  We still have a few contrib scripts
(p4import and gitview) that are in Python, so doing that would
not remove our dependency on Python anyway.
