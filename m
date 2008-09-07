From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and complex branch/tag layout
Date: Sat, 6 Sep 2008 19:56:26 -0700
Message-ID: <20080907025626.GB12392@untitled>
References: <48C139EB.1000104@icyb.net.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcus Griep <marcus@griep.us>
To: Andriy Gapon <avg@icyb.net.ua>
X-From: git-owner@vger.kernel.org Sun Sep 07 04:59:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcAUm-0007Re-HF
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 04:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbYIGC42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 22:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbYIGC42
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 22:56:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42062 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbYIGC41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 22:56:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E04502DC01B;
	Sat,  6 Sep 2008 19:56:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48C139EB.1000104@icyb.net.ua>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95106>

Andriy Gapon <avg@icyb.net.ua> wrote:
> 
> I am trying to use 'git svn' with FreeBSD base repository (which is now
> in svn).
> As can be seen here in "RELENG_* branches and general layout" section:
> http://wiki.freebsd.org/SubversionPrimer
> 
> There are several subdirectories for branches and tags depending on the
> status of a branch/tag in question. As I understand those subdirectories
> do not introduce separate namespaces, i.e. a particular tag/branch name
> is supposed to be unique across all subdirectories.
> 
> Does git-svn support repository layouts with multiple branch/tag
> subdirectories? Or does it only support "standard layout" variations
> that still have only one subdirectory for each?
> 
> Thank you in advance for any help/advice!

Hi Andriy,

For tracking /etc, this seems to work:

  git svn clone -b 'releng/*/etc' -t 'release/*/etc' svn://svn.freebsd.org/base
  (it started, I don't have the time/space/bandwidth to let it finish).

Unfortunately only releng and release, you can get other namespaces like
stable.


Double-globbing should work, (I thought Marcus got it to work a few
months ago), but doesn't seem to at the moment:

  git svn clone -b '*/*/etc'

Marcus?


The long way:

If you explicitly specify every branch you want, it'll definitely, too.
It's just a huge pain to setup since you'll lose all the advantages of
globbing, so it could end up being a very big .git/config file:

[svn-remote "svn"]
        url = svn://svn.freebsd.org/base
	fetch = releng/4.3/etc:refs/remotes/releng/4.3/etc
	fetch = release/4.3.0/etc:refs/remotes/release/4.3.0/etc
	fetch = stable/4/etc:refs/remotes/stable/4/etc
	; ...

-- 
Eric Wong
