From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Mon, 19 Feb 2007 12:05:15 +0100
Message-ID: <81b0412b0702190305j20cf2d10w8f75c4345ba0fc26@mail.gmail.com>
References: <E1HIzh2-0001Ph-T2@candygram.thunk.org>
	 <7virdybu9a.fsf@assigned-by-dhcp.cox.net>
	 <20070219073238.GA30030@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "Theodore Ts'o" <tytso@mit.edu>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 19 12:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ6Kr-0005JN-7b
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 12:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXBSLFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 06:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbXBSLFT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 06:05:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:19740 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbXBSLFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 06:05:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so535937uga
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 03:05:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WkT3JX7BxbC4+vUIoSa4HGdZGIof7tcyLcf5FOJElVRLecD2T25lfv27iJuyYIe+85CaXb0Y5xiT2MJGP/OBtBJrVRgdqDBSidRfXlu29g5ijIA1AgTtIkFFk3UP+89kSGDLdV6YD4XM9hfKL5aJhFatNnLgd7feqslO4rHi8oA=
Received: by 10.78.47.15 with SMTP id u15mr1020906huu.1171883115880;
        Mon, 19 Feb 2007 03:05:15 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Mon, 19 Feb 2007 03:05:15 -0800 (PST)
In-Reply-To: <20070219073238.GA30030@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40120>

On 2/19/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > "Theodore Ts'o" <tytso@mit.edu> writes:
> >
> > > This allows users to use the command "git remote update" to update all
> > > remotes that are being tracked in the repository.
> >
> > Sounds like a good idea.  Thanks.
>
> <personalwishlist>
>
> It would be nice to define "gang remotes".  For example I want to
> be able to have:
>
>   `git fetch cs`  ==  `git fetch cs-one; git fetch cs-two`
>   `git fetch jc`  ==  `git fetch origin; git fetch alt`

I was thinking about something very similar.

> Why?  Well, I often have multiple remotes setup to the *same*
> repository depending on the SSH hostname I want to use to access
> that repository.  This has a lot to do with the way my firewalls
> are setup and where I'm physically connected at any given time.

For all the same reasons :)

> Yes, I really do have multiple remotes setup to the access the
> same (remote) physical disk.  :)
>
> Possible syntax:
>
>         [remote "cs"]
>                 remote = cs-one
>                 remote = cs-two
>         [remote "jc"]
>                 remote = origin
>                 remote = alt
>

Or :

  [remote "jc"]
    url = git://...
    fetch = refs/heads/*:remotes/jc/*
    remote ("include"? "next"?) = origin

(I mean: it can be allowed to mix url/fetch and remote).

And:

  [remote "jc"]
    fail = all-fail
    remote = origin
    remote = backup

IOW: the fetch fails only if all fetches fail (with default
being "fail = first").
