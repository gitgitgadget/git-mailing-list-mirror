X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Wed, 06 Dec 2006 13:27:43 +0100
Organization: At home
Message-ID: <el6crv$p7e$1@sea.gmane.org>
References: <200612061207.23437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:26:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 58
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33440>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grvqj-00016v-QW for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760547AbWLFM0G (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760550AbWLFM0G
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:26:06 -0500
Received: from main.gmane.org ([80.91.229.2]:52146 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760547AbWLFM0E
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:26:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrvqT-0007Kr-V5 for git@vger.kernel.org; Wed, 06 Dec 2006 13:25:54 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:25:53 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 13:25:53 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> Without any specification in the .git/config file, git-pull will execute
> "git-pull origin"; which in turn defaults to pull from the first "pull"
> definition for the remote, "origin".
> 
> This is a difficult set of defaults to track for a new user, and it's
> difficult to see what tells git to do this (especially when it is
> actually hard-coded behaviour).  To ameliorate this slightly, this patch
> explicitly specifies the default behaviour during a clone using the
> "branch" section of the config.
> 
> For example, a clone of a typical repository would create a .git/config
> containing:
>   [remote "origin"]
>   url = proto://host/repo.git
>   fetch = refs/heads/master:refs/remotes/origin/master
>   [branch "master"]
>   remote = origin
>   merge = refs/heads/master
> 
> The [branch "master"] section is such that there is no change to the
> functionality of git-pull, but that functionality is now explicitly
> documented.

This doesn't help newbies if they do "git pull" on branch other than
"master". Git would fetch (a) from default remote "origin" (which can
be unexpected a bit) (b) into current branch (which can be very
unexpected for newbie) (c) the first branch in remote (which can be
very unexpected).

The part (c) could be ameliorated (especially when globbing/regexp
matching would get into 'master') with "Merge:" line in remotes file
and equivalent remote.<name>.merge which would specify explicitely
the branch to be merged, instead of using first branch.

> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This is really to help newbies.  By explicitly documenting the default
> behaviour, it makes it clearer what is going on.  It also means no routing
> through documentation to find out what config option needs changing.

Very nice.
 
> It's possible that we would want to remove the default behaviour entirely
> if there is no "branch" definition in the config.  That would prevent
> accidents by users who don't know what pull does fully yet.

Perhaps protected by config option and/or pull option... or perhaps not.
Refuse pulling into current branch if it doesn.t have branch.<name>.remote
matching current remote and doesn't have branch.<name>.merge entry, unless
of course refspec is provided.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

