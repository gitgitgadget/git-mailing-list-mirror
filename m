From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: better way to find Git.pm officially?
Date: Wed, 28 Mar 2012 21:58:12 -0700
Message-ID: <86r4wc9f6j.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 06:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD7RD-0003w7-FD
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 06:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2C2E6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 00:58:15 -0400
Received: from lax-gw18.mailroute.net ([199.89.0.118]:41249 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751506Ab2C2E6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 00:58:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by lax-gw18.mroute.net (Postfix) with ESMTP id 44F6A583C84C
	for <git@vger.kernel.org>; Thu, 29 Mar 2012 04:58:13 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw18.mroute.net (Postfix) with ESMTP id 6390E583A49B
	for <git@vger.kernel.org>; Thu, 29 Mar 2012 04:58:12 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 50D4A1ED5; Wed, 28 Mar 2012 21:58:12 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.4.12; tzolkin = 9 Eb; haab = 0 Uayeb
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194227>


I'm using Git.pm in a git subcommand.  There doesn't (yet :) seem to be
an official way to *find* the directory Git.pm was installed in to add
it to my @INC, so I can up with this ugly hack:


    #!/usr/bin/perl
    use strict;

    use lib $ENV{GITPERLLIB}
      ? split(/:/, $ENV{GITPERLLIB})
      : do {
        chomp(my $exec_path = qx{git --exec-path});
        open my $gitsvn, "<", "$exec_path/git-svn" or die "Cannot find
      git-svn";
        {
          last unless local $_ = readline $gitsvn;
          redo unless m{\Ause lib.*GITPERLLIB.*\|\| "(.*)"};
          "$1";
        }
      };

    use Git;

As in, find the git-svn binary (via git --exec-path), parse its second
line to see where the git installer put the GITPERLLIB, and then add
that myself.

Is there a simpler way?  Can we get "git --perl-path" added to the
binary or something?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
