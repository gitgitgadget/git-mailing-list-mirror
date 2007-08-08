From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Git doesn't like symlinks?
Date: Wed, 08 Aug 2007 10:29:57 +0200
Message-ID: <46B97F05.6060503@dawes.za.net>
References: <46A09A2B.3030205@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 10:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIgwF-0002e6-KN
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 10:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXHHIak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 04:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbXHHIak
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 04:30:40 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:42344 "EHLO
	spunkymail-a16.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751262AbXHHIaj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 04:30:39 -0400
Received: from [192.168.201.102] (dsl-146-27-152.telkomadsl.co.za [165.146.27.152])
	by spunkymail-a16.dreamhost.com (Postfix) with ESMTP id 9D9BC7CE09
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 01:30:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46A09A2B.3030205@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55306>

Rogan Dawes wrote:
> Hi folks,
> 
> I have been tasked with doing some development against an external SVN 
> repo, and keeping it largely in sync with an internal directory.
> 
> Seeing as how this is a git list, I obviously decided to do this using 
> git :-)
> 
> So, I have a local git repo with my local changes from the SVN repo, and 
> I can push them to the SVN repo without too many problems. The problem 
> arises when I try to sync with the local directory.
> 
> Since the local directory's structure doesn't match the repo exactly, I 
> figured I could work around that by using a symlink to get to the right 
> place.
> 
> ie. the local dir is
> C:\local\blah\release\5.2\<contents>
> 
> and the structure of the SVN (and hence git) repo is:
> /top/main/<contents>
> 
> where <contents> is/should be identical between the two places.
> 
> Obviously, git won't work correctly in the local dir, so I tried the 
> following (on Cygwin)
> 
> $ cd /tmp
> $ ~/git/contrib/workdir/git-new-workdir /my/git/repo/ repo-local
> $ cd repo-local/top
> $ rm -rf main/
> $ ln -s /c/local/blah/release/5.2/ main/
> $ git status
> 
> This worked, and showed me that there were a few files out of sync.
> 
> I decided to copy over one of the files from git to the local dir:
> 
> $ git checkout top/main/some/file
> 
> And git deleted my "main" symlink, and replaced it with a real dir, 
> containing "some/file".
> 
> Everything _else_ was now "missing".
> 
> Any ideas on how I can get this to work? I know this is not strictly 
> what git was designed for, but it could do a really good job if it would 
> only leave my symlink alone.
> 
> Rogan

So, for anyone else caught in this awkward position, the answer is not 
to use a symlink, but to use cygwin's mount command instead.

$ cd /tmp
$ ~/git/contrib/workdir/git-new-workdir /my/git/repo/ repo-local
$ cd repo-local/top
$ rm -rf main/
$ mkdir main/
$ mount 'C:\local\blah\release\5.2\' /tmp/repo-local/top/main/

And everything works as expected.

Regards,

Rogan
