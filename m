From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 25 May 2007 14:05:40 -0700
Message-ID: <7vwsywpqaj.fsf@assigned-by-dhcp.cox.net>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
	<20070521165938.GA4118@efreet.light.src>
	<20070521211133.GD5412@admingilde.org>
	<7viraixeme.fsf@assigned-by-dhcp.cox.net>
	<20070525203505.GB4493@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri May 25 23:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgzH-00089u-WC
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765577AbXEYVFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765712AbXEYVFw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:05:52 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56057 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765701AbXEYVFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:05:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525210549.GVMU12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 17:05:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3Z5h1X0081kojtg0000000; Fri, 25 May 2007 17:05:46 -0400
In-Reply-To: <20070525203505.GB4493@efreet.light.src> (Jan Hudec's message of
	"Fri, 25 May 2007 22:35:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48414>

Jan Hudec <bulb@ucw.cz> writes:

> It would also solve (rare) case when for some reason the same subproject
> should be checked out twice (different revisions).

I have a feeling that you are equating two subprojects that
happens to have the same upstream URL the same, and if that is
the case I think that is a mistake.

If you were doing an efficient cgi script that renders history
of git managed projects, binding git as its subproject, and that
system can be built with either 'maint' (i.e. 1.5.2 series) or
'master' (i.e. ultrastable WIP towards 1.5.3), even though they
both might come from git://git.kernel.org/pub/scm/git/git.git/,
I think they should be registered as two separate logical
subprojects.

The .gitmodules file might have:

	[module "git-maint"]
        	path = git-stale/
        	url = git://git.kernel.org/pub/scm/git/git.git/
                ;; branch = maint

	[module "git-master"]
        	path = git-stable/
        	url = git://git.kernel.org/pub/scm/git/git.git/
                ;; branch = master

and two paths (git-stale/ and git-stable/) in the superproject
tree would have commit object names from the named branches.
