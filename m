From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision: simplify argument parsing.
Date: Sun, 02 Apr 2006 21:22:12 -0700
Message-ID: <7vpsjzguff.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
	<7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603302225160.27203@g5.osdl.org>
	<7vr74jw0zj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604011628500.3684@g5.osdl.org>
	<7vmzf4mzsv.fsf@assigned-by-dhcp.cox.net>
	<443063E2.1040904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 06:22:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGa2-0007uW-QJ
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWDCEWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWDCEWQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:22:16 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22458 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751293AbWDCEWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 00:22:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060403042214.LRQS17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 00:22:14 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18312>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The comment is misleading because the patch not only moves stuff around,
> it also removes setting of revs->limited when revs->min_age has been
> set.

You are correct that the patch does more than it claims to.

That is an independent fix mentioned in my earlier message
<7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>.  We did not have to
pay the overhead of having to call limit_list() when only
min_age was specified because we did not do traversal filtering
using UNINTERESTING logic for min_age, but we called it anyway.
Unlike --max-age that marks an old one _and_ its parents
uninteresting, it needs to filter a young one without making its
parents uninteresting.
