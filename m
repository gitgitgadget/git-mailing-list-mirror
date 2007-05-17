From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Wed, 16 May 2007 22:58:31 -0700
Message-ID: <7vk5v89ek8.fsf@assigned-by-dhcp.cox.net>
References: <20070517023743.1982.41240.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 07:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoZ0b-00055D-43
	for gcvg-git@gmane.org; Thu, 17 May 2007 07:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbXEQF6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 01:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757153AbXEQF6f
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 01:58:35 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61429 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866AbXEQF6f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 01:58:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517055832.FFFK19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 01:58:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 05yX1X00k1kojtg0000000; Thu, 17 May 2007 01:58:32 -0400
In-Reply-To: <20070517023743.1982.41240.stgit@rover> (Petr Baudis's message of
	"Thu, 17 May 2007 04:37:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47505>

Petr Baudis <pasky@suse.cz> writes:

> .... Too bad that
>
> 	git-ls-remote --heads .
> 	
> is subtly different from
>
> 	git-ls-remote . refs/heads/
>
> so we have to provide the interface for specifying both.

I've already heard you say the above elsewhere, but I am not
sure what you exactly mean here.  Mind substantiating it a bit
more clearly?

I think "ls-remote --heads ." is just a special case of giving
"refs/heads/*" as the glob pattern:

        $ git ls-remote --heads . | head -n 3
        3545193735522f733fdb4e345f16ddf131e2007a	refs/heads/ap/ident
        b7993dd57a9cfd5b989f0e2cc5d271a524339318	refs/heads/db/remote
        960ccca6803c9fb57429d43572a9545a96107e32	refs/heads/dh/pack

	$ git ls-remote . refs/heads/ | wc -l
        0

	$ git ls-remote . "refs/heads/*" | head -n 3
        3545193735522f733fdb4e345f16ddf131e2007a	refs/heads/ap/ident
        b7993dd57a9cfd5b989f0e2cc5d271a524339318	refs/heads/db/remote
        960ccca6803c9fb57429d43572a9545a96107e32	refs/heads/dh/pack

	$ git ls-remote . "refs/heads/???/*"
        7841ce79854868eaaa146c1d018b17fc4f3320be	refs/heads/mst/connect

        $ git ls-remote . "refs/*/jc/*" | head -n 4
        80a767ba3b1c69fc41fa5f5fbe4a247757a9c575	refs/heads/jc/blame
        a1481ab7b16c51d4ec7925fd9b38d9cf21f72263	refs/heads/jc/diff
        4e8daa0dca5deb9d391538241939a2a2ad6d36b8	refs/tags/hold/jc/3way
        ff77ab7919e6f31cb6c58bc004217e624b553fb6	refs/tags/hold/jc/changes

So if you really do not want separate interfaces, I think you
could just implement --heads as what it is: a shorthand for
"refs/heads/*".
