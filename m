From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.5.1
Date: Tue, 22 Apr 2008 04:55:56 +0400
Message-ID: <20080422005556.GC2631@dpotapov.dyndns.org>
References: <7vej8yako4.fsf@gitster.siamese.dyndns.org> <20080421235610.GB2631@dpotapov.dyndns.org> <480D2FEE.3010904@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Apr 22 02:57:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo6oY-0006Ag-RJ
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 02:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761155AbYDVA4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 20:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761221AbYDVA4F
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 20:56:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:38763 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761155AbYDVA4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 20:56:03 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1972207fgb.17
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=9TLE9dEFN/Bngg3Ez+g7G0rKTjz8wM6xn3jNw0QTM8k=;
        b=Ub/ANLBKhOlx0T3IyfxK3w0vvHGV/w+Ujar1yegEhs9BNoZdgk7iIEbkLRhJ0bTA0sJA9qiMY6DhUwtp4Rou3Z3cQgzGeYmdPbVgJDEIHTOwXr2JIPJmz/Un+UddhpNAcqCyJ6IjEViUQuB9OFNVWI3AsQ+POADo4rtICnmX8Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=CSGjU1JGrFd9r73qFIdmJG8eomlak2c2l+KNrnuZBMpsxOxeiQleZVCJ43JlyVlQap5i0O0qGIVXjy+mJjiRRz3b5BXWSCh6yYfysuz/hCrEErUcJ9jHNGKIQ2lTNaCfLNlo09zNm9GOtmLo/qHgnb6pCRnOYsR/+HN+WOeOUE8=
Received: by 10.82.165.5 with SMTP id n5mr12084028bue.39.1208825760854;
        Mon, 21 Apr 2008 17:56:00 -0700 (PDT)
Received: from localhost ( [85.140.171.25])
        by mx.google.com with ESMTPS id i3sm6632261nfh.28.2008.04.21.17.55.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Apr 2008 17:55:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <480D2FEE.3010904@nrlssc.navy.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80049>

On Mon, Apr 21, 2008 at 07:23:10PM -0500, Brandon Casey wrote:
> Dmitry Potapov wrote:
> 
> > Johannes' patch removed this option, which IMHO was a significant user
> > interface improvement.
> 
> Unless I missed something, this option has not been removed. The original
> purpose for its existence (which was to cause git-gc to call git-prune)
> has been removed. The call to git-prune within git-gc will remove _loose_
> unreferenced objects, but _packed_ unreferenced objects are removed by
> repack. The --prune option to git-gc is still used to adjust the call to
> git-repack so that packed unreferenced objects are discarded.

I thought that it had no effect any more, because it had been removed
from the git-gc man page. Now I have looked at the code now, and it seems
the difference between running git gc with and without the prune option
is that with this option the git repack is called with '-a' option while
without it with '-A'. Unfortunately, the '-A' option in the git-repack
is also undocumented, but based on the reading git-repack.sh, you are
right. So, now I wonder wether removing the --prune option from the man
page was the right thing to do.

> 
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> > index 9758243..c1bf814 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -65,10 +65,12 @@ OPTIONS
> >  +
> >  *NOTE*: this is a possibly dangerous operation; do *not* use
> >  it unless you understand what it does. If you clone your
> > -repository using this option, then delete branches in the
> > -source repository and then run linkgit:git-gc[1] using the
> > -'--prune' option in the source repository, it may remove
> > -objects which are referenced by the cloned repository.
> > +repository using this option and then delete a branch or use
> > +any other git command that makes any previous existing commit
> > +unreachable, then after some time linkgit:git-gc[1] may remove
> > +unreachable objects, and this will break the cloned repository.
> > +Because some git commands may run git-gc, it may happen at any
> > +time after gc.pruneExpire time since commits became unreachable.
> 
> I agree that something should be said here about shared repositories,
> but I think this wording is a little complicated (disclosure: I also
> submitted some text for this a few weeks ago :). Of course something
> is better than nothing.
> 
> Here's the blurb I submitted if you're interested:
> +repository using this option and then delete branches in the
> +source repository, some objects may become unreferenced (or dangling).
> +These objects may be removed by normal git operations (such as git-commit[1])
> +which automatically call git-gc[1]. If these objects are removed and
> +were referenced by the cloned repository, then the cloned repository
> +will become corrupt.

I like your wording better though I still prefer to mention that
deleting branches is just one of many possible commands that may
create unreferenced commits, i.e. something like that:

 ... repository using this option and then delete branches (or use any
 other git command that makes any existing commit unreferenced) ...


Dmitry
