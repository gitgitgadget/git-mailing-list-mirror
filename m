From: Larry Martell <larry.martell@gmail.com>
Subject: Re: inconsistent behavior on mac with case changes
Date: Fri, 14 Sep 2012 10:18:17 -0400
Message-ID: <CACwCsY5kE-v6vzpURQ6oGsLPcYMivYs6DzZANBdvppk0jqZ2_w@mail.gmail.com>
References: <CACwCsY4iO2WzXizbG+75OJ096OpHp7KOidn4q11nfxnkJuQg_g@mail.gmail.com>
	<CACwCsY4vQDQNqaMaAEJEDGbZWVFbktfXrQj+-79fN40_d+075g@mail.gmail.com>
	<505335AE.9000906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 14 16:18:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCWix-0004LU-S8
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 16:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2INOST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 10:18:19 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61002 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab2INOSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 10:18:18 -0400
Received: by vcbfo13 with SMTP id fo13so3887937vcb.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UssBZPNjduNaFCmT+dN04Ebvpf7ZOZFd5sKtuEIzyYE=;
        b=DuVqUdG7GHDa1D1d6QGDzdoEtf0IwH/cHsidL6mf3vhZQBQK1h+3GtD6LUN5+gI0EO
         SP+Btp+ku2x9xtjLajWO31CWPtYHMH9aCz8/ZgDv3y9tUtinLqCK97X6uXvH/wXjdn+q
         FnKY85c10sgs/rlMj95sqZZRciVkX1JBYH88/8MpFgO6/MhF6MqMIYgMrFiRduizgI3A
         Bop+7fqMtXS53coB6/Z5I6aD5Fk4YZQDybPRFx41LUOwb2pi0bY6Zr7GHjNrsR1xphiv
         /DXalueuTHgF/kiH4bGvDL+LfuwQX2+n7RO2fhCO7lLRvgTPquOnucqyLhW0G54a3kf4
         IjWw==
Received: by 10.58.58.144 with SMTP id r16mr2290057veq.52.1347632297227; Fri,
 14 Sep 2012 07:18:17 -0700 (PDT)
Received: by 10.58.198.112 with HTTP; Fri, 14 Sep 2012 07:18:17 -0700 (PDT)
In-Reply-To: <505335AE.9000906@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205491>

On Fri, Sep 14, 2012 at 9:48 AM, Andreas Ericsson <ae@op5.se> wrote:
> On 09/14/2012 02:37 PM, Larry Martell wrote:
>> On Thu, Sep 13, 2012 at 5:24 PM, Larry Martell <larry.martell@gmail.com> wrote:
>>> I created a dir on my Mac called Rollup, and pushed it out. Then went
>>> to a CentOS box, pulled it, and realized I wanted to call it RollUp
>>> (capital U). I renamed it, and pushed out the change. Went back to the
>>> Mac and did a pull - it said it created the RollUp dir, but it did not
>>> - it was still called Rollup. I reamed it, but status did not pick up
>>> the change. Then I checked out a branch that had Rollup, but it was
>>> gone there - no Rollup or RollUp. I did a merge and then RollUp was
>>> created.
>>>
>>> I know the Mac is somewhat inconsistent with how it deals with case, e.g.:
>>>
>>> $ ls
>>> RollUp
>>> $ ls -d Rollup
>>> Rollup
>>> $ ls -d RollUp
>>> RollUp
>>> $ find . -name Rollup -print
>>> $ find . -name RollUp -print
>>> ./RollUp
>>>
>>> So I guess I can understand git also being inconsistent there. But
>>> what really got me was the dir being gone on the branch.
>>>
>>> Is all this expected behavior?
>>
>
> More or less. Git sees Rollup and RollUp as two different directories,
> so assuming everything inside it is committed git is free to remove
> the directory that exists on one branch but not the other when switching
> branches in order to keep the work tree in sync with the index.
>
> Consider this (most output cut away):
>
> git init
> touch base; git add base git commit -m "first commit"
> mkdir foo && touch foo/lala && git add foo/lala && git commit -m "meh"
> git checkout -b newbranch HEAD^
> ls -ld foo
> ls: cannot access foo.: No such file or directory
> mkdir bar && touch bar/bear && git add bar/bear && git commit -m "rawr"
> git checkout master
> ls -ld bar
> ls: cannot access bar.: no such file or directory
>
> If git would leave your committed directory in the worktree when you
> move to a branch that doesn't have it, it would put you in a very
> weird position where you may have to clear away rubble from someone
> else, or start depending on code that's not in your branch. So yes,
> you're seeing the expected behaviour, and OSX is retarded wrt case
> sensitive filenames. I'd suggest you either reformat your drive to
> stop using HFS+ or do your development work inside a loopback fs
> mounted with proper case sensitivity, as there's really no sane way
> around the problem OSX causes.

Thanks for the detailed reply!
