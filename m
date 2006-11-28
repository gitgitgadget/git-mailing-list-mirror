X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 14:13:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281355480.4244@woody.osdl.org>
References: <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
 <20061128215332.GK28337@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 22:13:40 +0000 (UTC)
Cc: Nicholas Allen <nick.allen@onlinehome.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061128215332.GK28337@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32592>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBCh-0004tw-Lf for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757471AbWK1WNY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbWK1WNY
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:13:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:20906 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1757471AbWK1WNY (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:13:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kASMDDix007405
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 14:13:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kASMDCaH028010; Tue, 28 Nov
 2006 14:13:12 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org



On Tue, 28 Nov 2006, Shawn Pearce wrote:
> 
> Except when you are doing a large merge, your terminal scrollback
> is really short, and there's a lot of conflicts.  Then you can't
> see what merge said about any given file.  :-(

Heh. Which is partly why I just do "git diff", which usually tells me what 
is up, or "git log --stat --merge", which is usually even better. I've 
never actually had to scroll up.

[ But I'll also admit that I used to have a "xterm*savedlines=5000" in my 
  .Xdefaults, and it might be worth it for some people. I haven't actually 
  needed it with git, because the _real_ reason for it used to be applying 
  patch-sets, and I've made sure that the git patch-application is so 
  robust that I never need to go back and look for reasons for conflicts - 
  if something conflicts, it just _stops_ and undoes the whole patch 
  instead of continuing to apply the rest or leave the already-applied 
  part applied. ]

Although I agree that we could probably also improve "git status" output, 
especially as I doubt it has been tested much.

People don't tend to use "git status" very much, I suspect - the most 
common usage is not in "git status" itself, but simply as the commit 
message template, and that one obviously cannot have any unmerged stuff at 
all (since then we'd refuse to even go as far as asking for a commit 
message in the first place).

Figuring out that the reason for a conflict is a name clash is not 
necessarily possible after the merge, though: it's really up to the merge 
policy to decide to merge a file cleanly or not, and the "Why" part of why 
some particular merge policy decided not the resolve a file is really 
internal to the policy, and not externally visible in the tree itself.

(But we can certainly see whether it was a pure content conflict or 
whether it had some component of a name clash by just looking at what 
stages we have for a name: so we could at least separate out the causes 
for merge failures at least _partially_ in "git status")

> Fortunately its easy to back out of the merge and redo it with
> large enough scrollback, or redirecting it to a file for later
> review, but its annoying that we don't save that information off
> for later review.

I personally find "git log --merge" to be a huge timesaver. But I have to 
say, I don't think I've seen more than one or two name conflicts ever, and 
almost all of the true issues tend to be just regular data conflicts. So 
that's what I personally care about most.

[ For the non-git users, "git log --merge" is just shorthand for a much 
  more complicated git revision parsing expression which boils down to: 
  "show all commits as they pertain to any remaining unmerged pathnames, 
  and only within the symmetrical set difference between the two branches 
  you merged". You could write it out as

	git log ORIG_HEAD...MERGE_HEAD -- $(git ls-files --unmerged)

  but that "git log --merge" is a much simpler shorthand for that thing. 

  It's not that merge conflicts are necessarily common, but when they do 
  happen, that's where you _really_ want the SCM to support you in 
  figuring out what happened ]

So with "git diff" showing a three-way diff for anything unmerged, and 
"git log --merge" showing the commits that caused the problems, I don't 
think I've ever really needed to go back and say "ok, so why did that 
fail". 

It's just that "git status" was never what I'd have used in the first 
place. I guess it's been long enough since I used CVS that "git status" 
doesn't even enter my mind all that much on a merge failure.

