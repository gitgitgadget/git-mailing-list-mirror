From: Petr Baudis <pasky@suse.cz>
Subject: Re: merge-one-file: use common as base, instead of emptiness.
Date: Thu, 10 Nov 2005 20:43:17 +0100
Message-ID: <20051110194317.GV30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108095600.GA1431@pasky.or.cz> <7v64r16ro9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:43:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIKS-0001zK-1V
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVKJTnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVKJTnV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:43:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:13227 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751201AbVKJTnU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:43:20 -0500
Received: (qmail 23559 invoked by uid 2001); 10 Nov 2005 20:43:17 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64r16ro9.fsf_-_@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11512>

Dear diary, on Thu, Nov 10, 2005 at 05:41:10AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > I think having
> >
> > 	<<<<<
> > 	file1
> > 	=====
> > 	file2
> > 	>>>>>
> >
> > is an awful PITA to resolve, especially when the files actually are
> > similar. Running some vimdiff (or just diff and possibly applying either
> > way) on two separate files is much more convenient.
> 
> You are right.
> 
> How about something like this?  This adds a specialized hackery
> flag, --no-add, to git-apply, and uses it to compute common base
> to be used for 2-file merge, instead of using /dev/null.

Wow, astonishingly simple.

>  -- >8 -- cut here -- >8 --
> Unlike the previous round that merged the path added differently
> in each branches using emptiness as the base, compute a common
> version and use it as input to 'merge' program.
> 
> This would show the resulting (still conflicting) file left in
> the working tree as:
> 
> 	common file contents...
> 	<<<<<< FILENAME
> 	version from our branch...
> 	======
> 	version from their branch...
> 	>>>>>> .merge_file_XXXXXX
> 	more common file contents...
> 
> when both sides added similar contents.

But obviously now the trouble is opposite, when the files are completely
unrelated, since now you likely get large conflicting areas interleaved
with some scarce common lines... And this might get to be a big PITA to
resolve as well.

That said, I still really like --no-add and it would be heart-wrenching
to just coldly dismiss it. It is a great tool, but I would let the user
to use it manually. Possibly something like

	git-twofile-merge foo~1 foo~2

(the name is stupid, obviously) or a button in some GUI tool.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
