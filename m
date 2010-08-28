From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git-svn mirror in bare repo
Date: Sat, 28 Aug 2010 09:45:14 -0700
Message-ID: <4C793D1A.8050200@icecavern.net>
References: <20100823122425.GB12810@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, weigelt@metux.de
X-From: git-owner@vger.kernel.org Sat Aug 28 18:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpOhH-0007SD-8O
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 18:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab0H1Qz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 12:55:58 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:47343 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752119Ab0H1Qz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 12:55:57 -0400
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Aug 2010 12:55:57 EDT
Received: from [10.0.0.14] (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 7482935B25;
	Sat, 28 Aug 2010 10:45:16 -0600 (MDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <20100823122425.GB12810@nibiru.local>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154647>

On 08/23/2010 05:24 AM, Enrico Weigelt wrote:
> is it possible to use git-svn w/ an bare repository (eg. using
> an temporary workdir when necessary or directly creating tree
> and commit objects w/o going through workdir at all) ?
> 
> I'm running a dozen of mirrors (also from cvs), some from fairly
> large and I'd like to get rid of the working copies.

When I have a large repository with git-svn that I only occasionally
want to use the working copy of it, here is what I do:

1) git svn clone the SVN repository normally
2) Create an "empty" branch with no files ("git checkout --orphan")

When I want to update SVN, I do:

  git checkout trunk
  git svn rebase
  git checkout empty

When I want to push something to SVN I do:

  git checkout trunk
  git svn dcommit
  git checkout empty

This makes it work sort of like a bare repository, but it still works
with git-svn. I use this when I have a bunch of SVN repositories I need
to be able to work with quickly at any time, but I don't want to waste
the disk space having all of their working copies checked out
simultaneously.
