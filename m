From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Extract Git classes from git-svn (2/10) (was Re: Fix git-svn
 tests for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 19:08:58 -0500
Message-ID: <20120718000858.GH25325@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F164.3060300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 02:09:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrHpT-0008Of-3S
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 02:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564Ab2GRAJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 20:09:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43998 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757569Ab2GRAJE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 20:09:04 -0400
Received: by yenl2 with SMTP id l2so1040264yen.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QWKbi6/ho2zW4DoYksOAPme6o5hXUvATSfhlc8KmY+Y=;
        b=ibt9xkjkwBTeRWzP7H7/4lcHTP5OgbX5ufWk8cfmnEiHxogQjMuxFXAEg2lDH50PiX
         ForpeLYno83udsOBnFJDeHP2SifhA5H76Q/3FdC4xKTQwsAd9bP33+mp3igGudpWGX67
         5EKWXxREVuqaTwfCMby1XRaIlbv7UKx7Hue34lOw7PtIVYU7PA59bvNMwBuzWlKZLlX5
         WU19aqK26KN5Bad3vdAihAzCyEyePfyzvB5rIjr0BCkSgQkOO0cKKlFvupCtpXNzFQ8b
         Pxoe+Gj8JtuoNrlkMlOWD1Ph9Y0kLXlgYCPjwOfkJYCeKt2+VKLWJToEfMdql5F3AIh0
         GEZQ==
Received: by 10.50.159.135 with SMTP id xc7mr452919igb.9.1342570142904;
        Tue, 17 Jul 2012 17:09:02 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id bo7sm26820153igb.2.2012.07.17.17.09.02
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 17:09:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5005F164.3060300@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201638>

Hi,

Michael G Schwern wrote:

> From 683a230e439f1d5ac2727ce4c2a74e93804fc72b Mon Sep 17 00:00:00 2001
> From: "Michael G. Schwern" <schwern@pobox.com>
> Date: Wed, 11 Jul 2012 22:16:01 -0700

Just like with patch 1, the mail body should lose the above.

> Subject: [PATCH 03/11] Fix Git::SVN so it can at least compile alone.

Did I miss patch 2?

> It's still very intertwined with git-svn, but that's a lot of work.  This
> gets things working and tests passing again (as well as they were).
>
> This required some parallel refactorings...
>
> * fatal() moved out of git-svn into a new Git::SVN::Utils
[...]
>  git-svn.perl                   | 33 ++++++++++++++++++---------------
>  perl/Git/SVN.pm                | 29 ++++++++++++++++++++---------
>  perl/Git/SVN/Utils.pm          | 19 +++++++++++++++++++
>  perl/Makefile                  |  2 ++
>  t/Git-SVN/00compile.t          |  9 +++++++++
>  t/Git-SVN/Utils/can_compress.t | 11 +++++++++++
>  t/Git-SVN/Utils/fatal.t        | 34 ++++++++++++++++++++++++++++++++++
>  7 files changed, 113 insertions(+), 24 deletions(-)
>  create mode 100644 perl/Git/SVN/Utils.pm
>  create mode 100644 t/Git-SVN/00compile.t
>  create mode 100644 t/Git-SVN/Utils/can_compress.t
>  create mode 100644 t/Git-SVN/Utils/fatal.t

It seems like a lot is going on in the one patch.  Probably most of
the changes are good, but if this causes a regression we would have no
choice but to revert the whole thing, which would be unfeasible
because of later patches building on it.

So in other words, a patch like this that makes a lot of changes at
once would make life very hard for the maintainer, I imagine.

What is the motivation behind these changes?  Can they be untangled
from each other and applied one at a time, in such a way that each
incremental change looks obviously correct?

Since I'm missing the patch that created Git/SVN.pm in the first
place, I can't tell --- did that patch break the build and this one
fixes it?  In that case, the order of the two patches should be
swapped to ensure "git bisect" is still usable.

Sorry, I wish I had better news to mix in with all this.  I am
thrilled to see this is making the internal APIs saner and adding
tests so I hope we can get it in in a way that makes regressions
unlikely.

Thanks,
Jonathan
