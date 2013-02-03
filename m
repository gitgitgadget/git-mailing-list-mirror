From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 4 Feb 2013 03:26:51 +0400
Message-ID: <20130203232651.GV5210@localhost.localdomain>
References: <1359901085.24730.11.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 00:27:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U28xz-0005Xa-Jh
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 00:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab3BCX06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 18:26:58 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:46827 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab3BCX05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 18:26:57 -0500
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r13NQqVA003885;
	Mon, 4 Feb 2013 03:26:53 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 43858B2325B; Mon,  4 Feb 2013 03:26:51 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <1359901085.24730.11.camel@t520>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215343>

On Sun, Feb 03, 2013 at 03:18:05PM +0100, Robert Clausecker wrote:

> git currently has the archive command that allows to save an arbitrary
> revision into a tar or zip file. Sometimes it is useful to not save this
> revision into an archive but to directly put all files into an arbitrary
> directory. Currently this seems to be not possible to archive directly;
> the only way I found to do it is to run git archive and then directly
> unpack the archive into a directory.
> 
>     git --git-dir REPO archive REVISION | tar x
> 
> It would be nice to have a command or simply a switch to git archive
> that allows the user to put the files of REVISION into a directory
> instead of making an archive.

You could use plumbing commands combined with a throwaway custom index
file and a separate work tree which will receive the tree at REVISION:

export GIT_WORK_TREE=/path/to/dest/directory
export GIT_DIR=/path/to/repo/.git
export GIT_INDEX_FILE="$GIT_WORK_TREE/.index"
git read-tree REVISION
git checkout-index -a
rm -f "$GIT_INDEX_FILE"
