From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 08:53:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512140837160.3292@g5.osdl.org>
References: <200512140257.03975.len.brown@intel.com> <7vmzj4yq3l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512140822540.3292@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 18:02:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmZt8-00051u-Qj
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 17:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVLNQx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 11:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVLNQx4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 11:53:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49113 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964858AbVLNQxz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 11:53:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBEGrdDZ026071
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Dec 2005 08:53:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBEGrcmk025307;
	Wed, 14 Dec 2005 08:53:38 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0512140822540.3292@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13634>



On Wed, 14 Dec 2005, Linus Torvalds wrote:
> 
> Argh. 
> 
> Len, how old a git are you using? "git-merge" really should _never_ have 
> done this, but old (and I mean really old) git merges sometimes got 
> confused with the base parent and would create a merge even when it was 
> unnecessary.

Going through the real kernel tree, this has happened before:

	commit 8e9887cc3b8d9f1c88c6f3842346a9478e52718f
	Merge: 0a47c906342e2447003e207d23917dfa5c912071 d2149b542382bfc206cb28485108f6470c979566
	Author: Len Brown <len.brown@intel.com>
	Date:   Wed Nov 30 22:22:52 2005 -0500
	
	    Auto-update from upstream

and doing a

	git-merge-base -a 0a47c906342 d2149b542

results in the second parent: d2149b542382bfc206cb28485108f6470c979566.

We also have two old ones:

	commit b129a8ccd53f74c43e4c83c8e0031a4990040830
	commit 603fff54420a0ccc4c3b48bfef43896fb4e33161

but both of those are from June, and of known causes (Russell King using 
an old git that didn't clean up after a failed merge, and he ended up 
committing a perfectly normal change as a bogus merge because git would 
remember that broken MERGE_HEAD).

So Len, since you seem to use "git merge" in your scripts, I suspect you 
have an old version of git lying around. Can you try doing just

	git merge-base -a 0a47c906342e2447003e207d23917dfa5c912071 d2149b542382bfc206cb28485108f6470c979566

to see what the result is for you?

Also, maybe the _reason_ you have an old git lying around is that you have 
two installations - if you have at some point installed both an RPM _and_ 
recompiled your own git, you may have different git versions in ~/bin and 
in /usr/bin, and then depending on how you log in to the machine, you may 
end up with different versions being used..

			Linus
