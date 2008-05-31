From: Jeff King <peff@peff.net>
Subject: Re: unable to push
Date: Sat, 31 May 2008 11:50:36 -0400
Message-ID: <20080531155036.GA27397@sigill.intra.peff.net>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat May 31 17:52:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2TN8-0003Lg-EK
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 17:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYEaPuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 11:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbYEaPuk
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 11:50:40 -0400
Received: from peff.net ([208.65.91.99]:4820 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbYEaPuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 11:50:39 -0400
Received: (qmail 30291 invoked by uid 111); 31 May 2008 15:50:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 31 May 2008 11:50:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 May 2008 11:50:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83393>

On Sat, May 31, 2008 at 08:03:47AM -0700, david@lang.hm wrote:

> for some reason when I try to push to my public repo I get a message that  
> everything is up to date, but if I switch to that repo and do a pull it  
> updates properly

If you "git push" without a refspec, it pushes "matching branches". See
git-push(1) for more details.

> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote public
> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        HEAD
> d3f3d8474db1c006a53be8b5f5c1a0d866d7e357        refs/heads/localmaster

So you have only one branch, "localmaster".

> root@asgard:/var/www/adastra/xml2pdf/current# git ls-remote .
> 71ab4eea48eb3407a2ff4eef2befe9251897d676        HEAD
> 71ab4eea48eb3407a2ff4eef2befe9251897d676        refs/heads/master

But the remote has only one branch, "master".

If you want to push your localmaster to his master, you can do:

  git push origin localmaster:master

You can also set it up permanently by adding a "remote.origin.push" line
to your config file.

But I do wonder why you don't just name your local branch "master" in
the first place (it won't conflict in your local repo with the remote's
master, which can be named as "origin/master").

> root@asgard:/var/www/git/xml2pdf.git# git pull
> remote: Counting objects: 8, done.
> remote: Compressing objects: 100% (6/6), done.
> remote: Total 6 (delta 4), reused 0 (delta 0)
> Unpacking objects: 100% (6/6), done.
> From /movies/www/adastra/xml2pdf/current/
>    d3f3d84..71ab4ee  master     -> origin/master
>  * [new tag]         1.8.5      -> 1.8.5
> Updating d3f3d84..71ab4ee
> Fast forward
>  xml2pdf.pl |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)

And this pulls from master -> localmaster, presumably because you have a
branch.localmaster.merge config option (which is generally set up by
default these days).

-Peff
