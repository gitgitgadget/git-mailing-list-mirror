From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 09/11] daemon: use run-command api for async  serving
Date: Wed, 2 Dec 2009 20:12:08 +0100
Message-ID: <200912022012.08905.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <200911272159.38757.j6t@kdbg.org> <40aa078e0912020745o4b72342fm722a944621cfda5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 20:12:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFucr-0004bj-Tg
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbZLBTMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbZLBTMW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:12:22 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:21437 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754830AbZLBTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:12:21 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 94AE0CDF8D;
	Wed,  2 Dec 2009 20:12:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0070A19F60D;
	Wed,  2 Dec 2009 20:12:08 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0912020745o4b72342fm722a944621cfda5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134375>

On Mittwoch, 2. Dezember 2009, Erik Faye-Lund wrote:
> On Fri, Nov 27, 2009 at 9:59 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Would it make sense to
> > have a function finish_async_nowait() instead of is_async_alive() that
> > (1) stresses the start/finish symmetry and (2) can return more than just
> > Boolean?
>...
>
> I'm not entirely sure how to make the interface, though. Any good
> suggestions?

I suggest to model finish_async_nowait() after waitpid() so that

	while ((pid = waitpid(-1, &status, WNOHANG)) > 0) ...
becomes
	while ((pid = finish_async_nowait(&some_async, &status)) > 0) ...

but where the resulting status is already "decoded", i.e. zero is success and 
non-zero is failure (including death through signal); WIFEXITED and 
WEXITSTATUS should not be applicable to status anymore.

-- Hannes
