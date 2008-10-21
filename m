From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Tue, 21 Oct 2008 19:02:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810211856090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home> <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 18:58:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsKXw-0004Md-LT
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 18:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbYJUQzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYJUQzy
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 12:55:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:34125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751963AbYJUQzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 12:55:53 -0400
Received: (qmail invoked by alias); 21 Oct 2008 16:55:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 21 Oct 2008 18:55:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vWntczuBv/vvzLGw0raKN4GN2oaoRdNnzePqYqZ
	M7KxRammYw947x
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98796>

Hi,

On Tue, 21 Oct 2008, Nguyen Thai Ngoc Duy wrote:

> Maybe we should let setup_*_gently() do read-only stuff only and let its 
> consumers to handle cwd.

I think that makes sense.  This would allow setup*gently() to be much 
cleaner, and only setup_git_directory() itself would do the 
chdir(worktree).

However, let's think this really through this time, so that that darned 
worktree stuff is fixed for good.

So I propose this change in semantics:

- setup_git_directory_gently(): rename to discover_git_directory(), 
  and avoid any chdir() at all.
- setup_git_directory(): keep the semantics that it chdir()s to the
  worktree, or to the git directory for bare repositories.

Using _gently() even for RUN_SETUP builtins should solve the long standing 
pager problem, too.

Ciao,
Dscho
