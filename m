From: Sebastian Thiel <byronimo@gmail.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after printing the report line
Date: Sun, 3 Jan 2010 10:41:31 +0000 (UTC)
Message-ID: <loom.20100103T114055-16@post.gmane.org>
References: <loom.20091119T221732-624@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 03 11:42:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRNuP-0002Ag-W3
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 11:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab0ACKl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 05:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214Ab0ACKl4
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 05:41:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:42260 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583Ab0ACKlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 05:41:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NRNuD-00028i-F6
	for git@vger.kernel.org; Sun, 03 Jan 2010 11:41:53 +0100
Received: from 91-64-162-37-dynip.superkabel.de ([91.64.162.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 11:41:53 +0100
Received: from byronimo by 91-64-162-37-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 11:41:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.162.37 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136074>

Sorry for the badly formatted message, and thanks a lot for the correction which
is what my post should have been in the first place.

Redoing the commit is not what will be needed for git-python to work properly
which is why I will tell the whole story before submitting any(more) patches.

With git v1.6.5, git-push was adjusted not to provide progress messages anymore
if the device attached to stderr is not a tty. Previously, this was only the
case with git-fetch. For git-python, and other callers of the commandline such
as tortoise-git, there currently is no way to provide progress information to
the user unless they (somehow) simulate a tty which appears unfeasible. When
using these tools, time consuming operations tend to appear as if they are
hanging. One might argue that most code is fetched and pushed in a matter of
seconds, but if git is used to store large binary data, processing and
transferring it will take time.

The issue mentioned with git-update-index and it's missing flush that would
cause a deadlock in some porcelain can be fixed trivially, but seen in the
context of the git-push and git-pull a more thorough solution might be more
appealing. As mentioned by Junio, a default flush after each report might slow
down some existing porcelain, and a commandline option would be part of the
proper solution. I would argue though that a separate option would add quite
some complexity to the command as it is a very specialized one. Instead I would
recommend checking whether --stdin is given on the commandline, and flush stdout
if that is true. This would natively make the command behave like
git-hash-object and git-cat-file. If --stdin is not provided, report is not
required to flush after every call as the commandline options are processed
without additional user interaction.

Adding a commandline option to git-push and git-pull that enforces progress
messages to be printed to stderr would be a feasible and simple fix that would
clearly improve the usability of tortoise-git and git-python to name only two.

That said, I hope I managed to make myself clear enough this time to help the
people in charge to figure out how to solve the issue. Once the desired solution
has been sketched out and the desired new commandline options have been named,
it could even be me to implement it if necessary, as I'd consider it a gentle
start into the world of the git codebase.

Thanks for picking this up again,
Sebastian
