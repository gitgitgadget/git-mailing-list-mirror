From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Wed, 20 Oct 2010 09:39:30 +0100
Message-ID: <1287563970.2673.12.camel@wpalmer.simply-domain>
References: <20101018051702.GD22376@kytes>
	 <8043579.526738.1287452576766.JavaMail.root@mail.hq.genarts.com>
	 <20101019064210.GA14309@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stephen Bash <bash@genarts.com>, Matt Stump <mstump@goatyak.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 10:39:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8UD0-0005cj-L2
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 10:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab0JTIjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 04:39:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65230 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab0JTIjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 04:39:35 -0400
Received: by wwf26 with SMTP id 26so930142wwf.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Ne2OdqxmxG8b0JIlCRSDleFBd3agy8Igq+t0xUskVME=;
        b=hO8s4aWQXrWo/By6ZP6+c2ECnxOkY9rKjm2tWkNBJFJ7hbu2W4Uar0ZD9i9D2W3LpF
         zPFfBCpk+mBiOSIMRuiKFeyS28BNFfPuWJSNzehnJcT/cJ+mWidaDP1MYZhRah0jOPAe
         klZOlP5/jV8sp5/lpJO9m1skHWDN9sYPYBxlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=HRaPj93eJLQaZojIJlZeFxEiWnsxcRq/ZxVW1rL6SxnWvDI96T0/rTvv8BQhFaCFo1
         LMZyNuZBF4UtGhBygU2P8LUpip6FprKzTjVf+mkKnoSdC9GcxtQvM3UlaYyEHpGhau/H
         afB/dvuXl75Hw2RIX3h0wyIfoq2rw2R+F3/6E=
Received: by 10.227.138.132 with SMTP id a4mr855518wbu.171.1287563974127;
        Wed, 20 Oct 2010 01:39:34 -0700 (PDT)
Received: from [192.168.2.64] (09020403.dsl.redstone-isp.net [193.164.118.24])
        by mx.google.com with ESMTPS id o43sm8789171weq.23.2010.10.20.01.39.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 01:39:33 -0700 (PDT)
In-Reply-To: <20101019064210.GA14309@kytes>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159401>

On Tue, 2010-10-19 at 12:12 +0530, Ramkumar Ramachandra wrote:
> Hi Stephen,
> 
> Stephen Bash writes:
...
> > 
> > I have 32 SVN revs in my history that touch multiple Git commit
> > objects.  The simplest example is
> >   svn mv svn://svnrepo/branches/badBranchName svn://svnrepo/branches/goodBranchName
> > which creates a single SVN commit that touches two branches
> > (badBranchName will have all it's contents deleted, goodBranchName
> > will have an "empty commit" as described above).  The more devious
> > version is the SVN rev where a developer checked out / (yes, I'm not
> > kidding) and proceeded to modify a single file on all branches in
> > one commit.  In our case, that one SVN rev touches 23 git commit
> > objects.  And while the latter is somewhat a corner case, the former
> > is common and probably needs to be dealt with appropriately (it's
> > kind of a stupid operation in Git-land, so maybe it can just be
> > squashed).
> 
> Ouch! Thanks for the illustrative example- I understand now. We have
> to bend backwards to perform a one-to-one mapping. It's finally struck
> me- one-to-one mapping is nearly impossible to achieve, and I don't
> know if it makes sense to strive for it anymore. Looks like Jonathan
> got it earlier.

It's been a while since I was involved in this discussion, so maybe the
design has changed by now, but I was under the impression that there
would be one "one-to-one" mapping branch (which would never be checked
out), containing the history of /, and that the "real" git branches,
tags, etc, would be based on the trees originally referenced by the root
checkout, with git-notes (or similar) being used to track the weirdness
in mappings. How does the "multiple branches touched in a single commit"
complicate anything other than the heuristics for automatic branch
detection (which I assume nobody is at the stage of talking about yet).

I suppose we wouldn't be talking, technically, about a one-to-one
mapping in that case, as we would be turning "one" svn revision into
"many" git branches, but in the conceptual sense of "one svn repository
equals one git repository", I don't see this as being impossible, or so
difficult that it shouldn't be striven-for.

Something else which is at least semi-common in svn is to treat a folder
both as a "directory" and a "branch", which the "checking out /" example
would just be an extreme example of. Think in terms of git branches
being a "view" of the history, with some mapper sitting between each
view and "root" checkout.
