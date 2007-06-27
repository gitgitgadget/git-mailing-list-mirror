From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT + CVS workflow query.
Date: Tue, 26 Jun 2007 17:36:56 -0700
Message-ID: <7vbqf2xmfr.fsf@assigned-by-dhcp.pobox.com>
References: <47281e410706261520r5b3549c7t39d93924d0a8ceea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eoin Hennessy" <eoin.hennessy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 02:37:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3LWn-0004Xn-0O
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 02:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbXF0Ag6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 20:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbXF0Ag6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 20:36:58 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59045 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbXF0Ag5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 20:36:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627003656.HWSO17683.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 20:36:56 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GQcw1X0081kojtg0000000; Tue, 26 Jun 2007 20:36:56 -0400
In-Reply-To: <47281e410706261520r5b3549c7t39d93924d0a8ceea@mail.gmail.com>
	(Eoin Hennessy's message of "Tue, 26 Jun 2007 23:20:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50990>

"Eoin Hennessy" <eoin.hennessy@gmail.com> writes:

> I'd like to use GIT to track changes in a CVS repository. As well as
> tracking changes, I will also need to push patches back to CVS from
> GIT. My workflow is currently as follows:
>
> - Use git-cvsimport to import and update a mirror of the CVS
>    repository; 'project.git'.
> - Pull changes from the mirror to a cloned working copy; 'project'.
> - Fix bugs in the working copy and push commits back to the mirror.

Fix bugs, yes, but push back to the mirror is probably not what
you want.

> - Use git-cherry to identify commits in master not currently in the
>   branch updated by git-cvsimport. Then use git-cvsexportcommit to push
>   these commits into a CVS checkout.

What I do with my day-job project is that I keep a separate CVS
checkout like you do, and

 - cvsimport keeps track of the "project.git" mirror as you do;
 - pull changes from that to my "project" as you do (but see below);
 - fix things in "project", as you do;
 - identify the needed changes with 'git-cherry' as you do;
 - exportcommit to push them back to CVS through the CVS checkout;
 
Then the next cvsimport will get my changes (among other
people's changes) to "project.git".  

 - fetch changes from the "project.git" to my "project";
 - 'git-rebase' my changes on top of the tip of "project.git";

This will remove the duplicates that I had but now are in CVS.
