From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange output of git-diff-tree
Date: Wed, 09 Aug 2006 11:24:24 -0700
Message-ID: <7vfyg54vjb.fsf@assigned-by-dhcp.cox.net>
References: <ebcnml$btf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 20:24:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAsjG-0004Ep-Aq
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 20:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWHISY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 14:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHISY0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 14:24:26 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29343 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751278AbWHISY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 14:24:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809182425.UVTH29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 14:24:25 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebcnml$btf$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	09 Aug 2006 15:24:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25131>

Jakub Narebski <jnareb@gmail.com> writes:

> First (noticed by matled) is that for git-diff-tree with single tree
> as an argument it outputs fist commit-id of commit given at input. 
> It is not mentioned in documentation and I think totally unnecessary:
>
> 1038:jnareb@roke:~/git> git diff-tree --abbrev origin
> d5dc6a76d49367cddc015e01d2e9aa22e64d7e28
> :040000 040000 44fb36d... 1c26294... M  Documentation

Working as specified as in the original version.  See
core-tutorial and look for "git-diff-tree -p HEAD".

> Second, for some combination of options for it returns "..." instead of
> 0{40} for file creation.

Well spotted.  The minimum reproduction recipe is:

     $ git diff-tree --find-copies-harder 2ad9331

Will look into it.

> Third, while it detects that gitweb/gitweb.perl was renamed from 
> gitweb/gitweb.cgi:
>   [...]  R100   gitweb/gitweb.cgi       gitweb/gitweb.perl
> it does not notice that gitweb/gitweb.cgi was gitweb.cgi in 
> 1130ef362fc8d9c3422c23f5d5a833e93d3f5c13.

Depends on how you ask.

git diff-tree --abbrev --pretty -m -M -r --diff-filter=R 0a8f4f00

or

git diff-tree --abbrev --pretty -c -M -r 0a8f4f00
