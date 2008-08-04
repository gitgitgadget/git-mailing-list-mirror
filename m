From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Sun, 3 Aug 2008 17:48:26 -0700
Message-ID: <20080804004826.GB13019@untitled>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807311243.35219.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 02:49:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPoGP-0007S9-Nr
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 02:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbYHDAs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 20:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYHDAs2
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 20:48:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50165 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbYHDAs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 20:48:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 250A62DC01B;
	Sun,  3 Aug 2008 17:48:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807311243.35219.litvinov2004@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91301>

Alexander Litvinov <litvinov2004@gmail.com> wrote:
> Make git-svn works with crlf (or any other) file content convertion enabled.
> 
> When we modify file content SVN cant apply its delta to it. To fix this
> situation I take full file content from SVN as next revision. This is
> dump and slow but it works.

> +	my $ctx = SVN::Client->new();
> +	$ctx->cat($fh, $url, $rev);
>  }

I know you've already (at least for now) pulled this patch but I won't
accept anything that opens a second connection to the server.

I've seen this in some svn:// servers intermittently, but I've seen
git-svn get its connection terminated whenever it opens a second
connection (it happens with parent-following).  git-svn used to do
this more frequently, but most of those cases got fixed (but
one remains with parent-following).

Additionally, git-svnimport and older versions of git-svn used the
equivalent of $ctx->cat without deltas from the SVN::Ra object, so you
should be able todo something functionally equivalent w/o opening a new
socket.



As far as crlf issues with git-svn go, I'm blissfully ignorant of the
complexities behind what git (or svn for that matter) does with crlf
conversions[1].

I'll be alright with any changes to git-svn that don't modify existing
behavior for crlf-ignorant users such as myself.  I'll trust Junio and
other folks on the list to know and do what makes the most sense here.



[1] I would have much rather preferred git didn't implement or care
    about crlf filters at all, but maybe I'm just in a small minority.

-- 
Eric Wong
