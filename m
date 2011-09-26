From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Mon, 26 Sep 2011 01:56:38 +0100
Message-ID: <1aec7c1qq0n56.sxybjnsj6ngr$.dlg@40tude.net>
References: <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <op.v2byz2p80aolir@keputer.lokaal> <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net> <201109242259.p8OMxqIM026259@no.baka.org> <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net> <m31uv4rc47.fsf@localhost.localdomain> <1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net> <m3oby8pcfz.fsf@localhost.localdomain> <1ttmqsxtaj98i$.hv6s5shjeugr.dlg@40tude.net> <20110926003447.GG10955@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 02:58:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7zWe-0006nJ-JE
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 02:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab1IZA45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 20:56:57 -0400
Received: from lo.gmane.org ([80.91.229.12]:50749 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290Ab1IZA44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 20:56:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R7zV9-0006NB-PN
	for git@vger.kernel.org; Mon, 26 Sep 2011 02:56:55 +0200
Received: from 31.64.26.194 ([31.64.26.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 02:56:55 +0200
Received: from a5158017 by 31.64.26.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 02:56:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.26.194
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182086>

Konstantin Khomoutov wrote:

>>>> From what I read, detached heads are subject to garbage collection.
>>>  
>>> No, HEAD is protected against garbage collecting.  To be sure you
>>> should name a branch when switching branches, though reflog would
>>> protect you for 30 days (by default) even if you don't do that.
>> 
>> So Git doesn't really support anonymous branching as part of a normal
>> workflow.
> 
> I perceive a certain logical fallacy here: you cannot switch between
> anything anonymous because to switch, you should somehow identify
> something to switch to--a name in whatever sense we put into this word.

In Mercurial, you can just update to a particular changeset (and you
identify that changeset by repository-local revision number or globally
unique ID) and then commit again.  The point is that there's no need to
give a label to a head in Mercurial (although you can if you want to, using
Mercurial bookmarks, which are basically the same as what Git uses).

Here's an example of anonymous branching:

    c:\test>hg init

    c:\test>echo test>foo

    c:\test>hg commit --addremove -m initial
    adding foo

    c:\test>echo first>>foo

    c:\test>hg commit -m first

    c:\test>hg log
    changeset:   1:3e895ec28d6c
    tag:         tip
    user:        tactical
    date:        Mon Sep 26 01:39:46 2011 +0100
    summary:     first

    changeset:   0:b51644bb3450
    user:        tactical
    date:        Mon Sep 26 01:39:40 2011 +0100
    summary:     initial

    c:\test>hg update 0
    1 files updated, 0 files merged, 0 files removed, 0 files unresolved

    c:\test>echo second>>foo

    c:\test>hg commit -m second
    created new head

    c:\test>hg glog
    @  changeset:   2:35c82a7e7de1
    |  tag:         tip
    |  parent:      0:b51644bb3450
    |  user:        tactical
    |  date:        Mon Sep 26 01:40:10 2011 +0100
    |  summary:     second
    |
    | o  changeset:   1:3e895ec28d6c
    |/   user:        tactical
    |    date:        Mon Sep 26 01:39:46 2011 +0100
    |    summary:     first
    |
    o  changeset:   0:b51644bb3450
       user:        tactical
       date:        Mon Sep 26 01:39:40 2011 +0100
       summary:     initial

I now have two anonymous branches, and these will never be garbage
collected.  I can easily update to either branch with "hg update 1" or "hg
update 2" (or "hg update 0" again, if i want to create yet another
anonymous branch).

> As I understand, by switching between branches in Mercurial you mean
> switching between directories with clones;

No.  Clones are a different topic.

> As to branches, they do have names in Git but they are very loosely
> coupled with their names: tag a tip of some branch (to still have a
> handle on that tip commit) then delete that branch--there will be no
> traces of that branch's name left, the branch's name is not encoded in
> its history in any way.

Git branch names are basically the same as Mercurial bookmarks.  The
difference is that in Mercurial you don't *have* to use bookmarks.

> The branch names is just a way to not mess with
> SHA-1 names of commits (and to have references to those commits to keep
> them out of consideration for garbage collection).
> Hence the idea to demand support for anonymous branches in Git's model
> is just unfounded.

I think it's simply a weakness of Git.  There are zero problems with
anonymous branching in Mercurial, and it's a very powerful and simple
system.
