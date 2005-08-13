From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] possible memory leak in diff.c::diff_free_filepair()
Date: Sat, 13 Aug 2005 12:30:59 -0700
Message-ID: <7viry9my6k.fsf@assigned-by-dhcp.cox.net>
References: <87y876gl1r.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 21:32:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E41ij-00055H-Hr
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 21:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVHMTbB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 15:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVHMTbB
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 15:31:01 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53502 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932264AbVHMTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 15:31:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813193058.KAZG550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 15:30:58 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87y876gl1r.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Sat, 13 Aug 2005 19:58:56 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> When I run git-diff-tree on big change, it seems the command eats so
> much memory.  so I just put git under valgrind to see what's going on.
>
> diff_free_filespec_data() doesn't free diff_filespec itself.  is this
> because in merge_broken() filespec itself is used but fliespec data
> need to be freed?

Thanks for the patch.  I am wondering if the same leak exists in
diff_free_filepair(), which frees the filespec data without
freeing filespec itself for both sides.  If this is something
you can trap easily with valgrind I would really appreciate it.
