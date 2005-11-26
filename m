From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Fri, 25 Nov 2005 18:22:00 -0800
Message-ID: <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 03:22:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efpho-0000J3-O7
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 03:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKZCWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 21:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVKZCWF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 21:22:05 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55761 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750728AbVKZCWC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 21:22:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126022131.ZJME15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 21:21:31 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 24 Nov 2005 22:54:01 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12762>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  - Natively, they work only from the project toplevel.  Period.
>
> How about changing *that*?

I once advocated for an environment to name the top of working
tree directory --- it might make sense to resurrect that one.

"natively" was a bad choice of word.  What I meant by the above
was that the core library part (what is in read-cache,
sha1_file, etc) works on canonical path, which is defined to be
project toplevel relative.  I do not think changing that is wise
nor necessary.

The setup_git_directory() interface is a good way to take path
arguments given by the end user and convert them into canonical
path form.  So instead of punting when GIT_DIR is specified that
we have no way knowing where the working tree top is, we could
use GIT_WORKING_TREE, if exists, and use that location as the
toplevel when we need to access the working tree.  That implies
we chdir() to that directory and do necessary prefix adjustments
before returning.  But I'd rather postpone that after 1.0.
