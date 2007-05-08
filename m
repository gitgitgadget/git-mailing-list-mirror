From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-clean fails to remove a file whose name contains \\, ", or  \n, TAB, etc.
Date: Tue, 08 May 2007 13:51:01 -0700
Message-ID: <86k5vj9gzu.fsf@blue.stonehenge.com>
References: <87ps5bhx8t.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlWeN-0000aQ-Fg
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967542AbXEHUvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934439AbXEHUvE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:51:04 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:42456 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934370AbXEHUvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:51:03 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 476611DE9D3; Tue,  8 May 2007 13:51:01 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.5.6; tzolkin = 4 Cimi; haab = 14 Uo
In-Reply-To: <87ps5bhx8t.fsf@rho.meyering.net> (Jim Meyering's message of "Tue, 08 May 2007 22:32:50 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46621>

>>>>> "Jim" == Jim Meyering <jim@meyering.net> writes:

Jim> Not that it matters (or maybe this is a feature :-), because people
Jim> who create such files in their working directory deserve what they
Jim> get, Eh? :-)

The problem is the newline in the string, since

  git-ls-files --others --directory $excl ${excl_info:+"$excl_info"} -- "$@" |
  while read -r file; do

is using newline as a delimiter.  Any file with a newline would mess this up.

Not being a shell programming expert, is there a way we could use -z and xargs
-0 here instead?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
