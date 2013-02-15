From: Alain Kalker <a.c.kalker@gmail.com>
Subject: Re: [BUG] Git clone of a bundle fails, but works (somewhat) when
 run with strace
Date: Fri, 15 Feb 2013 22:25:47 +0000 (UTC)
Message-ID: <kfmclb$4ro$2@ger.gmane.org>
References: <511E8D84.6060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 23:26:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6Tjh-0002G0-05
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 23:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab3BOW0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 17:26:04 -0500
Received: from plane.gmane.org ([80.91.229.3]:33784 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab3BOW0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 17:26:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U6TjY-0002DL-5Y
	for git@vger.kernel.org; Fri, 15 Feb 2013 23:26:20 +0100
Received: from 524a7994.cm-4-3b.dynamic.ziggo.nl ([82.74.121.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 23:26:20 +0100
Received: from a.c.kalker by 524a7994.cm-4-3b.dynamic.ziggo.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 23:26:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 524a7994.cm-4-3b.dynamic.ziggo.nl
User-Agent: Pan/0.139 (Sexual Chocolate; GIT bf56508
	git://git.gnome.org/pan2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216357>

On Fri, 15 Feb 2013 20:33:24 +0100, Alain Kalker wrote:

> tl;dr:
> 
> - `git bundle create` without <git-rev-list-args> gives git rev-list
> help, then dies.
>    Should point out missing <git-rev-list-args> instead.
> - `git clone <bundle> <dir> gives "ERROR: Repository not found."
> - `strace ... git clone <bundle> <dir>` (magically) appears to work but
>    cannot checkout files b/c of nonexistent ref.
> - Heisenbug? Race condition?
> - Zaphod Beeblebrox has left the building, sulking.
> 
> Full description:
> 
> When I try to clone from a bundle created from a local repository, `git
> clone <bundle> <dir>` fails with: "ERROR: Repository not found. fatal:
> Could not read from remote repository." unless I run it with strace.
> 
> OS: Arch Linux (rolling release)
> Git versions: 1.8.1.3 and git://github.com/git.git master@02339dd
> 
> Steps to reproduce:

For those who like to "save the trees" (source code or otherwise), here 
is a much simplified test case:

$ # Create test repository with a single commit in it
$ mkdir testrepo
$ cd testrepo
$ git init
$ echo Test > test.txt
$ git add test.txt
$ git commit -m "Add test.txt"

$ # Create bundle
$ git bundle create ../testrepo.bundle master

$ # Try to clone from bundle
$ cd ..
$ git clone testrepo.bundle testrepofrombundle

$ # Clone from bundle, wrapped with strace
$ strace -f -o /dev/null git clone testrepo.bundle testrepofrombundle

$ # Examine cloned repository
$ cd testrepofrombundle
$ ls
$ git branch -av
$ git checkout master
$ git branch -av
$ # Where's my HEAD?

> Kind regards,
> 
> Alain Kalker
