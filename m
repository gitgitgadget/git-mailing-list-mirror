From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix
	fetch_local for .git/HEAD
Date: Thu, 10 Nov 2005 15:11:47 -0500
Message-ID: <1131653507.11283.31.camel@dv>
References: <1124832796.23795.9.camel@dv>
	 <20051110192430.GS30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 21:14:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaImZ-00032P-Gv
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVKJUMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVKJUMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:12:25 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:20102 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751062AbVKJUMY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 15:12:24 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EaImS-0007vp-6D
	for git@vger.kernel.org; Thu, 10 Nov 2005 15:12:20 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EaIlv-0000aY-TE; Thu, 10 Nov 2005 15:11:47 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110192430.GS30496@pasky.or.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11518>

Hi, Petr!

On Thu, 2005-11-10 at 20:24 +0100, Petr Baudis wrote:
>   can you still remember why did you introduce this? In GNU cp
> documentation, I can see just
> 
>        -b, --backup
>               Make backups of files that are about to be overwritten or removed.
> 
> which doesn't make sense to me - -L dereferences symlinks.

You are right, it must be my error.  Anyway, it was so long ago that I
would need to review and retest it.

While at that, let's stop using symlinks.  git doesn't use symlinks on
Cygwin.  I think git should use that code on all OSes, since the
benefits of using symlinks are minimal (I think the only benefits are
their atomicity and resolving the reference in the kernel rather than in
userspace).  Having more uniform code for all platforms would simplify
development and testing.  It could also reduce requirements for the
transport protocols.  Finally, symlinks could be still used by the users
(if they know what they are doing) - git and cogito would simply become
symlink agnostic.

When files are copied around, symlinks are pain to deal with.  They
require special handling to be preserved both for remote operation and
dereferenced for local operation (that's what my patch was intended to
do).  I'm not even considering what would happen when cloning from Linux
to Windows or vice versa.

Sure, it can wait until git 1.0, but it would be great to keep this goal
in mind.

Disclaimer - I'm not reading the git mailing list, so if it was
discussed, I'm sorry, I don't intend to restart that discussion - just
give me the pointer and I'll read it.

-- 
Regards,
Pavel Roskin
