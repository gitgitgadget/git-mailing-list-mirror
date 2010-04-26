From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] start_command: close cmd->err descriptor when fork/spawn
 fails
Date: Mon, 26 Apr 2010 08:29:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1004260828470.7651@pacific.mpi-cbg.de>
References: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: bert Dvornik <dvornik+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 08:29:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Hp7-0005pS-Bd
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 08:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0DZG3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 02:29:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:35928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752398Ab0DZG3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 02:29:33 -0400
Received: (qmail invoked by alias); 26 Apr 2010 06:29:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 26 Apr 2010 08:29:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tSyU0ZiUtI9sBiFb9G7LQUYHBG6guv6NeSkqYp2
	xGQgd3mqob5HTz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145791>

Hi,

On Sun, 25 Apr 2010, bert Dvornik wrote:

> Fix the problem where the cmd->err passed into start_command wasn't 
> being properly closed when certain types of errors occurr.  (Compare the 
> affected code with the clean shutdown code later in the function.)
> 
> On Windows, this problem would be triggered if mingw_spawnvpe() failed, 
> which would happen if the command to be executed was malformed (e.g. a 
> text file that didn't start with a #! line).  If cmd->err was a pipe, 
> the failure to close it could result in a hang while the other side was 
> waiting (forever) for either input or pipe close, e.g. while trying to 
> shove the output into the side band.  On msysGit, this problem was 
> causing a hang in t5516-fetch-push.
> 
> I'm not sure why (or if) this problem hasn't cropped up under Linux. The 
> non-Windows code *does* try to check for execve() failures in the child, 
> in addition to the fork() failures.

Thanks. Both patches applied and pushed to 4msysgit.git.

Ciao,
Dscho
