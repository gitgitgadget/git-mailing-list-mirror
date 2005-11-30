From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Question about handling of heterogeneous repositories
Date: Wed, 30 Nov 2005 16:01:00 +0100
Message-ID: <81b0412b0511300701w71da125am2dcc896b4693f37f@mail.gmail.com>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com>
	 <81b0412b0511300515u5d2840ccv92be6e374dd795be@mail.gmail.com>
	 <Pine.LNX.4.63.0511301457040.2284@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200511301540.34776.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 30 16:24:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhTTY-0005j7-Gb
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 16:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVK3PBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 10:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVK3PBE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 10:01:04 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:44335 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbVK3PBC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 10:01:02 -0500
Received: by nproxy.gmail.com with SMTP id x4so1236nfb
        for <git@vger.kernel.org>; Wed, 30 Nov 2005 07:01:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=akMEisMhOZPfSMG0O1v+gfEDFgAG6GTMYZ2fueGhNToQu+7lpIVJx/xkG9jfdYPHD3ybaSeCWUqSdbjOUG/+a6Yzb0p0v/VM5cr5nepo6qIKbvKHS/PCpSwJYQykTW7i89acIm6MLLY1mgRgB+bfuGSNOGvXSmjzNhJrSjv1a3A=
Received: by 10.48.221.20 with SMTP id t20mr29165nfg;
        Wed, 30 Nov 2005 07:01:00 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Wed, 30 Nov 2005 07:01:00 -0800 (PST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511301540.34776.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13001>

On 11/30/05, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> git-mv could support this. Additional to deleting from
> one repository and adding to the new, it could generate a remark for
> the commit message, like:
>
>  Added file xxx is from remote repo '/path/myrepo' with name 'yyy'
>  (file SHA1: 123445... from remote commit SHA1: 345667...)

That's sounds very tempting to special-case for nested repos :)

Maybe use .git/objects/info/alternates in top-level repo? It may
have side-effects of the new objects ending up in top-level repo
if commited from top-level directory. Even then, the tools can
be tought to stop looking for GIT_DIR in the directory closest
to the file being commited:
  $ pwd
  .../top
  $ git-commit sub1/dir/file
  ... uses repo in .../top/sub1 instead of $(pwd)/../top/.git

Looks very messy, with a potential for lots of corner cases and
not that tempting anymore :(

> This info could be interesting both for humans and a history browsing tool.
> The tool still would have to know where to look for repo '/path/myrepo'.
> It could also work for moving subdirectories (ie. trees instead of files).

Well, these are just lots of files. I can't really think of case were
I'd need to know about moving a directory without knowing what
happened to the files.

>
> Josef
>
