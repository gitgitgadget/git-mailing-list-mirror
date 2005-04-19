From: Petr Baudis <pasky@ucw.cz>
Subject: Re: naive question
Date: Tue, 19 Apr 2005 19:15:34 +0200
Message-ID: <20050419171534.GH12757@pasky.ji.cz>
References: <16997.222.917219.386956@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:12:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwGM-00021p-7T
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVDSRPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVDSRPm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:15:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38850 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261207AbVDSRPf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:15:35 -0400
Received: (qmail 1493 invoked by uid 2001); 19 Apr 2005 17:15:34 -0000
To: torvalds@osdl.org, Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <16997.222.917219.386956@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 03:00:14PM CEST, I got a letter
where Paul Mackerras <paulus@samba.org> told me that...
> Is there a way to check out a tree without changing the mtime of any
> files that you have already checked out and which are the same as the
> version you are checking out?  It seems that checkout-cache -a doesn't
> overwrite any existing files, and checkout-cache -f -a overwrites all
> files and gives them the current mtime.  This is a pain if you are
> using make and your tree is large (like, for instance, the linux
> kernel :), because it means that after a checkout-cache -f -a you get
> to recompile everything.

Actually, to then get sensible show-diff output, you need to also
update-cache --refresh to compensate for the changes. I personally
really hate update-cache --refresh; sure, 0.1s with hot cache, but
easily eats 5 minutes (!) with cold cache.

I'd actually prefer, if:

(i) checkout-cache simply wouldn't touch files whose stat matches with
what is in the cache; it updates the cache with the stat informations
of touched files

(ii) read-tree would take over the stat information from the matching
files in previous cache.

This way, doing update-cache --refresh would become a rather rare event.
Stuff would become swifter, faster, less I/O bound and you would get rid
of problems as the one described above.

What do you think?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
