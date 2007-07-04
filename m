From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-init: set core.worktree if GIT_WORK_TREE is
 specified
Date: Wed, 4 Jul 2007 09:23:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707040920520.9434@woody.linux-foundation.org>
References: <20070703224919.GA22578@moooo.ath.cx>
 <20070704092915.GA18597@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 04 18:23:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I67da-0006lm-K8
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 18:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbXGDQX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbXGDQX2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 12:23:28 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51097 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752057AbXGDQX1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 12:23:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l64GNNuR009473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2007 09:23:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l64GNH5p004746;
	Wed, 4 Jul 2007 09:23:17 -0700
In-Reply-To: <20070704092915.GA18597@moooo.ath.cx>
X-Spam-Status: No, hits=-4.632 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51621>



On Wed, 4 Jul 2007, Matthias Lederhofer wrote:

> > +	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
> > +		die("Unable to read current working directory");
> 
> Dscho just pointed out that this causes problems on windows.  The same
> is also in setup_git_directory_gently and was there before I touched
> it, introduced by Linus in d288a700.  What was the original reason to
> do this?  Are there implementations of getcwd which return a relative
> path?

Just remove the check for cwd[0] being '/'.

It's just me being too kernel-oriented - inside the kernel, a d_path() 
return value pathname can be either a real path, or something like 
"pipe:[8003]", and the difference is the '/' at the beginning.

In user space, and for getcwd(), the check doesn't make sense. So please 
just remove it, and sorry for my idiotic "I've worked with the kernel for 
too damn long" programming mistakes.

		Linus
