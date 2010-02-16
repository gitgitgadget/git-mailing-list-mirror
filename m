From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [patch] git svn slowness on win32
Date: Tue, 16 Feb 2010 11:34:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002161130590.20986@pacific.mpi-cbg.de>
References: <13237f021002160204o3c8af7a6i3e7105bd6bc43fa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-309307651-1266316480=:20986"
Cc: git@vger.kernel.org
To: josh robb <josh_robb@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Feb 16 11:28:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhKf7-000642-8q
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773Ab0BPK2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:28:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:54438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932603Ab0BPK2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 05:28:06 -0500
Received: (qmail invoked by alias); 16 Feb 2010 10:28:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 16 Feb 2010 11:28:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eA7sVz9ieL0imoWA8r57rzUdLjPu8xPc8V1g/X+
	gpB7xpQm+CiWQR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <13237f021002160204o3c8af7a6i3e7105bd6bc43fa3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140092>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-309307651-1266316480=:20986
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 16 Feb 2010, josh robb wrote:

> I'm using git svn (1.6.4.msysgit.0) within a WindowsXP VM running
> under VMWare fusion on OSX 10.5. For me (and at least one other person
> I know) git svn has been unbearably slow.
> 
> My profiling shows that almost all of the git-svn runtime is being
> spent in DynaLoader (via SVN::Base::import) which I guess is slow in a
> virtualized windows environment. For example:
> 
> $ time perl /libexec/git-core/git-svn rebase
> Current branch master is up to date.
> 
> real 2m56.750s
> user 0m3.129s
> sys 2m39.232s
> 
> I've been able to make significant (an order of magnitude)
> improvements to it's performance by delaying SVN::Base::import from
> running until it's actually needed. After making this change:
> 
> $ time perl /libexec/git-core/git-svn rebase
> Current branch master is up to date.
> 
> real 0m33.407s
> user 0m1.409s
> sys 0m23.054s
> 
> git svn rebase -n goes from 3m7.046s to 0m10.312s.
> 
> Would love to get some feedback/thoughts etc...

How about the following commit message (trying to follow 
http://repo.or.cz/w/git.git?a=blob;f=Documentation/SubmittingPatches;hb=HEAD):

-- snip --
git svn: delay importing SVN::Base until it is needed

Importing functions from a .dll into Git for Windows' perl is pretty slow,
so let's avoid importing if it is not necessary.

[... timing statistics here...]

Signed-off-by: Josh Robb <josh_robb@fastmail.fm>
-- snap --

Hmm?

Ciao,
Dscho

--8323328-309307651-1266316480=:20986--
