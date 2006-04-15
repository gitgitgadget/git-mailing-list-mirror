From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 18:35:57 -0700
Message-ID: <7vacanmxhe.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
	<7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141748070.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 03:36:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUZhu-0000zf-FK
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 03:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWDOBgB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 21:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWDOBgB
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 21:36:01 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39645 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965231AbWDOBgA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 21:36:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415013559.KHKT14494.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 21:35:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604141748070.3701@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 14 Apr 2006 17:49:56 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18720>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 14 Apr 2006, Junio C Hamano wrote:
>> 
>> I was thinking long because I had an impression that anything
>> based on revision.c interface, if it wants to do a tree-diff on
>> the commit stream, would need two different diff options.  One
>> is used by revision.c internally so that it can use its own
>> add_remove/change for parent pruning, and another to control the
>> way diff is run by the user of revision.c.
>
> I think you're right, and I've probably broken "--full-diff" (causing the 
> revparse to also use the empty set of paths). Gaah.

Another thing is that some revision.c users are not interested
in taking diff options at all.

I was going to suggest a new structure that captures struct
rev_info, struct log_tree_opt and miscellaneous bits cmd_log
uses such as do_diff, full_diff, etc., and move the option
parser out of cmd_log() to a separate function, and have that
shared across cmd_log(), cmd_show(), cmd_whatchanged(), and
cmd_diff() without affecting any of the existing revision.c
users.  That way, "rev-list --cc HEAD" will remain nonsense.

One nice property your approach has is that it makes
"git diff-tree a..b" magically starts working, unlike what
I suggested above.
