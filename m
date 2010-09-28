From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: merge removed content back into current content
Date: Tue, 28 Sep 2010 11:26:21 -0500
Message-ID: <i7t52j$hl3$1@dough.gmane.org>
References: <i7jp1a$kc0$1@dough.gmane.org> <AANLkTimxHbCktv=kaq0UfV+u1kH1Pb2LYA2Xi=qkgduW@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 18:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0d2W-0000oh-0x
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 18:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab0I1Q2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 12:28:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:43803 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754144Ab0I1Q2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 12:28:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P0d2L-0000lc-Bk
	for git@vger.kernel.org; Tue, 28 Sep 2010 18:28:13 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 18:28:13 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 18:28:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157442>


>"Elijah Newren" <newren@gmail.com> wrote in message 
> >news:AANLkTimxHbCktv=kaq0UfV+u1kH1Pb2LYA2Xi=qkgduW@mail.gmail.com...
>On Fri, Sep 24, 2010 at 9:06 PM, Neal Kreitzinger <neal@rsss.com> wrote:
>> How do I tell git to merge a single program from an old commit into the
>> current version of that program in the HEAD commit? In this scenario, I
>> want to get back some removed code but still keep the new code.
>>
>> e.g.
>>
>> Commit-1 = initial commit containing Program-A, and other programs
>>
>> Commit-2 = add Changeset-1 to Program-A , and make changes to other 
>> programs
>>
>> Commit-3 = remove Changeset-1 from Program-A, then add Changeset-2 to
>> Program-A, and make changes to other programs
>>
>> *desired* Commit-4 = only merge Program-A from Commit-2 into Program-A of
>> Commit-3, and don't change any other programs
>> (in other words, get my old changes from Commit-2 back, but don't loose 
>> the
>> new changes from Commit-3)
>
>Does something like:
>  git diff commit1 commit2 -- ProgramA | git apply
>do what you need?
>
All of our source conflicts because we add a user/datestamp to the first 
line.  We do this to insure the programmer reviews the merge.
However, I never used git apply before so that was interesting to learn.

>If diff+apply doesn't work[1], you can try
>  git cat-file -p commit1:ProgramA > base
>  git cat-file -p commit2:ProgramA > other
>  git cat-file -p commit3:ProgramA > current
>  git merge-file current base other
>
This method is also something new to me, but it seems too manual.  It also 
does not do the normal git merge where the results are in the index.  An 
easier method is to do this:
git difftool commit1 commit2 -- ProgramA
and then use kdiff3's merge option.  this does not include the common 
ancestor as a reference like a normal git merge conflict followed by git 
mergetool (kdiff3), but is user friendly.  However, I'm not crazy about it 
because I'd rather have the merge results in the index and use git mergetool 
like I do for commit merges.

>[1] e.g. would cause conflicts -- btw, does anyone know how to force
>git apply to proceed and add conflict markers if necessary rather than
>just bailing out? 
