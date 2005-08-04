From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as well.
Date: Thu, 04 Aug 2005 12:59:56 -0700
Message-ID: <7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:02:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0ltx-0005fL-3o
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVHDUAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVHDUAi
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:00:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21675 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262645AbVHDT76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 15:59:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804195955.NVMJ19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 15:59:55 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 4 Aug 2005 20:41:09 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This may be controversial from the robustness standpoint, so I
>> am placing it in the proposed update queue first.  Discussions
>> on the list very welcomed.
>
> I'd vote against it: As of now, I can perfectly do
>
> export PATH=$PATH:/whereever/my/git/is
> git-init-db
>
> which would not work with this patch.

I take it to mean that you do not mind building but would want
to try it out before installing.

Yes, that is similar to what I meant by "robustness".  Maybe we
could do two things to make it palatable:

 * Instead of $src/templates/Makefile installing in place, give
   it a real 'build' target that creates $src/templates/blt/
   hierarchy and build things there (I expect we would need some
   templates that needs installation specific customization
   later, and really want to avoid making $src/templates
   something that is copied straight out).  "make install" would
   copy it out to the final destination.

 * Make git-init-db create an absolute minimum $GIT_DIR
   structure itself, if the template directory is not available,
   possibly with a warning.

Then, your post-build pre-installation trial can go like this:

    $ make
    $ PATH=`pwd`:"$PATH"
    $ GIT_TEMPLATE_DIRECTORY=`pwd`/templates/blt
    $ export PATH GIT_TEMPLATE_DIRECTORY
    $ cd /where/ever
    $ git-init-db
