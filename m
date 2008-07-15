From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git rev-parse: Fix --show-cdup inside symlinked
 directory
Date: Tue, 15 Jul 2008 16:19:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807151614510.8950@racer>
References: <1216131208.19334.171.camel@gemini> <20080715145920.13529.25603.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:20:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImKM-0008Ae-V6
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYGOPTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYGOPTc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:19:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:33188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757554AbYGOPTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:19:31 -0400
Received: (qmail invoked by alias); 15 Jul 2008 15:19:30 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp058) with SMTP; 15 Jul 2008 17:19:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zMa8ySWEzRZ7rRFBs9aVMHM9UnViCh6begn+Zgq
	tTl3TvSdDql4ia
X-X-Sender: gene099@racer
In-Reply-To: <20080715145920.13529.25603.stgit@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88565>

Hi,

On Tue, 15 Jul 2008, Petr Baudis wrote:

> Consider the scenario when someone makes a symlink into a working tree
> subdirectory at an unrelated place, then attempts to work inside the
> symlinked directory. The scenario is a bit unwieldly, but most of
> the Git will handle it fine - except git rev-parse --show-cdup. That
> will output a sequence of ../ which will work wrong inside the symlink
> using shell cd builtin.

Short version: do not use symlinks in the working directory, if you do not 
want to track the _symlink_.

Long version: there are a lot of problems with that, and --show-cdup is 
the least of the problems.  A checkout, for example, is able to kill the 
symlink and check out a fresh copy of the subdirectory.

AFAICT this is a concious decision: If you want to track a symlink, track 
a symlink, but if you want to track a subdirectory, you will have to track 
a subdirectory, and it cannot be a symlink.

> This patch changes --show-cdup to always show absolute workdir path
> instead. I think this should hopefully cause no compatibility problems;
> the testsuite is passing fine, at least.

See the thread where I proposed a change like this, back with the infamous 
worktree desaster, and Junio NACKed; or the thread where Linus rightfully 
insists that git_dir should be relative if possible, for performance 
reasons.

Hth,
Dscho
