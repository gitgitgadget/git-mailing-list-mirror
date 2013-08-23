From: Yann Dirson <dirson@bertin.fr>
Subject: [BUGLET] git bisect visualize does not show BISECT_HEAD
Date: Fri, 23 Aug 2013 15:21:27 +0200
Organization: Bertin Technologies
Message-ID: <20130823152127.73733364@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: dirson@bertin.fr, poulot-cazajous@bertin.fr, metral@bertin.fr
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 23 15:29:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCrQR-0008Ff-TB
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 15:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab3HWN3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 09:29:12 -0400
Received: from blois.bertin.fr ([195.68.26.9]:51850 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab3HWN3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 09:29:11 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Aug 2013 09:29:11 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id D5E374C2B
	for <git@vger.kernel.org>; Fri, 23 Aug 2013 15:21:09 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id B3E784522
	for <git@vger.kernel.org>; Fri, 23 Aug 2013 15:21:09 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MRZ00EO4JR9O6E0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 23 Aug 2013 15:21:09 +0200 (CEST)
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.20; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8250-7.0.0.1014-20094.001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232807>

[v1.8.3.4]

"git bisect visualize" when run without --no-checkout has the standard gitk handling of
"HEAD" showing what the current revision being tested is (as a yellow node).

Now when using --no-checkout, the information "current revision" we may be looking for
has nothing to do with HEAD any longer: we need BISECT_HEAD instead - and if by any chance
HEAD would happen to be in the displayed scope, the user may do wrong assumptions about
it (maybe).


Wondering whether there would be any flags that would pass to gitk through "bisect visualize",
I naively tried:

 $ git bisect visualize -h
 usage: git log [<options>] [<revision range>] [[--] <path>...]
   or: git show [options] <object>...

    --quiet               suppress diff output
    --source              show source
    --use-mailmap         Use mail map file
    --decorate[=...]      decorate options
    -L <n,m:file>         Process line range n,m in file, counting from 1

Wandering away from what I was look for:

 $ git bisect visualize --decorate
 ... some git log output

That seems unfortunate in its own right as well...


Back to the problem of visualizing the info, it looks like gitk would need a way to display
refs that are not displayed by default, when we need them.  Something like:

	gitk --explicit-refs=BISECT_HEAD,refs/whatever

That would also be helpful when one tries to look at the reflog graphically: whereas
gitk accepts to show whatever@{1} and friends, it never tells us which revision corresponds
to which reflog entry, and --explicit-refs=whatever@{1},whatever@{2} would help here, as would
something like --explicit-refs=whatever@{*} or --explicit-refs=whatever@{1..5}, but that starts
to be more tricky to formalize.

Thoughts, anyone ?

-- 
Yann Dirson - Bertin Technologies
