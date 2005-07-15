From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-diff-*: Allow "--name-only -z" as alias for
 "--name-only-z"
Date: Thu, 14 Jul 2005 22:12:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507142205580.19183@g5.osdl.org>
References: <20050714215126.GY9915@kiste.smurf.noris.de>
 <7vvf3d6nis.fsf@assigned-by-dhcp.cox.net> <20050714223622.GZ9915@kiste.smurf.noris.de>
 <7vmzop56fo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 07:15:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtIXw-0006NA-53
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 07:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbVGOFOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 01:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbVGOFOz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 01:14:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263211AbVGOFNV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2005 01:13:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6F5CHjA028266
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Jul 2005 22:12:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6F5CGbx027361;
	Thu, 14 Jul 2005 22:12:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzop56fo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Jul 2005, Junio C Hamano wrote:
> 
> That said, I have been hating that diff options parsing for
> quite a while, and I've been thinking about cleaning it up along
> the lines I'll outline here, but have not done anything about
> it.  Care to help me out?

I didn't do what you suggested, but I _did_ split the "format" up into 
"format + line_termination", which in my opinion cleaned up part of it a 
_lot_.

So now "-z" only sets "line_termination" to NUL. "format" starts out as 
"DIFF_FORMAT_RAW" (which is the old HUMAN/MACHINE format - the difference 
between those two are now the line termination) but can be "PATCH" and 
"NAME".

Now, DIFF_FORMAT_PATCH + -z wouldn't seem to make any sense at all, but
you can actually do so, and it actually makes some amount of sense for the 
case of

	git-diff-tree -v -p -z HEAD

where the "-z" means that the commit _message_ will be terminated by a NUL 
character, while the "-v" obviously means that the commit message will be 
printed at all, and the "-p" means that the diff gets printed as a patch.

But the diff obviously gets printed with newlines (as does any newlines
_within_ the commit message), not with lines terminated by NUL's.

So "--name-only-z" no longer exists. It's "-z --name-only" (in any order,
quite naturally).

			Linus
