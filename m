From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] pager: do not fork a pager if environment variable PAGER is set to NONE
Date: Sat, 15 Apr 2006 19:20:47 -0700
Message-ID: <7v4q0udzwg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604151516150.6563@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwtdqef6u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0604160357460.31461@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 04:21:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUwsq-0002iG-MB
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 04:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWDPCUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 22:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDPCUt
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 22:20:49 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29916 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932131AbWDPCUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 22:20:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060416022048.HWTK815.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 22:20:48 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604160357460.31461@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 16 Apr 2006 04:01:30 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18772>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 15 Apr 2006, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > This helps debugging tremendously.
>> >
>> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> 
>> I like what this wants to do.  I am not so sure PAGER=NONE is a
>> good convention, however.
>
> I am sure it is not.
>
> One solution would be to introduce yet another command line option 
> "--no-pager", but I find that ugly.
>
> Another solution would be to check if the environment variable NO_PAGER is 
> set.
>
> Wishes?

Honestly, undecided.  Not that I think people would do
PAGER=NONE to mean a program /usr/bin/NONE.

Right now, the following does not say anything:

	$ PAGER= git log

but I do not think that is a reasonably behaviour, either.  So
detecting PAGER is set to an empty string (not "nonexistence" -
the current behaviour of defaulting to "less" in such a case is
reasonable) is probably a better alternative.

A somewhat related topic; I often set PAGER=cat when I do not
want the --[More]-- prompt and I thing many Emacs users do this.
It might also be good to detect it and omit piping in such a
case, but that is independent, so if you are going to do this as
well, please make it a separate patch.
