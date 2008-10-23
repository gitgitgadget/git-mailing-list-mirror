From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 03:29:08 +0200
Message-ID: <gdok16$vh2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 03:30:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksp21-0004T9-Qi
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 03:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYJWB3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbYJWB3U
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 21:29:20 -0400
Received: from main.gmane.org ([80.91.229.2]:54659 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbYJWB3U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 21:29:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ksp0o-0001Jd-8T
	for git@vger.kernel.org; Thu, 23 Oct 2008 01:29:18 +0000
Received: from 94.37.30.171 ([94.37.30.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 01:29:18 +0000
Received: from giuseppe.bilotta by 94.37.30.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 01:29:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 94.37.30.171
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98938>

Hello all,

one of the common remarks done about git is that since it tracks
tree contents, it's not the best-suited tool to track a bunch of
independent files which happen to be in the same directory.

I've found myself in the situation of wanting to track my changes done
to one or more 'single' files in a directory (e.g. $HOME), and
deciding to use antiquate, clumsy, slow and inefficient but file-based
RCS (yes, you read that right) over git.

In other situations (e.g. for my UserJS folder) I ended up using git,
but not liking the idea of having things such as tags referring to all
of my UserJS projects instead of the single file they were inteded
for, or having to put 'filename: ' at the beginning of commit messages
just because the history was shared.

So today I decided to start hacking at a git-based but file-oriented
content tracker, which I decided to name Zit.

The principle is extremely simple: when you choose to start tracking a
file with Zit,

zit track file

Zit will create a directory .zit.file to hold a git repository
tracking the single file .zit.file/file, which is just a hard link to
file.

The reason for using .zit.file as a non-bare repository rather than
just a GIT_DIR is that it allows things such as 'git status' to ignore
everything else. A possible alternative could have been to use
.zit.file as the GIT_DIR and create an all-encopassing
.zit.file/info/exclude, but the general idea of having this kind of
detached GIT_DIR felt less robust (or maybe I just forgot some
export).

I also don't like the idea of the hardlink, first of all because of
portability problems, and secondly because of the way too many
possibility that the hardlink broke somewhere along the way. For
example, I haven't tested any fancy git commands on my sample zit
implementation, and I'm not sure checking out some older version would
actually work.

If anybody is intered in trying out my quick hack for the idea,
there's a git repository for Zit at git://git.oblomov.eu/zit --beware
that nothing past the most elementary uses (i.e. diff, status, log,
commit) has been tested yet. Many commands are bound to fail due to
the braindead way commands are delegated to git.

Suggestions on the best way to approach the many limits of the
implementation are more than welcome.

-- 
Giuseppe "Oblomov" Bilotta
