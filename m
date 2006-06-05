From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Mon, 05 Jun 2006 16:43:51 -0700
Message-ID: <7vfyij2mo8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606060053440.25344@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk67v2o85.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606060117180.25685@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 01:44:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnOjr-0006wH-Q6
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 01:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWFEXny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 19:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWFEXny
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 19:43:54 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:5101 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750801AbWFEXnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 19:43:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605234352.NBAS6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 19:43:52 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606060117180.25685@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Jun 2006 01:21:35 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21353>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Hmph.  Would it be a bug in clone that does not create GIT_DIR
>> then?
>
> I don't think so. The whole point in calling git-init-db is to create 
> that. GIT_DIR is set so that the otherwise nice work-in-a-subdirectory 
> does not kick in. Imagine for example:
>
> 	git-clone ./. victim
>
> (taken straight out of t5400). If GIT_DIR was not set, git-init-db (which 
> reads repositoryformat from the config if that exists, right?) would find 
> .git/ in git/t/trash, and _not_ create git/t/trash/victim/.git/.

I know clone currently relies on init-db to create the directory if
it does not exist (I wrote the code after all).

I am questioning if that was a wise thing to do.  In the case of
clone, we _know_ where we want the directory to be, so creating
the directory upfront before calling init-db feels like the
right thing to do.  In all the case other than this "clone calls
init-db" I can think of, if we have GIT_DIR set and it is set to
a non-existent location, it would be a bug in the code/script
and I think it is saner to error out in such a case.
