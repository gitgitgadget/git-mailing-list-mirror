From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010 Update] Please try the initial version of the line level 
	history browser
Date: Fri, 18 Jun 2010 00:05:10 +0800
Message-ID: <AANLkTimRGZziLnffQXmzYnNhhE3dE_5Hsp1mxAEmBiIk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 18:05:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPHai-00058d-FD
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 18:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760273Ab0FQQFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 12:05:13 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:65385 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab0FQQFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 12:05:11 -0400
Received: by pxi12 with SMTP id 12so40226pxi.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=13MHt598k/WVv4k6BWDQMTrrAQMA1fPITZYsyJTudFw=;
        b=PHftw/oEKeUKZRHZMTAmFFjuGwg3PXdxx5CmAD6uOzc9y0ldy+o0Kx0WAYUAF8XNnZ
         x4VV6z8P0l0WJZqN4gXVYNRvwE7Yk6oRf/l9qU3sQuJkuEVqjh+AKs0Tnov9OyUg9GHa
         oEzB5Joddq7Bj6SQ3nS+bM1XT9A22M1LitfTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=EbKVmyELObgvQQ0/KWUz5ri+XY5nI0G/qashGd6JW4yZ7DO8KVNMkTUcYuDn22sgKk
         5H6fTNGrPoDPsTITnwwvSx2oBiWKYMaS9VCL66B6Ts9k0b2Lh2aOG+DfwW3RORhzGAa+
         lngS7IRCOyCGxm4dD/1uNLDpRlZ9Ye7PG30Yo=
Received: by 10.229.187.82 with SMTP id cv18mr4785526qcb.83.1276790710156; 
	Thu, 17 Jun 2010 09:05:10 -0700 (PDT)
Received: by 10.229.98.70 with HTTP; Thu, 17 Jun 2010 09:05:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149316>

Hi all,

    After 3 weeks of heavy development, I have finally made up a
usable version of line level history browser. Thomas and I have try
some use cases with it indeed generate useful output for us. :) So, I
think it is a good chance to let all of the ones who is interested in
this feature have a try with it, and please give me any advice if any.

    Generally, the code is located at:

ssh://repo.or.cz/srv/git/line.git   phrase2

Yes, this is a tag on 'diff-range' branch, all development is on this
branch and phrase1/phrase2 are tags used for 'public testing' version.
:)

For the feature itself, it supports a command line syntax:  git-log
log [rev] -L <s>,<e> -L <s>,<e> <file1> -L <s>,<e> file2. And the
multiple ranges case is not fully tested, but mostly works well.

Here are some interesting cases we have run until now. Generally, the
line level history will show users the complete change story of any
line range.
I usually use it for two purpose:
1. Understand code. Many times, when I want to read/modify some lines
of code, the first thing is to try to find out whether my changes has
been considered by other ones. And viewing the whole history of just
these lines( the function contain these lines) is necessary, so ./git
log -L /try_to_find_renames/,/^}/ tree-diff.c and "git log -L '/int
rev_compare_tree/,/^}/' revision.c" helps. :)
2. Find out some code I have delete. :) yes, sometimes, after some
commits, I find the 3 lines deleted the day before yerstoday may be
better than current one. But I really forget what they exactly are
except I know they have appeared in which function. So, run the line
log to find it like. ./git log -L '/void map_lines/,/^}/' line.c to
find it.

And Thomas give some other interesting usecases.
1. Use  "git log -L /common_prefix/,/^}/ dir.c" to replace a series
'git blame; git show' to find what whether the function is buggy.
2. Try 'git log be58e70^ -L /builtin_funcname_pattern/,/^}/ diff.c',
the line level browser will report the 'nontrivial merges' touch the
interesting lines.

So, come on everybody, try it in your way, and tell me your advice,
thanks a lot!


Finally, below are the change summary:
 Makefile        |    2 +
 builtin/log.c   |  125 ++++++-
 diff.c          |    6 +-
 diff.h          |   22 +
 diffcore.h      |    3 +
 line.c          | 1210 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h          |  120 ++++++
 parse-options.c |   24 +-
 parse-options.h |    5 +
 revision.c      |   16 +-
 revision.h      |   12 +-
 11 files changed, 1534 insertions(+), 11 deletions(-)


And finally, my future plans are:
1. Fix some memory leaks of this verion.
2. Collect advice of this version and improve it.
3. Start to prepare this version to list and submit patches.

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
