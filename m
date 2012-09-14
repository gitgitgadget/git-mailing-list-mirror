From: Andreas Ericsson <ae@op5.se>
Subject: Re: inconsistent behavior on mac with case changes
Date: Fri, 14 Sep 2012 15:48:30 +0200
Message-ID: <505335AE.9000906@op5.se>
References: <CACwCsY4iO2WzXizbG+75OJ096OpHp7KOidn4q11nfxnkJuQg_g@mail.gmail.com> <CACwCsY4vQDQNqaMaAEJEDGbZWVFbktfXrQj+-79fN40_d+075g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Larry Martell <larry.martell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 15:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCWGD-0000Ae-PQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 15:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab2INNsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 09:48:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45264 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab2INNsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 09:48:35 -0400
Received: by lbbgj3 with SMTP id gj3so2761681lbb.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 06:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=w88NobP6yZvRzPbbSroqx25CQ6BHYGFXfCarwGRiktI=;
        b=e0WN02/1m/Buur8DIeTjiTOrHifaruneaTieXY9qz1Q6XOzZ/1rGgZYWsGQdLpZ46q
         unvcG3oXcrzxEShG0270Zan/t0HWWeRK1Zjdq2z0aji0ZVukHHbW5WsazA+wlwgjf1cQ
         IZZn+UPpZXfBDcACl8lNUXhecEAo3iJPhBzDeh7iwTjKb1mNFjw/zRLCMENGnztuAjbb
         zlJIAKliEa8rJme8dvI8t3Eap6LU37ZPjP1uIaIij74OQDm1MjYTYAb5PvOqlA5XFGu8
         aDVJbGF6d3Rqdc+RY4LvMCvIZP6Dc0J9E5lcKE/P+CRL1q4b+whBiEg91f8Ddpa7JraU
         jtXg==
Received: by 10.152.48.70 with SMTP id j6mr2404551lan.57.1347630514138;
        Fri, 14 Sep 2012 06:48:34 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id u5sm553503lbg.8.2012.09.14.06.48.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 06:48:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
In-Reply-To: <CACwCsY4vQDQNqaMaAEJEDGbZWVFbktfXrQj+-79fN40_d+075g@mail.gmail.com>
X-Gm-Message-State: ALoCoQmo/IbjXisQtfro0lm0h7Tyu+RtXyaPdLemNKnk6/br37Ld+wzZprD1Spn8FlsNwjwT0LJZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205490>

On 09/14/2012 02:37 PM, Larry Martell wrote:
> On Thu, Sep 13, 2012 at 5:24 PM, Larry Martell <larry.martell@gmail.com> wrote:
>> I created a dir on my Mac called Rollup, and pushed it out. Then went
>> to a CentOS box, pulled it, and realized I wanted to call it RollUp
>> (capital U). I renamed it, and pushed out the change. Went back to the
>> Mac and did a pull - it said it created the RollUp dir, but it did not
>> - it was still called Rollup. I reamed it, but status did not pick up
>> the change. Then I checked out a branch that had Rollup, but it was
>> gone there - no Rollup or RollUp. I did a merge and then RollUp was
>> created.
>>
>> I know the Mac is somewhat inconsistent with how it deals with case, e.g.:
>>
>> $ ls
>> RollUp
>> $ ls -d Rollup
>> Rollup
>> $ ls -d RollUp
>> RollUp
>> $ find . -name Rollup -print
>> $ find . -name RollUp -print
>> ./RollUp
>>
>> So I guess I can understand git also being inconsistent there. But
>> what really got me was the dir being gone on the branch.
>>
>> Is all this expected behavior?
> 

More or less. Git sees Rollup and RollUp as two different directories,
so assuming everything inside it is committed git is free to remove
the directory that exists on one branch but not the other when switching
branches in order to keep the work tree in sync with the index.

Consider this (most output cut away):

git init
touch base; git add base git commit -m "first commit"
mkdir foo && touch foo/lala && git add foo/lala && git commit -m "meh"
git checkout -b newbranch HEAD^
ls -ld foo
ls: cannot access foo.: No such file or directory
mkdir bar && touch bar/bear && git add bar/bear && git commit -m "rawr"
git checkout master
ls -ld bar
ls: cannot access bar.: no such file or directory

If git would leave your committed directory in the worktree when you
move to a branch that doesn't have it, it would put you in a very
weird position where you may have to clear away rubble from someone
else, or start depending on code that's not in your branch. So yes,
you're seeing the expected behaviour, and OSX is retarded wrt case
sensitive filenames. I'd suggest you either reformat your drive to
stop using HFS+ or do your development work inside a loopback fs
mounted with proper case sensitivity, as there's really no sane way
around the problem OSX causes.

> Is this not the correct list for a question like this? If not, is
> there another list that's more appropriate?

It is, but people don't always spend their days looking for questions
to answer.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
