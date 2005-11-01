From: Chris Mason <mason@suse.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 13:13:52 -0500
Message-ID: <20051101181352.GD26847@watt.suse.com>
References: <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com> <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com> <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz> <b0943d9e0511010123i1f9eb679w@mail.gmail.com> <436787BD.9080705@citi.umich.edu> <20051101153650.GB26847@watt.suse.com> <b0943d9e0511010918ob2dbcfcv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chuck Lever <cel@citi.umich.edu>, Petr Baudis <pasky@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 19:17:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX0dz-0001tx-Jw
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 19:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVKASN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVKASN4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 13:13:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:57485 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751087AbVKASN4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 13:13:56 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 14454DB04;
	Tue,  1 Nov 2005 19:13:55 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0511010918ob2dbcfcv@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10947>

On Tue, Nov 01, 2005 at 05:18:49PM +0000, Catalin Marinas wrote:
> On 01/11/05, Chris Mason <mason@suse.com> wrote:
> 
> That's true, but you can use a 'git tag' command to mark the whole
> stack as something useful and this would include the state of all the
> patches on the stack. This would be a whole stack history, not
> individual patch history. Maybe we should implement this as well (or
> maybe only this).
> 
> Anyway, I wasn't sure that's the right implementation and that's why I
> didn't include Chuck's patch yet.

I would suggest just putting the .git/patches directory under revision
control.  If you make it a head in git and then add helper functions so
that common operations are easy to do, you won't be reimplementing the
whole SCM wheel just for patches.

For example:

stg commit-patch-tree:
    does git-write-tree and git-commit-tree on .git/patches

stg checkout-patches sha1:
    updates .git/patches to a given patch commit

stg diff-patches [-p] [-f]:
    by default this does the same as git-diff-tree
    -p, read the patch commit objects and diff the patch files
    -f, read the patch commit objects and diff the source files
   
The command names could be better, but the idea is to make commits that
change the state of your patch tree.  Later on, you'll be able to find the
one commit where you added 6 patches, or the one commit where you
adapted the whole tree to some new feature.

More importantly, you can reuse gitk and all of the other history
functionality in the SCM.

-chris
