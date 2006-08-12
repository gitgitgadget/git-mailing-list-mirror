From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to resolve git-am conflict (possible bug)
Date: Fri, 11 Aug 2006 18:20:31 -0700
Message-ID: <7vslk2rbq8.fsf@assigned-by-dhcp.cox.net>
References: <ebj7er$64j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 03:20:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBiB7-0000AA-Up
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 03:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWHLBUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 21:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWHLBUd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 21:20:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40097 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932408AbWHLBUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 21:20:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812012032.QMQR12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 21:20:32 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebj7er$64j$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	12 Aug 2006 02:30:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25248>

Jakub Narebski <jnareb@gmail.com> writes:

> Third, I wonder why it printed the same error message _twice_.

Do you have blob 7ea52b1?  Otherwise you would not see two "does
not apply" messages, so I suspect you do.  Does the patch
cleanly apply to that blob?

More likely explanation is that you edited the patch by hand for
some reason, and made it inapplicable to the base blob the
"index" line records.

The first "patch does not apply" comes from ll. 363 of git-am.
After it fails because the patch does not apply to the version
of gitweb.perl in your index, since you told it to fall back to
three-way merge, l. 391 calls fall_back_3way, which inspects the
patch, finds the "index" line and notices that the patch claims
to apply to blob 7ea52b1, finds the blob in your repository, and
prepares a temporary index with "update-index -z --index-info"
on l. 58 successfully, tries to apply the patch again on l. 63.

However, the patch contents and the blob object name recorded on
the index line are not necessarily consistent if you hand edited
the patch (IOW, the context lines in the patch contents may not
match blob 7ea52b1).
