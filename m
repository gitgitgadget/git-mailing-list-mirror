From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: git-svn and migration
Date: Wed, 19 Dec 2007 20:47:24 +0000
Message-ID: <320075ff0712191247m132ecd95o46a7778d8bd4f42b@mail.gmail.com>
References: <320075ff0712190849u2c40cc46pf01fa2a75f557482@mail.gmail.com>
	 <320075ff0712190850r35263bcfv1d8f84e699208e15@mail.gmail.com>
	 <20071219175447.GB15898@dervierte>
	 <20071219202333.GD4390@genesis.frugalware.org>
	 <320075ff0712191246r46cd76f7r1d8edc1adf35ae57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 21:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J55q6-0004EI-TD
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 21:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbXLSUr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 15:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbXLSUr1
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 15:47:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:38190 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbXLSUr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 15:47:26 -0500
Received: by wr-out-0506.google.com with SMTP id c49so2201165wra.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XO2D3naUB2Kjc9tlzdWa5R2jujnM91IPh0Xzn6rqaC8=;
        b=Ccj7RUcyBWs73wXg9hfyHhyKngontIMhVSSYHfHPGebRv3CsYAodYciNB0JCJ70jJXLYpt1hWjRM2pK+Zb0hZI8vWJ9EgPOGIoosoqr9T4QyOL5TfvTmEhlf0opvotmDsiGsNeg0Lw8R8wNkEg/LrmOPj/byht+X7gQIBFwUMvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rv9dv6+wtWpPe/c0Bc7Fe03xFKzWuhk0jTMnHTiJmmBlAOAXdJiZ76uyfjc/u1cpagc65QGOZsKLXXldY36mRYUmdyKM3przZYxLIlx66ZxcNh6Hs0ar4qU9uUuMUCNOLoEFq4eyB4VPe48IkNuXGDjLNTEaKmiEA7eyP+FcHIM=
Received: by 10.142.77.11 with SMTP id z11mr2000755wfa.23.1198097244116;
        Wed, 19 Dec 2007 12:47:24 -0800 (PST)
Received: by 10.142.199.7 with HTTP; Wed, 19 Dec 2007 12:47:24 -0800 (PST)
In-Reply-To: <320075ff0712191246r46cd76f7r1d8edc1adf35ae57@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68937>

I was prepared to put up with it not being a bare repository (asides
the extra /.git/ in the URL it's pretty much the same).

On the git host I'd set refs/heads/trunk to be
 ref: refs/remotes/svn/trunk

And I'm hoping that a cron of git svn fetch ; git-update-server-info
will do the trick.  It appeared to keep it in sync when I fetch
downstream. I don't know if I'm being naive though expecting that to
work as I don't grok all that git-svn needs to work properly - but I'm
working on it ;-)

My current plan is for developers to push/pull to git to share amongst
the git-devs, and to push to svn when wanting to share with everyone
else..

[svn user] ---(ci/co)--->[svn] --pull--> [git]
                            ^               ^
                           |               |
                          push          push/pull
                            |               |
                           ---[git user]----




On Dec 19, 2007 8:23 PM, Miklos Vajna < vmiklos@frugalware.org> wrote:
> On Wed, Dec 19, 2007 at 12:54:47PM -0500, Steven Walter < stevenrwalter@gmail.com> wrote:
> > Using a central git repo that is kept uptodate with svn is the approach
> > I've used.  git-svn isn't especially keen on this mode of operation,
 > > however.  After every fetch, you have to reset refs/remotes/trunk to
 > > origin/master, which it turn puts .git/svn out of date (you can blow it
> > away and run "git svn fetch" to regenerate it).
>
> an other problem is that you probably want to have a bare repo while
> git-svn needs a working dir. a possible solution:
 >
> http://blogs.frugalware.org/vmiklos/2007/12/09/p320
>
> (it works for me fine, but maybe there are problems with it so use with
> care :) )
 >
> - VMiklos
 >
