From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 04:26:05 -0500
Message-ID: <5364b62d5fb7b_ac68dd30816@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5364A143.1060404@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sat May 03 11:36:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgWNH-0007He-IU
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 11:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbaECJgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 05:36:47 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:50293 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaECJgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 05:36:45 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so6387842obc.34
        for <git@vger.kernel.org>; Sat, 03 May 2014 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=KykU4ylHZOLiVgUykiiWa4OnSVLy+gZQvuyBRbW78ho=;
        b=YD3mKJODi6WpQwiWTzDwLToG0qlpresGq4DL619qsWqsLr6Yp+4T6CcU8ewcbfdhWF
         6L0JQGz7hMx/RHVvuuzdbZLUgxCj/pZo7F8j/WV4WEz+ENxjVRKOPLCsy0x7JEcuQqlI
         ngiB2Bm4z7ANevJnfKFOCOTz7BUUCOrCqJKOBmXdRo/yMX8xIzRRD1dxbJ/YJnATU9f2
         JScz5mRQMglhOozOpQt3reonQgh5k2CC7dLzSOEG0AS9GZ+OdCVMYWdhfN7KJTK2Ue4S
         W/7Yys30YYkea45AwwPl3HgKxSo9YLPQ7fRmvm2wtQj7vFar2LCGiDTQjcrpYSq1fLc6
         J4PA==
X-Received: by 10.182.213.168 with SMTP id nt8mr19859931obc.7.1399109805192;
        Sat, 03 May 2014 02:36:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm7804438oeb.11.2014.05.03.02.36.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 02:36:43 -0700 (PDT)
In-Reply-To: <5364A143.1060404@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248030>

Richard Hansen wrote:

> I think the fundamental difference is in the relationship between the
> local and the remote branch (which branch derives from the other).
> The relationship between the branches determines what the user wants
> from 'git pull'.
> 
> In my experience 'git pull' is mostly (only?) used for the following
> three tasks:

I agree.

>  1. update a local branch to incorporate the latest upstream changes
> 
>     In this case, the local branch (master) is a derivative of the
>     upstream branch (origin/master).  The user wants all of the
>     commits in the remote branch to be in the local branch.  And the
>     user would like the local changes, if any, to descend from the tip
>     of the remote branch.

My current propsal of making `git pull` by default do --ff-only would
solve this. In addition I think by default 'master' should be merged to
'origin/master', if say --merge is given.

>     For this case, 'git pull --ff-only' followed by 'git rebase -p'
>     works well, as does 'git pull --rebase=preserve' if the user is
>     comfortable rebasing without reviewing the incoming commits first.

I suppose you mean a `git rebase -p` if the `git pull --ff-only` failed.
This might be OK on most projects, but not all.

What happens after a `git pull --ff-only` fails should be totally
up to the user.

>  2. update a published feature branch with the latest changes from its
>     parent branch
> 
>     In this case, the local branch (foo) is a derivative of the
>     upstream branch (origin/foo) which is itself a derivative of
>     another branch (origin/master).  All commits in origin/master
>     should be in origin/foo, and ideally all commits unique to
>     origin/foo would descend from the tip of origin/master.

I don't understand why are you tainting the example with 'origin/foo',
'foo' and 'origin/master' are enough for this example. In fact, the
mention of 'origin/master' made it wrong: after the pull not all the
commits of origin/master would be in origin/foo, you need a push for
that. We have enough in our plate to taint this with yet another branch
and push.

For this case `git pull origin master` already work correctly for most
projects. We probably shouldn't change that.

>  3. integrate a more-or-less complete feature/fix back into the line
>     of development it forked off of
> 
>     In this case the local branch is a primary line of development and
>     the remote branch contains the derivative work.  Think Linus
>     pulling in contributions.  Different situations will call for
>     different ways to handle this case, but most will probably want
>     some or all of:
> 
>      * rebase the remote commits onto local HEAD

No. Most people will merge the remote branch as it is. There's no reason
to rebase, specially if you are creating a merge commit.

>      * merge into local HEAD so that the first parent (if a real merge
>        and not a ff) is the previous version of the main line of
>        development and the second parent is the derivative work
>      * merge --no-ff so that:
>         - the merge can serve as a cover letter (who reviewed it,
>           which bug reports were fixed, where the changes came from,
>           etc.)
>         - the commits that compose the new topic are grouped together
>         - the first-parent path represents a series of completed tasks

It is very rare that an integrator is even able to do a fast-forward
merge anyway. So being explicit about --no-ff might better, but it would
hardly make a difference. Either way, a good integrator would configure
pull.ff = false.

I'd say `git pull origin master` already works fine for this case.

-- 
Felipe Contreras
