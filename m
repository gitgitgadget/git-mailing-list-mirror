X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Change in git-svn dcommit semantics?
Date: Tue, 19 Dec 2006 14:09:00 -0800
Message-ID: <20061219220900.GA3148@localdomain>
References: <m2mz5jegka.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 22:09:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2mz5jegka.fsf@ziti.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34857>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwn9B-0000tP-1t for gcvg-git@gmane.org; Tue, 19 Dec
 2006 23:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932993AbWLSWJO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 17:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbWLSWJO
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 17:09:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33991 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932993AbWLSWJN
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 17:09:13 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id D060F2DC035; Tue, 19 Dec 2006 14:09:00 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 19 Dec 2006
 14:09:00 -0800
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> Hi Eric,
> 
> I just updated to the latest git/git-svn (on branch 'master') and the
> workflow I've been using no longer seems to work:
> 
>    # review the commits I'm going to send to svn
>    ziti:~/proj/bioc-2.0-git seth$ git log remotes/git-svn..HEAD
>    
>    # now send them
>    ziti:~/proj/bioc-2.0-git seth$ git svn dcommit remotes/git-svn..HEAD
> 
>    fatal: ambiguous argument
>    'refs/remotes/git-svn..remotes/git-svn..HEAD': unknown revision or
>    path not in the working tree.  Use '--' to separate paths from
>    revisions 32768 at /Users/seth/scm/bin/git-svn line 2190
>            main::safe_qx('git-rev-list', '--no-merges', 'refs/remotes/git-svn..remotes/git-svn..HEAD') called at /Users/seth/scm/bin/git-svn line 610
>            main::dcommit('remotes/git-svn..HEAD') called at /Users/seth/scm/bin/git-svn line 197
> 
> 
> At this point, my last commit seems to have been reset (although the
> changes are thankfully still in my working tree).  If this happens to
> you, you can recover the last commit like:
> 
>   git commit -a -v -c ORIG_HEAD

Huh?  safe_qx should've croaked or died, causing git-svn to exit before
it could do any damage (via git-reset or git-rebase).  dcommit is not
called inside any eval blocks, either...

> And it seems that the new interface requires no extra args:
> 
>  git svn dcommit
> 
> The new interface seems ok until things like 
> 
>   git svn dcommit remotes/git-svn..HEAD~2
> 
> are allowed (if ever).  But it would be nice for the failure mode to
> not undo commits :-)
 
Before, the 'remotes/git-svn..HEAD' argument meant absolutely nothing to
dcommit (it silently ignored it).  Nowadays, you only need 'HEAD~2', the
'remotes/git-svn..' is already implied.

	git-svn dcommit HEAD~2

Not specifying any argument implies that it is called with 'HEAD'

-- 
