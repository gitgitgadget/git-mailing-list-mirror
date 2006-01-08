From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 7/7] Add an optional limit to git-rebase
Date: Sun, 08 Jan 2006 01:30:20 -0800
Message-ID: <7vk6db12z7.fsf@assigned-by-dhcp.cox.net>
References: <20060108004120.GO1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 10:30:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvWsc-0005OB-9B
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 10:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWAHJaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 04:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbWAHJaX
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 04:30:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58521 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161169AbWAHJaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 04:30:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060108092916.LKFA6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 Jan 2006 04:29:16 -0500
To: Yann Dirson <ydirson@altern.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14312>

Yann Dirson <ydirson@altern.org> writes:

> This patch adds a limit to restrict the list of patches to rebase.
>
> This is useful when a set of patches were done against a given head,
> but needs to be ported to a different head, as opposed to being ported
> to a descendant of the original head.  In such a case we only want to
> port our own patches, not those that make the two branches different
> upstream.

This usage makes sense, independent from your git-format-patch
"limit" patch.  The patched argument to git-format-patch does
not match your git-format-patch changes AFAICT ;-).

> -git-format-patch -k --stdout --full-index "$other" ORIG_HEAD |
> +git-format-patch -k --stdout --full-index "$other" ORIG_HEAD $limit |

If all you want to do is to move the cut-off point more recent
than the merge base is, how about (without your git-format-patch
changes) doing something stupid like this instead?

  git-format-patch -k --stdout --full-index ${limit:-"$other"} ORIG_HEAD
