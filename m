From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper functions
 everywhere
Date: Thu, 15 Sep 2011 08:52:55 +0200
Message-ID: <4E71A0C7.8080602@viscovery.net>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil> <1316051979-19671-1-git-send-email-drafnel@gmail.com> <1316051979-19671-3-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	sunshine@sunshineco.com, bharrosh@panasas.com,
	trast@student.ethz.ch, zapped@mail.ru
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 08:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R45ov-0006pp-C5
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 08:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab1IOGxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 02:53:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18032 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751796Ab1IOGxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 02:53:05 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R45od-000503-R5; Thu, 15 Sep 2011 08:52:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 80D4E1660F;
	Thu, 15 Sep 2011 08:52:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
In-Reply-To: <1316051979-19671-3-git-send-email-drafnel@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181443>

Am 9/15/2011 3:59, schrieb Brandon Casey:
> The "x"-prefixed versions of strdup, malloc, etc. will check whether the
> allocation was successful and terminate the process otherwise.
> 
> A few uses of malloc were left alone since they already implemented a
> graceful path of failure or were in a quasi external library like xdiff.
> 
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  ...
>  compat/mingw.c        |    2 +-
>  compat/qsort.c        |    2 +-
>  compat/win32/syslog.c |    2 +-

There is a danger that the high-level die() routine (which is used by the
x-wrappers) uses one of the low-level compat/ routines. IOW, in the case
of errors, recursion might occur. Therefore, I would prefer that the
compat/ routines do their own error reporting (preferably via return
values and errno).

-- Hannes
