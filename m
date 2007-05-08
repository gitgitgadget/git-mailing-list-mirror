From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Perl code for git-clean
Date: Tue, 08 May 2007 16:51:55 -0700
Message-ID: <86hcqm98mc.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 01:52:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlZTP-0002Ao-QK
	for gcvg-git@gmane.org; Wed, 09 May 2007 01:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031578AbXEHXv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 19:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031993AbXEHXv5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 19:51:57 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:36032 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031578AbXEHXv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 19:51:56 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id D33B21DEC37; Tue,  8 May 2007 16:51:55 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.5.6; tzolkin = 4 Cimi; haab = 14 Uo
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46640>


OK, this is untested, but I usually get this stuff right
by eyeballing it. :)

export cleandir;
git-ls-files -z --others --directory $excl ${excl_info:+"$excl_info"} -- "$@" |
perl -ln0e '
  use File::Path qw(rmtree);
  if (-d and not -L) {
    if (not $ENV{cleandir}) {
      print "Not removing $_";
      next;
    }
    print "Removing $_";
    rmtree($_);
  } else {
    print "Removing $_";
    unlink($_);
  }
'

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
