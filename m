From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: git-svn with multiple remote repositories?
Date: Tue, 2 Dec 2008 15:07:43 -0800
Message-ID: <9071816B-9AA4-4891-8719-556446C16AD7@gmail.com>
References: <20081202213930.GD12716@raven.wolf.lan>
Mime-Version: 1.0 (iPhone Mail 5G77)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Wed Dec 03 00:09:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7eMi-00069u-54
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 00:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbYLBXHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 18:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYLBXHx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 18:07:53 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:52007 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbYLBXHw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 18:07:52 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3176801rvb.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=eK+y5A7Q+AzfoR9OFN7Fgtxdx1AN0QRzdobWAeB+nhg=;
        b=vF2t+gmPL1OG3zkdDmPh7ofcqr+Yz1MYaeKZhgH+cY6GJplhLHSVgBvRiiiunqDtGp
         h++e0JHedJIh19aLDocoTkSzMQ78iG9FtFQz7K0NO0OsykyDhiRYRs3iZRPHe/w0yWQq
         aGAjVGQ4TYcy6cDA17WNJx1t39a6+WMJAL/rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=GbRxses/kitfqQ4xVaLbYXVBjwKz2aVxLk88uDR/v2nFiz3xugknhHB43XcM3mfTyg
         xUPnwil+Kp90jfIRHPaVPI3N66e0M3vgmyRe+HnhVICbbIwC9OS5iHAYHT0WidBJmpw7
         2Q7wIzmUTRHNRyeh6qCc6AKPMiOjyQwTP9MHw=
Received: by 10.140.188.19 with SMTP id l19mr5990533rvf.216.1228259271177;
        Tue, 02 Dec 2008 15:07:51 -0800 (PST)
Received: from ?10.0.45.117? ([166.190.239.171])
        by mx.google.com with ESMTPS id f21sm10884065rvb.5.2008.12.02.15.07.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 15:07:50 -0800 (PST)
In-Reply-To: <20081202213930.GD12716@raven.wolf.lan>
X-Mailer: iPhone Mail (5G77)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102186>

No branch for your checkout is correct. Try something like: git  
checkout -b foo public/trunk

On Dec 2, 2008, at 13:39, Josef Wolf <jw@raven.inka.de> wrote:

> Hello,
>
> I am trying to create a git repository with two remote svn  
> repositories
> so that I can merge/move patch-sets back and forth between the svn
> repositories.
>
> This is what I have tried so far:
>
>  mkdir -p project
>  cd project
>  git-svn init -R private -s https://foo.bar/repos/private
>
> Then I go and edit .git/config too look like this:
>
>  [core]
>          repositoryformatversion = 0
>          filemode = true
>          bare = false
>          logallrefupdates = true
>  [svn-remote "private"]
>          url       =   https://foo.bar/repos/private
>          fetch     =      trunk:refs/remotes/private/trunk
>          branches  = branches/*:refs/remotes/private/*
>          tags      =     tags/*:refs/remotes/private/tags/*
>  [svn-remote "public"]
>          url       =   https://foo.bar/repos/public
>          fetch     =      trunk:refs/remotes/public/trunk
>          branches  = branches/*:refs/remotes/public/*
>          tags      =     tags/*:refs/remotes/public/tags/*
>
> And finally, I do
>
>  git-svn fetch -R private
>  git-svn fetch -R public
>
> Both commands seem to fetch the contents from their origins.  But
> git-branch shows me only the local master branch with contents from
> the "private" svn repository.  When I do
>
>  git checkout public/trunk
>
> the contents actually change to reflect the "public" svn repository,
> but git-branch says I am on "(no branch)" at all.
>
> As a newbie to git, I am somewhat confused now.  Any hints how I can
> get a hold on the remote branches merge between them?
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
