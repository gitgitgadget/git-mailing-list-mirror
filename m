From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: git fetch vs push, git am questions
Date: Tue, 7 Dec 2010 14:14:04 -0600
Message-ID: <idm4j0$ov1$1@dough.gmane.org>
References: <99351291667275@web152.yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 21:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ3xI-0005If-6M
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0LGUOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 15:14:40 -0500
Received: from lo.gmane.org ([80.91.229.12]:40891 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab0LGUOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 15:14:39 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PQ3vq-0004Wq-Ot
	for git@vger.kernel.org; Tue, 07 Dec 2010 21:14:38 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 21:14:38 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 21:14:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163122>

"Konstantin Kivi" <kkivi@yandex.ru> wrote in message 
news:99351291667275@web152.yandex.ru...
> HI all
> I honestly tried to find answers in various docs/books about git and 
> failed, so I have to ask here.
>
> 1) Is it possible to achieve the same result with git fetch, as I have 
> with git push. I have cloned a bare repository (2) from my repository (1) 
> and
> I want fetch made in (2) get all info contained in (1) . I talk only about 
> 'master' here. git push from (1) to (2) does the job, but git fetch in (1) 
> updates only origin/master, and not master.
> I also found that there is a notions of current branch in bare repository 
> (master in my case), that stops my experiments of deleting master and 
> making new master out of origin/master.
> How can I change current branch in bare repositry?
>
> 2) I read that git rebase used 'git am' internally. How can  force git 
> am/apply to create conflicts like rebase does in form
>
> <<<<<<old
> dksjfd
> ========
>>>>>>jfkjdfkd
>
> instead of *.rej files
>
I think the --mirror technology was made for what you are trying to do.  I 
created my bare repo as a mirror, but I see you don't want to recreate your 
bare repo.  However, I think you can convert yours to a mirror by modding 
your config for that repo.  With a bare repo that is a mirror, a git fetch 
will make the bare repo look exactly like the remote repo it is mirroring. 
That is, the mirror will get everything that the remote has.  If the mirror 
has extra branches that the remote does not have then the mirror will also 
keep the extra branches as is.  However, I think if you push from the mirror 
to the remote the remote will get those extra branches so watch out for that 
(I haven't tried it yet because I don't need to do that.)

You could play around with it on a testcopy of your bare repo:

cp -rp barerepo.git testmirror.git

will make a totally functional copy of your barerepo.git.  Then you could 
mod the config of testmirror.git to try and convert it to a mirror.  The 
mirror technology is on the git-clone manpage.  It doesn't explain it in 
much detail, but this is what I've learned from playing around with it.  You 
can first create a bare repo mirror with git-clone to find out what the 
config setting are supposed to be.

For the push you can create a test copy of your remote:

cp -rp remote testremote

and then alter the config of testmirror.git to point to testremote.  If you 
are pushing from testremote to testmirror.git then be sure to mod 
testremote's config to point to testmirror.git.  I don't push from my remote 
to my mirror because I use git fetch to get stuff from the remote to the 
mirror.  You shouldn't need to git push from your remote to your mirror, 
either.  However, you may have valid reasons for doing so, but I'm not sure 
what they would be.

I am using a mirror very heavily in productional work so I know it works 
(for what I want).  I recommend you play around with it for yourself to get 
a feel for it and not just go by what I say (the manpage does not explain it 
very much).

Hope this helps.

v/r,
Neal 
