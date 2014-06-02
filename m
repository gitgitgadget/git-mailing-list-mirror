From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 0/9] replace signal() with sigaction()
Date: Mon, 02 Jun 2014 13:28:25 +0200
Message-ID: <538C5FD9.1010706@viscovery.net>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 13:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrQPq-0006co-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 13:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbaFBL2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 07:28:31 -0400
Received: from so.liwest.at ([212.33.55.24]:38265 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbaFBL2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 07:28:30 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WrQPh-0004wB-Uh; Mon, 02 Jun 2014 13:28:26 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A951216613;
	Mon,  2 Jun 2014 13:28:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250563>

Am 6/1/2014 20:10, schrieb Jeremiah Mahler:
> This is version 3 of the patch set to convert signal(2) to sigaction(2)
> (previous discussion [1]).
> 
> [1]: http://marc.info/?l=git&m=140148352416926&w=2
> 
> Changes in this revision include:
> 
>   - Using NULL pointers instead of 0 as per the
>     Documentation/CodingGuidlines pointed out by Chris Packham.
> 
>     sigaction(SIGCHLD, &sa, NULL);
> 
>   - Conversion of all remaining files which used signal().
> 
>   - sigchain.c required the most changes.  Both the old signal handler
>     was used and the return value from signal() was being checked.
>     signal() would return the previous error handler which would be
>     SIG_ERR if an error occurred.  sigaction() just returns -1 in this
>     case.
> 
> Jeremiah Mahler (9):
>   compat/mingw.c: expand MinGW support for sigaction
>   connect.c: replace signal() with sigaction()
>   progress.c: replace signal() with sigaction()
>   write_or_die.c: replace signal() with sigaction()
>   daemon.c: replace signal() with sigaction()
>   builtin/log.c: replace signal() with sigaction()
>   builtin/merge-index.c: replace signal() with sigaction()
>   builtin/verify-tag.c: replace signal() with sigaction()
>   sigchain.c: replace signal() with sigaction()

The series without patch 9/9 works on Windows so far.

Without patch patch 9/9 and a more complete implementation of sigaction in
compat/mingw.c the series misses its goal. But even if you complete it, it
is IMHO only code churn without practical merits.

-- Hannes

> 
>  builtin/log.c         |  6 +++++-
>  builtin/merge-index.c |  5 ++++-
>  builtin/verify-tag.c  |  5 ++++-
>  compat/mingw.c        |  9 +++++----
>  connect.c             |  5 ++++-
>  daemon.c              | 16 +++++++++++++---
>  progress.c            |  6 +++++-
>  sigchain.c            | 14 +++++++++++---
>  write_or_die.c        |  6 +++++-
>  9 files changed, 56 insertions(+), 16 deletions(-)
