From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Please consider adding a -f switch to git-clone (or something similar)
Date: Sat, 7 Mar 2015 18:32:47 -0800
Message-ID: <569EEC82-664C-48A7-990D-BFCDB7D78D16@gmail.com>
References: <CA+ToGPEZN7TBcYF3o5YgbayjZ8WKok-fjTPeq5nbt2vAG1wDDQ@mail.gmail.com> <87d24kzbor.fsf@igel.home> <CA+ToGPHOM9mu_ng4wVc7QUGyvf09y=nDjE32oSh9JzKbpbzN2Q@mail.gmail.com> <CA+ToGPFSbOjfd5gJg+r-7WkwMB=m=4sOupaZo1WUn+O0bxAAXw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Diego Viola <diego.viola@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 03:33:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUR1Z-0001aM-8J
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 03:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbbCHCcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 21:32:52 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44444 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbCHCcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 21:32:51 -0500
Received: by padet14 with SMTP id et14so38724585pad.11
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 18:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=D/6PWYAss9BPYv+IIyusBKaUR7nusROt5mJ0FA7dSEk=;
        b=SZVLOsdYNzsZvEmJI7gs9EJTgmUWP7iTrYAbKpbgKPhQIgQeMFKJd0ya4m0mo2ErBF
         87+sS+8cQUL4miUzGFUK5Ah4iU1QAnsBXLau2qK6vY9tyIE/FjA7n/SapkQuI76FZFoA
         w563S5glnCdXNLIz10r9QwFraMdSQaibbTTLchv0rj2ALobfI5NGpxZUldgXCSImHI3B
         EcfTc5z/imBoJT9uCYfZpsaqIA6jMMSjDi/NXLN5LjvP8XbUa8yaVE5i9JPgnn+5o3V3
         tyc4Jmw8DsTXNDmBSEQmR9Fc8UUzmIcccxSHKhTuIGMlkJWw+grbna23jELsziJ+Nuu4
         N6kg==
X-Received: by 10.66.141.42 with SMTP id rl10mr39148871pab.124.1425781970838;
        Sat, 07 Mar 2015 18:32:50 -0800 (PST)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id in3sm13491622pbd.50.2015.03.07.18.32.49
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 18:32:50 -0800 (PST)
In-Reply-To: <CA+ToGPFSbOjfd5gJg+r-7WkwMB=m=4sOupaZo1WUn+O0bxAAXw@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265024>

On Mar 7, 2015, at 17:53, Diego Viola wrote:
> Something like this is the scenario I'm talking about:
>
> $ mkdir non-empty-dir
> $ cd non-empty-dir
> $ touch foo bar baz
> $ git clone -f url:user/dotfiles.git .
> $ git status
> On branch master
> Your branch is up-to-date with 'origin/master'.
> Untracked files:
>  (use "git add <file>..." to include in what will be committed)
>
>    bar
>    baz
>    foo
>
> nothing added to commit but untracked files present (use "git add"  
> to track)

Have you considered using an alias?

git config --global alias.irfc \
   '!sh -c '\''git init && git remote add origin "$1" && git fetch &&  
git checkout "${2:-master}"'\'' sh'

(You'll likely have to carefully unwrap that line above.)

Then you get

   git irfc <URL> [<branch>]

where <branch> defaults to master.
So your scenario would become just:



$ mkdir non-empty-dir
$ cd non-empty-dir
$ touch foo bar baz
$ git irfc url:user/dotfiles.git
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

    bar
    baz
    foo

nothing added to commit but untracked files present (use "git add" to  
track)


-Kyle

P.S. irfc = init, remote, fetch, checkout.  But do make up a better  
name. :)
