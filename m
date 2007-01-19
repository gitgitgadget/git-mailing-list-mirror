From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Fri, 19 Jan 2007 11:56:47 -0800
Message-ID: <7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45AF5F83.6090207@fs.ei.tum.de>
	<Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 20:57:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zr3-0005jm-0C
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbXAST4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 14:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932868AbXAST4t
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:56:49 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33203 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932864AbXAST4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 14:56:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119195648.IKCH25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 14:56:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D7x51W0061kojtg0000000; Fri, 19 Jan 2007 14:57:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 18 Jan 2007 14:57:15 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37199>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:
>
>> Johannes Schindelin wrote:
>> > On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:
>> > 
>> > >  for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
>> > > -			| @@PERL@@ -e 'print reverse <>'`
>> > > +			| sed -ne '1!G;$p;h'`
>> > 
>> > Why not teach the revision machinery to output in reverse with "--reverse"?
>> 
>> I'm more in favour of "small is beautiful".  Also from looking at the code,
>> this seems to be a bit complicated.
>
> I'm more in favour of "less shell dependecy is beautiful". And from what I 
> can tell, it should be relatively easy:
>
> ---
>
> 	14 insertions and 11 deletions stem from moving (and extern'ing) 
> 	reverse_commit_list() from merge-recursive.c to commit.c
>
> 	So the change is actually 9 insertions and one deletion.

I think this is sane but I hate to having to worry about
possible fallouts from giving --reverse in setup_revisions() to
make it available to everybody.  E.g. things like "what happens
when you say "git format-patch --reverse HEAD~3".

Nevertheless, moving reverse_commit_list out of merge-recursive
is a good clean-up.
