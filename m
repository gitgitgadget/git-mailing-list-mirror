From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about git-prune
Date: Sat, 30 Jun 2007 13:12:39 -0700
Message-ID: <7vps3db3rc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706300915440.16800@x2.ybpnyarg>
	<Pine.LNX.4.64.0706301900290.4438@racer.site>
	<f66d3l$sa6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 22:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jJC-0005pY-T4
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbXF3UMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbXF3UMl
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:12:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51805 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXF3UMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:12:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630201241.MLY1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 16:12:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HwCf1X0021kojtg0000000; Sat, 30 Jun 2007 16:12:39 -0400
In-Reply-To: <f66d3l$sa6$1@sea.gmane.org> (wa1ter@myrealbox.com's message of
	"Sat, 30 Jun 2007 13:06:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51252>

walt <wa1ter@myrealbox.com> writes:

>> Probably the objects were packed.
>
> I also tried git-prune-packed, which also did nothing AFAICT.

Of course it wouldn't; prune-packed is to prune loose objects
that also appear in packs.

What is happening is:

 - You create a pack that has everything reachable from refs at
   one point;

 - You pull or do your own development; the set of objects
   reachable from refs change from the above set.  This set is
   superset of the above only if there is no rewind is
   involved.  Otherwise, some objects already packed in the
   previous step are now unreachable.

 - git-prune and git-prune-packed are about removing loose
   objects.  They never go into existing packs and eradicate
   objects from them.

When you have unreachable cruft in packs, repacking is the only
way to rid them ("git repack -a -d", which is run by "git gc").
