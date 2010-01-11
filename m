From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove empty directories when checking out a commit with
 fewer submodules
Date: Mon, 11 Jan 2010 09:57:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001110954410.4985@pacific.mpi-cbg.de>
References: <1263178794-3140-1-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 11 09:51:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUG07-0007BT-61
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab0AKIvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 03:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855Ab0AKIvq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:51:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:34018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752854Ab0AKIvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 03:51:45 -0500
Received: (qmail invoked by alias); 11 Jan 2010 08:51:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 11 Jan 2010 09:51:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4uytySvr4/zTcc7FaQG9Ca84kmJz0XiRe7DrAF2
	tGC7rfqYerHHcM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1263178794-3140-1-git-send-email-peter@pcc.me.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136623>

Hi,

On Mon, 11 Jan 2010, Peter Collingbourne wrote:

> Change the unlink_entry function to use rmdir to remove submodule
> directories.

NAK.  We should not even try to _unlink_ submodule subdirectories; it 
would be _way_ too easy to lose data that way.  Remember, submodules are a 
totally different beast from regular files.  They can contain valuable, 
yet uncommitted data, that is not even meant to be committed.

So you say if the submodule directories are empty, it is safe?  Not so.  
They will never be empty: there is always .git/, and _that_ can contain 
valuable information that you do not want to throw away, too.  Think of 
unpushed branches, for example.  That would be _fatal_ if you rmdir() that 
for me.

So please, no,
Dscho
