From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix "git log -z" behaviour
Date: Wed, 07 Feb 2007 11:55:56 -0800
Message-ID: <7vmz3p7neb.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
	<Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 20:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEsvs-00041V-Uv
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 20:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422915AbXBGT4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 14:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161445AbXBGT4Q
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 14:56:16 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40009 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161439AbXBGT4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 14:56:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207195558.OLRA1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 14:55:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ljvx1W0041kojtg0000000; Wed, 07 Feb 2007 14:55:57 -0500
In-Reply-To: <Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 7 Feb 2007 11:49:56 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38956>

Ah, I was looking at other minor issues and then came up with
this one liner.  But obviously "termination should be the true
inter-commit spacing" is the right direction, so I'll chuck this
one.

diff --git a/log-tree.c b/log-tree.c
index d8ca36b..410f90f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -354,6 +354,8 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent = NULL;
 		show_log(opt, "");
+		if (!opt->diffopt.line_termination)
+			putchar(0);
 		shown = 1;
 	}
 	opt->loginfo = NULL;
