From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Sun, 19 Oct 2014 00:32:56 +0000
Message-ID: <20141019003256.GA18532@dcvr.yhbt.net>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: Fabian Schmied <fabian.schmied@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 02:33:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfeR8-0007xn-F8
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 02:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbaJSAd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 20:33:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50418 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbaJSAc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 20:32:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id B82EA1F8B3;
	Sun, 19 Oct 2014 00:32:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Schmied <fabian.schmied@gmail.com> wrote:
> Hi,
> 
> I'm currently migrating an SVN repository to Git using git-svn (Git
> for Windows 1.8.3-preview20130601), and I'm experiencing severe
> performance problems with "git svn fetch". Commits to the SVN "trunk"
> are fetched very fast (a few seconds or so per SVN revision), but
> commits to some branches ("hotfix" branches) are currently taking
> about 9 minutes per revision. I fear that the time per these commits
> is increasing and that indeed the migration might not be finishable at
> all.
> 
> For the commits that take such a long time, git-svn always outputs
> lots of warnings about ignored SVN cherry-picks, and it tells me it
> can't find a revmap for the path being imported. (See [1].)
> 
> AFAICS, the offending commits take place on some branches that include
> a lot of manually merged ("SVN cherry-picked") revisions. Git-svn
> seems to be checking something (though I don't know what) that makes
> importing these revisions really slow. And it repeats this for every
> revision on these branches with increasing work to do.
> 
> Is there anything I can do to speed this up? (I already tried
> increasing the --log-window-size to 500, didn't have any effect.)

Can you take a look at the following two "mergeinfo-speedups"
in my repo?  (git://bogomips.org/git-svn)

Jakob Stoklund Olesen (2):
      git-svn: only look at the new parts of svn:mergeinfo
      git-svn: only look at the root path for svn:mergeinfo

Also downloadable here:

http://bogomips.org/git-svn.git/patch?id=9b258e721b30785357535
http://bogomips.org/git-svn.git/patch?id=73409a2145e93b436d74a

Hin-Tak (Cc-ed) reported good improvements with them, but also
a large memory increase:

http://mid.gmane.org/1412706046.90413.YahooMailBasic@web172303.mail.ir2.yahoo.com

Jakob (or anybody else): I suppose we could tie the new
cached_mergeinfo* caches to disk-backed storage to avoid the memory
bloat.
