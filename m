From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 8 Apr 2008 23:33:49 -0400
Message-ID: <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
	 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
	 <47FBDA77.2050402@et.gatech.edu>
	 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
	 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 05:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjR5K-0008Gi-4n
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 05:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYDIDdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 23:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbYDIDdy
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 23:33:54 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:51866 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085AbYDIDdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 23:33:53 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3265902mue.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RCTU5XgqM+T0QNnSvVhIorr0bV640iohl9YH1XrNFx8=;
        b=OzcdgYobRannFn+XcTirZwttGPG7KRZym3E9ElTtulGt5aUHD4SSfbe1rIW5wxEtbNhnbGGOLW1KhJJyODJsfv7XLPi2rFDxuYYXVznQJoieNuhXijfDa6sXMVoJOHDZwhpRc5qHyO2FtBPYVXIkuBQHWJy8Yn0H2pE96EX/c8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HJktzsltawnk6Cjgovn4eY90zBI4UnqZKiZbO9znjURU6IwQLlL6TlX5C2bmPk84ZxykhSirHx/YhZ0C8curqUVRxlz2xhyGxkwjVxkBq9UaRbNqIuRILtCjYQpPnskxfpDfCPnAypimK6rnvilhqXuyxDvBkRsrlPCGYBPR4ic=
Received: by 10.82.165.5 with SMTP id n5mr2404826bue.39.1207712029405;
        Tue, 08 Apr 2008 20:33:49 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 8 Apr 2008 20:33:49 -0700 (PDT)
In-Reply-To: <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79068>

On Tue, Apr 8, 2008 at 11:03 PM, Roman Shaposhnik <rvs@sun.com> wrote:
> On Apr 8, 2008, at 2:01 PM, Avery Pennarun wrote:
> > The way to understand git-submodule's operation is in terms of what it
> > actually does.  Roughly speaking, git-submodule-add puts things into
> > .gitmodules and .git/config;
>
>  I could be mistaken, but I don't think "git submodule add" does anything
>  to the .git/config. In fact, how settings migrate between .gitmodules
>  and .git/config has been a long standing source of slight confusion
>  for me.
>
>  Please correct me if I'm wrong, but it seems that the only reason
>  for the file .gitmodules to be there at all is because it can be
>  revved through commits, just as any file under Git's control.
>  .git/config doesn't have such a property. Other than that, it is not
>  really needed, right?

You have the last paragraph right, but I think the first paragraph wrong :)

.gitmodules doesn't do anything unless git-submodule reads it, which
it does in git-submodule-init and git-submodule-add.  (You know
git-submodule-add is screwing with .git/config because you don't need
to call git-submodule-init when you use it.)  git-submodule-update,
AFAICT, just reads .git/config.

>  Speaking of complications, it took me awhile to realize that 90%
>  of the Submodule magic seems to be based on the secret ability of
>  tree objects to hold references not only to blobs and trees but
>  also to *commits*:

Indeed, this is the majority of the coolness right there.  The rest of
the screwiness with .gitmodules and so on is really just to support
fetching the objects for the submodules from repos than the primary
supermodule one.

Also, git-checkout seems to explicitly *not* checkout refs to commits
by itself; you have to call git-submodule-update for that.  This is
probably because git-checkout wouldn't know what to do if the
submodule were dirty (ie. the sub-checkout couldn't complete because
files had been changed but not checked in).  This is useful in a
not-destroying-my-data way, but the behaviour isn't too obvious or
coherent.

>  That's exactly what makes me doubtful about .gitmodules being the
>  best place for storing the url, but then again, I don't have any
>  better ideas. :-( Yet ;-)

There's definitely no better place; .git/config isn't versioned, and
URLs don't belong in the tree objects themselves, which are otherwise
location-neutral and transport-neutral.

In my own use case, I think having all the objects from the
supermodule *and* submodules all be in the same repo is what I want.
This kind of obviates the need for .gitmodules entirely, if
git-checkout and friends will do the right thing.  I think I'll submit
some patches eventually once I have this figured out properly.

Have fun,

Avery
