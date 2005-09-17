From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree
	into another rather than two trees into merge base
Date: Sat, 17 Sep 2005 10:31:57 +0100
Message-ID: <1126949517.6941.19.camel@localhost.localdomain>
References: <200509102027.28812.blaisorblade@yahoo.it>
	 <1126427087.8457.33.camel@localhost.localdomain>
	 <200509142019.04667.blaisorblade@yahoo.it> <tnxslw6d4qt.fsf@arm.com>
	 <7vvf10hji1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 11:33:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGZ3G-0005qq-31
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 11:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVIQJcD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 05:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVIQJcC
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 05:32:02 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:16724 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751013AbVIQJcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 05:32:00 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050917093159.THAQ10357.mta08-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Sat, 17 Sep 2005 10:31:59 +0100
Received: from cpc3-cmbg5-3-0-cust65.cmbg.cable.ntl.com ([81.104.194.65])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050917093159.LRLE13031.aamta09-winn.ispmail.ntl.com@cpc3-cmbg5-3-0-cust65.cmbg.cable.ntl.com>;
          Sat, 17 Sep 2005 10:31:59 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf10hji1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8762>

On Fri, 2005-09-16 at 12:59 -0700, Junio C Hamano wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
> 
> > git-read-tree -m doesn't handle the case when a file is removed from
> > one branch and unmodified in the other, which is what happens in your
> > test. For each of these removed files, git-merge-cache will call
> > gitmergeonefile.py which calls 'git-update-cache --remove'.
> >
> > An improvement would be to make git-read-tree smarter...
> 
> I think this was once discussed but the primary reason for the
> behaviour is that Linus wanted to leave as much merge policy
> decision to be scriptable without hardcoding it in read-tree.

This could be OK for git-read-tree but maybe git-merge-index could have
a --smart option to deal with trivial cases like below (or a separate
tool). Whoever wants to write a more interactive script would not pass
this option.

> If you always do "added or removed in only one head
> means take that head", most likely in the above example B would
> not have a new path (rename target of A) so you would end up
> always taking the file rename.

That's what happens with the current merge scripts.

Another option for me would be to try to interface Python with libgit.a
and emulate the git-merge-index behaviour but I've never tried mixing
Python and C before.

> A completely different topic:  would it please people if I did this?
> 
>     $ git-diff-tree -r --names-and-changes A B
>     M	frotz
>     R93	rezrov	nitfol
>     D	yomin

It might help for people using git directly (me as well). StGIT parses
the git-diff-tree output anyway.

-- 
Catalin
