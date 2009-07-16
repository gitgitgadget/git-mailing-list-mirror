From: Andrey Smirnov <allter@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Fri, 17 Jul 2009 02:09:01 +0400
Message-ID: <cdea6cd10907161509g7771c72bl608b1924785b49fc@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
	 <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
	 <20090430085853.GA21880@pvv.org>
	 <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com>
	 <loom.20090716T160021-218@post.gmane.org>
	 <32541b130907161134n51e070a1l93690d1b8a63bee8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 00:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRZ8d-0007pY-4G
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 00:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933429AbZGPWJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 18:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933391AbZGPWJG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 18:09:06 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:51084 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933364AbZGPWJE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 18:09:04 -0400
Received: by ewy26 with SMTP id 26so482242ewy.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PIPeLKabrJ2fP0JMgbsHLw1kZNZw3VZV02NiNj3jgIo=;
        b=Ti1fbrQlcbJ+yUoVyDQBmhzZjF8FtIUDu/ygXiaVHZRxHHq+8kYwzGXnyktAaWKH+Q
         mWwQCRKrv66YQBVvM6/9sOORMLqI45PjE+1sJH22hvNTXjWobaUH5NFKh/DoCitmSisn
         OHZTSYy5mdTu+IPmfksuCFdO++0XIqltm9a2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lkd3ylQMXuwRiauPJYNABpJlDq0qhNduKcPKwtAtuVnGb74IS+g0+6i9ViUzwwZ2D0
         QK3IVXFlpbTBElzKgFol98iEaVUuiRi4t2oAGj0K4fM/tXoD/jMYFtdnrGavZ+Ho7Nvz
         qbo8UEkL0zgnR+Nb6oDqrtNcYnW9kabccB+IE=
Received: by 10.216.19.212 with SMTP id n62mr96568wen.66.1247782141246; Thu, 
	16 Jul 2009 15:09:01 -0700 (PDT)
In-Reply-To: <32541b130907161134n51e070a1l93690d1b8a63bee8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123430>

Hello!

On Thu, Jul 16, 2009 at 10:34 PM, Avery Pennarun<apenwarr> wrote:
>> When I did
>>   git subtree split --prefix=lib NewProj -b test-split
>>  and
>>   git subtree split --prefix=lib OldProj -b test-split-old
>> I got the following two trees without a common root:
>>
>> ...X ----- Y ----- OldProj ----...---- Z ---- NewProj
>>
>> X' ----- Y'==test-split-old ----- Z'==test-split
> So, why don't they have a common root?  This is, of course, the
> primary cause of your problems.

The line with OldProj and NewProj is story of commits for the project
that contains both library and other code. The line with test-split
and test-split-old is the story of commits of the shared library alone
with test-split-old corresponding to OldProj and test-split
corresponding to NewProj.
And I needed to get changes test-split-old..test-split in superproject
(but without other
garbage commits that lead to NewProj).

> How did this shared library get merged into OldProj and NewProj in the
> first place?  Did you just copy the files, or did you use something
> like 'git merge -s subtree'?  If the latter, you should be able to
> convince git-subtree to produce two split repositories with identical
> roots, and then merge smoothly between them.

They don't share commits because the library was never developed on its own.
The library evolved from the common code that was cut and pasted
trough about a hundred
web projects stored in SVN. Before I started to use git (mostly I use
it as merge/rebase tool
because our primary VCS is still Subversion) I transplanted changes in
library by manual
svn merge, even on individual files in some cases. While I was typing
my previous message, I
found that if I added "--rejoin", I would have situation that imitate
effect of "add test-split-old"
command followed by "merge -s subtree test-merged":

...X ----- Y ----- OldProj ----- rejoined-merge ----...---- Z ---- NewProj
                                     /                \
X' ----- Y'==test-split-old                      Z''==test-merged
                                   \
                                     Z'==test-split

But Subversion and git-svn don't like git-ish merges, they need rebase. :(

>  git checkout -b test-merged test-split
>  git checkout OldProj
>  git subtree split --prefix=lib OldProj --rejoin
>  git subtree merge --prefix=lib test-merged

Yes, that's one of ways I thought of and that I pictured above. But I
would like
approach that deals only with patches and not commit trees due to
git-svn restriction.

>> And so I ask if this behavior is the way git-subtree was meant to work.
>> It probably has sense to add 'rebase' command to git-subtree script to let
>> perform such tasks simplier.
> I don't think that's a good idea.  git-subtree is completely separate
> from rebasing, and doesn't deal with patches at all.  Maybe there
> should be some kind of "force-update" option that does what "git
> subtree add" does, but wiping out everything in the subtree before it
> starts.  That would have simplified the above commands a bit.

The only thing that links git-subtree with git-rebase is the fact, that
git-subtree "knows" the target commit for rebases dealing with subtrees.
So if one knows commit of a subtree that he wishes to see in superproject
(in my case "test-split") he could issue:
    git subtree rebase --prefix=lib OldProject test-split

Though simple:
    git rebase --onto OldProject test-split-old test-split
worked for me, I think this was a lucky coincidence because of simplicity
of my library commits.

--
Sincerly yours, Andrey.
