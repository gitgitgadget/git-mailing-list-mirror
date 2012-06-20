From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Push to a branch breaks origin, requires a manual gc to fix
Date: Wed, 20 Jun 2012 15:10:49 -0500
Message-ID: <4FE22E49.4020400@gmail.com>
References: <CAMO9iftAP_QKDJwssvPhg0jm8MBjV3isCxKNuP0Ewf-X6kYtxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Varshavchik <sam.varshavchik@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:11:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShREy-0007PP-2V
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391Ab2FTUK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:10:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57827 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab2FTUKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:10:53 -0400
Received: by obbuo13 with SMTP id uo13so440obb.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=71HZfpLgwEEPfxHkvqlSWoI+XSq5ZkUJYVYcQdfgvtY=;
        b=Terrnh9/f4yy7UOpRg9ALXa9KQjf/fpOpjE42XpXWww+Hb5MkQxnKeJ+FvLoOUlQ0A
         3fEXnqz5V/jXGCpRikUyrUmsHIWVK9sFpngUHm3rzrtHxKLGBH5vCmYpryXQTkYBpHn/
         HlqnAxRLyzgfGsXt3ce7D+AsbPcnKLROQDWaqbaxQ82iU6o8mR2qzPWjerSNzSPFHs4J
         pgPT3UvXNNwSpFlMGSLoCsz2CLPwgPSWw4iENj59qd8kP7hoBJGzkJMhTgmpo1JpTGzo
         HeFb9Ryjij7Oa6Ne1ChsYr8t5mB8JA3RkLaaScS/0iFz3vGtVZ4ZFyZIBiBc2y6h3Ufv
         4Sww==
Received: by 10.182.72.42 with SMTP id a10mr24764762obv.22.1340223052883;
        Wed, 20 Jun 2012 13:10:52 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id hg10sm23937113obb.15.2012.06.20.13.10.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 13:10:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAMO9iftAP_QKDJwssvPhg0jm8MBjV3isCxKNuP0Ewf-X6kYtxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200357>

On 6/17/2012 10:07 AM, Sam Varshavchik wrote:
> Something's goes wrong every time I push a branch to origin.
>
> When I start, everything looks ok:
>
> $ git remote show origin
> * remote origin
>    Fetch URL: http://monster/gitrepos/stasher.git/
>    Push  URL: http://monster/gitrepos/stasher.git/
>    HEAD branch: master
>    Remote branches:
>      distreboot tracked
>      master     tracked
>    Local branches configured for 'git pull':
>      distreboot merges with remote distreboot
>      master     merges with remote master
>    Local refs configured for 'git push':
>      distreboot pushes to distreboot (fast-forwardable)
>      master     pushes to master     (up to date)
>
> I push:
>
> $ git push
> Fetching remote heads...
>    refs/
>    refs/heads/
>    refs/tags/
> updating 'refs/heads/distreboot'
>    from 0000000000000000000000000000000000000000
>    to   e0bce568272859eca817455acafb5f0a52b8fd5a
>      sending 6 objects
>      done
> Updating remote server info
> To http://monster/gitrepos/stasher.git/
>     6d4900e..e0bce56  distreboot ->  distreboot
>
> This breaks something:
>
> $ git remote show origin
> * remote origin
>    Fetch URL: http://monster/gitrepos/stasher.git/
>    Push  URL: http://monster/gitrepos/stasher.git/
>    HEAD branch: (unknown)
>    Remote branches:
>      distreboot                 tracked
>      refs/remotes/origin/master stale (use 'git remote prune' to remove)
>    Local branches configured for 'git pull':
>      distreboot merges with remote distreboot
>      master     merges with remote master
>    Local ref configured for 'git push':
>      distreboot pushes to distreboot (up to date)
>
> Going forward, clone will fail:
>
> $ git clone http://monster/gitrepos/stasher.git/ stasher-test
> Cloning into 'stasher-test'...
> warning: remote HEAD refers to nonexistent ref, unable to checkout.
>
> If I do some random fiddling in the origin repo (not really knowing
> what I'm doing, I can usually fix it:
>
> sh-4.2$ cat HEAD
> ref: refs/heads/master
> sh-4.2$ ls -al refs/heads
> total 16
> drwxr-xr-x 3 apache apache 4096 Jun 17 10:53 .
> drwxr-xr-x 4 apache apache 4096 May 24 10:37 ..
> drwxr-xr-x 2 apache apache 4096 Jun 17 10:53 .DAV
> -rw-r--r-- 1 apache apache   41 Jun 17 10:53 distreboot
> sh-4.2$ cat info/refs
> e0bce568272859eca817455acafb5f0a52b8fd5a	refs/heads/distreboot
> sh-4.2$ git gc
> Counting objects: 124, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (59/59), done.
> Writing objects: 100% (124/124), done.
> Total 124 (delta 67), reused 116 (delta 63)
> sh-4.2$ cat info/refs
> e0bce568272859eca817455acafb5f0a52b8fd5a	refs/heads/distreboot
> ee94edb5fcdc7a28ffbdeaabe841e3ecff863983	refs/heads/master
> sh-4.2$ ls -al refs/heads
> total 12
> drwxr-xr-x 3 apache apache 4096 Jun 17 10:54 .
> drwxr-xr-x 4 apache apache 4096 May 24 10:37 ..
> drwxr-xr-x 2 apache apache 4096 Jun 17 10:53 .DAV
>
> git clone starts working again.
>
> Until I push the branch, and then master breaks again.

i don't use http with git, but have you looked at git-config manpage and 
searched for http?  i know i've heard http has extra considerations. 
The version of git you are using may be important info also.  there is 
something in git-config about unclonability problems with older git 
versions.

v/r,
neal
