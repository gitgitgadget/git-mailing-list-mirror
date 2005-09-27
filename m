From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 15:27:25 +0200
Message-ID: <200509271527.26050.Josef.Weidendorfer@gmx.de>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net> <200509271214.31933.Josef.Weidendorfer@gmx.de> <20050927123455.GE30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 15:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKFUh-0005Uf-RD
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 15:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVI0N1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 09:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVI0N1h
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 09:27:37 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:52886 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S964930AbVI0N1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 09:27:36 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id A26A026E7;
	Tue, 27 Sep 2005 15:27:35 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.2
In-Reply-To: <20050927123455.GE30889@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9395>

On Tuesday 27 September 2005 14:34, Petr Baudis wrote:
> But we don't need any global tags or heads. You just have some heads in
> your refs/heads (it doesn't matter if they are public or remote, that's
> a "social" issue what you tell people to fetch). And based on your heads
> you have in your refs/heads, there would be directories in your
> refs/tags/ corresponding to those.

Ah, ok.

Let me see if I understand:
1) These tags are bound to a head, and they have the invariant that they 
appear in the commit history of the head.
2) They are updated automatically.
3) When someone rebases a head, the bound tags should be synced to the
rebased head's history.
4) Tags can appear multiple times, if they happen to be in the commit
history of multiple heads?

How to make sure that the invariant mentioned in (1) always holds?

> If you fetch remote head, its local subdirectory in refs/tags/ is
> populated with the new tags, and if you merge two heads, the public tags
> are copied around.

Ok, this is the "automatically updated" feature I talked about above.
So missing here is:
- If you want to get rid of a head, the tags should be removed
- If a head is rebased, this has to be detected and the tags recreated,
possibly removing some

Probably there should be a "cg-tag --recover" to resync these volatile
tags with tag objects appearing in the histories of heads?

As for lightweight tags of remote repositories, you probably need some
space to recover them e.g. on a rebase or creation of a new head without
running git-ls-remote all the time.

> Then if you are resolving a tag, we should first look 
> at refs/tags/$(readlink HEAD)/tagname, and if it doesn't exist, we would
> look at refs/tags/tagname (so if you wanted to reference a tag not in
> your head, you'd have to use a "head/tag" form).

Sounds nice.

> > Perhaps interpret tag objects as global branch names, similar to
> > the "mixture" in .git/refs ?
>
> I don't understand.

Tag objects in a repository could be interpreted as branch names
for commits based on it. When creating a new branch point, I first
would put a tag object on this branch, thus renaming it.
I think this would be quite handy for navigation in histories.

Josef
