From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Mon, 05 Jun 2006 12:45:18 -0700
Message-ID: <7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jun 05 21:45:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnL13-0007Qy-Fu
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 21:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWFETpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 15:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWFETpW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 15:45:22 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:12779 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbWFETpU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 15:45:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605194519.CWGL11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 15:45:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 5 Jun 2006 19:46:09 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21331>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When calling git_setup_directory_gently, and GIT_DIR was set, it just
> ignored the variable nongit_ok.

Hmph.  Is this really a breakage?  That is, gently() is meant
for a case where you do not know if you even find a git
repository and tell it not to complain because you are prepared
for the case where you are not in a git repository.

If the environment has an incorrect GIT_DIR, I think that falls
into a different category.  It is more like "the user or calling
script says we have GIT_DIR there but it is corrupt and
unusable".

I do not have a strong opinion on this, though.  If you have
two commands in your script, the first of which does gently()
with such an environment, your change may allow that first
command to succeed, but if the second command does not say
nongit_ok, it would die() there anyway.
