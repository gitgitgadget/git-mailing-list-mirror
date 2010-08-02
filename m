From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/16] Subtree clone proof of concept
Date: Sun, 1 Aug 2010 23:18:31 -0600
Message-ID: <AANLkTims5Xq67QXaE54bCTHP-BZSNRVsJnUKM6YJjt2G@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 07:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfnQI-000404-0y
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 07:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab0HBFSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 01:18:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46912 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0HBFSd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 01:18:33 -0400
Received: by wyb39 with SMTP id 39so2911827wyb.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 22:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6HN7vfkDh3Hdb/0fE84mtFOHafVvOMcCqKhEUQW5JS8=;
        b=e+kkuLxUialxEw7FgHToaAXY4inG04pOKL6BL/S9I2NRo/b+WGTA2l1BuC3ZSk2E3A
         biLcm3rWtQOgDO/8g1ijmNZFqipuRIWdU3GJHs8cMZBw5MfVAC7ybk/dtT1h2BtRcGQx
         CZEc1taDuUDLd+J6113zbsVZrayOIRO5BtuAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R/IhXt7USUa7wVv4Uw887DCzTKA6g+3mgPyULnKiGdnrO+ipoSecGCssszWK4KOIC5
         2okF/Pm9wG75wgDh2QFm4XcA5+o4OJVSJR9MTk2OM4zvi6DzYxa5EwlBWqEFAOs58eDu
         vsevbg37cVogLv6XYYivK4xrWhCdUw+ncoMJQ=
Received: by 10.216.145.198 with SMTP id p48mr4469550wej.18.1280726311776; 
	Sun, 01 Aug 2010 22:18:31 -0700 (PDT)
Received: by 10.216.132.8 with HTTP; Sun, 1 Aug 2010 22:18:31 -0700 (PDT)
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152395>

Hi,

2010/7/31 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Something to play with so we can evaluate which is the best strategy
> for non-full clone (or whatever you call it).

Very nice, it's awesome you're working on this.  I'm of the same
opinion that Shawn stated earlier, namely that I don't like the route
of rewriting commits on the fly like this (more on that later), but
it's really cool to see some ideas being tried and pushed to their
limits.

> The idea is the same: pack only enough to access a subtree, rewrite
> commits at client side, rewrite again when pushing. However I put
> git-replace into the mix, so at least commit SHA-1 looks as same as f=
rom
> upstream. git-subtree is not needed (although it's still an option)
>
> With this, I can clone Documentaion/ from git.git, update and push. I

I tried it out, but I seem to be doing something wrong.  I applied
your patches to current master, and tried the following -- am I doing
something wrong or omitting any important steps?

$ git --version
git version 1.7.2.1.22.g236df

$ git clone file://$(pwd)/git fullclone
Cloning into fullclone...
warning: templates not found /home/newren/share/git-core/templates
remote: Counting objects: 96220, done.
remote: Compressing objects: 100% (24925/24925), done.
remote: Total 96220 (delta 70575), reused 95687 (delta 70236)
Receiving objects: 100% (96220/96220), 18.45 MiB | 11.43 MiB/s, done.
Resolving deltas: 100% (70575/70575), done.
fatal: unable to read tree 49374ea4780c0db6db7c604697194bc9b148f3dc

$ git clone --subtree=3DDocumentation/ file://$(pwd)/git docclone
Cloning into docclone...
warning: templates not found /home/newren/share/git-core/templates
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed


> haven't tested it further. Space consumption is 24MB (58MB for full
> repo). =C2=A0Not really impressive, but if one truely cares about dis=
k
> space, he/she should also use shallow clone.

58 MB for full repo?  What are you counting?  For me, I get 25M:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ ls -lh git/.git/objects/pack/*.pack
-r--r--r--. 1 newren newren 25M 2010-08-01 18:05
git/.git/objects/pack/pack-d41d36a8f0f34d5bc647b3c83c5d6b64fbc059c8.pac=
k

Are you counting the full checkout too or something?  If so, that
varies very wildly between systems, making it hard to compare numbers.
 (For me, 'du -hs git/' returns 44 MB.)  I'd like to be able to
duplicate your numbers and investigate further.  It seems to me that
we ought to be able to get that lower.

> Performance is impacted, due to bulk commit replacement. There is a
> split second delay for every command. It's the price of replacing 24k
> commits every time. I think the delay could be improved a little bit
> (caching or mmap..)
>
> Rewriting commits at clone takes time too. Doing individual object
> writing takes lots of space and time. I put all new objects directly
> to a pack now. Rewriting time now becomes quite acceptable (a few
> seconds). Although deep subtree/repo may take longer. Rewriting on
> demand can be considered in such cases.
>
> Repo-care commands like fsck, repack, gc are left out for now.
>
> Finally, it's more of a hack just to see how far I can go. It will
> break things.

I think it's a pretty nifty hack.  It's fun to see.  :-)  However, I
do have a number of reservations about the general strategy:  As
mentioned earlier, I'm not sure I like the on-the-fly commit
rewriting, as mentioned by Shawn in your previous
subtree-for-upload-pack patch series.  You did take care of the
"referring to commit-sha1" issue he brought up by using the replace
mechanism, but I'm still not sure I'm comfortable with it.  The
performance implications also worry me (a lot of the reason for sparse
clones was to improve performance, at least from my view), as does the
fact that it only works on exactly one subtree (at least your current
implementation; most of my usecases involve multiple sibling
subdirectories that I'd like to get), as does the fact that it
(currently) only handles trees and does not handle files (ruling out
the translator usecase I'd like to see covered, e.g. cloning just
po/de.po and its history without all sibling files).

Also, I couldn't tell if your implementation downloaded full commit
information for commits that didn't touch any of the files under the
relevant subtree.  I think it does, but couldn't tell for sure (I
wanted to use a clone and dig into it to find out, but ran into the
problems I mentioned above).  If so, that also worries me a bit -- see
http://article.gmane.org/gmane.comp.version-control.git/152343.

Your implementation also suffers from the same limitations as current
shallow clones.  For example, you can't clone or fetch from a subtree
clone.  That limits collaboration between people needing to work on
the same subset of history, and was a limitation I was hoping to see
fixed, rather than propagated to more features.

I hope I'm not coming across as too critical.  I'm really excited to
see work in this area.  Hopefully I can get more time to pursue my
route a bit further; currently I don't have too much more than a
detailed idea write-up (heavily revised since the previous thread --
thanks for the feedback, btw).  Or maybe you just know how to address
all my concerns and you beat me to the punch.  That'd be awesome.


Elijah
