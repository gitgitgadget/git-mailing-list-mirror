From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Thu, 02 Jun 2005 11:02:53 -0700
Message-ID: <7vhdgg7i2a.fsf@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
	<7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
	<1117731830.32257.52.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:01:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdtzH-0005go-Eg
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 20:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFBSDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 14:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFBSDF
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 14:03:05 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49863 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261208AbVFBSCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 14:02:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602180254.BAUT20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 14:02:54 -0400
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1117731830.32257.52.camel@jmcmullan.timesys> (Jason McMullan's
 message of "Thu, 02 Jun 2005 13:03:49 -0400, Thu, 2 Jun 2005 12:57:02
 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JM" == McMullan, Jason <jason.mcmullan@timesys.com> writes:

JM> Eww. Don't you want to attempt to get the referenced sha1 *before*
JM> you stick the delta blob into the repository?

That issue crossed my mind, and I admit I haven't looked at the
issues closely enough, but I suspect that it may not worth it
with the current pull.c structure.

The current pull code fetches and stores a commit object before
it retrieves the tree object associate with it, and similarly a
tree object before its subtree and blobs, which has the same
issue.  Adding -r (recover) option to the pull family to not
check for the existence of required object but its dependents
would be necessary if my suspition turns out to be correct, and
delta dependency should be handled the same way commit and tree
dependencies are handled there.

