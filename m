From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 21:16:52 +0000 (UTC)
Message-ID: <loom.20050712T230013-978@post.gmane.org>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org> <m1eka574c8.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org> <m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507111815180.17536@g5.osdl.org> <m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com> <m18y0c1prv.fsf@ebiederm.dsl.xmission.com> <7veka48lcw.fsf@assigned-by-dhcp.cox.net> <m14qb012x4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 12 23:21:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsSAd-0003Wl-Ec
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 23:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVGLVTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 17:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVGLVTe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 17:19:34 -0400
Received: from main.gmane.org ([80.91.229.2]:11142 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262467AbVGLVSM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 17:18:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DsS8N-00037n-MU
	for git@vger.kernel.org; Tue, 12 Jul 2005 23:17:43 +0200
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 23:17:43 +0200
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 23:17:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511 Firefox/1.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Eric W. Biederman <ebiederm <at> xmission.com> writes:

> 
> Junio C Hamano <junkio <at> cox.net> writes:
>
> > The only in-tree user after your patch is applied is the tagger
> > stuff, so in that sense committer_ident may make more sense.
> 
> There is also the commit path, and that comes from C.  I'm not
> quite certain how we should be using the environmental variables.

But there you would not have "default" issue, would you?

> Part of the request was to put all of this information together
> in a common place.  And note that it is actually:
> tagger="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE"
> Where the date is a human unreadable string of the number of seconds
> since the epoch (aka 1 Jan 1970 UTC).

This may sound whacy, but how about having git-env command that

 (1) parrots GIT_* environment variables if the user has one; or
 (2) shows the values of environment variables the user _could_ have had
     to cause the program to behave the same way, when it the user does
     not have them?

Synopsis.

  $ git-env [--values-only] [<variable name>...]

Examples.

 $ git-env GIT_COMMITER_DATE GIT_AUTHOR_NAME
 GIT_COMMITTER_DATE='1121202267 -0700'
 GIT_AUTHOR_NAME='Junio C Hamano'
 $ unset GIT_OBJECT_DIRECTORY
 $ GIT_DIR=foo git-env --values-only GIT_OBJECT_DIRECTORY
 foo/objects
 $ git-env
 GIT_DIR=.git
 GIT_OBJECT_DIRECTORY=.git/objects
 ...
 $ eval "`git-env GIT_COMMITTER_DATE GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE`"
 $ tagger="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE"

We could add a couple of "variable name"s that we do _not_ use
from the environment as a shorthand as well while we are at it,
so that you can say:

 $ git-env GIT_COMMITTER_ID
 GIT_COMMITTER_ID='Junio C Hamano <junkio@cox.net> 1121202267 -0700'

Once we go this route, it may even make sense to have that GIT_COMMITTER_ID
environment variable as well.  I don't know..
