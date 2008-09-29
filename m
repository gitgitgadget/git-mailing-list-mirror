From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add contrib/rerere-train script
Date: Mon, 29 Sep 2008 14:39:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809291430050.16478@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080927204415.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 14:35:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkHyA-000169-9A
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 14:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYI2MdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 08:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbYI2MdS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 08:33:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:34625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751763AbYI2MdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 08:33:18 -0400
Received: (qmail invoked by alias); 29 Sep 2008 12:33:15 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 29 Sep 2008 14:33:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19up1Qxpspu513fa5q+sKpJSi0ZouTgdulkHeAi3I
	NbxLUK7F7pj2ov
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080927204415.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97007>

Hi,

On Sat, 27 Sep 2008, Nanako Shiraishi wrote:

> This script takes a range of commits (e.g. maint..next) as its 
> arguments, recreates merge commits in the range to prime rr-cache 
> database.

Cute idea.  However, I would _love_ to have this as an option to 
git-rerere, which would work in memory only.

This is how I would do it (if I had enough time to play with Git):

- teach merge_recursive_options not to write anything to the working 
  directory (should be relatively easy, as many parts of merge-recursive.c 
  already have no_wd/update_wd/!o->call_depth checks for that),

- refactor handle_file() in rerere.c to provide an in-memory-only version,

- teach rerere to call merge_recursive() with the in-memory-only option, 
  and then call the in-memory version of the handle_file() function for 
  all unmerged paths, using the resolutions from the given merge commit.

- then teach this new function to take an arbitrary commit range (but only 
  handling the two-parent merges within it).

Ciao,
Dscho
