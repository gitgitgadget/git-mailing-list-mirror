From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 16:40:36 +0200
Message-ID: <200610201640.36640.jnareb@gmail.com>
References: <200610180246.18758.jnareb@gmail.com> <45382120.9060702@utoronto.ca> <20061020141222.GA17497@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:41:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GavYI-0001cV-6V
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946261AbWJTOki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946361AbWJTOki
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:40:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:2188 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946265AbWJTOkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 10:40:36 -0400
Received: by ug-out-1314.google.com with SMTP id z34so637366ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 07:40:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VxRllB/VL/xzvyNsM7+BetU6gNIdJFIO2lA7q0+KodPENrizf4LwLpzHryKcPEmp3eTU7TWaQsfim2d3j//raztorvlmvXwBgaC0PbPr3eKjcLGPz0Ge9+j96wncDzxYIuD7hGgM3LMdQxctn8j+jwBgcNXnX6S8Cdt2VqCy2Jg=
Received: by 10.67.89.5 with SMTP id r5mr1998181ugl;
        Fri, 20 Oct 2006 07:40:33 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id z40sm1259814ugc.2006.10.20.07.40.32;
        Fri, 20 Oct 2006 07:40:32 -0700 (PDT)
To: Jeff King <peff@peff.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061020141222.GA17497@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29478>

Jeff King wrote:
> On Thu, Oct 19, 2006 at 09:06:40PM -0400, Aaron Bentley wrote:
> 
>> What's nice is being able see the revno 753 and knowing that "diff -r
>> 752..753" will show the changes it introduced.  Checking the revo on a
>> branch mirror and knowing how out-of-date it is.
> 
> I was accustomed to doing such things in CVS, but I find the git way
> much more pleasant, since I don't have to do any arithmetic:
>   diff d8a60^..d8a60

By the way "diff d8a60" also works (unless d8a60 is merge commit, in
which case you would need "diff -c d8a60" or "diff -m d8a60").

> (Yes, I am capable of performing subtraction in my head, but I find that
> a "parent-of" operator matches my cognitive model better, especially
> when you get into things like d8a60^2~3).
> 
> Does bzr have a similar shorthand for mentioning relative commits?

By the way, git has the following extended SHA1 syntax for <commit-ish>
(documented in git-rev-parse(1)):
 * full SHA1 (40-chars hexadecimal string) or abbreviation unique for
   repository
 * symbolic ref name. E.g. 'master' typically means commit object referenced
   by $GIT_DIR/refs/heads/master; 'v1.4.1' means commit object referenced
   [indirectly] by $GIT_DIR/refs/tags/v1.4.1. You can say 'heads/master'
   and 'tags/master' if you have both head (branch) and tag named 'master',
   but don't do that. HEAD means current branch (and is usually default).
 * <ref>@{<date>} or <ref>@{<n>} to specify value of <ref> (usually branch)
   at given point of time, or n changes to ref back. Available only if you
   have reflog for given ref.
 * <commit-ish>^<n> means n-th parent of given revision. <commit-ish>^0
   means commit itself. <commit-ish>^ is a shortcut for <commit-ish>^1.
   <commit-ish>~<n> is shortcut for <commit-ish>^^..^ with n*'^', for
   example rev~3 is equivalent to rev^^^, which in turn is equivalent
   to rev^1^1^1

Additionally it has following undocumented extended SHA1 syntax to refer
to trees (directories) and blobs (file contents)
 * <revision>:<filename> gives SHA1 of tree or blob at given revision
 * :<stage>:<filename> (I think for blobs only) gives SHA1 for different
   versions of file during unresolved merge conflict.

I'm not enumerating here all the ways to specify part of DAG of history,
except that it includes "A ^B" meaning "all from A", "exclude all from B",
"B..A" meaning "^B A", "A...B" meaning "A B --not $(git merge-base A B)",
and of course "A -- path" meaning "all from A", "limit to changes in path".

What about _your_ SMC? ;-)
-- 
Jakub Narebski
Poland
