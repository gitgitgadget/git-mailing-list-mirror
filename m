From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 08:26:12 -0800
Message-ID: <20071119162612.GA10122@soma>
References: <47416F68.9070908@ogersoft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gerhard.oettl.ml@ogersoft.at
X-From: git-owner@vger.kernel.org Mon Nov 19 17:26:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9SB-0001rb-N3
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbXKSQ0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXKSQ0N
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:26:13 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35010 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbXKSQ0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:26:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4EF717DC0FE;
	Mon, 19 Nov 2007 08:26:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47416F68.9070908@ogersoft.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65461>

gerhard.oettl.ml@ogersoft.at wrote:
> I hope this is the correct mailing list. If not please point me in the 
> right direction.
> 
> 
> I played a little with git (1.5.3.4 / debian) and had the following 
> observation:
> Doing a "svn cp" (for example for a tag) results in a large traffic when 
> doing a "git-svn fetch" afterwards.
> 
> To verify I did:
> git-svn clone -s svn://www.ogersoft.at/ogerlit
> git-svn fetch
> svn cp svn://... svn://... (one file ca 3mb)
> svk checkout (a tcpflow output of about 3k - plaintext commands, I think 
> a svn checkout would be the same)
> git-svn fetch (a tcpflow output of 700k - containing a textdelta of 
> nearly 700k)
> 
> 
> So the question remains:
> Does svn-git dont know about lightweight svn copies?
> or can svn-git not handle them correct by now?
> or did I something wrong?

Older versions of the Perl SVN bindings have a broken do_switch()
function, so I fall back to the do_update() function which re-downloads
the whole tree instead..

SVN 1.4.4+ has this fix which allows do_switch() to be used instead of
do_update().

do_switch() will only download the delta between two trees if the parent
is present.

If you don't have easy access to 1.4.4+ packages, I have patched 1.4.3
(x86) packages here for Debian Etch (I haven't built 1.4.4 or 1.4.5 yet):

http://git-svn.yhbt.net/svn/

-- 
Eric Wong
