From: Junio C Hamano <junkio@cox.net>
Subject: Re: symlinked directories in refs are now unreachable
Date: Wed, 17 Aug 2005 13:41:38 -0700
Message-ID: <7vslx8thx9.fsf@assigned-by-dhcp.cox.net>
References: <1124073677.27393.15.camel@della.draisey.ca>
	<7v64u7941c.fsf@assigned-by-dhcp.cox.net>
	<1124089116.749.39.camel@della.draisey.ca>
	<1124171194.762.74.camel@della.draisey.ca>
	<7vbr3yl7oz.fsf@assigned-by-dhcp.cox.net>
	<1124246082.776.54.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 22:44:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5UjI-0002Zy-FA
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 22:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVHQUlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 16:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVHQUll
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 16:41:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62337 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751233AbVHQUll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 16:41:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817204139.ONCR3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 16:41:39 -0400
To: Matt Draisey <mattdraisey@sympatico.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Draisey <mattdraisey@sympatico.ca> writes:

> Having thus been forced to read the mailing list, I see a slight problem
> in .git/objects/info/alternates mechanism.  Using the original
> ALTERNATE_DB_ENVIRONMENT variable you assert to the git programmes that
> you know all the repositories to search for objects.  In
> the .git/objects/info/alternates mechanism you implicitly defer to other
> repositories, which might also implicitly defer to yet another
> repository.  To ensure an object is truly available you need to compute
> a transitive closure on all .git/objects/info/alternates --- you can't
> really rely on .git/objects/info/alternates being transitively closed
> already.

No, "git clone -l -s" not copying the objects/info/alternates of
the repository being cloned was simply a bug; by doing so the
transitive closure can be set up "initially".

Both the environment variable and objects/info/alternates share
the same problem if the cloned/borrowed from repository suddenly
starts to borrow from another repository, losing objects it used
to have from itself.  You just shouldn't do it.

With objects/info/alternates, you _could_ do the transitive
closure at runtime and do not have to worry about this issue
(but you now need to worry about cycles), which you cannot do
with the environment variable approach.
