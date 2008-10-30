From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Thu, 30 Oct 2008 12:24:14 -0700
Message-ID: <7vljw5evj5.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Oct 30 20:27:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvdAD-0008H2-8G
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 20:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbYJ3TY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYJ3TY3
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 15:24:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYJ3TY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 15:24:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FF0D76467;
	Thu, 30 Oct 2008 15:24:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E3BF676465; Thu, 30 Oct 2008 15:24:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D613B72-A6B8-11DD-95FE-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99522>

I have a mixed feeling about this.  From a longer-term perspective, do you
really want this to be a part of git.git repository?

I do not mind having notes to endorse and advocate "stats" as one of the
"Third party packages that may make your git life more pleasuable", just
like tig, stgit, guilt and topgit, but I cannot convince myself that
merging it as a subtree is the right thing to do at this point.

The "stats" tool, at least at the conceptual level, shares one important
property with tools like gitk and gitweb: it could be useful to people
whose sources are not in git repositories but in say Hg or Bzr, with some
effort.  The code may need refactoring to make it easier to plug in
different backends and writing actual backends (aka "porting"), but that
is something you can expect people with different backends to help you
with.

However, it would be awkward for the contrib/ area in git.git to carry a
lot of code that are only needed to produce stat data from non-git
repositories, once such a porting effort begins.

It's perfectly fine if you are not interested in any of the other
backends, and tell the people that they are welcome to fork it never to
merge back.  But if this were my brainchild, I'd imagine I'd be wishing to
be able to buy back the improvements to the "core stats" parts that are
done by people with other backends.  I would imagine binding the current
code as part of git.git would make such improvements harder to manage,
both for you (who wants to buy back the changes made by others on
different backends) and for others on different backends (who want to
merge the changes made by you to their forks).

Perhaps pointing at your tree as a submodule would be the right thing to
do; then git.git proper will be just one of the users of "stats" tool.

How about making that as a mid-to-longer term goal?  When we eject git-gui
and gitk from git.git and make them a submodule (wasn't that supposed to
happen in 1.8 or 2.0 timeframe?), we may also add "stats" as a submodule?
