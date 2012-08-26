From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Re*: mergetool: support --tool-help option like difftool does
Date: Sun, 26 Aug 2012 20:38:22 +0200
Message-ID: <503A6D1E.5070909@web.de>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFAE1.3070304@gmail.com> <7vr4s2mnir.fsf@alter.siamese.dyndns.org> <7vipdemm0a.fsf_-_@alter.siamese.dyndns.org> <7vzk5m41gk.fsf_-_@alter.siamese.dyndns.org> <CAJDDKr42YtfcpARQx6Vx8-Uy7KF3yEoGOQ0VzPKsWQA_hG=MgA@mail.gmail.com> <7vvcg94if1.fsf@alter.siamese.dyndns.org> <CAJDDKr6zk3ztEXeX8=vn3apZ3k1DxdCAu2ZDyqtNnb=Cb5ZUvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5hkN-0000tv-U3
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab2HZSja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 14:39:30 -0400
Received: from mout.web.de ([212.227.17.12]:52261 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab2HZSix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 14:38:53 -0400
Received: from [192.168.178.41] ([91.3.164.193]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LxOHm-1Tgb7u3oYE-016P3e; Sun, 26 Aug 2012 20:38:30
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CAJDDKr6zk3ztEXeX8=vn3apZ3k1DxdCAu2ZDyqtNnb=Cb5ZUvQ@mail.gmail.com>
X-Provags-ID: V02:K0:Cld5UPNhcw+1Ptl2PbSP+F1Kia/kWsVToGBL3fYwMum
 UNfY+NsJ+I9eHml+WXqMXXrX53LIU+YlQQpxJ1tHlM4i38aQdx
 odsRTxYTuiaGWZw/iudPFC8mBd6/X7HfmxrhYg8PQhWtIFxEWR
 GW9wmGcitmuJ4ad45wo8CfYprewI7DDvy8KmnfyLd4qSiBx+HR
 6q2Zsorvh1d8BGRu8KE2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204308>

Am 24.08.2012 10:31, schrieb David Aguilar:
> On Thu, Aug 23, 2012 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>> Would the ability to resolve the various merge situations using
>>> the command-line be a wanted addition?
>>>
>>> This would let a submodule or deleted/modified encountering
>>> user do something like:
>>>
>>> $ git mergetool --theirs -- submodule
>>>
>>> ...and not have to remember the various git commands that it runs.
>>
>> Does it have to run various git commands?  For a normal path, all it
>> needs to do is "git checkout --theirs $path", no?
>>
>> What does it mean to resolve a conflicted merge of a gitlink to take
>> "theirs"?  We obviously would want to point the resolved gitlink at
>> the submodule commit their side wants in the resulting index but what,
>> if any, should we do to the submodule itself?
>>
>> Stepping back a bit, if there is no conflict, and as a result of a
>> clean merge (this applies to the case where you check out another
>> branch that has different commit at the submodule path), if gitlink
>> changed to point at a different commit in the submodule, what should
>> happen?
>>
>> If you start from a clean working tree, with your gitlink pointing
>> at the commit that matches HEAD in the submodule, and if the working
>> tree of the submodule does not have any local modification, it may
>> be ideal to check out the new commit in the submodule (are there
>> cases where "git checkout other_branch" in the superproject does not
>> want to touch the submodule working tree?).
>>
>> There are cases where it is not possible; checking out the new
>> commit in the submodule working tree may not succeed due to local
>> modifications.  But is that kind of complication limited to the
>> merge resolution case?  Isn't it shared with normal "switching
>> branches" case as well?
>>
>> If so, it could be that your "git mergetool --theirs -- submodule"
>> is working around a wrong problem, and the right solution may be to
>> make "git checkout --theirs -- $path" to always do an appropriate
>> thing regardless of what kind of object $path is, no?
> 
> True.

I agree.

> Admittedly, I'm not a heavy submodule user myself so I
> tried crafting the directory vs submodule conflict to see
> what the usability is like.
> 
> checkout --theirs and --ours could learn a few tricks.

Me thinks that after I successfully taught checkout to properly
recurse into submodule work trees too it should know all those
tricks. In my current version it can handle directory/submodule
conversions in both directions, this should be sufficient to
make "checkout --theirs/--ours" work properly. Note to self: add
tests for that.

> When trying to choose the directory in that situation
> I had to  had to "git rm --cached" the submodule path
> so that git would recognize that there was no longer a conflict.
> 
> That makes sense to me because I was following along by
> reading the mergetool code, but I don't think most users
> would know to "git rm" a path which they intend to keep.

True. But a submodule recursing checkout would do the right thing
here too.

> Afterwards, the .git file is left behind, which could cause
> problems elsewhere since we really don't want a .git file
> in that situation.

Hmm, either you remove all the files tracked in the submodule
together with the gitfile or you'll possibly have former submodule
files lying around there too. Recursive checkout will do all that
for you.

>  I'm not even sure what to do about the
> .gitmodules file either.

Maybe we should issue a warning when the .gitmodules file is not
consistent with the [non]existence of a submodule in the work tree?

> That said, this really isn't an issue, per say.
> I first poked at it because I noticed that mergetool
> still needed stdin for some things.
> 
> It's certainly an edge case, and perhaps this just shows
> that mergetool really is the right porcelain for the job
> when a user runs into these types of conflicts
> (the stdin thing really isn't an issue).

It looks to me as if the submodule/directory conflict can be handled
by a recursive checkout without having to add something to mergetool.
