From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/4] teach wait_or_whine a "quiet" mode
Date: Thu, 31 Mar 2011 22:56:39 +0200
Message-ID: <201103312256.39317.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <20110331184342.GA16906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:56:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5OvA-0004i6-4u
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 22:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab1CaU4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 16:56:42 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:42603 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751950Ab1CaU4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 16:56:41 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A0387CDF86;
	Thu, 31 Mar 2011 22:56:32 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6825D19F5F5;
	Thu, 31 Mar 2011 22:56:39 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20110331184342.GA16906@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170529>

On Donnerstag, 31. M=C3=A4rz 2011, Jeff King wrote:
> The wait_or_whine function will complain to stderr in a few
> cases:
>
>   1. We fail to actually waitpid() correctly.
>
>   2. The child died of a signal.
>
>   3. The child returned exit code 127, indicating a missing
>      command to exec after forking.
>
> We already have a silent_exec_failure flag to silence (3).
> Let's convert that into a "quiet" flag to also silence (2).

I'm rather negative on controlling these two error reports with the sam=
e flag=20
because...

> This shouldn't result in signal failure being silent for
> existing users of silent_exec_failure, since they already
> will need to be checking the return code and complaining for
> the case of a non-zero exit code.

This reasoning is not correct. Error reporting in the routines in=20
run-command.c is structured such that callers have to check the return =
code,=20
but they do not report errors themselves. Therefore, even if callers re=
quest=20
silent_exec_failure, they will not do their own error reporting if ther=
e is=20
some other failure.

-- Hannes
