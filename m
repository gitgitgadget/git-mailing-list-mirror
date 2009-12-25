From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH 1/2] Report exec errors from run-command
Date: Fri, 25 Dec 2009 15:39:34 +0100
Message-ID: <200912251539.35201.j6t@kdbg.org>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi> <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 25 15:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOBLD-0003Pb-C1
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 15:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbZLYOkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 09:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbZLYOkS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 09:40:18 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:39211 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753713AbZLYOkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 09:40:17 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 956642C4007;
	Fri, 25 Dec 2009 15:40:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8565F19F5C6;
	Fri, 25 Dec 2009 15:39:35 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135675>

On Donnerstag, 24. Dezember 2009, Ilari Liusvaara wrote:
> Previously run-command was unable to report errors happening in exec
> call. Change it to pass errno from failed exec to errno value at
> return.
>
> The errno value passing can be done by opening close-on-exec pipe and
> piping the error code through in case of failure. In case of success,
> close-on-exec closes the pipe on successful exec and parent process
> gets end of file on read.

The only really *important* errno of a failed exec is ENOENT. For this case, 
wouldn't it be easier to do the PATH lookup manually in the parent (before 
the fork()), and use execv() in the forked child rather than execvp()?

There is already a path lookup function in compat/mingw.c; it could certainly 
need some improvement, but it is a starter.

That said, we don't need the stunt that you implemented on WIN32, because by 
the time mingw_spawnvpe() returns, we have a running child process.

-- Hannes
