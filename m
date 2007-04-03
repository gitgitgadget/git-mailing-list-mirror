From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 13:34:19 -0700
Message-ID: <7vbqi5w62c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	<db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <clee@kde.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYphw-0002g3-Iz
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945922AbXDCUeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbXDCUeV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:34:21 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36141 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945922AbXDCUeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:34:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403203420.WJDW24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 16:34:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ikaK1W00V1kojtg0000000; Tue, 03 Apr 2007 16:34:20 -0400
In-Reply-To: <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 3 Apr 2007 13:18:33 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43655>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That whole "verify no SHA1 hash collision" code is really pretty damn 
> paranoid. Maybe we shouldn't have it enabled by default.
>
> So how about this updated patch? We could certainly make "git pull" imply 
> "--paranoid" if we want to, but even that is likely pretty unnecessary. 
> It's not like anybody has ever shown a SHA1 collision, and if the *local* 
> repository is corrupt (and has an object with the wrong SHA1 - that's what 
> the testsuite checks for), then it's probably good to get the valid object 
> from the remote..

I agree with that reasoning. We did not do paranoid in git-pull
long after we introduced the .keep thing anyway, so I do not
think the following patch is even needed, but I am throwing it
out just for discussion.



diff --git a/fetch-pack.c b/fetch-pack.c
index 06f4aec..c687f9f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -522,6 +522,7 @@ static int get_pack(int xd[2])
 
 	if (do_keep) {
 		*av++ = "index-pack";
+		*av++ = "--paranoid";
 		*av++ = "--stdin";
 		if (!quiet && !no_progress)
 			*av++ = "-v";
