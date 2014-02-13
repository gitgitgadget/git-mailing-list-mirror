From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Process of updating a local branch from another with tracking
Date: Thu, 13 Feb 2014 21:42:04 +1300
Message-ID: <52FC855C.9010204@gmail.com>
References: <CAHd499CQK7Mmd+vWb74Nj4usX8KhmurJNd31MrAMUs6Vb2zOOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 13 09:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDrs6-0008Mg-2b
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 09:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbaBMImJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 03:42:09 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:34038 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbaBMImI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 03:42:08 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so10461585pbc.40
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 00:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=0qkIGMvVHmJrvC6jKw8FTjB/9pB5LFonMH364M8YPIQ=;
        b=rVUkTJBWysGk6WSOlWtkS+ny7IF2uHmVH0Xbt9oEsSPEqyOuWXxJ00OQ1RL+cUcyLO
         QmubgUK/Y41zi48tzjJdhtk6+9SW3ykSyyvaiFgpXNfzfNiyCNGsNMtzOUNq04k5iqzI
         5VszBWR7X9ZkdfexFF7j8xbKLYBMEwycL/XfH0HetvrNKkiaoFs+1WEvCpc+pJLoNjO2
         /vWct6ylBkmalt4z6Ou3rJHERFJxwG6gKjiIFbm8VpwYhdDAR5MADy0AfEtqS2rEy73P
         vgEd6jhxQ+Kgogag5JMO23c9u4B4pDeq8YLI32vfrA332jq2U38LYrDRke/36EunePlK
         x36g==
X-Received: by 10.68.227.36 with SMTP id rx4mr319082pbc.164.1392280928043;
        Thu, 13 Feb 2014 00:42:08 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id id1sm4066931pbc.11.2014.02.13.00.42.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Feb 2014 00:42:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAHd499CQK7Mmd+vWb74Nj4usX8KhmurJNd31MrAMUs6Vb2zOOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242050>

On 13/02/14 10:55, Robert Dailey wrote:
> I have the following alias defined:
> sync = "!f() { cbr=$(git rev-parse --abbrev-ref HEAD); git co $1 &&
> git pull && git co $cbr && git rebase $1; }; f"
> 
> The goal is to basically update a local branch which tracks a branch
> on a remote, and then rebase my local topic branch onto that updated
> local branch.

Generally speaking there is little benefit in manually keeping a local
branch that just tracks a remote one because you already have a "remote
tracking branch" which gets updated whenever you fetch from that remote.
So you could be doing something like

  git fetch origin # or whatever other remotes you may have configured
  git rebase origin/master # or whatever branch you're tracking

You can also tell git this kind of information when you create your
topic branch and git will to this all for you.

  git checkout -b topic1 origin/master
  git pull -r # -r makes pull run fetch + rebase instead of pull + merge

If you already have a topic branch and you want to tell it what remote
branch (upstream) to track you can do that too.

  git checkout topic
  git branch -u origin/master
  git pull -r

> I do this instead of just rebasing onto origin/master. Example:
> 
> git checkout master
> git pull --rebase origin master
> git checkout topic1
> git rebase master
> 
> I could do this instead but not sure if it is recommended:
> 
> git checkout topic1
> git fetch
> git rebase origin/master

I do it all the time. Actually I set the upstream and I can just use
'git pull -r'.

> Any thoughts on the alias I created? I'm a Windows user and still new
> to linux stuff, so if it sucks or could be simplified just let me
> know.

Aliases are fine to save yourself some typing. In this case I think you
can just set the upstream branch and use 'git pull -r'. There is a
config option to make this the default but you probably want to be
comfortable with the difference between merging and rebasing before you
set that.

> And as a secondary question, just curious what people think about
> rebasing onto a remote tracking branch. When I do merges I usually
> refer to the remote branch, but during rebase I use the local branch
> instead, but I don't know if there is any functional reason to not
> skip the local branch and go straight to the remote tracking branch
> (it saves a step).

Branches are branches. You might use multiple local branches to separate
dependent topics that you're working on. You might do the same with
remote branches if you have topics based on other peoples work.
