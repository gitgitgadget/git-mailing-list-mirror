From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Thu, 07 Sep 2006 23:37:42 +0200
Organization: At home
Message-ID: <edq3eb$1tm$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <edpuut$dns$1@sea.gmane.org> <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 07 23:38:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLRa0-0002dq-5A
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 23:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWIGVid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWIGVid
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 17:38:33 -0400
Received: from main.gmane.org ([80.91.229.2]:32737 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751894AbWIGVic (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 17:38:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLRZP-0002Sl-I9
	for git@vger.kernel.org; Thu, 07 Sep 2006 23:37:59 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 23:37:59 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 23:37:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26658>

Jon Smirl wrote:

> On 9/7/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> I don't understand. Git is _not_ patchset based (like GNU Arch, or
> 
> I meant change set to refer to a commit plus trees plus blobs that
> make it up. These may be present in full or delta form.
> 
>> Mercurial, or CVS). It is snapshot based. So if you want to download
>> "skip", you need only for the local part of downloader to make 
>> appropriate grafts, like below
>>
>>
>>  *--*--*--*--*--*--*--*--*--*--*--HEAD    (server)
>>
>>  *--*--*...........*--*--*--*--*--HEAD    (shallow/sparse clone)
>>
>> But the part you were talking about is _easy_ part; the hard part is
>> merges including merging branch which was split off the trunk before
>> cutoff-point, history rewriting (c.f. 'pu' branch, and rebases), etc.
> 
> Does an average user do these things? The shallow clone is there to
> address the casual user who gags at a five hour download to get an
> initial check out Mozilla when they want to make a five line change or
> just browse the source for a few minutes.

The question is not if average user do these things, but do average user
encounter these things. I think that merging branches into 'master' branch
(trunk) is quite common, and merging trunk into branches for checking is
also common.

As to checking out latest revision... with git-archive --remote (or
git-tar-tree --remote as of now) you can download newest version as
archive; although without commit object I think.

> I would expect advanced users to have a full tree present.
> 
> I was going to have the dangling references from the shallow clone
> point to 'not-present' objects. When you try to do any of the more
> complex operations you would hit these objects and fault down more of
> the tree.

Only if you consider git-log to be complex operation. It would be better I
think to cover laps using grafts.

In first post you are talking about downloading diff covering the lap/skip;
it would be important only if git was patchset based. You need to download
commits and referenced objects, _except_ cutting off some parents.

> There would also be a command to bring down all of the objects to
> fully populate a sparse tree. You could do the shallow clone to begin
> with and then do the full tree populate overnight or in the
> background.

And that should be done by marking "shallow"/"sparse" grafts and just delete
them (or update if needed).

> Maybe the answer is to build a shallow clone tool for casual use, and
> then if you try to run anything too complex on it git just tells you
> that you have to download the entire tree.

The shallow/sparse/lazy[*1*] clone proposal is one of recurring proposals
(besides subproject support) on git mailing list.

Footnotes:
[*1*] Lazy clone, also known as remote alternatives.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
