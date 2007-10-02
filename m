From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn merge helper
Date: Tue, 2 Oct 2007 18:04:58 -0400
Message-ID: <20071002220458.GA21038@dervierte>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr> <20071001025059.GA29323@atjola.homenet> <0D8A7A3C-8F51-482D-9229-29ADC9585760@lrde.epita.fr> <8c5c35580710010113v7d4ad14bt129b7cb12d8f4fb8@mail.gmail.com> <20071002211400.GA992@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 00:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcpsG-0003Kr-Qt
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 00:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbXJBWFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 18:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbXJBWFg
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 18:05:36 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:47021 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbXJBWFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 18:05:36 -0400
Received: by nz-out-0506.google.com with SMTP id s18so3070444nze
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=3wYnbAQNGDw0YhnYNEBXgNEX9JZijLSJYnxoTTj9sXU=;
        b=pvYYI62hDX9Tfn6qR+b4KavnJWF4Zh5b/4VNoavDcYNSsEPvWF8VGniJ2KRsZ2d616Xe1zxOyJsv9eeKn9wpYnTi0KotjPML9Z7tXlStMsAf8ZfnbjMTvvE/Z/20bMQ1CaredwFxkxSyWyAN2tQfwOvJfRh3faKK2sxNae8IGSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=eO3hLreYsnvCpHf3VZHbaeyc7Ur+IG+b0+/u0pTi7R+/JfOQH/lzmbcoEUjPiYgLodnwsx8z79PhVJ9Viuo3WFC9UwuCfetp//4HlcF6pgfeFSFWA3EZVbDviqUSQiS1D1uFYQBc1g+CT7RhsQlfkRUzM9edm+gChKoVzFiCbQQ=
Received: by 10.114.56.1 with SMTP id e1mr4360287waa.1191362734393;
        Tue, 02 Oct 2007 15:05:34 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 24sm1850708nzn.2007.10.02.15.05.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2007 15:05:33 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 8FBF3C1D76A; Tue,  2 Oct 2007 18:04:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071002211400.GA992@atjola.homenet>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59747>

On Tue, Oct 02, 2007 at 11:14:00PM +0200, Bj=F6rn Steinbrink wrote:
> One common pattern in SVN is to have the feature branch following the
> trunk. In git terms, that would mean that the feature branch is
> continually rebased onto the HEAD of the HEAD AFAICT (although SVN of
> course cannot represent that). The problem with that is, that git
> doesn't create a merge commit in that case and git-svn gets confused
> again.
>=20
> git checkout mybranch
> git merge master # Creates a merge commit
> git checkout master
> git merge mybranch # Does just fast forward
>=20
> Is there anyway to force a merge commit or some other work around?

When I want to do something like this, I go about it one of two ways.
The first option is to simply rebase mybranch onto master.  Since my
feature branches are not usually published, there is no problem
rewinding them.  That may not be an option for you, however.

The other option is to have a "build" branch.  By example:

git checkout build
git reset --hard master
git merge mybranch
make

In that way, I have branch with the latest changes from head and the
changes from mybranch together.  The downside to this method is that yo=
u
may have to repeated resolve merges.  Despite the downsides, I find
these two methods to work quite well.
--=20
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
