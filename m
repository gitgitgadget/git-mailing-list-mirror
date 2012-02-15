From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: how to determine oldest supported version of git
Date: Wed, 15 Feb 2012 12:34:54 -0600
Message-ID: <20120215183454.GA23016@burratino>
References: <jgeekn$of2$1@dough.gmane.org>
 <7v8vkktt6y.fsf@alter.siamese.dyndns.org>
 <7vwr7upj9m.fsf@alter.siamese.dyndns.org>
 <20120215053607.GC29902@sigill.intra.peff.net>
 <7vaa4k38nj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 19:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxjhI-0003XG-8V
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 19:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab2BOSfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 13:35:13 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64050 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab2BOSfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 13:35:12 -0500
Received: by yhoo21 with SMTP id o21so855053yho.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DUPhGQz2kxhrVam1gTU2cKTdjo03stzBf+ioM+ZjeM0=;
        b=EYXE4LOQ8yjbiyYDF2Tu89HJPrDMuMhgKy9CYJd9X1/a0zuyxmrd8RzSxwdIHzBUZ8
         E/SgBSM7k1aEYLLdAYv85akEKJLEoRUL6bIoVPr2ehOsFUkwO+qbdQtBmApJvq//DPVm
         +Qc/OQgkWbOeG5ecO0RkoSOBfmS4AAHz0dENo=
Received: by 10.50.156.166 with SMTP id wf6mr13598706igb.20.1329330911904;
        Wed, 15 Feb 2012 10:35:11 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en8sm20637818igc.5.2012.02.15.10.35.10
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 10:35:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vaa4k38nj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190846>

Junio C Hamano wrote:

> But think again, with the intimate knowledge of how these bugfix topics
> are merged down to older maintenance tracks.
[...]
> But nobody in the development community rebuilds 'maint' every time it is
> updated and runs the result as his or her primary production version. Even
> I do not do that (remember, I run 'next'). I only build and run full test
> suite. Older maintenance tracks are worse. I do not think anybody runs
> them before they are tagged and released.

I can offer one data point.  In the context of Debian sid, Gerrit and
I do test each version in daily work before uploading it.  I generally
build from and test whatever track is going to be used for the next
upload (usually plus a few extra features I am interested in for
private use) a little while before the release, to be prepared.
Anders sometimes uploads to the Ubuntu PPA which brings more testers.
After the upload, users running "sid" test for about a week before
even more users running "testing" get to take a look at it and test
for the sake of later users who will run "stable".

So little bugs get discovered, with time to fix them.

Even with this, the extra time to migrate from 1.7.6 to 1.7.7, for
example, was very helpful in the context of Debian sid.  Like it or
not, new features *do* come with minor regressions, and it helps the
sanity of a package maintainer to not have to suffer people who did
not request a bleeding-edge release complaining about regressions
until there has been time to fix them.

Of course, this has nothing to do with Debian stable, which is an
orthogonal story.  I'll discuss that below.

[...]
>  * At that point, old 'maint' and 1.7.9.X track cease to receive updates,
>    as there is no point maintaining them. It only encourages distros to
>    stay behind, adding unnecesary maintenance burden to us.

If you are thinking of distros like Debian stable, then that is just
wishful thinking.  Dropping support for old releases does not have any
effect except to cause patches to be missed there.  (See iceweasel and
chromium-browser for examples where using the version in Debian stable
is something I would usually not recommend.)

This may seem weird, but keep in mind that people like you and me are
not the target audience for the git package in Debian stable.  We use
git heavily.  If I am on a machine running stable or RHEL, I will
build a private copy of git in $HOME or ask the sysadmin to install a
more recent git as the first thing I do.

The reason that packages go into Debian stable and then just _don't
change_ is that the target users are not using those packages heavily.
If a new feature (e.g., "signatures from tags get incorporated into
the merge commit from pulling them") causes a regression (e.g., "the
script I used to run every week that pulls my favorite software
package and builds it just stopped working"), then these people get
zero benefit, for a sizable cost.

Though that's a digression.  The relevant detail to mention here is
that there is real demand on downstreams to continue to maintain
packages without adding new features.  They will help to maintain
old releases if you want.  If we want to influence that maintainance,
for example to ensure security bugs are fixed correctly and in the
same way everywhere, a good way is to keep a maintenance branch.

Hoping that clarifies a little.
Jonathan
