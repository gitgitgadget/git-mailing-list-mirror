From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Thu, 31 Dec 2009 22:41:37 +0100
Message-ID: <200912312241.37895.j6t@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <4B3CD74D.7020605@kdbg.org> <7v4on7x6w1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 22:43:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQSnb-00024o-21
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 22:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbZLaVmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 16:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZLaVmY
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 16:42:24 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:44188 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751764AbZLaVmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 16:42:24 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BFFD110013;
	Thu, 31 Dec 2009 22:42:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0FE6F19F586;
	Thu, 31 Dec 2009 22:41:38 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v4on7x6w1.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135978>

On Donnerstag, 31. Dezember 2009, Junio C Hamano wrote:
> It is a cute idea that covers 70-80% of the cases, as you also have to
> assume that you don't have to specify your own pager on a path with IFS
> (e.g. "Program files" in your example) and give your parameter to the
> pager at the same time, e.g.
>
>     PAGER="C:\Program Files\cygwin\bin\less -FRSX"
>
> Because it has its own LESS environment to set FRSX and you can get away
> with:
>
>     PAGER="C:\Program Files\cygwin\bin\less"
>     LESS=FRSX
>
> "less" is not a representative example for this issue.  In real life I
> suspect that custom programs that we don't ship with git (or you don't
> ship with msysgit) would lack such a workaround, (and that is why I didn't
> say "98% of the cases").

OTOH, once you see that you would have to set

	PAGER: C:\Program Files\cygwin\bin\less -FRSX

(I'm not using shell syntax here; think of a dialog that has name and value in 
separate edit boxes) then it is rather obvious that this cannot work. If you 
are clever (and you probably are - after all, you are modifying something 
esoteric: the environment!), then you will have heard about the magic 
double-quotes, and you will write this as

	PAGER: "C:\Program Files\cygwin\bin\less" -FRSX

instead, and it will work as intended.

Granted, "less" is not representative.

	GIT_EDITOR: "C:\Program Files\Notepad++\notepad++" -multiInst

is probably more realistic (but I didn't test it).

-- Hannes
