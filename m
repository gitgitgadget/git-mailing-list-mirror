From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 10:28:31 +0600
Message-ID: <200702081028.31493.litvinov2004@gmail.com>
References: <17866.27739.701406.722074@lisa.zopyra.com> <7vr6t13251.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 05:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF0tr-0001JV-Ln
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 05:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161500AbXBHE2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 23:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161517AbXBHE2k
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 23:28:40 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:42149 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161500AbXBHE2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 23:28:39 -0500
Received: by an-out-0708.google.com with SMTP id b33so373960ana
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 20:28:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BlT+fH5/n5gtuNHHH7Ld+njG17Wg12BiO+wQK8qlcjDmc0aaVA8WfyEazhJtyBo4KmnLKd72nnZfo2gjmDoccG+goqNc6lYneIxG+vnEZ9lhJPJXmcjkpck7oi+0GFiz0RLpVhJodA7H5lSFJn3k2RWqA+Qg6pvQjKdmajvI+UE=
Received: by 10.100.94.3 with SMTP id r3mr9457263anb.1170908919203;
        Wed, 07 Feb 2007 20:28:39 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id u6sm2409760uge.2007.02.07.20.28.37;
        Wed, 07 Feb 2007 20:28:37 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <7vr6t13251.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39029>

> In order to prevent merging their 'master' into your 'topic'
> when you are on 'topic', git-fetch/git-pull from 1.5.0 uses
> further safety which is left by 'git clone'.  The real
> configuration created by 'git clone' looks like this:
>
> 	[remote "origin"]
>         	url = /repos/git/project
>                 fetch = refs/heads/*:refs/remotes/origin/*
> 	[branch "master"]
>         	remote = origin
>                 merge = refs/heads/master
>
> The 'fetch' lines correspond to 'Pull' in .git/remotes/origin file;
> it uses globbing pattern so if there are new branches on the
> remote side you can automatically track them, which is a plus.
>
> But more importantly, when 'fetch' lines only do the globbing
> pattern, 'git pull' without explicitly saying which remote
> branch you want to merge to the current branch (perhaps by
> mistake) refuses to do a merge, if there is no branch.*.merge
> configuration ("refs/heads/master" in the above example).  So
> with the above configuration, 'git pull' from 1.5.0 will fetch
> two remote branches and keep them in remotes/origin/master and
> remotes/origin/topic, and if you are on 'master' their
> refs/heads/master is merged into your current branch, but if you
> are on 'topic', it will not do the merge step (this only applies
> to "git pull" without any refspec parameters).
>
> With 1.4.4 series, I think you can create the [branch] section
> yourself and do something like this:
>
> 	[remote "origin"]
>         	url = /repos/git/project
>                 fetch = refs/heads/master:refs/remotes/origin/master
>                 fetch = refs/heads/topic:refs/remotes/origin/topic
> 	[branch "master"]
>         	remote = origin
>                 merge = refs/heads/master
> 	[branch "topic"]
>         	remote = origin
>                 merge = refs/heads/topic
>
> This configuration also works with 1.5.0, so if you are happy
> with this (I am assuming you are using 1.4.4 series, preferably
> the last one, 1.4.4.4), after you upgrade to 1.5.0, it will
> continue to do its thing (but you would want to upgrade the
> fetch line).

I think this should go to git-pull/git-clone man pages. Personaly for me this 
post dispels dark magic about git-pull's merging logic. I always did 
git-fetch and then git-pull . <some-branch> to control what and where should 
be merged.
