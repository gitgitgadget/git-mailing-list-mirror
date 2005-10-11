From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Mon, 10 Oct 2005 23:04:43 -0700
Message-ID: <7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Oct 11 08:05:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPDFq-0000uA-ML
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 08:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVJKGEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 02:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVJKGEs
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 02:04:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60089 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751380AbVJKGEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 02:04:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011060438.MUGD16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 02:04:38 -0400
To: git@vger.kernel.org
In-Reply-To: <7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Oct 2005 22:07:14 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9955>

Junio C Hamano <junkio@cox.net> writes:

> "git-fetch --tags" can get confused with tags with spaces in their names,
> it used to use shell IFS to split the list of tags and also used curl
> which insists the URL to be escaped.  Fix it so it can work with Martin's
> moodle repository http://locke.catalyst.net.nz/git/moodle.git/.

The one I sent to the list was buggy and broke usual multi-head
fetches, and what I have in the proposed updates branch is a
replacement one.

We cannot still do arbitrary reference names, but at least now
we allow spaces in them.  But I am not sure if this is a good
change.

Do we in general want to support references with [^-a-zA-Z0-9.]
in them?  Most notably spaces?

The current replacement patch implies that .git/remotes/
short-cut file format now has a slight incompatible change.  You
cannot have more than one refspec on single Pull: line.  I used
to have:

	Pull: master:ko-master +pu:ko-pu maint:ko-maint

but these should now be split into multiple lines, like this:

	Pull: master:ko-master
	Pull: +pu:ko-pu
	Pull: maint:ko-maint

The latter format, one refpair per line, has always been
supported, BTW.

Opinions?
