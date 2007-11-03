From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git reset -- path weirdness
Date: Sat, 3 Nov 2007 12:17:43 +0100
Message-ID: <20071103111743.GA29358@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jasampler@gmail.com, gitster@pobox.com
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Nov 03 12:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoH0r-00023m-Sp
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 12:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbXKCLRr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbXKCLRr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 07:17:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:43124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752538AbXKCLRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 07:17:46 -0400
Received: (qmail invoked by alias); 03 Nov 2007 11:17:44 -0000
Received: from i577BAA93.versanet.de (EHLO localhost) [87.123.170.147]
  by mail.gmx.net (mp046) with SMTP; 03 Nov 2007 12:17:44 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18VuDwAl5gV7Dznog1s5WY8DLhwTGDVKLZL4ZktWJ
	HryI+29WT3NVfI
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63234>

Hi,

I noticed some weirdness with git reset when a path is given. Basically
it seems to cycle the file through 3 states: unstaged, unmerged,
deleted(!) which is IMHO weird at best. A bisection showed that the
behaviour was introduced with the shell -> conversion of git-reset.

Extra annoyance is caused by the fact that "git status" tells you to ad=
d
the file when it is in the unmerged state, but that doesn't do anything=
=2E

Log of "git reset" switching through the states:

doener@atjola:git (master) $ git status
# On branch master
nothing to commit (working directory clean)

doener@atjola:git (master) $ git reset -- builtin-reset.c
builtin-reset.c: needs merge

doener@atjola:git (master) $ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       unmerged:   builtin-reset.c
#
no changes added to commit (use "git add" and/or "git commit -a")

doener@atjola:git (master) $ git reset -- builtin-reset.c

doener@atjola:git (master) $ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    builtin-reset.c
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       builtin-reset.c

doener@atjola:git (master) $ git reset -- builtin-reset.c

doener@atjola:git (master) $ git status
# On branch master
nothing to commit (working directory clean)


Thanks,
Bj=F6rn
