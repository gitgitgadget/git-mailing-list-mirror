From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Thu, 21 Jun 2007 02:18:10 -0700
Message-ID: <7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045903.GA14047@spearce.org>
	<7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
	<20070621061045.GG8477@spearce.org>
	<7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
	<7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 11:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Inx-0005OG-47
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 11:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbXFUJSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 05:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXFUJSM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 05:18:12 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41890 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbXFUJSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 05:18:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621091811.ZJMT4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 05:18:11 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E9JA1X0081kojtg0000000; Thu, 21 Jun 2007 05:18:11 -0400
In-Reply-To: <7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Thu, 21 Jun 2007 02:00:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50609>

I am now getting sort of convinced that the list-features is a
slippery slop towards total suckage, unless managed very
carefully.

The "auto manage" patch I am responding to would tempt anybody
to extend the mechanism to do something like the attached patch,
because a one-line comment near the code, like:

	/* FEATURE<oneline-first-paragraph> */

does not look very useful nor pretty by itself in the source
code.  It makes it very tempting to actually describe the
"feature".  People with only half a brain would even advocate
updating supported_features[] to a tuple of (name, explanation),
and have "git version --list-features" to spit both out, or
something like that.  I really do not think we would want to go
there.

A few years down the road, do we really care if we did not do
something long time ago, but the code was updated and added as a
new feature?  That information belongs to the commit log, not to
in-source comments.  This will lead to the same mistake often
made by users of other SCMs, embedding "$Log$" in their sources.


=== sample diff that is not acceptable ===

diff --git a/commit.c b/commit.c
index dbb28b5..4b713b6 100644
--- a/commit.c
+++ b/commit.c
@@ -1016,6 +1016,12 @@ static void pp_header(enum cmit_fmt fmt,
 	}
 }
 
+/*
+ * FEATURE<oneline-first-paragraph>: we used to treat the first line of the
+ * commit messages special, but messages imported from foreign culture often
+ * have more than one line in the first "paragraph".  We now treat the
+ * first paragraph as special for the purposes of --pretty=oneline.
+ */
 static void pp_title_line(enum cmit_fmt fmt,
 			  const char **msg_p,
 			  unsigned long *len_p,
@@ -1140,6 +1146,11 @@ static void pp_remainder(enum cmit_fmt fmt,
 	}
 }
 
+/*
+ * FEATURE<log-unlimited-message>: we used to have a hard limit
+ * of 16kB message, but that is sometimes not enough for huge commits
+ * imported from foreign culture.  We now dynamically grow the buffer.
+ */
 unsigned long pretty_print_commit(enum cmit_fmt fmt,
 				  const struct commit *commit,
 				  unsigned long len,
