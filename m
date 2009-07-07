From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] Tree blame (git blame <directory>)
Date: Tue, 7 Jul 2009 10:58:38 +0200
Message-ID: <200907071058.39390.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 10:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO6W2-0007ro-R4
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 10:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbZGGI64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbZGGI6z
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 04:58:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:57338 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbZGGI6x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 04:58:53 -0400
Received: by fxm18 with SMTP id 18so4731530fxm.37
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=+uT6K3DijStzwu+KeJqbcuo+KIy30QMSd/Mx0BalFPQ=;
        b=X2m3VFUspTooHelZGGeoMeXUmoLReOFRG1v2ov2l5IhszHzZOjl8mNsH+qEyjKBLtH
         RZByw6bUFyv7JSXIEwapKA2rwUH6i8tAL7tTsNQVSxkFWIWuEf+hk3XFEM+yjvMaWN7O
         /1rQ54RM5wtCsyctZKbQwT4SoQAQmd3YnGMfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=g9T4oj4fEZnTITplJr/HyAsOLAFseIYrRlwWieYmJl8j36kYkhr4uHUVaY6uV49Bjs
         LfUVN0rniqYW0cx3fgYQ+Tuss53529vHfi2a1xeHXkDUVFDxJgDlrZi5+L28VU06EzFE
         ucl1hqweKnNs4kdF8MLhQh/xjVhPwKak1ul34=
Received: by 10.103.240.15 with SMTP id s15mr3182254mur.102.1246957136042;
        Tue, 07 Jul 2009 01:58:56 -0700 (PDT)
Received: from ?192.168.1.13? (abwt137.neoplus.adsl.tpnet.pl [83.8.243.137])
        by mx.google.com with ESMTPS id e9sm9916223muf.2.2009.07.07.01.58.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 01:58:55 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122830>

Currently git-blame supports only ordinary files (blobs).  If you try to 
use git-blame on directory, it errors-out with a bit cryptic error 
message:

  $ git blame Documentation
  fatal: unsupported file type Documentation

Meanwhile some git web interface (e.g. GitHub and Gitorious), most 
probably following web interfaces for file-based VCS like ViewVC for 
CVS and Subversion, provide kind of "tree blame" view as default view 
for directory contents.  It means that for each element (entry) in 
given directory it shows 'last changed' info, namely author, date and 
summary of commit that changed given entry to current version.

I don't know what algorithm they use to generate this info (well,
I could find out in the case of Gitorious... if I read Ruby ;-)), 
but I suspect that they might a bit inefficient algorithm to find such 
info.  Some time ago I tried to add such 'tree_blame' view to gitweb:
you can check the result in the 'gitweb/tree_blame' branch in my 
git/jnareb-git.git repository at repo.or.cz:
  http://repo.or.cz/w/git/jnareb-git.git?a=commitdiff;h=gitweb/tree_blame


It would be nice if "git blame <directory>" would give us required 
information; for tools such like GitHub, Gitorious or gitweb one could 
use '--porcelain' or '--incremental' output.

Unfortunately I don't know this part of code good enough to write it
easily myself. I would think that it wouldn't be too hard to code it;
certainly easier than git-blame for ordinary files.

I think that ordinary git-blame output for trees (directories) could
mimic "ls -l" output format as far as possible, i.e. when currently
  $ git ls-tree --abbrev v1.6.3.3
generates the following output:
  ...
  100644 blob e57630e     walker.c
  100644 blob 8a149e1     walker.h
  100644 blob 7eb3218     wrapper.c
  100644 blob 4c29255     write_or_die.c
  100644 blob 819c797     ws.c
  100644 blob 1b6df45     wt-status.c
  100644 blob 78add09     wt-status.h
  100644 blob b9b0db8     xdiff-interface.c
  100644 blob 7352b9a     xdiff-interface.h
  040000 tree ef5d413     xdiff

then
  $ git blame --abbrev v1.6.3.3 -- .
would generate

  100644 blob e57630e ba19a80 Junio C Hamano      Feb 10 17:42   walker.c
  100644 blob 8a149e1 c13b263 Daniel Barkalow     Apr 26  2008   walker.h
  100644 blob 7eb3218 fc71db3 Alex Riesen         Apr 29 23:21   wrapper.c
  100644 blob 4c29255 559e840 Junio C Hamano      Jul 20  2008   write_or_die.c
  100644 blob 819c797 a437900 Junio C Hamano      Jun 21 02:35   ws.c
  100644 blob 1b6df45 2af202b Linus Torvalds      Jun 18 10:28   wt-status.c
  100644 blob 78add09 6c2ce04 Marius Storm-Olsen  Jun  5  2008   wt-status.h
  100644 blob b9b0db8 eb3a9dd Benjamin Kramer     Mar  7 21:02   xdiff-interface.c
  100644 blob 7352b9a 86295bb Rene Scharfe        Oct 25  2008   xdiff-interface.h
  040000 tree ef5d413 5719db9 Charles Bailey      May 25 01:21   xdiff/

or something like that.  Date doesn't have to be in this strange format
used by 'ls'.  Also instead of name we can use username part of email,
or just email; OTOH git-blame uses above format for author.

The porcelain / incremental output format for "git blame <directory>"
wouldn't need to be changed much from "git blame <file>"; line numbers
do not matter though, as what is important is SHA-1 of entry (blob, tree
or commit).
  $ git blame --porcelain v1.6.3.3 -- .
The blame output for last two lines could look like the following:
  86295bb6bac1482d29650d1f77f19d8e7a7cc2fe 7352b9a9c204c2b1d4ca9df5ce040fe22d6f521c
  author Rene Scharfe
  author-mail <rene.scharfe@lsrfire.ath.cx>
  author-time 1224941475
  author-tz +0200
  committer Junio C Hamano
  committer-mail <gitster@pobox.com>
  committer-time 1224961771
  committer-tz -0700
  summary add xdi_diff_hunks() for callers that only need hunk lengths
  filename xdiff-interface.h
  100644 blob 7352b9a9c204c2b1d4ca9df5ce040fe22d6f521c    xdiff-interface.h
  5719db91ce5915ee07c50f1afdc94fe34e91529f ef5d413237b3a390007fba56671b00d7c371ae1e
  author Charles Bailey
  author-mail <charles@hashpling.org>
  author-time 1243210874
  author-tz +0100
  committer Junio C Hamano
  committer-mail <gitster@pobox.com>
  committer-time 1243234594
  committer-tz -0700
  summary add xdi_diff_hunks() for callers that only need hunk lengths
  filename xdiff
  040000 tree ef5d413237b3a390007fba56671b00d7c371ae1e    xdiff


What do you think about adding such feature?  

It either could use infrastructure for better '--follow' implementation,
or lead to better implementation of '--follow' option (which currently
as it is now works only for simplest cases).  Probably.

-- 
Jakub Narebski
Poland
