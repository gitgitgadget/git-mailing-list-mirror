From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: fatal output from git-show really wants a terminal
Date: Wed, 10 Dec 2008 20:46:50 +0100
Message-ID: <200812102046.50186.j6t@kdbg.org>
References: <ghop5d$qud$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Olsen <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAV2c-0006jp-5K
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 20:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbYLJTq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 14:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbYLJTq4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 14:46:56 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:12086 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180AbYLJTqz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 14:46:55 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D0453CDF97;
	Wed, 10 Dec 2008 20:46:50 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4A9B971519;
	Wed, 10 Dec 2008 20:46:50 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <ghop5d$qud$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102707>

On Mittwoch, 10. Dezember 2008, Tim Olsen wrote:
> It appears that when outputting a fatal error, git-show will choose
> stdout over stderr if stdout is a terminal and stderr is not.

This is by design.

> How do I 
> redirect the error but still allow stdout to be displayed?

$ git show 12345 2> /dev/null | less

> ~/git$ mkdir test
> ~/git$ cd test
> ~/git/test$ git init
> ~/git/test$ git show 12345
> fatal: ambiguous argument '12345': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions

You see this through the pager.

> ~/git/test$ git show 12345 2> /dev/null
> fatal: ambiguous argument '12345': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions

And this went through the pager as well.

> ~/git/test$ git show 12345 > /dev/null
> fatal: ambiguous argument '12345': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions

This went straight to the terminal.

The pattern is that if stdout is a terminal, the pager is thrown up and both 
stdout and stderr of git show proper are redirected to the pager. If you 
redirect only stderr, then this redirection is actually ignored.

-- Hannes
