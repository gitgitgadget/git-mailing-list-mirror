From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 14:21:53 -0700
Message-ID: <7v1x8u7g26.fsf@assigned-by-dhcp.cox.net>
References: <42703E79.8050808@zytor.com>
	<1114673723.12012.324.camel@baythorne.infradead.org>
	<20050428081005.GG8612@pasky.ji.cz>
	<1114676955.12012.346.camel@baythorne.infradead.org>
	<1114680199.12012.363.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>, Petr Baudis <pasky@ucw.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:17:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGNA-0003PK-8l
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVD1VV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVD1VV7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:21:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50143 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262175AbVD1VVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:21:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428212155.IJXS7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 17:21:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 28 Apr 2005 11:55:16 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> So what you can do is:
LT>  - if there is one parent, just always walk straight down
LT>  - if it's a merge, add the parents _in_date_order_ to the list of things 
LT>    to do, and then pop the most recent one.
LT> Really. You say that dates don't matter, but they _do_ actually matter a
LT> lot more than "remote/local" does. At least they have meaning.

On a related topic, I have two questions on commit objects.

1. Currently, commit-tree does not seem to verify that all its
   parent SHA1's actually name valid commit objects.  Is this
   intentional?

I cannot see a good practical reason to commit a new version
that claim to be descendant of some SHA1 you know exists in
somebody else's tree, without actually having that object also
in your SHA1_FILE_DIRECTORY.  Otherwise how did you merge with
it in the first place?  For that reason, I expect the answer to
this question to be "no it was just being lazy.  Go ahead if you
really care."

2. Assuming that we do want to enforce that parent fields of a
   commit object name valid commit objects, is it OK to also
   require that the commit timestamp of a child object is not in
   the future relative to any and all of its parent commit
   objects (I'm talking about the timestamp of committer field
   not author field, although your e-mail patch acceptance
   procedure seems to be giving it the same timestamp right
   now)?

I have been wondering if imposing these two requirement has some
negative effects, but I do not offhand see any.  And these
requirements may make implementation of git log viewer simpler
when the user specifies "I want to view commit between these
ones---give me a linearlized list of commits."  When following
the ancestor chain from the current top, we can immediately stop
upon seeing a commit made before the timestamp of the named
bottom one.

