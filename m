From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-files handling of 'missing' files
Date: Mon, 13 Feb 2006 19:56:32 -0800
Message-ID: <7vpslqwq33.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602132126210.6352@gheavc.wnzcbav.cig>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 04:56:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8rIv-0000y9-Hi
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 04:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWBND4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 22:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWBND4g
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 22:56:36 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33671 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750945AbWBND4f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 22:56:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214035527.BMXG3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 22:55:27 -0500
To: Jon Nelson <jnelson-git@jamponi.net>
In-Reply-To: <Pine.LNX.4.63.0602132126210.6352@gheavc.wnzcbav.cig> (Jon
	Nelson's message of "Mon, 13 Feb 2006 21:46:44 -0600 (CST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16109>

Jon Nelson <jnelson-git@jamponi.net> writes:

> The documentation confuses me when it says that files marked with a 'K' 
> are "to be killed / other" - it don't understand why 'killed' and 
> 'other' are lumped together.

I think there is a typo in asciidoc source (probably ?:: is needed).
Whenever you see funky things in the documentation please first
check the Documentation/that-file.txt to see if you are just
seeing a bad rendition of what was meant.

> The docs for git-ls-files indicate that a file marked as 'killed' (wrong 
> tense?) is a file that needs to be removed for git-checkout-index to 
> succeed. The manpage doesn't say why git-checkout-index needs to succeed 
> or under what conditions git-checkout-index would be invoked. (ie, "why" 
> should I manually remove this file).

This was from long time ago so I may be misremembering things
but it is for D/F conflicts.  index has "doc/file1" stored but
your working tree has a regular file doc.  To check "doc/file1"
out you would need to remove that file.  Or index has a regular
file "path2" stored when you have "path2/file2" on the working
tree (hence path2 is a directory), in which case "path2/file2"
needs to disappear.

> It seems to me that files can also exist in the state 'new' or 'added' 
> (is this the same as unmerged?) Is there a state for 'conflict'?

Remember, ls-files is about index vs working tree files.  It
works before your initial commit, and never looks at the HEAD
commit.  'new' or 'added' has no meaning.  working tree file is
either known to be the same (thanks to stat information that is
cached in the index), known to be different (ditto), or unknown
(when stat information is stale), relative to index.

Unmerged and conflict should be the same, I think.
