From: mac4-git@theory.org
Subject: Re: [PATCH] Support ref logs for refs/*
Date: Thu, 8 Jan 2009 08:52:40 -0800
Message-ID: <20090108165240.GA22815@tesla.theory.org>
References: <20090108082827.GA6177@tesla.theory.org> <20090108180857.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 17:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKy90-0007uR-7b
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbZAHQwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbZAHQwm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:52:42 -0500
Received: from in.theory.org ([64.147.163.250]:36904 "EHLO tesla.theory.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbZAHQwl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:52:41 -0500
Received: by tesla.theory.org (Postfix, from userid 1014)
	id 6575224BB76; Thu,  8 Jan 2009 08:52:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090108180857.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104934>

On Thursday, January 08, 2009, the wise Nanako Shiraishi wrote:
>Quoting Neil Macneale <mac4-git@theory.org>:
>
>> The documentation for git update-ref seems to imply that logging of ref
>> updates should be done for anything in refs/...
>
>The documementation for git-update-ref is part of git, and git does not use anything outside of refs/{heads,tags,remotes}/ for its normal operation. 
>
>I think it is generally assumed that there is nothing of interest outside of these areas that deserves the automated creation of reflogs, and the code you are touching is about that. Once you have reflog for any ref you are interested outside of these areas, your actions will be logged regardless. 

Why is that generally assumed? I can fetch to arbitrary refs and git prune
doesn't clean objects references from argitrary refs, so it seems like
there is implicit support for these references. A little extra logging
never hurt anyone.

>Most notably, refs/stash itself is exempt from this code path and it makes sure that reflog exists without relying on log_all_ref_updates configuration. 

Why not? I'd like like have logs for stash actions. Makes the case when
someone runs git stash clear by mistake a little easier to recover from.

The alternative is for me to touch a file in .git/logs/refs prior to any
use of git update-ref.  It seems like most git commands go to great
lengths to prevent you from ever needing to get into the .git dir, so maybe
an alternative would be an option to force git update-ref to create a log
file automatically. I thought thats what the "all" in core.logallrefupdates
meant. Silly me. 

A command line option for git update-ref is not ideal because when I run
git fetch remote refs/whatever:refs/whatever, I still want a log entry. 
Thus, I still need to be mucking with the .git dir when I shouldn't need
to.

Whats the harm in a little more logging? The space wasted is pretty much
nothing. I'd much rather be able to look at a ref log in the event that I
mess somthing up than run git fsck.

Cheers,
Neil

>
>-- 
>Nanako Shiraishi
>http://ivory.ap.teacup.com/nanako3/
>
>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
